package Foo;

use 5.014002;
use strict;
use warnings;
use Scalar::Util qw(looks_like_number);

our @ISA = qw();

our $VERSION = '0.01';

sub sum {
    my @num;
    if ( @_ == 1 && ref $_[0] eq 'ARRAY' ) {
        @num = @{ $_[0] }
    }
    elsif ( @_ == 1 && ref $_[0] eq 'HASH' ) {
        die 'Usage: Foo::sum(@array|\@array)';
    }
    else {
        @num = @_;        
    }

    my $total = 0;
    for ( grep looks_like_number($_), @num ) {
        $total += $_;
    }
    return $total;
}

# Preloaded methods go here.

1;
__END__
# Below is stub documentation for your module. You'd better edit it!

=head1 NAME

Foo - Perl extension for blah blah blah

=head1 SYNOPSIS

  use Foo;
  blah blah blah

=head1 DESCRIPTION

Stub documentation for Foo, created by h2xs. It looks like the
author of the extension was negligent enough to leave the stub
unedited.

Blah blah blah.


=head1 SEE ALSO

Mention other useful documentation such as the documentation of
related modules or operating system documentation (such as man pages
in UNIX), or any relevant external documentation such as RFCs or
standards.

If you have a mailing list set up for your module, mention it here.

If you have a web site set up for your module, mention it here.

=head1 AUTHOR

ysasaki, E<lt>ysasaki@(none)E<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2013 by ysasaki

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.14.2 or,
at your option, any later version of Perl 5 you may have available.


=cut
