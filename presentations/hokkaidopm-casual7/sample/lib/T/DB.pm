package T::DB;

use parent 'Teng';

package T::DB::Schema;

use Teng::Schema::Declare;

table {
    name 'artists';
    pk 'id';
    columns qw(id name);
};

table {
    name 'cds';
    pk 'id';
    columns qw(id artists_id title);
};
1;
