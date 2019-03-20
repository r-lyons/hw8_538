#!usr/bin/perl
=pod

File: hw8q2.perl
To run: Ensure that this script is in the same directory as irregular_verbs.txt.
        Enter the following command in the terminal:
		perl hw8q2.perl irregular_verbs.txt
Script to get the irregular past participles out of the table in irregular_verbs.txt.
Loops over the file line by line and uses a regex to match the entry in the third 
column. If the entry contains two words joined by a /, splits the words. Prints each
word on a new line.

=cut

use strict;
use warnings;

my @irrs = ();

open(my $data, $ARGV[0]) or die "$ARGV[0] not found!\n";

my $line = <$data>;

while ($line = <$data>) {
	$line =~ m/^.*?((\w+\/)?\w+\b)$/;
	push(@irrs, $1);
}

foreach my $verb (@irrs) {
	if($verb =~ /\//) {
		my $verbs = join("\n", split(/\//, $verb));
		print "$verbs\n";
		}
	if($verb !~ /\//) {
		print "$verb\n";
		}
	}

close($data);

