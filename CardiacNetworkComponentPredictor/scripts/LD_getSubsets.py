##########################################################################################################################################
# USAGE: python LD_getSubsets.py file1 file2 file3 etc... outputDir
# Requirements: Latest version of BEDtools
# 18/11/2016
##########################################################################################################################################
import sys
import os
import string
import random
import re


def main():
    #inputDir = sys.argv[1]
    outputDir = sys.argv[len(sys.argv)-1]
    
    if not outputDir.endswith("/"):
        sys.exit("Error: must specify output directory")
    
    files = []
    
    for f in sys.argv :
        if f.endswith(".bed") or f.endswith("*") :
            files.append(f)

    files = ' '.join(files)

    #create temporary directory within output for temporary files
    tempDir = outputDir + "temp/"
    if not os.path.exists(tempDir):
        os.makedirs(tempDir)

    #concatenate bed files into one single bed file
    #os.system('cat %s | sort -n -k 2 > %s' % (inputDir + "*", tempDir + "all.txt"))
    os.system('cat %s | sort -k 1,1 -k 2,2n > %s' % (files, tempDir + "all.txt"))

    #run BEDTools' mergeBed on the concatenated file all.txt
    #os.system('/home/tradoa/apps/BEDTools-Version-2.11.2/bin/mergeBed -nms -d 100 -i %s > %s' % (tempDir + "all.txt", tempDir + "all_merged.txt"))
    #os.system('/Users/ramialis/Documents/MIMI_LAB/001_PROJECTS/000_PIPELINES/000_packages/bedtools2-2.19.1/bin/mergeBed -n -i %s > %s' % (tempDir + "all.txt", tempDir + "all_merged.txt")) #####nmr deprecated
    #os.system('/Users/ramialis/Documents/MIMI_LAB/001_PROJECTS/000_PIPELINES/000_packages/bedtools2-2.19.1/bin/mergeBed -n -c4 -ocollapse -delim "_" -i %s > %s' % (tempDir + "all.txt", tempDir + "all_merged.txt"))
    os.system('mergeBed -c 4 -o collapse -delim ";" -i %s > %s' % (tempDir + "all.txt", tempDir + "all_merged.txt"))

    #Split the merged file into subsets
    annotate_result(tempDir + "all_merged.txt", outputDir)


def annotate_result(bedFile, outputDir):
    bedFile = open(bedFile, "r")
  
    for line in bedFile:
        line = line.strip()
        linel = line.split("\t")
	
        id = linel[3]
	
        id_2 = re.sub('_\d*', "", id)
	#id_2 = id_2.replace('|', ';')
	#id_2 = id_2.replace('Dam', '')
	
        factorList = id_2.split(";")
        for i,name in enumerate(factorList): #strip white space
            factorList[i] = name.strip()
	    
        factorList = set(factorList) # get unique
        factorList = sorted(factorList)
        id_2 = "_".join(factorList)
	
        newLine = "\t".join(linel)
        outputFile = outputDir + id_2 + ".bed"
        os.system('echo "%s" >> %s' % (newLine, outputFile))	
    bedFile.close()	 
    
main()
