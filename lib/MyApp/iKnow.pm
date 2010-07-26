package MyApp::iKnow;
use strict;
use warnings;
use utf8;
use Carp;
use Encode;

use MyApp::iKnow::Items;
use MyApp::iKnow::Sentences;

our $VERSION = '0.01';

use overload ('""' => sub { $_[0]->as_string });

sub tr {
    my($class, $word) = @_;

    bless {
        items => MyApp::iKnow::Items->search($word),
        sentences => MyApp::iKnow::Sentences->search($word),
    }, $class;
}

sub as_string {
    my($self, $word) = @_;

    my @strings= map {
        sprintf("%s\t%s", $_->{en}, $_->{ja});
    } @{$self->{items}}, @{$self->{sentences}};

    join "\n", @strings;
}

1;
__END__

=head1 NAME

MyApp::iKnow -

=head1 SYNOPSIS

  use MyApp::iKnow;

=head1 DESCRIPTION

MyApp::iKnow is

=head1 AUTHOR

monmon E<lt>noE<gt>

=head1 SEE ALSO

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
