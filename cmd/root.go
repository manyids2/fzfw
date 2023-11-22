package cmd

import (
	"fmt"
	"os"

	"github.com/spf13/cobra"
	"github.com/spf13/viper"
)

var (
	Verbose bool
	Debug   bool
	Version bool
)

var (
	version  string = "0.1"
	revision string = "devel"
)

// rootCmd represents the base command when called without any subcommands
var rootCmd = &cobra.Command{
	Use:   "fzfw",
	Short: "Create fzf applications",
	Long:  `Generate fzf applications using tui.`,
	Run: func(cmd *cobra.Command, args []string) {
		print_version := viper.GetBool("version")
		if print_version {
			fmt.Printf("fzfw\n%s %s\n", version, revision)
		}
	},
}

// Execute adds all child commands to the root command and sets flags appropriately.
// This is called by main.main(). It only needs to happen once to the rootCmd.
func Execute() {
	err := rootCmd.Execute()
	if err != nil {
		os.Exit(1)
	}
}

func init() {
	viper.Set("_version", version)   // set version
	viper.Set("_revision", revision) // set revision

	viper.SetConfigName("config")                // name of config file (without extension)
	viper.SetConfigType("yaml")                  // REQUIRED if the config file does not have the extension in the name
	viper.AddConfigPath("$HOME/.config/fzfw")    // call multiple times to add many search paths
	viper.AddConfigPath("$XDG_CONFIG_HOME/fzfw") // call multiple times to add many search paths
	viper.AddConfigPath(".")                     // optionally look for config in the working directory

	rootCmd.PersistentFlags().BoolVar(&Version, "version", false, "Print version and quit. (default: false)")
	viper.BindPFlag("version", rootCmd.PersistentFlags().Lookup("version"))

	rootCmd.PersistentFlags().BoolVarP(&Verbose, "verbose", "v", false, "Verbose output. (default: false)")
	viper.BindPFlag("verbose", rootCmd.PersistentFlags().Lookup("verbose"))

	rootCmd.PersistentFlags().BoolVarP(&Debug, "debug", "d", false, "Debug output. (default: false)")
	viper.BindPFlag("debug", rootCmd.PersistentFlags().Lookup("debug"))
}
