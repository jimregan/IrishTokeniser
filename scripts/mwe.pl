#!/usr/bin/perl

use warnings;
use strict;
use utf8;

binmode STDIN, ":utf8";
binmode STDOUT, ":utf8";
my %fada = (
	"á" => "AFADA",
	"é" => "EFADA",
	"í" => "IFADA",
	"ó" => "OFADA",
	"ú" => "UFADA"
);
while(<>) {
	chomp;
	s/[{}]//g;
	s/ *\|//g;
	my @chars = split//;
	print "| ( ";
	for my $c (@chars) {
		if($c =~ /[a-z]/) {
			print "[" . uc($c) . $c . "]";
		} elsif ($c =~ /[A-Z]/) {
			print "[" . $c . lc($c) . "]";
		} elsif ($c eq ' ') {
			print " {Space} ";
		} elsif (exists $fada{lc($c)}) {
			print "{" . $fada{lc($c)} . "}";
		} elsif ($c eq "'") {
			print "{APOS}";
		} else {
			print STDERR "ERROR: $c\n";
		}
	}
	print " )\n";

}
