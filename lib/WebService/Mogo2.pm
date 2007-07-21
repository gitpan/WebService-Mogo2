package WebService::Mogo2;

use strict;
use warnings;
use base qw/Net::Twitter/;
use JSON::Any;
use URI;
our $VERSION     = '0.01';

sub new {
    my $class = shift;
    my %conf = @_;

    $conf{apiurl} = 'http://api.mogo2.jp/statuses' unless defined $conf{apiurl};
    $conf{apihost} = 'api.mogo2.jp:80' unless defined $conf{apihost};
    $conf{apirealm} = 'mogo2 api basic auth' unless defined $conf{apirealm};

    $class->SUPER::new(%conf);
}

sub _request {
    my $self = shift;
    my $path = shift;
    my $uri = URI->new( $self->{apiurl} . $path );
    $uri->query_form(@_);
    my $req = $self->{ua}->post($uri);
    return ($req->is_success) ? JSON::Any->jsonToObj($req->content) : undef;
}

sub public_timeline {
    my $self = shift;
    $self->_request("/public_timeline.json", @_);
}


sub thread_timeline {
    my $self = shift;
    my $id   = shift;
    $self->_request("/thread_timeline/$id.json", @_);
}


sub friends_timeline {
    my $self = shift;
    my $id;
    if ( @_ % 2 ) {
        $id = shift;
    }
    my $uri = $id ? "/friends_timeline/$id.json" : "/friends_timeline.json";
    $self->_request($uri, @_);
}

sub user_timeline {
    my $self = shift;
    my $id;
    if ( @_ % 2 ) {
        $id = shift;
    }
    my $uri = $id ? "/user_timeline/$id.json" : "/user_timeline.json";
    $self->_request($uri, @_);
}


1;

__END__
=head1 NAME

WebService::Mogo2 - Perl Interface to mogo2.jp

=head1 SYNOPSIS

 use WebService::Mogo2;
 my $mogo2 = WebService::Mogo2->new(
     username => 'example@example.com',
     password => 'mypass'
 );
 $result = $mogo2->update("My current Status");

=head1 DESCRIPTION

WebService::Mogo2 impliments perl interface to mogo2.jp's API. This modules is based on Net::Twitter.

=head1 METHODS

=over 4

=item thread_timeline

 $mogo2->thread_timeline( $id, since => '..' );

=back

=head1 OVERRIDE METHODS

=over 4

=item public_timeline

 $mogo2->public_timeline( since_id => '..' );

=item friends_timeline

 $mogo2->friends_timeline( count => '..', since => '..' );
 $mogo2->friends_timeline( $id, count => '..', since => '..' );

=item user_timeline

 $mogo2->user_timeline( count => '..', since => '..' );
 $mogo2->user_timeline( $id, count => '..', since => '..' );

=back

=head1 SEE ALSO

L<Net::Twitter>, L<http://mogo2.jp/api.shtml>

=head1 AUTHOR

Masahiro Nagano C<< <<kazeburo@gmail.com>> >>

=head1 COPYRIGHT

Copyright (c) 2007 by Masahiro Nagano

This program is free software; you can redistribute
it and/or modify it under the same terms as Perl itself.

The full text of the license can be found in the
LICENSE file included with this module.


=cut

