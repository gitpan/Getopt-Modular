#!perl -T

use Test::More qw(no_plan); # tests => 1;

# for ease-of-use:
package GM;
use Test::More;
BEGIN {
    use_ok( 'base', 'Getopt::Modular');
}

package main;
use Data::Dumper;

GM->acceptParam(
                'foo|f' => {
                    spec => '!',
                    help => 'helpful foo that has a really nice, long annoying run-on boring description',
                    default => 5,
                },
               );

my @l = GM->getHelpRaw();
is_deeply($l[0]{param}, [ qw(--foo --nofoo -f) ], 'parameters right');
like($l[0]{help}, qr/helpful foo/, 'help right');
ok($l[0]{default}, 'default right');

SKIP: {
    eval { require Text::Table; 1 } or skip 5, 'Optional module Text::Table missing';

    my $help = GM->getHelp();
    like("$help", qr/helpful foo/);
};

