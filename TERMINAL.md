# terminal.go

Largest file in `fzf/src`.

## Constants

```go
type jumpMode int

const (
	jumpDisabled jumpMode = iota
	jumpEnabled
	jumpAcceptEnabled
)

type resumableState int

const (
	disabledState resumableState = iota
	pausedState
	enabledState
)
```

## Functions with description

```go
// Defines various regexps
func init()

// -- [ disabled / paused / enabled ] ---
func (s resumableState) Enabled() bool
func (s *resumableState) Force(flag bool)
func (s *resumableState) Set(flag bool)

// State diagram : TODO

// -- [ time order ] ---
func (a byTimeOrder) Len() int
func (a byTimeOrder) Swap(i, j int)
func (a byTimeOrder) Less(i, j int) bool

// -- [ actions ] ---
func toActions(types ...actionType) []*action
func defaultKeymap() map[tui.Event][]*action

// -- [ trim query ] ---
func trimQuery(query string) []rune

// -- [ preview ] ---
func hasPreviewAction(opts *Options) bool

// -- [ spinner ] ---
func makeSpinner(unicode bool) []string

// -- [ setup terminal ] ---
func evaluateHeight(opts *Options, termHeight int) int
func NewTerminal(opts *Options, eventBox *util.EventBox) *Terminal
func (t *Terminal) environ() []string

// -- [ appearance ] ---
func borderLines(shape tui.BorderShape) int
func (t *Terminal) extraLines() int
func (t *Terminal) MaxFitAndPad(opts *Options) (int, int)
func (t *Terminal) ansiLabelPrinter(str string, color *tui.ColorPair, fill bool) (labelPrinter, int)
func (t *Terminal) parsePrompt(prompt string) (func(), int)
func (t *Terminal) noInfoLine() bool
func getScrollbar(total int, height int, offset int) (int, int)
func (t *Terminal) getScrollbar() (int, int)

// -- [ input ] ---
func (t *Terminal) Input() (bool, []rune)

// -- [ count ] ---
func (t *Terminal) UpdateCount(cnt int, final bool, failedCommand *string)

// -- [ reverse ] ---
func reverseStringArray(input []string) []string

// -- [ header ] ---
func (t *Terminal) changeHeader(header string) bool
func (t *Terminal) UpdateHeader(header []string)

// -- [ progress ] ---
func (t *Terminal) UpdateProgress(progress float32)

// -- [ list ] ---
func (t *Terminal) UpdateList(merger *Merger)

// -- [ output ] ---
func (t *Terminal) output() bool

// -- [ sort ] ---
func (t *Terminal) sortSelected() []selectedItem

// -- [ appearance ] ---
func (t *Terminal) displayWidth(runes []rune) int
func calculateSize(base int, size sizeSpec, occupied int, minSize int, pad int) int
func (t *Terminal) adjustMarginAndPadding() (int, int, [4]int, [4]int)
func (t *Terminal) resizeWindows(forcePreview bool)

// -- [ label ] ---
func (t *Terminal) printLabel(window tui.Window, render labelPrinter, opts labelOpts, length int, borderShape tui.BorderShape, redrawBorder bool)

// -- [ move ] ---
func (t *Terminal) move(y int, x int, clear bool)

// -- [ truncate query ] ---
func (t *Terminal) truncateQuery()

// -- [ prompt ] ---
func (t *Terminal) updatePromptOffset() ([]rune, []rune)
func (t *Terminal) promptLine() int
func (t *Terminal) placeCursor()
func (t *Terminal) printPrompt()
func (t *Terminal) trimMessage(message string, maxWidth int) string

// -- [ various prints ] ---
func (t *Terminal) printInfo()
func (t *Terminal) printHeader()
func (t *Terminal) printList()
func (t *Terminal) printItem(result Result, line int, i int, current bool, bar bool)
func (t *Terminal) trimRight(runes []rune, width int) ([]rune, bool)
func (t *Terminal) displayWidthWithLimit(runes []rune, prefixWidth int, limit int) int
func (t *Terminal) trimLeft(runes []rune, width int) ([]rune, int32)
func (t *Terminal) overflow(runes []rune, max int) bool
func (t *Terminal) printHighlighted(result Result, colBase tui.ColorPair, colMatch tui.ColorPair, current bool, match bool) int
func (t *Terminal) printColoredString(window tui.Window, text []rune, offsets []colorOffset, colBase tui.ColorPair)

// -- [ various renders ] ---
func (t *Terminal) renderPreviewSpinner()
func (t *Terminal) renderPreviewArea(unchanged bool)
func (t *Terminal) renderPreviewText(height int, lines []string, lineNo int, unchanged bool)
func (t *Terminal) renderPreviewScrollbar(yoff int, barLength int, barStart int)

// -- [ preview prints ] ---
func (t *Terminal) printPreview()
func (t *Terminal) printPreviewDelayed()

// -- [ tabs ] ---
func (t *Terminal) processTabs(runes []rune, prefixWidth int) (string, int)

// -- [ all? ] ---
func (t *Terminal) printAll()

// -- [ refresh ] ---
func (t *Terminal) refresh()

// -- [ backspace? ] ---
func (t *Terminal) delChar() bool

// -- [ find match ] ---
func findLastMatch(pattern string, str string) int
func findFirstMatch(pattern string, str string) int

// -- [ copy? ] ---
func copySlice(slice []rune) []rune

// -- [ ignore? ] ---
func (t *Terminal) rubout(pattern string)

// -- [ ? ] ---
func keyMatch(key tui.Event, event tui.Event) bool

// -- [ placeholder ] ---
func parsePlaceholder(match string) (bool, string, placeholderFlags)

// -- [ preview ] ---
func hasPreviewFlags(template string) (slot bool, plus bool, query bool)

// -- [ history? ] ---
func writeTemporaryFile(data []string, printSep string) string
func cleanTemporaryFiles()

// -- [ placeholder ] ---
func (t *Terminal) replacePlaceholder(template string, forcePlus bool, input string, list []*Item) string
func (t *Terminal) evaluateScrollOffset() int
func replacePlaceholder(template string, stripAnsi bool, delimiter Delimiter, printsep string, forcePlus bool, query string, allItems []*Item) string

// -- [ draw ] ---
func (t *Terminal) redraw()

// -- [ ex ] ---
func (t *Terminal) executeCommand(template string, forcePlus bool, background bool, capture bool, firstLineOnly bool) string

// -- [ preview ] ---
func (t *Terminal) hasPreviewer() bool
func (t *Terminal) needPreviewWindow() bool
func (t *Terminal) canPreview() bool
func (t *Terminal) hasPreviewWindow() bool

// -- [ current ] ---
func (t *Terminal) currentItem() *Item

// -- [ multi ] ---
func (t *Terminal) buildPlusList(template string, forcePlus bool) (bool, []*Item)
func (t *Terminal) selectItem(item *Item) bool
func (t *Terminal) selectItemChanged(item *Item) bool
func (t *Terminal) deselectItem(item *Item)
func (t *Terminal) deselectItemChanged(item *Item) bool
func (t *Terminal) toggleItem(item *Item) bool

// -- [ preview ] ---
func (t *Terminal) killPreview(code int)
func (t *Terminal) cancelPreview()

// -- [ ** OG ** ] ---
func (t *Terminal) Loop()

// -- [ utils? ] ---
func (t *Terminal) constrain()
func (t *Terminal) vmove(o int, allowCycle bool)
func (t *Terminal) vset(o int) bool
func (t *Terminal) maxItems() int
```
