#!/usr/bin/env python

import sys

##############################################################################
##This script will extract lineage information from a txt file generated
##within Dendroscope using the "Select" -> "Extract Subnetwork" -> "Export
##Selected taxa". Be sure to write "Lineage X" on its own line before
##extracting.
##############################################################################

def assign_lineage(infilename, outfilename):
    """Assign the lineage to each genome"""
    lineage = None #Set lineage to None
    with open(infilename, 'r') as infile, open(outfilename, 'w') as outfile:
        for line in infile:
            if len(line) > 1: #exclue blank lines
                line = line.strip().split()
                if line[0] == "Lineage":
                    #All genomes listed below a 'lineage' will be assigned
                    #that lineage.
                    lineage = int(line[1]) 
                else:
                    try:
                        fileExt = line[0].split(".")[-1]
                        #update to reflect your ref genome extensions
                        if fileExt == "fasta" or fileExt == "fsa_nt": 
                            outfile.write(line[0] + '\t' + str(lineage) + '\n')
                    except IndexError:
                        continue
        
            
# check for correct arguments
if len(sys.argv) != 3:
    print("Usage: NexusStrainParser.py <inputfile> <outputfile>")
    sys.exit(0)

infilename,outfilename = sys.argv[1:]
assign_lineage(infilename, outfilename)
