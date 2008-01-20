#!perl -wT
# $Id$
use strict;
use warnings;
use Test::More;

BEGIN {
    plan skip_all => 'set TEST_AUTHOR to enable this test' unless $ENV{TEST_AUTHOR};
    plan tests => 12;

    use_ok('Finance::Currency::Convert::WebserviceX');
};

## return undef is the params are bogus
{
    my $cc = Finance::Currency::Convert::WebserviceX->new;
    isa_ok($cc, 'Finance::Currency::Convert::WebserviceX');

    is($cc->convert(), undef);
    is($cc->convert(1), undef);
    is($cc->convert(1, 'asdf'), undef);
    is($cc->convert(undef, 'USD', 'JPY'), undef);
};

## try a conversion. whos knows that the rate result will be
## but at least it will let us know it's a working connection
{
    my $cc = Finance::Currency::Convert::WebserviceX->new;
    isa_ok($cc, 'Finance::Currency::Convert::WebserviceX');

    isnt($cc->convert(2.00, 'USD', 'JPY'), undef);
};

## make sure we uc the from/to
{
    my $cc = Finance::Currency::Convert::WebserviceX->new;
    isa_ok($cc, 'Finance::Currency::Convert::WebserviceX');

    isnt($cc->convert(2.00, 'usd', 'jpy'), undef);
};

## bug fix. when the from and to are the same, the rate
## returned is 0, so the price returned was 0 instead of
## price * 1
{
    my $cc = Finance::Currency::Convert::WebserviceX->new;
    isa_ok($cc, 'Finance::Currency::Convert::WebserviceX');

    is($cc->convert(2.34, 'USD', 'USD'), 2.34);
};