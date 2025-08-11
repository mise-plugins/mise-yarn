# mise-yarn

Yarn plugin for [mise](https://mise.jdx.dev/) (using the vfox plugin format).

> 💡 **Note:** This plugin validates package authenticity via [`gpg`](https://www.openpgp.org/) only for yarn v1.
> v2 and later versions are downloaded as single js file which doesn't have any signatures

## Features

- Supports Yarn Classic (v1.x) and Yarn Berry (v2.x+)
- Cross-platform: Works on Linux, macOS, and Windows
- GPG signature verification for v1 releases (optional)
- Lists v1 versions first for easier selection

## Requirements

- `wget` or `curl` - for downloading files
- `gpg` - for v1 signature verification (optional, can be skipped with `MISE_YARN_SKIP_GPG=1`)

## Installation

```bash
mise plugin install yarn
```

Or specify the repository:
```bash
mise plugin install yarn https://github.com/mise-plugins/mise-yarn.git
```

## Usage

### Install specific versions:
```bash
# Install latest v1
mise install yarn@1

# Install specific v1 version
mise install yarn@1.22.22

# Install latest v2
mise install yarn@2

# Install latest version
mise install yarn@latest

# Set a version globally
mise use -g yarn@1.22.22

# Set a version for current project
mise use yarn@2
```

### List available versions:
```bash
mise ls-remote yarn
# v1 versions will be listed first, followed by v2+
```

## Development

This plugin uses the vfox plugin format and is implemented in Lua with the following structure:
- `metadata.lua` - Plugin metadata
- `hooks/` - Plugin hooks for various operations
  - `available.lua` - Lists available versions
  - `pre_install.lua` - Handles installation
  - `post_install.lua` - Post-installation tasks
  - `env_keys.lua` - Environment variable configuration
  - `parse_legacy_file.lua` - Support for `.yvmrc` files
  - `legacy_filenames.lua` - Defines legacy config files

To test the plugin locally:
```bash
# Link the plugin for local development
ln -s /path/to/this/repo ~/.local/share/mise/plugins/yarn

# Test installation
mise install yarn@1.22.22
```

## yarn v1 missing signatures

[Some past v1 releases](https://github.com/yarnpkg/yarn/releases/) (`1.22.21`, `1.22.20`) don't have signature files (`.asc`) which makes it impossible to install these versions (gpg signature verification doesn't pass). They say "we're working on fixing this" but issue persists since Nov 14, 2023 (release of 1.22.20)

To be able to install those you can use `MISE_YARN_SKIP_GPG` env var

```shell
MISE_YARN_SKIP_GPG=true mise install yarn@1.22.21
```

## License

Licensed under the [MIT License](LICENSE).