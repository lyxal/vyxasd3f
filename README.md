<div align="center">

# asdf-vyxal3 [![Build](https://github.com/lyxal/asdf-vyxal3/actions/workflows/build.yml/badge.svg)](https://github.com/lyxal/asdf-vyxal3/actions/workflows/build.yml) [![Lint](https://github.com/lyxal/asdf-vyxal3/actions/workflows/lint.yml/badge.svg)](https://github.com/lyxal/asdf-vyxal3/actions/workflows/lint.yml)

[vyxal3](https://github.com/vyxal/vyxal) plugin for the [asdf version manager](https://asdf-vm.com).

</div>



# Contents

- [Dependencies](#dependencies)
- [Install](#install)
- [Contributing](#contributing)
- [License](#license)

# Dependencies

**TODO: adapt this section**

- `bash`, `curl`, `tar`, and [POSIX utilities](https://pubs.opengroup.org/onlinepubs/9699919799/idx/utilities.html).
- `SOME_ENV_VAR`: set this environment variable in your shell config to load the correct version of tool x.

# Install

Plugin:

```shell
asdf plugin add vyxal3
# or
asdf plugin add vyxal3 https://github.com/lyxal/asdf-vyxal3.git
```

vyxal3:

```shell
# Show all installable versions
asdf list-all vyxal3

# Install specific version
asdf install vyxal3 latest

# Set a version globally (on your ~/.tool-versions file)
asdf global vyxal3 latest

# Now vyxal3 commands are available
vyxal3 --help
```

Check [asdf](https://github.com/asdf-vm/asdf) readme for more instructions on how to
install & manage versions.


# License

See [LICENSE](LICENSE) © [lyxal](https://github.com/lyxal/)
