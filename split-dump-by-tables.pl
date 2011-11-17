#!/usr/bin/perl -w

# Split the insert statements of `pg_dump ... -Fp --inserts`
# into one file per table. If arguments are passed they are
# all considered table names to process. Otherwise all tables
# are parsed.
# Input is read from STDIN. Debugging stuff goes to STDERR.
# STDOUT is unused.
#
# <imagine usual no waranty stuff here>
 
use strict;

my $out_files = {};

while(<STDIN>) {
    next if ! m/^INSERT INTO (.*?) /;

    write_to_file($_, $1) if $#ARGV == -1;

    # this is the fun part
    if(grep { $_ eq $1 } @ARGV) {
        write_to_file($_, $1);
        @ARGV = sort { $a ne $1; } @ARGV if $ARGV[0] ne $1;
    }
}

sub write_to_file {
    my ($line, $table_name) = @_;

    my $file_name = "${table_name}.sql";

    if(!defined $out_files->{$file_name}) {
        open $out_files->{$file_name}, '>', $file_name;
        print STDERR "> $file_name\n";
    }

    my $fh = $out_files->{$file_name};

    print $fh $line;
}
