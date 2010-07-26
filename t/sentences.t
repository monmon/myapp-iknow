use strict;
use Test::More;

use Data::Dumper;

BEGIN { use_ok 'MyApp::iKnow::Sentences' }

can_ok('MyApp::iKnow::Sentences', 'search');
my $sentences_ref = MyApp::iKnow::Sentences->search('word');
isa_ok($sentences_ref, 'ARRAY');

for my $items (@{$sentences_ref}) {
    isa_ok($items, 'HASH');
    ok(exists $items->{en});
    ok(exists $items->{ja});
}

done_testing;
