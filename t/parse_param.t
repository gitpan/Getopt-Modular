#!perl -T

use Test::More qw(no_plan);
use Data::Dumper;

## due to a conflict between Test::Exception and Contextual::Return, force-
## load the latter to eliminate warning messages.
use Contextual::Return;
use Test::Exception;

# for ease-of-use:
package GM;
use Test::More;
BEGIN {
    use_ok( 'base', 'Getopt::Modular');
}

my $imand_set = 0;

GM->acceptParam(
                 'i' => { #integer test
                     aliases => 'Integer',
                     spec => '=i',
                     validate => sub { 1 <= $_ && $_ <= 10 }
                 },
                 'imand' => { #mandatory integer test
                     spec => '=i',
                     default => sub { $imand_set++; 8 },
                     mandatory => 1,
                 },
                 'f' => { # float test
                     spec => '=f',
                 },
                 'stuff' => {
                     spec => '=s@',
                     validate => sub {
                         for(@$_)
                         {
                             /foo/ or die "no 'foo' in --stuff";
                         }
                         1;
                     },
                 },
                );

package main;

@ARGV = qw(
    --Integer 8
    -f 3.145
    --stuff foobar
    --stuff foobaz
    );

lives_ok {GM->parseArgs()} 'parses no errors';
is($imand_set, 1, "Default sub called for mandatory arg");

is(GM->getOpt('i'), 8, "i parsed ok");
is(GM->getOpt('f'), 3.145, "f parsed ok");

do {
    local @ARGV = qw(
        --stuff blah
        );
    dies_ok {GM->parseArgs()} 'parses errors';
    my $e = Exception::Class->caught();
    like($e, qr/no 'foo'/, 'Checking error');
};

GM->unacceptParam('stuff');
do {
    local @ARGV = qw(
        --stuff fooblah
        );
    dies_ok {GM->parseArgs()} 'rejects unaccepted parameter';
    my $e = Exception::Class->caught();
    like($e->message(), qr/Bad command-line/, 'Checking error');
};
