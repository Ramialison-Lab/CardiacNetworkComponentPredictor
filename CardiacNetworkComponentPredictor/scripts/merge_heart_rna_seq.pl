#! usr/bin/perl

use strict;
use warnings;

my $rep1 = $ARGV[0];
my $rep2 = $ARGV[1];

my %rep2hash;

open (FH1, '<',$rep1) or die "could not open file 1";
open (FH2, '<',$rep2) or die "could not open file 2";


while (my $line = <FH2>) {
    chomp $line;
    my @gene = split (/\t/, $line);
    $rep2hash{$gene[0]} = $gene[2]."\t".$gene[3]."\t".$gene[4]."\t".$gene[5];
}

while (my $line = <FH1>) {
    chomp $line;
    my @gene = split(/\t/, $line);
    if ($rep2hash{$gene[0]}) {
        my @array = split (/\t/,$rep2hash{$gene[0]});
        my $avg = ($array[3]+$gene[5])/2;
        print $line."\t\t".$rep2hash{$gene[0]}."\t".$avg."\n";
    }
}