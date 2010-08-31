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
                'bar|b' => {
                    spec => '!',
                    help => qq[helpful bar that has a really nice, long annoying run-on boring description],
                    default => 1,
                    help_bool => [ qw/ yuck yum / ],
                },
               );

my @l = GM->getHelpRaw();
is_deeply($l[1]{param}, [ qw(--foo --nofoo -f) ], 'parameters right');
like($l[1]{help}, qr/helpful foo/, 'help right');
like($l[1]{default}, qr/on/, 'default right') or diag(Dumper $l[0]);

SKIP: {
    eval { require Text::Table; 1 } or skip 'Optional module Text::Table missing', 3;

    my $help = GM->getHelp();
    like("$help", qr/helpful foo/);
    like("$help", qr/\[on\]/);
    like("$help", qr/nofoo.*Default/);
};

SKIP: {
    eval { require Text::Table; require Text::Wrap; 1 } or skip 'Optional modules Text::Table, Text::Wrap missing', 7;

    my $help = GM->getHelpWrap();
    like("$help", qr/helpful foo/);
    like("$help", qr/\[on\]/);
    like("$help", qr/nofoo.*description/);
    unlike("$help", qr/nofoo.*long/);

    $help = GM->getHelpWrap(30);
    like("$help", qr/helpful foo/);
    like("$help", qr/\[yum\].*\[on\]/sm);
    like("$help", qr/nofoo.*really nice/);
};
