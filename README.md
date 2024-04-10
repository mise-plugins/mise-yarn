# mise-yarn

Yarn plugin for the [mise][1] version manager.

> 💡 **Note:** This plugin validates package authenticity via [`gpg`][2] only for yarn v1.
> v2 and later versions are downloaded as single js file which doesn't have any signatures

## Requirements

This plugin should work out of the box on Linux and Mac operating systems.
If one of the commands needed is unavailable, it will let you know.

## Installing

```
mise plugin i yarn
```

[1]: https://mise.jdx.dev/
[2]: https://www.openpgp.org/

## Migration from twuni/asdf-yarn

### Issue with yarn_old
If you can't update plugin like this
```bash
$ mise plugins update yarn
mise plugin:yarn is a symlink, not updating
```

Try removing both yarn and yarn_old
```bash
$ mise plugins rm yarn
$ mise plugins rm yarn_old
```

And then try to install newer version
```bash
$ mise plugins i yarn
mise plugin:yarn ✓ https://github.com/mise-plugins/asdf-yarn.git#somehash
```

if instead it outputs that it still installs from `twuni/asdf-yarn` like
``` bash
mise plugin:yarn ✓ https://github.com/twuni/asdf-yarn.git#somehash
```

then your registry is still not updated. You can set it to update more frequently (atm there is no command in mise to force update registry) and try to reinstall
```bash
$ mise settings set plugin_autoupdate_last_check_duration 1h
$ mise plugins rm yarn
$ mise plugins i yarn
```

it should output
```bash
mise plugin:yarn ✓ https://github.com/mise-plugins/asdf-yarn.git#somehash
```
