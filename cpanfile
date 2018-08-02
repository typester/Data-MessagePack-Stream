requires 'perl', '5.008001';

on configure => sub {
    requires 'Devel::PPPort', '3.42';
    requires 'Module::Build::XSUtil';
};

on test => sub {
    requires 'Test::More', '0.98';
    requires 'Data::MessagePack';
};
