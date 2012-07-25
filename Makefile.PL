
use strict;
use warnings;



use ExtUtils::MakeMaker 6.30;



my %WriteMakefileArgs = (
  "ABSTRACT" => "Modular access to Getopt::Long",
  "AUTHOR" => "Darin McBride <dmcbride\@cpan.org>",
  "BUILD_REQUIRES" => {
    "Data::Dumper" => 0,
    "Module::Build" => "0.3601",
    "Test::Exception" => 0,
    "Test::More" => 0
  },
  "CONFIGURE_REQUIRES" => {
    "Module::Build" => "0.3601"
  },
  "DISTNAME" => "Getopt-Modular",
  "EXE_FILES" => [],
  "LICENSE" => "perl",
  "NAME" => "Getopt::Modular",
  "PREREQ_PM" => {
    "Carp" => 0,
    "Exception::Class" => 0,
    "Getopt::Long" => 0,
    "List::MoreUtils" => 0,
    "Scalar::Util" => 0,
    "Text::Table" => 0,
    "Text::Wrap" => 0,
    "Text::WrapI18N" => 0,
    "strict" => 0,
    "warnings" => 0
  },
  "VERSION" => "0.08",
  "test" => {
    "TESTS" => "t/*.t"
  }
);


unless ( eval { ExtUtils::MakeMaker->VERSION(6.56) } ) {
  my $br = delete $WriteMakefileArgs{BUILD_REQUIRES};
  my $pp = $WriteMakefileArgs{PREREQ_PM};
  for my $mod ( keys %$br ) {
    if ( exists $pp->{$mod} ) {
      $pp->{$mod} = $br->{$mod} if $br->{$mod} > $pp->{$mod};
    }
    else {
      $pp->{$mod} = $br->{$mod};
    }
  }
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);



