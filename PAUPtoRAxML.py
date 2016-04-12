#!/usr/bin/env python

import argparse
import sys
from Bio import SeqIO
import os
import getopt
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt

#######################################################################
##This script converts the bootstrap output from PAUP to RAxML format.  
#######################################################################


class FullPaths(argparse.Action):
    """Expand user- and relative-paths"""
    def __call__(self, parser, namespace, values, option_string=None):
        setattr(namespace, self.dest,
            os.path.abspath(os.path.expanduser(values)))

def is_file(filename):
    """Checks if a file exists"""
    if not os.path.isfile(filename):
        msg = "{0} is not a file".format(filename)
        raise argparse.ArgumentTypeError(msg)
    else:
        return filename

def get_arguments(): 
    """Parse command line arguments"""
    parser = argparse.ArgumentParser(
        description="Collate summary info from multiple bamqc runs")
    parser.add_argument('-i', '--inputFile',
        help = 'file containing paths to bamqc results that are to be collated', 
        type = is_file,
        required = True)
    parser.add_argument('-o', '--outputFile',
        help = 'name of output file,',
        required = True)
    return parser.parse_args()

args = get_arguments()

def make_dict():
    d = {}
    with open(args.inputFile, 'r') as infile:
        for line in infile:
            line = line.strip()
            elements = line.split()
            if len(elements) > 1:
                try:
                    key = int(elements[0])
                    value = elements[1].strip(",")
                    if value == 'ERS1028703_ET_AFR':
                        d[str(key)] = '(ERS1028703_ET_AFR,ERS217640_ET_AFR)'
                    elif value == 'ERS1028689_ET_AFR':
                        d[str(key)] = '(ERS1028689_ET_AFR,ERS217636_ET_AFR)'
                    elif value == 'ERS1028710_ET_AFR':
                        d[str(key)] = '(ERS217642_ET_AFR,ERS1028710_ET_AFR)'
                    elif value == 'ERS1028704_ET_AFR':
                        d[str(key)] = '(ERS1028704_ET_AFR,ERS217641_ET_AFR)'
                    elif value == 'ERS1028701_ET_AFR':
                        d[str(key)] = '(ERS217639_ET_AFR,ERS1028701_ET_AFR)'
                    elif value == 'ERS1028695_ET_AFR':
                        d[str(key)] = '(ERS217638_ET_AFR,ERS1028695_ET_AFR)'
                    elif value == 'ERS1028692_ET_AFR':
                        d[str(key)] = '(ERS1028692_ET_AFR,ERS217637_ET_AFR)'
                    elif value == 'ERS1028715_ET_AFR':
                        d[str(key)] = '(ERS217643_ET_AFR,ERS1028715_ET_AFR)'
                    elif value == 'ERS1028678_ET_AFR':
                        d[str(key)] = '(ERS1028678_ET_AFR,ERS217634_ET_AFR)'
                    elif value == 'ERS1028684_ET_AFR':
                        d[str(key)] = '(ERS1028684_ET_AFR,ERS217635_ET_AFR)'
                    else:
                        d[str(key)] = value
                except ValueError:
                    continue
    print("There are {0} samples in the bootstrap trees.".format(len(d)))
    return d

def translate_trees(d):
    with open(args.inputFile, 'r') as infile, open(args.outputFile, 'w') as outfile:
        for line in infile:
            line = line.strip()
            elements = line.split()
            if len(elements) > 1:
                if elements[0] == "tree":
                    tre = elements[-1]
                    modtree = []
                    samps = tre.split(",")
                    for i in samps:
                        n = i.strip('();')
                        s = d[n]
                        newi = i.replace(n, s)
                        modtree.append(newi)
                    outfile.write(",".join(modtree) + '\n')

d = make_dict()
translate_trees(d)
