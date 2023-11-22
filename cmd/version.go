package cmd

import (
	"fmt"

	"github.com/spf13/cobra"
	"github.com/spf13/viper"
)

// versionCmd represents the version command
var versionCmd = &cobra.Command{
	Use:   "version",
	Short: "Version of fzfw",
	Long:  `Version of fzfw.`,
	Run: func(cmd *cobra.Command, args []string) {
		version := viper.Get("_version")
		revision := viper.Get("_revision")
		fmt.Printf("fzfw\n%s %s\n", version, revision)
	},
}

func init() {
	rootCmd.AddCommand(versionCmd)
}
