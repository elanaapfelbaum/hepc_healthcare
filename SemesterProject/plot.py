#! /usr/bin/python3

import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt

years  = ["2015", "2014", "2013"]
harv   = []
rib    = []
sov    = []
income = []

for year in years:
    fig  = plt.figure()
    axes = plt.gca()
    f = open("zipHistTotal" + year + ".txt")
    line = f.readline()
    while line:
        fields = line.split("|")
        income.append(float(fields[10]))   # append the zip code's average income to the list
        # append the int values to the appropriate lists- if the field is empty
        # append a 0 so that the lists are all the same length
        if fields[1]:      harv.append((int(fields[1])/int(fields[11])))
        if not fields[1]: harv.append(0)
        if fields[4]:     rib.append((int(fields[4])/int(fields[11])))
        if not fields[4]: rib.append(0)
        if fields[7]:     sov.append((int(fields[7])/int(fields[11])))
        if not fields[7]: sov.append(0)
        line = f.readline()

    f.close()
    
    plt.ylabel("Amount of Hep C Drug Prescribed per Capita")
    plt.xlabel("Average Income per Zip Code")
    plt.title("Hep C Drugs Per Capita Prescribed in Zip Codes by Income") 
    
    # graphing the data with the outliers
    maximum = max(max(harv), max(rib), max(sov))
    axes.set_ylim([0, maximum])
    plt.scatter(income, sov,  color='m', alpha=0.3, label = "Sovaldi")
    plt.scatter(income, rib,  color='c', alpha=0.3, label = "Ribavirin")
    plt.scatter(income, harv, color='b', alpha=0.3, label = "Harvoni")
    plt.legend()
    fig.savefig("graphOutliers" + year + ".pdf")

    # graphing the data without the outliers
    axes.set_ylim([0, 0.06])
    plt.scatter(income, sov,  color='m', alpha=0.0001)
    plt.scatter(income, rib,  color='c', alpha=0.0001)
    plt.scatter(income, harv, color='b', alpha=0.0001)
    plt.legend()
    fig.savefig("graph" + year + ".pdf")
