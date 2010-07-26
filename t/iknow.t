use strict;
use Test::More;

use MyApp::iKnow;
use Data::Dumper;

can_ok('MyApp::iKnow', 'tr');
my $iknow = MyApp::iKnow->tr('word');
isa_ok($iknow, 'MyApp::iKnow');
ok(exists $iknow->{items}, 'exists items');
ok(exists $iknow->{sentences}, 'exists sentences');
isa_ok($iknow->{items}, 'ARRAY');
isa_ok($iknow->{sentences}, 'ARRAY');

can_ok($iknow, 'as_string');


done_testing;
