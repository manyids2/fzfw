package cmd

import (
	"github.com/manyids2/fzfw/core"
	"github.com/spf13/cobra"
)

// countCmd represents the count command
var countCmd = &cobra.Command{
	Use:   "count",
	Short: "count files by fd",
	Long:  `count files by fd.`,
	Run: func(cmd *cobra.Command, args []string) {
		app := core.NewApp()
		app.Setup()
		app.Run()
		defer app.Teardown()
	},
}

func init() {
	rootCmd.AddCommand(countCmd)
}
