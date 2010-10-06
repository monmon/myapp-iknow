package MyApp::iKnow::Items;
use strict;
use warnings;
use Carp;
use XML::TreePP;

use MyApp::iKnow::Cache;

our $VERSION = '0.01';


sub search {
    my($class, $word, $tr_lang) = @_;
    my $base = "http://api.iknow.co.jp";
    my $items_uri = URI->new_abs("/items/matching/$word.xml", $base);

    my $file_path = MyApp::iKnow::Cache->get_file_path($items_uri);

    my $parser = XML::TreePP->new(utf8_flag => 1);
    my $tree_ref = $parser->parsefile($file_path);

    my $total_res = $tree_ref->{vocabulary}->{'openSearch:totalResults'};
    use Data::Dumper;
    warn Dumper $total_res;
    warn ref $tree_ref->{vocabulary}->{items}->{item};
    #my $items_ref = ($total_res == 1) ? [$tree_ref->{vocabulary}->{items}->{item}]
    #              : ($total_res)      ? $tree_ref->{vocabulary}->{items}->{item}
    #              :                     {}
    #              ;
    my $items_ref = ($total_res > 0) ? $tree_ref->{vocabulary}->{items}->{item}
                  :                    {}
                  ;

    my %tr_of;
    if (ref $items_ref eq 'ARRAY') {
        for my $item_ref (@{$items_ref}) {
            my $en = $item_ref->{cue}->{text};
            
            my @ja = split /,\s*/, $item_ref->{responses}->{response}->{text};
            my %seen = $tr_of{$en}->{_seen} ? %{$tr_of{$en}->{_seen}} : ();
            # uniq
            push @{$tr_of{$en}->{ja}}, grep {
                $_ if !$seen{$_}++;
            } @ja;
            
            $tr_of{$en}->{link} = $item_ref->{cue}->{sound};
            $tr_of{$en}->{_seen} = \%seen;
        }
    }

    my @res = map {
        +{
            en   => $_,
            ja   => join ", ", @{$tr_of{$_}->{ja}},
        };
    } keys %tr_of;

    \@res;
}

1;
__END__
