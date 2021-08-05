#! usr/bin/perl

use strict;
#use warnings;

#takes GREAT gene list as input
my $great_genes = $ARGV[0];
#RNA-seq data
#my $rna_genes = "/Volumes/R-ARMI-Ramialison/Shared/Projects/016_Identifying_candidate_heart_genes/001_pipeline/001_phase1/003_GREAT_data/002_RNA_seq/001_heart-E14.5-1_2_expr.txt";
my $rna_genes = "/mnt/d/Work/GenomeBiology/001_pipeline/001_phase1/003_GREAT_data/002_RNA_seq/001_heart-E14.5-1_2_expr.txt";
#list of RNA names ordered by ensemble names, gene name, refseq in columns
#my $namefile = "/Volumes/R-ARMI-Ramialison/Shared/Projects/016_Identifying_candidate_heart_genes/001_pipeline/001_phase1/003_GREAT_data/002_RNA_seq/002_mart_export-6_mrk_ensids_NM.txt";
my $namefile = "/mnt/d/Work/GenomeBiology/001_pipeline/001_phase1/003_GREAT_data/002_RNA_seq/002_mart_export-6_mrk_ensids_NM.txt";

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
