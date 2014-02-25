use Test::Base;
use FindBin;
use WWW::Selenium::Selenese::TestCase qw/case_to_perl/;

plan tests => 3;

my $case_dir = "$FindBin::Bin/convert_cases";
opendir(DIR, $case_dir) or die $!;
my @dirs = grep { /^[^.]/ && -d "$case_dir/$_" } readdir(DIR);
closedir(DIR);

foreach my $dir (@dirs) {
    my $test_case_name = "$case_dir/$dir/in.html";
    my $got = case_to_perl("$case_dir/$dir/in.html");
    open my $io, '<', "$case_dir/$dir/out.pl" or die $!;
    my $expected = join('', <$io>);
    close $io;
    is( $got, $expected, 'output precisely - ' . $test_case_name);
}

my $in = "/home/trcjr/code/perl/PerlSelenese/t/convert_cases/google_en/in.html";
use Data::Dumper;
my $tc = WWW::Selenium::Selenese::TestCase->new($in);
foreach my $command (@{$tc->{commands}}) {
    warn Dumper $command->{values}->[0];
    next if ( $command->{values}->[0] eq "storeTitle" );
    next if ( $command->{values}->[0] eq "open" );
    next if ( $command->{values}->[0] eq "type" );
    next if ( $command->{values}->[0] eq "comment" );
    next if ( $command->{values}->[0] eq "clickAndWait" );
    #warn Dumper $command->values_to_perl;
}
#print $tc->as_perl;
