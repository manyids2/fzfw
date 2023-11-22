package cmd

import (
	"fmt"

	"github.com/spf13/cobra"
	"github.com/spf13/viper"
)

// versionCmd represents the version command
var versionCmd = &cobra.Command{
	Use:   "version",
	Short: "version basic fzf script",
	Long:  `version basic fzf script.`,
	Run: func(cmd *cobra.Command, args []string) {
		version := viper.Get("version")
		revision := viper.Get("revision")
		fmt.Printf("fzfw\n%s %s\n", version, revision)
	},
}

func init() {
	rootCmd.AddCommand(versionCmd)
}
