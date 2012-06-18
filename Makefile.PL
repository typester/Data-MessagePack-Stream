use strict;
use warnings;

BEGIN {
    my @devmods = qw(
        Module::Install::AuthorTests
        Module::Install::ReadmeFromPod
        Module::Install::Repository
        Module::Install::XSUtil
    );
    my @not_available;

    eval qq{use inc::Module::Install; 1;} or push @not_available, 'inc::Module::Install';
    for my $mod (@devmods) {
        eval qq{require $mod} or push @not_available, $mod;
    }
    if (@not_available) {
        print qq{# The following modules are not available.\n};
        print qq{# `$^X $0 | cpanm` will install them:\n};
        print $_, "\n" for @not_available;
        print "\n";
        exit -1;
    }
}

use inc::Module::Install;

name 'Data-MessagePack-Stream';
all_from 'lib/Data/MessagePack/Stream.pm';

use_ppport 3.19;
cc_src_paths 'src';
cc_include_paths 'msgpack-0.5.7/src';
cc_warnings;

test_requires 'Data::MessagePack';

my ($amd64) = qx{ $^X -V } =~ /(amd64|x86_64)/i;

makemaker_args->{MYEXTLIB} = 'msgpack-0.5.7/src/.libs/libmsgpack$(LIB_EXT)';

if ($amd64) {
{
    package MY;
    sub postamble {
        <<'__EOF__';
$(MYEXTLIB):
	cd msgpack-0.5.7 && ./configure --with-pic --disable-shared && $(MAKE)

__EOF__
    }
}
}
else {
{
    package MY;
    sub postamble {
        <<'__EOF__';
$(MYEXTLIB):
	cd msgpack-0.5.7 && ./configure --disable-shared && $(MAKE)

__EOF__
    }
}
}

readme_from 'lib/Data/MessagePack/Stream.pm';
author_tests 'xt';
auto_set_repository;

WriteAll;
