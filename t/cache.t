use strict;
use Test::More;

use URI;

BEGIN { use_ok 'MyApp::iKnow::Cache' }

my $uri = URI->new_abs("/", "http://example.com");

can_ok('MyApp::iKnow::Cache', 'get_file_path');
my $file_path = MyApp::iKnow::Cache->get_file_path($uri);
ok($file_path);

done_testing;
