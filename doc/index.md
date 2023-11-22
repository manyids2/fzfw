# fzfw

Features of fzf that make it amazing:

- handling of tty
  - input from pipe
  - use of stderr for ui
  - stdout only for final selection
  - `become` mode
- `preview`
- fuzzy search algo

## Goal

Thorough study of repo.
Creation of barebones app that handles all the above.
Formal definition and creation of resulting state machines,
with iteraction.
Creation of component system to create interacting fzf 'windows'.
Facilitate creation of tui apps like btop, lazygit, visidata, etc.

## Study of man page

- OPTIONS

  - Search mode
  - Search result
  - Interface
  - Layout
  - Display
  - History
  - Preview
  - Scripting

- ENVIRONMENT VARIABLES

- EXIT STATUS

- FIELD INDEX EXPRESSION

  - `cut` params

- EXTENDED SEARCH MODE

  - regex searches

- KEY/EVENT BINDINGS

  - AVAILABLE KEYS: (SYNONYMS)
  - AVAILABLE EVENTS:
  - AVAILABLE ACTIONS:
  - ACTION COMPOSITION
  - ACTION ARGUMENT
  - COMMAND EXECUTION
  - RELOAD INPUT
  - PREVIEW BINDING
  - CHANGE PREVIEW WINDOW ATTRIBUTES

## Handling of tty

1. protector

Protect calls OS specific protections like pledge on OpenBSD.

```go
import "golang.org/x/sys/unix"
//go:build openbsd
func Protect() {
	unix.PledgePromises("stdio rpath tty proc exec")
}
//go:build !openbsd
func Protect() {
	return
}
```

2. Specifying version and revision

```go
var version string = "0.41"
var revision string = "devel"
```

3. ParseOptions

```go
options := fzf.ParseOptions()
```

4. Core

```go
fzf.Run(options, version, revision)
```

4a. If asked for version, print and exit

```go
if opts.Version {
	if len(revision) > 0 {
		fmt.Printf("%s (%s)\n", version, revision)
	} else {
		fmt.Println(version)
	}
	os.Exit(exitOk)
}
```

4b. Events channel

Need to check `eventBox`.

```go
eventBox := util.NewEventBox()
```

4c. ANSI code processor

```go
ansiProcessor := func(data []byte) (util.Chars, *[]ansiOffset) {
	return util.ToChars(data), nil
}

var lineAnsiState, prevLineAnsiState *ansiState
if opts.Ansi {
	if opts.Theme.Colored {
		ansiProcessor = func(data []byte) (util.Chars, *[]ansiOffset) {
			prevLineAnsiState = lineAnsiState
			trimmed, offsets, newState := extractColor(string(data), lineAnsiState, nil)
			lineAnsiState = newState
			return util.ToChars([]byte(trimmed)), offsets
		}
	} else {
		// When color is disabled but ansi option is given,
		// we simply strip out ANSI codes from the input
		ansiProcessor = func(data []byte) (util.Chars, *[]ansiOffset) {
			trimmed, _, _ := extractColor(string(data), nil, nil)
			return util.ToChars([]byte(trimmed)), nil
		}
	}
}
```

4d. Chunk list

```go
var chunkList *ChunkList
var itemIndex int32
header := make([]string, 0, opts.HeaderLines)
if len(opts.WithNth) == 0 {
	chunkList = NewChunkList(func(item *Item, data []byte) bool {
		if len(header) < opts.HeaderLines {
			header = append(header, string(data))
			eventBox.Set(EvtHeader, header)
			return false
		}
		item.text, item.colors = ansiProcessor(data)
		item.text.Index = itemIndex
		itemIndex++
		return true
	})
} else {
	chunkList = NewChunkList(func(item *Item, data []byte) bool {
		tokens := Tokenize(string(data), opts.Delimiter)
		if opts.Ansi && opts.Theme.Colored && len(tokens) > 1 {
			var ansiState *ansiState
			if prevLineAnsiState != nil {
				ansiStateDup := *prevLineAnsiState
				ansiState = &ansiStateDup
			}
			for _, token := range tokens {
				prevAnsiState := ansiState
				_, _, ansiState = extractColor(token.text.ToString(), ansiState, nil)
				if prevAnsiState != nil {
					token.text.Prepend("\x1b[m" + prevAnsiState.ToString())
				} else {
					token.text.Prepend("\x1b[m")
				}
			}
		}
		trans := Transform(tokens, opts.WithNth)
		transformed := joinTokens(trans)
		if len(header) < opts.HeaderLines {
			header = append(header, transformed)
			eventBox.Set(EvtHeader, header)
			return false
		}
		item.text, item.colors = ansiProcessor([]byte(transformed))
		item.text.TrimTrailingWhitespaces()
		item.text.Index = itemIndex
		item.origText = &data
		itemIndex++
		return true
	})
}
```

