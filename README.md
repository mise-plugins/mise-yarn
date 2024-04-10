# asdf-yarn

Yarn plugin for the [asdf][1] version manager.

> 💡 **Note:** This plugin validates package authenticity via [`gpg`][2] only for yarn v1.
> v2 and later versions are downloaded as single js file which doesn't have any signatures

## Requirements

This plugin should work out of the box on Linux and Mac operating systems.
If one of the commands needed is unavailable, it will let you know.

## Installing

```
asdf plugin-add yarn
asdf install yarn latest
```

[1]: https://asdf-vm.com/
[2]: https://www.openpgp.org/
