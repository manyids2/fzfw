package cmd

import (
	"fmt"

	"github.com/spf13/cobra"
)

// cutCmd represents the cut command
var cutCmd = &cobra.Command{
	Use:   "cut",
	Short: "Cut interactively",
	Long:  `Cut interactively.`,
	Run: func(cmd *cobra.Command, args []string) {
		fmt.Println("cut")
	},
}

func init() {
	rootCmd.AddCommand(cutCmd)
}

