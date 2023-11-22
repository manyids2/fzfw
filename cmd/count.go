package cmd

import (
	"log"

	"github.com/spf13/cobra"
)

// countCmd represents the count command
var countCmd = &cobra.Command{
	Use:   "count",
	Short: "count files by fd",
	Long:  `count files by fd.`,
	Run: func(cmd *cobra.Command, args []string) {
		log.Println("count")
	},
}

func init() {
	rootCmd.AddCommand(countCmd)
}
