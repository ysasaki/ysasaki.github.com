use utf8;
package D::Schema::Result::Cd;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

D::Schema::Result::Cd

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<cds>

=cut

__PACKAGE__->table("cds");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 artists_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 title

  data_type: 'text'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "artists_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "title",
  { data_type => "text", is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 artist

Type: belongs_to

Related object: L<D::Schema::Result::Artist>

=cut

__PACKAGE__->belongs_to(
  "artist",
  "D::Schema::Result::Artist",
  { id => "artists_id" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);


# Created by DBIx::Class::Schema::Loader v0.07033 @ 2012-11-20 00:22:21
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:lp1jXRHoQIu2KKKk5SZlyQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
