# $Id$
use strict;
use warnings;
use inc::Module::Install 0.65;

name 'Finance-Currency-Convert-WebserviceX';
license 'perl';
perl_version '5.006001';
all_from 'lib/Finance/Currency/Convert/WebserviceX.pm';

requires 'LWP';
requires 'HTTP::Response';

tests 't/*.t t/*/*.t';
clean_files 'Finance-Currency-Convert-WebserviceX-* t/var';

auto_install;

WriteMakefile(
  dist => {
    PREOP => 'pod2text lib/Finance/Currency/Convert/WebserviceX.pm > $(DISTVNAME)/README'
  }
);
