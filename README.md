# bin

A collection of personal utility scripts and configuration files for development environments.

## Contents

### Emacs Configuration Files

- **`.emacs`** - Legacy Emacs configuration file
- **`.emacs-v2`** - Updated Emacs configuration optimized for macOS Monterey with Python development support
  - Includes Elpy for Python IDE features
  - Flycheck for syntax checking
  - Py-isort for import formatting
  - Material theme support
  - Auto-save and backup file management

### Git Utility Scripts

- **`get_development.sh`** - Fetches changes from the development branch
- **`get_master.sh`** - Fetches changes from the master branch
- **`new_branch.sh`** - Creates a new feature branch
- **`merge_dev.sh`** - Merges development branch
- **`merge_development.sh`** - Enhanced merge for development branch
- **`merge_into_development.sh`** - Merges current branch into development

## Setup

To use these configuration files and scripts:

1. Clone the repository
2. Copy `.emacs-v2` to your home directory as `.emacs` (or configure your Emacs to use it)
3. Make the shell scripts executable: `chmod +x *.sh`
4. Update any hardcoded paths in `.emacs-v2` to match your system setup

## Emacs Configuration (.emacs-v2)

The Monterey-optimized configuration includes:

- **Python Development**: Elpy, Flycheck, and Py-isort integration
- **macOS Key Bindings**: Proper Command key mapping for macOS
- **Virtual Environment Support**: WORKON_HOME configuration for Python virtual environments
- **Auto-save Management**: Automatic cleanup of backup files older than one week
- **TeX Support**: Configuration for MacTeX/TeX Live

### Requirements

- Emacs 26.1 or later
- Python 3
- pyenv (optional, for Python version management)

## Notes

- The `.emacs-v2` file is tailored for macOS Monterey
- Update paths (e.g., `/Users/cagil/`) to match your system
- Consider using the git utility scripts to streamline your workflow

## License

Personal utility repository