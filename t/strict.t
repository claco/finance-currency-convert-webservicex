#!perl -wT
# $Id$
use strict;
use warnings;
use Test::More;
use File::Find;

eval 'use Test::Strict 0.05';
plan skip_all => 'Test::Strict 0.05 not installed' if $@;

plan skip_all => 'Need untaint in newer File::Find' if $] <= 5.006;

{
    no warnings;
    $Test::Strict::TEST_SYNTAX   = 0;
    $Test::Strict::TEST_STRICT   = 1;
    $Test::Strict::TEST_WARNINGS = 1;
};

all_perl_files_ok();