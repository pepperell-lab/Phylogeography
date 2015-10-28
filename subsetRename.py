#!/usr/bin/env python

import sys
from Bio import SeqIO
from Bio.Alphabet import IUPAC,Gapped
import os
import getopt

def rename_dict(metaFile):
    #create a dictionary that has the strain as the key
    #and a list with 'Country', "latitude", "longitude"
    #as the value
    d = {}
    for i in range(1,8): 
        d[i] = {} #make a dictionary of dictionaries for each lineage
    with open(metaFile, 'r') as infile:
        for line in infile:
            line = line.strip().split('\t')
            #if len(line) != 5:
            #    print line
            key = line[0]
            lineage = int(line[1])
            country = line[4].replace(" ", "")
            d[lineage][key] = country
    return d

def rename_recordID(alnIN, d):
    """for every strain in the dictionary created above, \
    change the seq_record.id to reflect the info"""
    out1 = alnIN.split(".")[0] + "_lin1.nexus"
    out2 = alnIN.split(".")[0] + "_lin2.nexus"
    out3 = alnIN.split(".")[0] + "_lin3.nexus"
    lin1Records = []
    lin2Records = []
    lin3Records = []
    for seq_record in SeqIO.parse(alnIN, "fasta", alphabet=Gapped(IUPAC.ambiguous_dna, '-')):
        strain = seq_record.id.split("_")[0]
        print strain
        if strain in d[1]:
            lin1Records.append(seq_record)
        elif strain in d[2]:
            lin2Records.append(seq_record)
        elif strain in d[3]:
            lin3Records.append(seq_record)
    SeqIO.write(lin1Records, out1, "nexus")
    SeqIO.write(lin2Records, out2, "nexus")
    SeqIO.write(lin3Records, out3, "nexus")

# check for correct arguments
if len(sys.argv) < 3:
    print("Usage: FastaStrainParser.py <alnIN> <metaFile>")
    sys.exit(0)

script, alnIN, metaFile = sys.argv

d = rename_dict(metaFile)
rename_recordID(alnIN, d)
