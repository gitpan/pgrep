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

The letter options can also be combined, e.g. as in "-li", in any
order and combination you like.

In the rare case that the <perlregexp> starts with a minus sign,
in order for it not to be confused with an (invalid) option, use
the double dash "--" to signify the end of the options list first:

Example: pgrep -- - pgrep*

Note that wildcards in filenames also work under Windows (but only
on the command line).

Note that you can also pass a list of filenames to this script via
STDIN to grep through (no wildcards are expanded in this case):

Example: find . -type f -print | pgrep <perlregexp> | more

This will grep through the CONTENTS of the files returned by "find".

The following will grep through the NAMES of the files returned by
"find":

Example: find . -type f -print | pgrep <perlregexp> - | more

BEWARE (counter-intuitive!) that the dash "-" filename is absolutely
essential whenever you are filtering the output of some program:

Example: <someprogram> | pgrep -<options> <perlregexp> - | more

Mnemonic: Each pipe "|" (before) needs its junction "-" (behind)!

The tool prints a help text if called without parameters or with
invalid options.

For more information on "grep", see also its corresponding manual
pages ("man grep", "man egrep") on your (UNIX) system.

Note that this tool is not restricted to UNIX platforms, though,
it will run wherever Perl does!

In order to install this script, type the following commands:

    UNIX:                         Windows:

    perl Makefile.PL              perl Makefile.PL
    make install                  nmake install

This is the recommended method. Alternatively, just move or copy
the file "pgrep" to somewhere in your search path.

Before doing so, under UNIX, don't forget to edit "pgrep" and to
adjust the shell-bang line (the first line of the script) to match
the path where the "perl" binary is located on your system.

Then proceed as follows (illustrative example):

    UNIX:                         Windows:

    chmod 555 pgrep               pl2bat pgrep
    cp -p pgrep /usr/local/bin    copy pgrep.bat C:\Windows\System32

Non-UNIX and non-Windows users please refer to the documentation
of your Perl installation for instructions on how to install Perl
scripts as executable applications if none of the above works.

Enjoy!
--
    Steffen Beyer <STBEY@cpan.org>
    Free Perl and C Software for Download:
    http://www.engelschall.com/u/sb/download/
