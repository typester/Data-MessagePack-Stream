use strict;
use warnings;
use Test::More;
use Data::MessagePack;
use Data::MessagePack::Stream;

my $mp = Data::MessagePack->new;

my $stream = Data::MessagePack::Stream->new;

$stream->feed( $mp->encode( Data::MessagePack::true() ) );
$stream->feed( $mp->encode( Data::MessagePack::false() ) );

ok $stream->next, 'next ok';
my $t = $stream->data;
is(0+$t, 1);
is("$t", "true");
is(ref($t), "Data::MessagePack::Boolean");

ok $stream->next, 'next ok';
$t = $stream->data;
is(0+$t, 0);
is("$t", "false");
is(ref($t), "Data::MessagePack::Boolean");

done_testing;
