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

WriteAll;
