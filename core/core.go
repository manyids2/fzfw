package core

import (
	"fmt"

	fzf "github.com/junegunn/fzf/src"
	"github.com/junegunn/fzf/src/protector"
	"github.com/junegunn/fzf/src/util"
)

// Options stores the values of command-line options
type Options struct {
	Sync bool
}

func defaultOptions() *Options {
	return &Options{
		Sync: false,
	}
}

// App is used to hold app state
type App struct {
	opts     *Options
	eventBox util.EventBox
}

func NewApp() *App {
	return &App{}
}

func (a *App) Setup() {
	fmt.Println("Setup")

	// Protector
	protector.Protect()

	// EventBox
	a.opts = defaultOptions()
	a.eventBox = *util.NewEventBox()

	// Synchronous
	if a.opts.Sync {
		a.eventBox.Unwatch(fzf.EvtReadNew)
		a.eventBox.WaitFor(fzf.EvtReadFin)
	}

	// Terminal I/O
	opts := fzf.ParseOptions()
	terminal := fzf.NewTerminal(opts, &a.eventBox)
	maxFit := 0 // Maximum number of items that can fit on screen
	padHeight := 0
	heightUnknown := true
	if heightUnknown {
		maxFit, padHeight = terminal.MaxFitAndPad(opts)
	}
	fmt.Println(maxFit, padHeight)

	deferred := opts.Select1 || opts.Exit0
	go terminal.Loop()
	if !deferred && !heightUnknown {
		// Start right away
		// terminal.startChan <- fitpad{-1, -1}
	}
}

func (a *App) Run() {
	fmt.Println("Run")
}

func (a *App) Teardown() {
	fmt.Println("Teardown")
}
