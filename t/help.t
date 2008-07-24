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
                    help => qq[helpful foo that has a really nice, long annoying run-on boring description],
                    default => 5,
                },
               );

my @l = GM->getHelpRaw();
is_deeply($l[0]{param}, [ qw(--foo --nofoo -f) ], 'parameters right');
like($l[0]{help}, qr/helpful foo/, 'help right');
like($l[0]{default}, qr/on/, 'default right') or diag(Dumper $l[0]);

SKIP: {
    eval { require Text::Table; 1 } or skip 2, 'Optional module Text::Table missing';

    my $help = GM->getHelp();
    like("$help", qr/helpful foo/);
    like("$help", qr/\[on\]/);
    like("$help", qr/nofoo.*Default/);
};

SKIP: {
    eval { require Text::Table; require Text::Wrap; 1 } or skip 2, 'Optional modules Text::Table, Text::Wrap missing';

    my $help = GM->getHelpWrap();
    like("$help", qr/helpful foo/);
    like("$help", qr/\[on\]/);
    like("$help", qr/nofoo.*description/);
};



