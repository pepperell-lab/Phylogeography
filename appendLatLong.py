#!/usr/bin/python
import sys,os

if(len(sys.argv) < 3):
    print("usage: <lat long file> <country counts file> ")
    sys.exit(-1)

def make_dict(latlongFile):
    d = {}
    with open(latlongFile, 'r') as infile:
        for i,line in enumerate(infile):
            if i > 0:
                line = line.strip().split(',')
                country = line[0]
                lat = float(line[4])
                longitude = float(line[5])
                d[country] = [lat, longitude]
    return d

def write_file(d, linbreakdownFile):
    outfileName = linbreakdownFile.strip(".txt") + "_latlong.txt"
    with open(linbreakdownFile, 'r') as infile, open(outfileName, 'w') as \
        outfile:
        for line in infile:
            line = line.strip().split('\t')
            country = line[0].replace("_", " ")
            if len(country) > 1:
                tups = country.split(" ")
                if tups[0] == "The":
                    country = country.strip("The ") 
            if country in d:
                outfile.write('%s\t%f\t%f\t%s\n' %
                (country, 
                d[country][0],
                d[country][1],
                "\t".join(line[1:7])))
            else:
                print country

latlongFile, linbreakdownFile = sys.argv[1:]
d = make_dict(latlongFile)
write_file(d, linbreakdownFile)
