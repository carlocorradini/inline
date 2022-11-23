<!-- markdownlint-disable MD033 -->

# [Inline](./inline.sh) script sources

[![ci](https://github.com/carlocorradini/inline/actions/workflows/ci.yml/badge.svg)](https://github.com/carlocorradini/inline/actions/workflows/ci.yml)
[![semantic-release: angular](https://img.shields.io/badge/semantic--release-angular-e10079?logo=semantic-release)](https://github.com/semantic-release/semantic-release)

Inline script sources (`source` or `.`).

It is convenient to be able to divide long scripts into many files to make them easier to work with while maintaining the ability to distribute them as a single script.

Inspired by [@joehillen](https://github.com/joehillen) [GitHub Gist](https://gist.github.com/joehillen/30f08738c1c3c0ca3e4c754ad33ad2ff)

## Features

- `POSIX` compliant

- Sourcing with quotes, spaces and more

- Sourcing from `$PATH`

- Sourcing from [ShellCheck](https://github.com/koalaman/shellcheck) source: `# shellcheck source=path/to/script.sh`

  > **Warning**: Only if `source` or `.` is invalid

  ```sh
  # shellcheck source=path/to/script.sh
  . "$DIR/path/to/script.sh"
  ```

- Sources in sources

- Recursion detection

- Shebang (`#!`) removal in sources

- Skip source: `# inline skip`

  > **Note**: that it also works with [ShellCheck](https://github.com/koalaman/shellcheck)

  ```sh
  # inline skip
  # shellcheck source=path/to/script.sh
  . path/to/script.sh
  ```

- Configurable
  See [Options](#options)

## Download

### `curl`

```sh
https://raw.githubusercontent.com/carlocorradini/inline/main/inline.sh -o inline.sh
```

### `wget`

```sh
https://raw.githubusercontent.com/carlocorradini/inline/main/inline.sh
```

## Usage

> **Warning**: Script must have _execute_ permission: `chmod u+x ./inline.sh`

> **Note**: See [Options](#options) for more configuration

> **Note**: Type `--help` for more information

Pass the script to be aligned with `--in-file path/to/script.sh` \
It creates a script called `output.sh` \
The resulting script is automatically _aligned_: all sources (`source` or `.`) are directly included.

### Examples

1. Inline script `hello.sh` and save it as `world.sh`

   ```sh
   ./inline.sh --in-file hello.sh --out-file world.sh
   ```

1. Inline script `hello_world.sh` and overwrite it

   ```sh
   ./inline.sh --in-file hello_world.sh --overwrite
   ```

## Options

| **Name**              | **Description**            | **Default** | **Values**                                                                                                |
| --------------------- | -------------------------- | ----------- | --------------------------------------------------------------------------------------------------------- |
| `--disable-color`     | Disable color              | `false`     |
| `--help`              | Show help message and exit |
| `--in-file <FILE>`    | Input file                 | `script.sh` | Any valid file                                                                                            |
| `--log-level <LEVEL>` | Logger level               | `info`      | `fatal` Fatal level <br/> `warn` Warning level <br/> `info` Informational level <br/> `debug` Debug level |
| `--out-file <FILE>`   | Output file                | `output.sh` | Any valid file                                                                                            |
| `--overwrite`         | Overwrite input file       | `false`     |

## Contributing

I would love to see your contribution :heart:

See [CONTRIBUTING](./CONTRIBUTING.md) guidelines.

## License

This project is licensed under the [MIT](https://opensource.org/licenses/MIT) License. \
See [LICENSE](./LICENSE) file for details.
