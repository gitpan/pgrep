
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME      => 'pgrep',
    VERSION   => '1.4',
    EXE_FILES => ['pgrep'],
    'dist'    => { COMPRESS => "gzip -9", SUFFIX => "gz" }
);

