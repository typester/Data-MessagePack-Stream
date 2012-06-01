use strict;
use warnings;

BEGIN {
    my @devmods = qw(
        inc::Module::Install
        Module::Install::AuthorTests
        Module::Install::ReadmeFromPod
        Module::Install::Repository
        Module::Install::XSUtil
    );
    my @not_available;
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
cc_include_paths 'deps/msgpack/cpp/src';
cc_warnings;

test_requires 'Data::MessagePack';

makemaker_args->{MYEXTLIB} = 'deps/msgpack/cpp/src/.libs/libmsgpack$(LIB_EXT)';

{
    package MY;
    sub postamble {
        <<'__EOF__';
$(MYEXTLIB):
	cd deps/msgpack/cpp && ./bootstrap && ./configure --disable-shared && $(MAKE)

__EOF__
    }
}

readme_from 'lib/Data/MessagePack/Stream.pm';
author_tests 'xt';
auto_set_repository;

WriteAll;
