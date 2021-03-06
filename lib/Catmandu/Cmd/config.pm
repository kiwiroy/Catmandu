package Catmandu::Cmd::config;

use Catmandu::Sane;
use parent 'Catmandu::Cmd';
use Catmandu;
use JSON ();

sub command_opt_spec {
    (
        [ "pretty!", "prettyprint", { default => 1 } ],
    );
}

sub command {
    my ($self, $opts, $args) = @_;
    my $config = Catmandu->config;
    if ($args->[0]) {
        for my $key (split /\./, $args->[0]) {
            $config = $config->{$key};
        }
    }
    print JSON->new
        ->pretty($opts->pretty)
        ->encode($config);
}

1;

=head1 NAME

Catmandu::Cmd::config - print the Catmandu config as JSON
