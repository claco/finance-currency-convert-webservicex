# $Id$
use ExtUtils::MakeMaker;
use strict;
use warnings FATAL => 'all';

WriteMakefile(
    NAME            =>  'Finance::Currency::Convert::WebserviceX',
    VERSION_FROM    =>  'lib/Finance/Currency/Convert/WebserviceX.pm',
    ABSTRACT        =>  'Lightweight currency conversion using WebserviceX.NET',
    ($] >= 5.005 ?
        (AUTHOR     =>  'Christopher H. Laco <claco@chrislaco.com>') : ()),
    PREREQ_PM       =>  {
        'LWP'            => undef,
        'HTTP::Response' => undef
    },
    (ExtUtils::MakeMaker->VERSION >= 6.11) ?
    (NO_META      => 1) : (),

    dist => {
        PREOP => 'pod2text lib/Finance/Currency/Convert/WebserviceX.pm > $(DISTVNAME)/README',
    }
);
