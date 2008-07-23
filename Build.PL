use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
    module_name         => 'Getopt::Modular',
    license             => 'perl',
    dist_author         => 'Darin McBride <dmcbride@cpan.org>',
    dist_version_from   => 'lib/Getopt/Modular.pm',
    build_requires => {
        'Test::More'       => 0,
        'Contextual::Return' => '0.2.1',
        'List::MoreUtils'  => 0,
        'Exception::Class' => 0,
        'Test::Exception'  => 0,
        'Smart::Comments'  => 0,
    },
    recommends => {
        'Text::Table' => 0,
    },
    #create_makefile_pl => 'traditional',
);

$builder->create_build_script();
