                          =======================
                            "pgrep" - perl grep
                          =======================

Did you ever want to have a "grep" combined with the power of Perl's
regular expressions?

Here it is!

Usage: pgrep [-i|-l|-v|-ilv] <perlregexp> [<filename>|-]

Items in square brackets mean "omit or repeat as often as you like".
Items in angle brackets are placeholders for the corresponding items.
The pipe symbol "|" means "or".

A filename of "-" means to grep through "STDIN".

This tool accepts the usual options for "grep":

    -i    ignore case
    -l    list filenames only
    -v    invert results (output files or lines NOT matching)
    --    end of options

These options can also be combined, e.g. as in "-li", in any
order and combination you like.

In the rare case that the <perlregexp> starts with a minus sign,
use the double dash "--" to signify the end of the options list first:

Example: pgrep -- - pgrep*

Note that you can also pass a list of filenames to this script via
STDIN to grep through:

Example: find . -type f -print | pgrep <perlregexp> | more

This will grep through the CONTENTS of the files returned by "find".

The following will grep through the NAMES of the files returned by
"find":

Example: find . -type f -print | pgrep <perlregexp> - | more

The tool prints a usage if called without any parameters at all.

For more information on "grep", see also its corresponding manual
pages ("man grep", "man egrep") on your (UNIX) system.

Note that this tool is not restricted to UNIX platforms, though,
it will run wherever Perl does!

Just install this tool somewhere in your search path, e.g.
"/usr/local/bin" or "C:\Windows\System32".

Don't forget to adjust the shell-bang line (the first line of the script)
of the Perl script "pgrep.pl" to match the path where Perl is installed on
your UNIX system (this is not necessary for the Windows version "pgrep.bat"),
and set the file permissions to "executable", e.g. with "chmod 555 pgrep.pl".

You may also want to remove the ".pl" file extension in order to save you
some typing when using it.

Non-UNIX and non-Windows users please refer to the documentation of their
Perl installation for instructions on how to install Perl scripts as
executable applications.

Enjoy!
--
    Steffen Beyer <STBEY@cpan.org>
    Free Perl and C Software for Download:
    http://www.engelschall.com/u/sb/download/
