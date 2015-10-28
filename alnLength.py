#!/usr/bin/env python

import sys
from Bio import SeqIO
import os
import getopt
import matplotlib.pyplot as plt

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

def rename_recordID(alnIN): #, d):
    d = {}
    """for every strain in the aln, count the number of missing data sites"""
    for seq_record in SeqIO.parse(alnIN, "fasta"):
        print("Processing sample {0}".format(seq_record.id))
        no_gaps = seq_record.seq.count("-")
        print("{0} has {1} gaps".format(seq_record.id, no_gaps))
        per_missing = float(no_gaps)/4411532 * 100
        sample = seq_record.id.split(".")[0]
        sample = sample.split("_")[0]
        print(sample)
        #d[sample].append(no_gaps)
        #d[sample].append(per_missing)
        d[sample] = [no_gaps, per_missing]
    return d

def make_plot(d):
    """make a plot of the missing data"""
    x = []
    c = []
    for key in d:
        x.append(d[key][1])
        if key[0:3] == "ERS":
            c.append(0)
        elif key[0:3] == "SRS":
            c.append(1)
        else:
            c.append(2)
    print("There are {0} strains from ENA that are RGA".format(c.count(0)))
    print("There are {0} strains from SRA that are RGA".format(c.count(1)))
    print("There are {0} strains from ENA that are de novo assembled".\
        format(c.count(2)))
    n, bins, patches = plt.hist(x, 50, histtype='bar', normed=1, stacked=True, 
        alpha=0.75)
    for i in range(len(patches)):
        if c[i] == 0:
            patches[i].set_facecolor('red')
        elif c[i] == 1:
            patches[i].set_facecolor('green')
        else:
            patches[i].set_facecolor('blue')
    for i in range(len(patches)):
    plt.xlabel('Percent Missing')
    plt.ylabel('No. of Isolates')
    plt.title('Histogram of Missing Data')
    plt.show()
    plt.savefig("missingData.png")

def rename_aln(alnIN, d):
    """for every strain in the aln, count the number of missing data sites"""
    outfileName = alnIN.split(".")[0] + "_recoded.fasta"
    with open(alnIN, "r") as aln, open(outfileName, 'w') as outfile:
        for line in aln:
            line = line.strip()
            if line[0] == ">":
                seqid = line.strip(">")
                sample = seqid.split(".")[0]
                sample = sample.split("_")[0]
                print sample
                newid = sample + "_" + str(d[sample][0]) + "_" + d[sample][1]
                outfile.write(">" + newid + '\n')
            else:
                outfile.write(line + '\n')
            
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
#if len(sys.argv) < 3:
#    print("Usage: alnLength.py <alnIN> <metaFile>")
#    sys.exit(0)

#script, alnIN, metaFile = sys.argv

#d = rename_dict(metaFile)
#d = rename_recordID(alnIN, d)
#write_file(alnIN, d)
#rename_aln(alnIN, d)
