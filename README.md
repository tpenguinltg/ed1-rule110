# ed(1) Rule 110 Simulation

This [ed(1)][] script simulates [Rule 110][], proving that ed(1) is
Turing-complete.

*The old self-modifying version, along with its README, can be found in
the [`selfmod`](./selfmod) directory. There is a [blog post][] that
provides a full explanation for this self-modifying version. This new
version is built on the same concepts.*

[ed(1)]: https://en.wikipedia.org/wiki/Ed_%28text_editor%29
[Rule 110]: https://en.wikipedia.org/wiki/Rule_110
[blog post]: https://nixwindows.wordpress.com/2018/03/13/ed1-is-turing-complete/

## Overview

The simulation is run on a data file whose last line is the input. This
file gets loaded into `ed`'s buffer. Unlike the old version, the script
is standalone and the data is not embedded into the script.

The Rule is implemented using substitutions.

The script is a [quine][] that writes itself to the beginning of the
buffer, partitioning the buffer into a code section and a data section.
Recursion is achieved by writing the code section to the stdin of an
invocation of `ed` using the `w` command. To pass data between recursive
calls, the data section is written to the data file before the recursive
call is done. If you do not consider using `!` to invoke another
instance of `ed`, then this script does not prove Turing-completeness.

To simplify writing the script, the full quine, `rule110.ed`, is built
from the half-quine in `rule110.proto.ed`. Naturally, the build script,
`build.ed`, is also written as an `ed` script.

[quine]: https://github.com/tpenguinltg/ed1-quine

## Building

Run `make`:

```sh
$ make
```

This will take `rule110.proto.ed` and build the full script, `rule110.ed`.

## Running

To run the simulation on the data file `cells.dat`, call `ed` on the
file, feeding the script through stdin:

```sh
$ ed -s cells.dat < rule110.ed; wait
```

For convenience, the above invocation is also available as the `run` make
target, so you may alternatively run it using `make`:

```sh
$ make run
```

The simulation will not terminate automatically, so you will have to
terminate it manually using `^C` or `kill`/`killall`/`pkill`. Having
`wait` at the end is not strictly necessary, but it keeps your prompt
from appearing until all of the child processes spawned by `ed` have
died.

The data file (`cells.dat` in this example, but the name does not matter
as long as it does not contain a `'`) should contain the input on the
last line. Apart from the terminal newline, it must contain only `0`s
and `1`s. The input line can be as wide as you want, but it must have at
least one character (apart from the newline). **Do not run this script on
a file with invalid data**, or else you'll have to hunt down a stray
`ed` process.

The results of the simulation will be written back to the data file.

For a nicer view of the results, consider running the data file through
`sed` to change the `0` and `1` characters:

```sh
$ sed 's/0/ /g;s/1/#/g' cells.dat
```

## License

MIT. See the [LICENSE](./LICENSE) file for details.
