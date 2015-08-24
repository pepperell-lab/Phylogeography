#!/usr/bin/python
import sys,os

if(len(sys.argv) < 2):
    print("usage: <path to .txt file> ")
    sys.exit(-1)

inFileName = sys.argv[1]

def make_dict():
    d = {}
    print(inFileName)
    with open(inFileName, 'r') as inFile:
        for line in inFile:
            line = line.strip().split('\t')
            RGID = line[0]
            RGSM = line[1]
            RGLB = line[2]
            RGPL = line[3]
            strategy = line[4]
            if RGSM in d:
                d[RGSM].append((RGID,RGLB,RGPL,strategy))
            else:
                d[RGSM] = [(RGID,RGLB,RGPL,strategy)]
    return d

def split_project(d):
    soloFileName = inFileName.split("_")[0] + "soloLib.txt"
    multiFileName = inFileName.split("_")[0] + "multiLib.txt"
    with open(soloFileName, 'w') as soloFile, \
        open(multiFileName, 'w') as multiFile:
        for samp in d:
            print("Processing sample {0} with {1} runs".format(samp, len(d[samp])))
            if len(d[samp]) == 1:
                print("Solo Library")
                soloFile.write('%s\t%s\t%s\t%s\%s\n' %
                (d[samp][0][0],
                samp,
                d[samp][0][1],
                d[samp][0][2],
                d[samp][0][3])
                )
            else:
                print("Multi Library")
                RGIDlist = []
                RGLBlist = []
                RGPLlist = []
                strategyList = []
                for tup in d[samp]:
                    RGIDlist.append(tup[0])
                    RGLBlist.append(tup[1])
                    RGPLlist.append(tup[2])
                    strategyList.append(tup[3])
                multiFile.write('%s\t%s\t%s\t%s\%s\n' %
                ("-".join(RGIDlist),
                samp,
                "-".join(RGLBlist),
                "-".join(RGPLlist),
                "-".join(strategyList))
                )
