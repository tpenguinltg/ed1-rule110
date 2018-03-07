# ed(1) Rule 110 Simulation

This [ed(1)][] script simulates [Rule 110][], proving that ed(1) is Turing-complete.

[ed(1)]: https://en.wikipedia.org/wiki/Ed_%28text_editor%29
[Rule 110]: https://en.wikipedia.org/wiki/Rule_110

## Overview

There are two parts to the script: the code part and the data part.
The code part is what gets executed by `ed`. It ends with the `q` command, after which point the data part starts.
The data part is marked by the comment `# DATA` for convenience.

The rule is implemented through substitutions.

Recursion is achieved by using `!` to invoke another instance of `ed` on the script. If you do not consider this to be valid, then this script does not prove Turing-completeness.

To save each iteration of the simulation between recursive calls, the script modifies itself before doing the recursive call.

## Running

The simulation uses the last line of the file as input.
Apart from the terminal newline, it must contain only `0`s and `1`s. It can be as wide as you want, but it must be at least one character wide.

There are two versions of the script: `rule110.ed`, whose edges "wrap around", and `rule110-nonperiodic.ed`, whose cells past the edges are always 0.

After initializing, run the simulation by invoking `ed` on the script and feeding the script into stdin:

```sh
$ ed rule110.ed < rule110.ed
```

The simulation will not terminate automatically, so you will have to terminate it manually using `^C` (possibly multiple times due to race conditions) or `kill`/`killall`/`pkill`.

The results of the simulation will be in the data part of the script.

For a nicer view, consider running the script through `sed` to change the `0` and `1` characters:

```sh
$ sed 's/0/ /g;s/1/#/g' rule110.ed
```
