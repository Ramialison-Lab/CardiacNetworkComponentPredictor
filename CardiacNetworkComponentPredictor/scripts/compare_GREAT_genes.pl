#! usr/bin/perl

use strict;
#use warnings;

#add help option
if ($ARGV[0] eq "--help") {
    print("Usage: perl compare_GREAT_genes.pl [INPUT_FILE] [OPTIONS]... >> [OUTPUT_FILE]\nInput file: TXT (tab-separated) file format, the output files from GREAT database\nOptions:\n  --help: Show this message and exit.\nOutput file: TXT (tab-separated) file format, containing the predicted cardiac-specific genes\n");
    exit;	
}

#takes GREAT gene list as input
my $great_genes = $ARGV[0];
#RNA-seq data
my $rna_genes = $ARGV[1];
#list of RNA names ordered by ensemble names, gene name, refseq in columns
my $namefile = $ARGV[2];;

# sort RNA names into hash
my %RNAnames;

open (NAMES ,'<', $namefile)  or die "could no open name file";

while (my $line = <NAMES>) {
    chomp $line;
    my ($ensmebl, $name, $refseq) = split (/\t/, $line);
    $RNAnames{$refseq}=$name;
}

close NAMES;

#Read in genes from RNA-seq data
open (RNASEQ ,'<', $rna_genes) or die "could not open RNA seq genelist";


while (my $line = <RNASEQ>) {
    chomp $line;
    my @rna_array = split(/\t/, $line);
    my $rnaseq_gene = $rna_array[0];

    # determine PFKM thresholf for epression data
    if ($rna_array[13]>20){#        print $rnaseq_gene."\n";
	      #read in GREAT genelist for comparison
        open (GREAT ,'<', $great_genes) or die "could not open GREAT gene list";
        
        while (my $otherline = <GREAT>) {
            chomp $otherline;
            my @GREATarray = split(/\t/,$otherline);
            my $GREATgene = $GREATarray[0];
            if ($RNAnames{$rnaseq_gene} eq $GREATgene) {
                print $GREATgene."\n";
            }
            #        print $RNAnames{$rnaseq_gene}."\n";
        }
        close GREAT;
    }

}

close RNASEQ;