package main

import (
	"fmt"

	fzf "github.com/junegunn/fzf/src"
	"github.com/junegunn/fzf/src/protector"
)

var (
	version  string = "0.1"
	revision string = "devel"
)

func main() {
	protector.Protect()
	options := fzf.ParseOptions()
	fmt.Printf("%+v", options)
}