4e. Reader

```go
streamingFilter := opts.Filter != nil && !sort && !opts.Tac && !opts.Sync
var reader *Reader
if !streamingFilter {
	reader = NewReader(func(data []byte) bool {
		return chunkList.Push(data)
	}, eventBox, opts.ReadZero, opts.Filter == nil)
	go reader.ReadSource()
}
```

4f. Matcher

```go
forward := true
withPos := false
for idx := len(opts.Criteria) - 1; idx > 0; idx-- {
	switch opts.Criteria[idx] {
	case byChunk:
		withPos = true
	case byEnd:
		forward = false
	case byBegin:
		forward = true
	}
}
patternBuilder := func(runes []rune) *Pattern {
	return BuildPattern(
		opts.Fuzzy, opts.FuzzyAlgo, opts.Extended, opts.Case, opts.Normalize, forward, withPos,
		opts.Filter == nil, opts.Nth, opts.Delimiter, runes)
}
inputRevision := 0
snapshotRevision := 0
matcher := NewMatcher(patternBuilder, sort, opts.Tac, eventBox, inputRevision)
```

4g. Filtering mode

```go
if opts.Filter != nil {
	if opts.PrintQuery {
		opts.Printer(*opts.Filter)
	}

	pattern := patternBuilder([]rune(*opts.Filter))
	matcher.sort = pattern.sortable

	found := false
	if streamingFilter {
		slab := util.MakeSlab(slab16Size, slab32Size)
		reader := NewReader(
			func(runes []byte) bool {
				item := Item{}
				if chunkList.trans(&item, runes) {
					if result, _, _ := pattern.MatchItem(&item, false, slab); result != nil {
						opts.Printer(item.text.ToString())
						found = true
					}
				}
				return false
			}, eventBox, opts.ReadZero, false)
		reader.ReadSource()
	} else {
		eventBox.Unwatch(EvtReadNew)
		eventBox.WaitFor(EvtReadFin)

		snapshot, _ := chunkList.Snapshot()
		merger, _ := matcher.scan(MatchRequest{
			chunks:  snapshot,
			pattern: pattern})
		for i := 0; i < merger.Length(); i++ {
			opts.Printer(merger.Get(i).item.AsString(opts.Ansi))
			found = true
		}
	}
	if found {
		os.Exit(exitOk)
	}
	os.Exit(exitNoMatch)
}
```

4h. Synchronous search

```go
if opts.Sync {
	eventBox.Unwatch(EvtReadNew)
	eventBox.WaitFor(EvtReadFin)
}
```

4i. Go interactive

```go
go matcher.Loop()
```

4j. Terminal I/O

```go
terminal := NewTerminal(opts, eventBox)
maxFit := 0 // Maximum number of items that can fit on screen
padHeight := 0
heightUnknown := opts.Height.auto
if heightUnknown {
	maxFit, padHeight = terminal.MaxFitAndPad(opts)
}
deferred := opts.Select1 || opts.Exit0
go terminal.Loop()
if !deferred && !heightUnknown {
	// Start right away
	terminal.startChan <- fitpad{-1, -1}
}
```

4k. Event coordination

```go
reading := true
ticks := 0
var nextCommand *string
eventBox.Watch(EvtReadNew)
total := 0
query := []rune{}
determine := func(final bool) {
	if heightUnknown {
		if total >= maxFit || final {
			deferred = false
			heightUnknown = false
			terminal.startChan <- fitpad{util.Min(total, maxFit), padHeight}
		}
	} else if deferred {
		deferred = false
		terminal.startChan <- fitpad{-1, -1}
	}
}
```

5. Actual even loop
