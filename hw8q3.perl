#!usr/bin/perl
=pod

File: hw8q3.perl
To run: Ensure that this script is in the same directory as wsj.txt and irregular_verbs.txt.
        Enter the following command in the terminal:
		perl hw8q3.perl irregular_verbs.txt wsj.txt
Script to search for the frequency of regular passives and perfectives and their 
negated counterparts in the wsj.txt file using regex patterns. Also looks for the irregular
forms using data read in from irregular_verbs.txt (irregular past participles). Loops over the 
lines in the file and finds matches to the regexes. Updates a hash of frequencies for the linguistic forms and prints out the frequencies.

=cut

use strict;
use warnings;

my @irrs = ();
my @irrvlist = ();
my %freqs = ("negated regular passive", 0, "negated irregular passive", 0, "negated regular perfective", 0, "negated irregular perfective", 0, "regular passive", 0, "irregular passive", 0, "regular perfective", 0, "irregular perfective", 0);

open(my $irrdata, $ARGV[0]) or die "$ARGV[0] not found!\n";

my $irrline = <$irrdata>;

while ($irrline = <$irrdata>) {
	$irrline =~ m/^.*?((\w+\/)?\w+\b)$/;
	push(@irrs, $1);
}

foreach my $verb (@irrs) {
	if($verb =~ /\//) {
		my @verbs = split(/\//, $verb);
		push(@irrvlist, $verbs[0]);
		push(@irrvlist, $verbs[0]);
		}
	if($verb !~ /\//) {
		push(@irrvlist, $verb);
		}
	}

close($irrdata);

#disjunct all the possible irregular past participles
my $irrvs = join("|", @irrvlist);

my $re_pass = qr/^.*(was|is|will be|were being|were|had been)\s\w+en\b.*$/;
my $re_irrpass = qr/^.*(was|is|will be|were being|were|had been)\s($irrvs).*$/;
my $re_negpass = qr/^.*(was n't yet|will not be|were not being|had not been|was not yet|were not|was n't|was not)\s\w+en\b.*$/;
my $re_irrnegpass = qr/^.*(was n't yet|will not be|were not being|had not been|were not|was not yet|was n't|was not)\s($irrvs).*$/;
my $re_perf = qr/^.*(have|had|has)\s\w+en\b.*$/;
my $re_irrperf = qr/^.*(have|had|has)\s($irrvs).*$/;
my $re_negperf = qr/^.*(hasn't yet|has not yet|have not yet|haven't yet|havent'|hasn't|have not|has not)\s\w+en\b.*$/;
my $re_irrnegperf = qr/^.*(hasn't yet|has not yet|have not yet|haven't yet|havent'|hasn't|have not|has not)\s($irrvs).*$/;


open(my $data, $ARGV[1]) or die "$ARGV[1] not found!\n";

while(my $line = <$data>) {
	if($line =~ m/$re_negperf/) {
		$freqs{"negated regular perfective"} += 1;
		}
	if($line =~ m/$re_negpass/) {
		$freqs{"negated regular passive"} += 1;
		}
	if($line =~ m/$re_pass/) {
		$freqs{"regular passive"} += 1;
		}
	if($line =~ m/$re_perf/) {
		$freqs{"regular perfective"} += 1;
		}
	if($line =~ m/$re_irrnegpass/) {
		$freqs{"negated irregular passive"} += 1;
		}
	if($line =~ m/$re_irrpass/) {
		$freqs{"irregular passive"} += 1;
		}
	if($line =~ m/$re_irrnegperf/) {
		$freqs{"negated irregular perfective"} += 1;
		}
	if($line =~ m/$re_irrperf/) {
		$freqs{"irregular perfective"} += 1;
		}
	
}
close($data);

foreach my $key (keys %freqs) {
	print "$key: $freqs{$key}\n";
	}

