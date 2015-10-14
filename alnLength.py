#!/usr/bin/env python

import sys
from Bio import SeqIO
import os
import getopt

def rename_dict(metaFile):
    #create a dictionary that has the strain as the key
    #and a list with 'Country', "latitude", "longitude"
    #as the value
    d = {}
    with open(metaFile, 'r') as infile:
        for line in infile:
            line = line.strip().split('\t')
            #if len(line) != 5:
            #    print line
            key = line[0]
            lineage = int(line[1])
            country = line[4].replace(" ", "")
            d[key] = [lineage, country]
    return d

def rename_recordID(alnIN, d):
    """for every strain in the aln, count the number of missing data sites"""
    outfileName = alnIN.split(".")[0] + "alnLens.txt"
    with open(outfileName, 'w') as outfile:
    for seq_record in SeqIO.parse(alnIN, "fasta"):
        print("Processing sample {0}".format(seq_record.id))
        no_gaps = seq_record.seq.count("-")
        print("{0} has {1} gaps".format(seq_record.id, no_gaps))
        per_missing = float(no_gaps)/4411532 * 100
        sample = seq_record.id.split(".")[0]
        sample = sample.split("_")[0]
        print(sample)
        d[sample].append(no_gaps)
        d[sample].append(per_missing)
    return d
            
def write_file(alnIN, d):
    """write the contents of dictionary to file"""
    outfileName = alnIN.split(".")[0] + "_alnLens.txt"
    with open(outfileName, 'w') as outfile:
        for samp in d:
            outfile.write('%s\t%i\t%s\t%i\t%f\n' %
                (samp,
                d[samp][0],
                d[samp][1],
                d[samp][2],
                d[samp][3]))


# check for correct arguments
if len(sys.argv) < 3:
    print("Usage: alnLength.py <alnIN> <metaFile>")
    sys.exit(0)

script, alnIN, metaFile = sys.argv

d = rename_dict(metaFile)
d = rename_recordID(alnIN, d)
write_file(alnIN, d)
