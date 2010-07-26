#!/usr/bin/env perl
use strict;
use warnings;
use MyApp::iKnow;

my $word = shift || 'word';
warn MyApp::iKnow->tr($word);
