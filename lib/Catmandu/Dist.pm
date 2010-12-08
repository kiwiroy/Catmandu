package Catmandu::Dist;

use 5.010;
use Try::Tiny;
use Carp ();
use File::ShareDir;
use Path::Class ();
use Sub::Exporter -setup => {
    exports => [qw(
        share_dir
    )],
};

sub share_dir {
    state $share_dir //= try {
        File::ShareDir::dist_dir('Catmandu');
    } catch {
        /failed to find share dir for dist/i or Carp::croak $_;
        Path::Class::file(__FILE__)->dir->parent->parent
            ->subdir('share')
            ->absolute->resolve->stringify;
    };
}

no Try::Tiny;
1;
