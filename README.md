# mise-yarn

Yarn plugin for the [mise](https://mise.jdx.dev/) version manager.

> 💡 **Note:** This plugin validates package authenticity via [`gpg`](https://www.openpgp.org/) only for yarn v1.
> v2 and later versions are downloaded as single js file which doesn't have any signatures

## Requirements

This plugin should work out of the box on Linux and Mac operating systems.
If one of the commands needed is unavailable, it will let you know.

## Installing / Updating

```
mise plugin i yarn
```

```
mise plugin up yarn
```

## Development

This repo has github workflows which check linting and formatting of code in `bin` folder.

To lint code run `make lint` (note: requires `shellcheck` to be installed)

To check formatting run `make format-check` (requires `shfmt` to be installed) and to format code run `make fmt`

## yarn v1 missing signatures

[Latest v1 releases](https://github.com/yarnpkg/yarn/releases/) (`1.22.22`, `1.22.21`, `1.22.20`) don't have signature files (`.asc`) which makes it impossible to install these versions (gpg signature verification doesn't pass). They say "we're working on fixing this" but issue persists since Nov 14, 2023 (release of 1.22.20)

To be able to install those you can use `MISE_YARN_SKIP_GPG` env var

```shell
MISE_YARN_SKIP_GPG=true mise install yarn@1.22.22
```
