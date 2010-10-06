use inc::Module::Install;
name 'MyApp-iKnow';
all_from 'lib/MyApp/iKnow.pm';

# requires '';
requires 'XML::TreePP';
requires 'XML::RSS';

tests 't/*.t';
author_tests 'xt';

test_requires 'Test::More';
auto_set_repository;
auto_include;
WriteAll;
