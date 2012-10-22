package PerlIO::via::Collector64;

use strict;
use warnings;
use Acme::Collector64;

our $INDEX_TABLE = undef;

sub import {
    my $class = shift;
    my ($index_table) = @_;
    $INDEX_TABLE = $index_table;
}

sub PUSHED {
    my ( $class, $mode, $fh ) = @_;
    bless {
        collector => Acme::Collector64->new( index_table => $INDEX_TABLE ),
        buf       => '',
    }, $class;
}

sub WRITE {
    my $self = shift;
    my ( $buf, $fh ) = @_;
    $self->{buf} .= $buf;
    return length($buf);
}

sub FLUSH {
    my $self = shift;
    my $fh   = shift;
    print $fh $self->{collector}->encode( $self->{buf} )
        or return -1;
    $self->{buf} = '';
    return 0;
}

1;