#!perl -wT
# $Id$
use strict;
use warnings;
use Test::More;
use File::Find;

eval 'use Test::Strict';
plan skip_all => 'Test::Strict not installed' if $@;

plan skip_all => 'Need untaint in newer File::Find' if $] <= 5.006;

## I hope this can go away if Test::Strict or File::Find::Rule
## finally run under -T. Until then, I'm on my own here. ;-)
my @files;

find({  wanted => \&wanted,
        untaint => 1,
        untaint_pattern => qr|^([-+@\w./]+)$|,
        untaint_skip => 1,
        no_chdir => 1
}, qw(lib t));

sub wanted {
    if ($File::Find::name =~ /\.(pm|pl|t)$/i) {
        push @files, $File::Find::name;
    };
};

if (scalar @files) {
    plan tests => scalar @files;
} else {
    plan tests => 1;
    fail 'No perl files found for Test::Strict checks!';
};

foreach (@files) {
    strict_ok($_);
};
