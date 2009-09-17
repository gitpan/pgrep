#!perl

###############################################################################
##                                                                           ##
##    "pgrep" (= "perl grep") version 1.2 (17-Sep-2009)                      ##
##                                                                           ##
##    Copyright (c) 1998 - 2009 by Steffen Beyer. All rights reserved.       ##
##                                                                           ##
##    This program is free software; you can redistribute it                 ##
##    and/or modify it under the same terms as Perl itself.                  ##
##                                                                           ##
###############################################################################

# Usage: pgrep [-i|-l|-v|-ilv] <perlregexp> [<filename>|-]

$self = $0;
$self =~ s!^.*[/\\:]!!;
$self =~ s!\.+[^.]*$!!;

$ignore_case = 0;
$list_filenames = 0;
$invert_result = 0;

while (@ARGV)
{
    last if (substr($ARGV[0],0,1) ne '-');
    $_ = shift;
    last if ($_ eq '--');
    if (/^-[ilv]+$/)
    {
        if (/i/) { $ignore_case = 1; }
        if (/l/) { $list_filenames = 1; }
        if (/v/) { $invert_result = 1; }
    }
    else { die "$self: unknown option '$_' encountered!\n"; }
}

unless (@ARGV)
{
    die "Usage: $self [-i|-l|-v|-ilv] <perlregexp> [<filename>|-]\n";
}

$reg_exp = shift;

$_ = '';
eval { /$reg_exp/o };
if ($@)
{
    if ($@ =~ /^(.+?)\s+at\s/) { die "$self: $1!\n"; }
    else                       { die "$self: $@"; }
}

if (@ARGV) { @ARGV = map( {glob}            @ARGV ) if $^O eq 'MSWin32'; }
else       { @ARGV = map( {s/[\n\r]+$//;$_}   <>  );                     }

$skip = 0;
while (@ARGV)
{
    $name = 1;
    $file = shift;
    $flag = $list_filenames;
    if ($file eq '-')
    {
        next if ($skip);
        $skip = 1; # STDIN can only be read once
        $name = 0; # There is no filename associated with STDIN to print
        $flag = 0; # Listing the names of the matching files makes no sense for STDIN
    }
    else
    {
        unless (-f $file)
        {
            warn "$self: file '$file' does not exist!\n";
            next;
        }
    }
    unless (open(FH, "<$file"))
    {
        warn "$self: unable to open file '$file': $!\n";
        next;
    }
    if ($invert_result)
    {
        if ($ignore_case)
        {
            while (<FH>)
            {
                unless (/$reg_exp/io)
                {
                    if ($flag) { print "$file\n"; close(FH); next; }
                    else { if ($name) { print "$file:$_"; } else { print; } }
                }
            }
        }
        else
        {
            while (<FH>)
            {
                unless (/$reg_exp/o)
                {
                    if ($flag) { print "$file\n"; close(FH); next; }
                    else { if ($name) { print "$file:$_"; } else { print; } }
                }
            }
        }
    }
    else
    {
        if ($ignore_case)
        {
            while (<FH>)
            {
                if (/$reg_exp/io)
                {
                    if ($flag) { print "$file\n"; close(FH); next; }
                    else { if ($name) { print "$file:$_"; } else { print; } }
                }
            }
        }
        else
        {
            while (<FH>)
            {
                if (/$reg_exp/o)
                {
                    if ($flag) { print "$file\n"; close(FH); next; }
                    else { if ($name) { print "$file:$_"; } else { print; } }
                }
            }
        }
    }
    close(FH);
}

__END__

