use strict;
use Test::More;

use Data::Dumper;

BEGIN { use_ok 'MyApp::iKnow::Items' }

can_ok('MyApp::iKnow::Items', 'search');
my $items_ref = MyApp::iKnow::Items->search('word');
isa_ok($items_ref, 'ARRAY');

for my $items (@{$items_ref}) {
    isa_ok($items, 'HASH');
    ok(exists $items->{en});
    is(ref $items->{en}, '');
    ok(exists $items->{ja});
    is(ref $items->{ja}, '');
}

done_testing;
