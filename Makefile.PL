use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    NAME         => 'WebService::Mogo2',
    VERSION_FROM => 'lib/WebService/Mogo2.pm',
    AUTHOR       => 'Masahiro Nagano (kazeburo@gmail.com)',
    ABSTRACT     => 'Perl Interface to mogo2.jp',
    PREREQ_PM    => {
                     'Test::Simple' => 0.44,
                     'Net::Twitter' => 1.04,
                     'JSON::Any'    => 0,
                     'URI'          => 0,
                    },
);
