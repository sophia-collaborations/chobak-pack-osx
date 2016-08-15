use strict;
use File::Basename;
use Cwd 'abs_path';

my $ourdir;
my $mycont;
my $mylast;

$ourdir = dirname(dirname(abs_path($0)));
$mycont = `cat $ourdir/info/vrsn.txt`; chomp($mycont);
$mylast = chop($mycont);
if ( $mylast ne 'x' ) { $mycont .= $mylast; }
if ( $mylast eq 'x' )
{
  my $lc_a;
  $lc_a = `date +%Y.%m%d.%H%M%S`; chomp($lc_a);
  $mycont .= '-bld' . $lc_a;
}

exec("echo",$mycont);


