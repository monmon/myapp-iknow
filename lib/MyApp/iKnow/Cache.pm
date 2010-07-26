package MyApp::iKnow::Cache;
use strict;
use warnings;
our $VERSION = '0.01';

use utf8;
use Carp;
use Encode;
use Digest::MD5 qw(md5_hex);
use FindBin qw($Bin);
use LWP::Simple ();
use Path::Class;

our $CacheDir;

sub __cache_dir {
    $CacheDir ||= dir($Bin)->subdir('cache')->stringify;

    if (! -e $CacheDir) {
        mkdir $CacheDir or die "cannot create $CacheDir: $!";
    }
}

sub get_file_path {
    my($class, $uri) = @_;

    __cache_dir();
    my $cache = sprintf("%s/%s", $CacheDir, Digest::MD5::md5_hex($uri));
    
    my $status = LWP::Simple::mirror($uri, $cache)
        or die "cannot get content from $uri: $!";

    $cache;
}

1;
__END__
