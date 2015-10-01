#!/usr/bin/python
import sys,os

if(len(sys.argv) < 2):
    print("usage: <path to .txt file> ")
    sys.exit(-1)

def make_dict():
    d = {}
    for study in ["ERP000520", "ERP001731", "ERP002611", "ERP006989", 
        "ERP008770"]:
        inFileName = study + "_SraRunTable.txt"
        print("Reading {0}".format(inFileName))
        with open(inFileName, 'r') as inFile:
            for i, line in enumerate(inFile):
                if i == 0:
                    line = line.strip()
                    entries = line.split('\t')
                    for i,entry in enumerate(entries):
                        if 'Run_s' in entry:
                            RGID = i
                            print("RGID is at position {0}".format(i))
                        elif 'SRA_Sample_s' in entry:
                            RGSM = i
                            print("RGSM is at position {0}".format(i))
                        elif 'Sample_Name_s' in entry:
                            studySamp = i
                            print("studySamp is at position {0}".format(i))
                        elif 'strain_s' in entry: #overwrite for ERP000520
                            studySamp = i 
                            print("studySamp is at position {0}".format(i))
                        elif 'SRA_Study_s' in entry:
                            project = i
                            print("project is at position {0}".format(i))
                else:
                    line = line.strip()
                    entries = line.split('\t')
                    if entries[RGSM] not in d:
                        d[entries[RGSM]] = [entries[project], 
                            entries[studySamp], entries[RGID]]
                    else:
                        d[entries[RGSM]].append(entries[RGID])
    return d

def add_GA(d):
    GADict = {}
    with open("GA_meta.txt", 'r') as inFile:
        for i, line in enumerate(inFile):
            if i > 0:
                line = line.strip().split('\t')
                genome = line[-1].strip('.gz')
                country = line[12]
                d[genome] = [line[3], line[3], line[3]]
                GADict[genome] = country
    return d, GADict

def Beijing_dict():
    BeijingDict = {}
    with open("Beijing_suppTable.txt", 'r') as infile:
        for i,line in enumerate(infile):
            if i > 0:
                line = line.strip().split('\t')
                presamp = line[0].replace("/","-")
                samp = presamp.replace("_","-")
                BeijingDict[samp] = line[24]
    return BeijingDict

def Comas_dict(d):
    ComasDict = {}
    with open("Comas_supp.txt", 'r') as infile:
        for i,line in enumerate(infile):
            if i > 1:
                line = line.strip().split('\t')
                samp = line[0]
                accession = line[4]
                if samp not in d: 
                    d[accession] = [line[1], line[0], "lookup"]
                ComasDict[samp] = line[7]
    return d, ComasDict

def add_canadian(d):
    CanadaDict = {}
    for i in ["ADHQ01", "ADIA01", "ADHZ01", "ADIB01", "ADHV01",
        "ADHS01", "ADHX01", "ADHT01", "ADHR01", "ADHU01", "ADHW01", "ADHY01"]:
        genome = i + ".1.fsa_nt"
        d[genome] = [i, i, i]
        CanadaDict[genome] = "Canada"
    return d, CanadaDict

def add_info(inputFileName, d):
    outputFileName = inputFileName.split(".")[0] + "_meta.temp"
    with open(inputFileName, 'r') as inputFile, open(outputFileName, 'w') \
        as outputFile:
        for line in inputFile:
            line = line.strip().split('\t')
            genome = line[0]
            if genome.split(".")[-1] == "fasta":
                sample = genome.split("_")[0]
                if sample in d:
                    outputFile.write("\t".join(line) + '\t' + \
                        "\t".join(d[sample][0:2]) + '\t' + \
                        ";".join(d[sample][3:]) + '\n')
                else:
                    print("{0} not in dictionary".format(sample))
                    outputFile.write("\t".join(line) + '\t' \
                        "lookup" + '\t' + "lookup" + '\t' \
                        "lookup" + '\n')
            else:
                if genome in d:
                    outputFile.write("\t".join(line) + '\t' + \
                    "\t".join(d[genome]) + '\n')
                else:
                    print("{0} not in dictionary".format(sample))
                    outputFile.write("\t".join(line) + '\t' \
                        "lookup" + '\t' + "lookup" + '\t' \
                        "lookup" + '\n')

def add_country(inputFileName, d, GADict, BeijingDict, ComasDict, CanadaDict):
    inFileName = inputFileName.split(".")[0] + "_meta.temp"
    outFileName = inputFileName.split(".")[0] + "_meta.txt"
    with open(inFileName, 'r') as inFile, open(outFileName, 'w') as outfile:
        for line in inFile:
            line = line.strip().split('\t')
            genome = line[0]
            if genome.split(".")[-1] == "fasta":
                sample = line[3]
            else:
                sample = line[0]
            project = line[2]
            if sample in ComasDict:
                outfile.write("\t".join(line) + '\t' + ComasDict[sample] 
                    + '\n')
            elif project == "ERP006989":
                outfile.write("\t".join(line) + '\t' + BeijingDict[sample]
                    + '\n')
            elif project == "ERP008770":
                outfile.write("\t".join(line) + '\t' + "Pakistan" + '\n')
            elif project == "ERP002611":
                outfile.write("\t".join(line) + '\t' + "Portugal" + '\n')
            elif project == "ERP000520":
                outfile.write("\t".join(line) + '\t' + "Uganda" + '\n')
            elif sample in GADict:
                    outfile.write("\t".join(line) + '\t' + GADict[sample]
                        + '\n')
            elif sample in CanadaDict:
                    outfile.write("\t".join(line) + '\t' + CanadaDict[sample]
                        + '\n')
            else:
                 outfile.write("\t".join(line) + '\t' + "lookup" + '\n')
                 print("Need to lookup country info for samp {0},"\
                        "genome {1}".format(sample, genome))

    

inputFileName = sys.argv[1]
d = make_dict()
d, GADict = add_GA(d)
BeijingDict = Beijing_dict()
d, ComasDict = Comas_dict(d)
d, CanadaDict = add_canadian(d)
add_info(inputFileName,d)
add_country(inputFileName,d,GADict,BeijingDict,ComasDict,CanadaDict)
