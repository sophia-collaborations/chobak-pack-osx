#! /usr/bin/perl
use strict;
use File::Basename;
use Cwd 'abs_path';

my $git_src_src = 'https://www.kernel.org/pub/software/scm/git/git-2.9.3.tar.gz';
my $git_slc_vrs = 'git-2.9.3';

my $start_loc;
my $ourdir;
my $git_src_loc;
my $soft_3p;
my $hme;

$start_loc = `pwd`; chomp($start_loc);

$hme = $ENV{"HOME"};
if ( $hme eq '' ) { $hme = `cd && pwd`; chomp($hme); }
&chadira($start_loc);

$ourdir=dirname(dirname(abs_path($0)));
$soft_3p = $hme . '/etc/chobakwrap/3p/';
$git_src_loc = $soft_3p . '/' . $git_slc_vrs;


system("rm","-rf",($ourdir . "/x-tmp"));

sub endmesage {
  my $lc_rg;
  system("mkdir","-p",($ourdir . "/x-tmp"));
  open TAKAI, ("| cat > " . $ourdir . "/x-tmp/end-mesg.txt");
  foreach $lc_rg (@_)
  {
    print TAKAI $lc_rg;
    print TAKAI "\n";
  }
  close TAKAI;
}

&endmesage("Installation failed.");

sub endshell {
  my $lc_rg;
  system("mkdir","-p",($ourdir . "/x-tmp"));
  open TAKAI, ("| cat > " . $ourdir . "/x-tmp/end-action.sh");
  foreach $lc_rg (@_)
  {
    print TAKAI $lc_rg;
    print TAKAI "\n";
  }
  close TAKAI;
}

sub chadira {
  my $lc_rg;
  my $lc_ok;
  my $lc_fr;
  foreach $lc_rg (@_)
  {
    $lc_ok = chdir($lc_rg);
    if ( $lc_ok < 0.5 )
    {
      $lc_fr = `pwd`; chomp($lc_fr);
      die "\nFATAL ERROR: Can not change directory:\n"
      . "    From: " . $lc_fr . " :\n"
      . "      To: " . $lc_rg . " :\n"
      . "\n"
      ;
    }
  }
}

sub func_install_json {
  my $lc_test;
  
  # If JSON is installed, we can already return to the
  # calling program.
  $lc_test = 10;
  if(system("perl -e \"use JSON;\"")) { $lc_test = 0; }
  system("echo","\n\nJSON Presend Test:\nTEST RESULT: " . $lc_test);
  if ( $lc_test > 5 ) { return; }
  
  # If not, we first must install CPANM - and then install
  # JSON:
  &func_install_cpanm();
  system("sudo cpanm -i JSON");
}

sub func_install_cpanm {
  my $lc_loca;
  
  $lc_loca = `which cpanm`; chomp($lc_loca);
  if ( $lc_loca ne '' ) { return; }
  
  system('sudo chown -R "$(whoami)" ~/.cpanm');
  system('curl -L http://cpanmin.us | perl - --sudo App::cpanminus');
  system('sudo chown -R "$(whoami)" ~/.cpanm');
}

sub func_install_git {
  my $lc_loca;
  
  $lc_loca = `which cpanm`; chomp($lc_loca);
  if ( $lc_loca ne '' ) { return; }
  
  &endmesage(
    "Your browser is about to be opened with a link to download a package for",
    "installing GIT on your system. Once you have installed GIT, try this installation",
    "again."
  );
  &endshell(
    "open 'http://sourceforge.net/projects/git-osx-installer/files/git-2.9.2-intel-universal-mavericks.dmg/download?use_mirror=autoselect'"
  );
  exit(0);
  
  #system("mkdir",$soft_3p);
  #system("curl",$git_src_src,"-o",(git_src_loc . ".tar.gz"));
  #&chadira($soft_3p);
  #system("gunzip",($git_slc_vrs . ".tar.gz"));
  #system("tar","xvf",($git_slc_vrs . ".tar"));
  #&chadira($git_slc_vrs);
  
  #system("configure",("--prefix=" . $soft_3p . '/local'),("--bindir=" . $hme . "/bin"));
  #system("make");
  system("make install");
  
  &chadira($start_loc);
}

sub func_verify_json {
  if ( !(system("perl -e \"use JSON;\"")) ) { return; }
  
  &endmessage(
    "For some reason, the installation of the CPAN module, JSON, has failed.",
    "Unfortunately, this CPAN module is an essential requirement of this",
    "software. You can either install it yourself without this script, or find",
    "out why the install failed and try again.",
    "",
    "One possibility -- when you were prompted for your password - did you",
    "properly enter the password that you used to log in to this computer as",
    "you are logged in now?"
  );
}


&func_install_json();
&func_verify_json();
&func_install_git();

&endmesage("Initial install complete.");

exec("sh",($ourdir . "/shl/initial-install.sh"));



