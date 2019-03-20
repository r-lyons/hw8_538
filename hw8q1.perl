#!usr/bin/perl
=pod

File: hw8q1.perl
To run: Ensure that this script is in the same directory as wsj.txt.
        Enter the following command in the terminal:
		perl hw8q1.perl wsj.txt
Script to search for the frequency of passives and perfectives and their 
negated counterparts in the wsj.txt file using regex patterns. Loops over the 
lines in the file and finds matches to the regexes. Updates a hash of
frequencies for the linguistic forms and prints out the frequencies.

=cut

use strict;
use warnings;

my %freqs = ("negated passive", 0, "negated perfective", 0, "passive", 0, "perfective", 0);

my $re_pass = qr/^.*(was|is|will be|were being|were|had been)\s\w+en\b.*$/;
my $re_negpass = qr/^.*(was n't yet|will not be|were not being|had not been|was not yet|were not|was n't|was not)\s\w+en\b.*$/;
my $re_perf = qr/^.*(have|had|has)\s\w+en\b.*$/;
my $re_negperf = qr/^.*(hasn't yet|has not yet|have not yet|haven't yet|havent'|hasn't|have not|has not)\s\w+en\b.*$/;

open(my $data, $ARGV[0]) or die "$ARGV[0] not found!\n";

while(my $line = <$data>) {
	if($line =~ m/$re_negperf/) {
		$freqs{"negated perfective"} += 1;
		}
	if($line =~ m/$re_negpass/) {
		$freqs{"negated passive"} += 1;
		}
	if($line =~ m/$re_pass/) {
		$freqs{"passive"} += 1;
		}
	if($line =~ m/$re_perf/) {
		$freqs{"perfective"} += 1;
		}
	
}
close($data);

foreach my $key (keys %freqs) {
	print "$key: $freqs{$key}\n";
	}
	
	
	
	
	
	
