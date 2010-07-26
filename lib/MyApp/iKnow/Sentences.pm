package MyApp::iKnow::Sentences;
use strict;
use warnings;
use Carp;
use XML::RSS;

use MyApp::iKnow::Cache;

our $VERSION = '0.01';

sub search {
    my($class, $word) = @_;
    my $tr_lang = ($word =~ m/[a-zA-Z]+/xms) ? 'ja' : 'en';
    my $base = "http://api.iknow.co.jp";
    my $sentences_uri = URI->new_abs("/sentences/matching/$word.rss", $base);
    $sentences_uri->query_form(
        translation_language => $tr_lang,
        require_translation  => 'true',
    );

    my $file_path = MyApp::iKnow::Cache->get_file_path($sentences_uri);

    my $rss = XML::RSS->new;
    $rss->parsefile($file_path);
    my @res = map {
        +{ 
            en   => __trim($_->{title}),
            ja   => __trim($_->{description}), 
        }
    } @{$rss->{items}}; 

    \@res;
}

sub __trim {
    my $str = shift;
    $str =~ s! \s* (.*) \s* !$1!xm;

    $str;
}

1;
__END__
