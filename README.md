# Data::MessagePack::Stream [![Build Status](https://secure.travis-ci.org/typester/Data-MessagePack-Stream.png?branch=master)](http://travis-ci.org/typester/Data-MessagePack-Stream)

Yet another msgpack streaming deserializer for Perl.

## SYNOPSIS

    use Data::Dumper;
    my $unpacker = Data::MessagePack::Stream->new;
    
    while (read($fh, my $buf, 1024)) {
        $unpacker->feed($buf);
    
        while ($unpacker->next) {
            print Dumper($unpacker->data);
        }
    }

## DESCRIPTION

Data::MessagePack::Stream is streaming deserializer for MessagePack.

This module is alternate for Data::MessagePack::Unpacker.
Unlike original unpacker, this module support internal buffer and it's possible to handle streaming data correctly.

