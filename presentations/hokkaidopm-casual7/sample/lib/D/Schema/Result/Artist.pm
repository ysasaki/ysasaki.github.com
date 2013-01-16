use utf8;
package D::Schema::Result::Artist;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

D::Schema::Result::Artist

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<artists>

=cut

__PACKAGE__->table("artists");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 name

  data_type: 'text'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "name",
  { data_type => "text", is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 cds

Type: has_many

Related object: L<D::Schema::Result::Cd>

=cut

__PACKAGE__->has_many(
  "cds",
  "D::Schema::Result::Cd",
  { "foreign.artists_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07033 @ 2012-11-20 00:22:21
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:5+3ef47LapiX4CRM5+0YsA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
