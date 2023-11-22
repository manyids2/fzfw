package cmd

import (
	"fmt"
	"log"

	"github.com/spf13/cobra"
	"github.com/spf13/viper"
)

// createCmd represents the create command
var createCmd = &cobra.Command{
	Use:   "create",
	Short: "Create basic fzf script",
	Long:  `Create basic fzf script.`,
	Run: func(cmd *cobra.Command, args []string) {
		err := viper.ReadInConfig() // Find and read the config file
		if err != nil {             // Handle errors reading the config file
			panic(fmt.Errorf("fatal error config file: %w", err))
		}

		for key, value := range viper.GetViper().AllSettings() {
			log.Println(key, value)
		}
	},
}

func init() {
	rootCmd.AddCommand(createCmd)
}
