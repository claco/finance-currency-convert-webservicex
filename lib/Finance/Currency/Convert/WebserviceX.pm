# $Id$
package Finance::Currency::Convert::WebserviceX;
use strict;
use warnings;
use vars qw($VERSION);
use LWP::UserAgent;

$VERSION = '0.01';

sub new {
    my $class = shift;
    my $self = bless{response => undef}, ref $class || $class;

    my $ua = LWP::UserAgent->new;
    $ua->timeout(10);
    $ua->env_proxy;

    $self->{'ua'} = $ua;

    return $self;
};

sub convert {
    my $self = shift;
    my $value = shift || '';
    my $from = shift || '';
    my $to = shift || '';

    $from = uc($from);
    $to   = uc($to);

    return unless length $value && $from =~ /^[A-Z]{3}$/ && $to =~ /^[A-Z]{3}$/;

    my $uri = sprintf('http://www.webservicex.net/CurrencyConvertor.asmx/ConversionRate?FromCurrency=%s&ToCurrency=%s', $from, $to);

    eval {
        $self->{'response'} = undef;
        $self->{'response'} = $self->{'ua'}->get($uri);
    };

    return if $@;

    if (!$self->{'response'}->is_success) {
        return undef;
    } else {
        if ($self->{'response'}->content =~ /<double.*>(.*)<\/double>/i) {
            return $value*$1;
        } else {
            return undef;
        };
    };
};

1;
__END__

=head1 NAME

Finance::Currency::Convert::WebserviceX - Lightweight currency conversion using WebserviceX.NET

=head1 SYNOPSIS

    use Finance::Currency::Convert::WebserviceX;
    my $cc = Finance::Currency::Convert::WebserviceX->new;
    my $result = $cc->convert(1.95, 'USD', 'JPY');

=head1 DESCRIPTION

This is a lightweight module to do currency conversion using the Curency Convertor
web service at http://www.webservicex.net/.

The motivation for this module was many fold. First, L<Finance::Currency::Convert>
with L<Finance::Quote> was a little too bulky for my needs, esp the need to download
or maintain conversion tables. L<Finance::Currency::Convert::Yahoo> seemed to be
based on screen scraping. Way to fragile for my taste.
L<Finance::Currency::Convert::XE> has usage restrictions from XE.com.
[No offense intended to any of the authors above]

=head1 CONSTRUCTOR

You know the routine. C<new> is your friend.

    use Finance::Currency::Convert::WebserviceX;
    my $cc = Finance::Currency::Convert::WebserviceX->new;


=head1 METHODS

=head2 convert($value, $from, $to)

=over

=item value

The number or price to be converted.

=item from

The three letter ISO currency code for the currency amount
specified in C<value>. See L<Locale::Currency> for the available
currency codes.

=item to

The three letter ISO currency code for the currency you want the
C<value> to be converted to. See L<Locale::Currency> for the available
currency codes.

=back

=head1 SEE ALSO

L<Locale::Currency>, L<Finance::Currency::Format>

=head1 AUTHOR

    Christopher H. Laco
    CPAN ID: CLACO
    claco@chrislaco.com
    http://today.icantfocus.com/blog/