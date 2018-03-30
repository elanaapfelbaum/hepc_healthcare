#! /usr/bin/python3

import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt

years = ["2015", "2014", "2013"]
harv  = []
rib   = []
sov   = []
areas = []

for year in years:
    fig = plt.figure()
    axes = plt.gca()  # allows me to change the y axis min and max
    f = open("zipHistTotal" + year + ".txt")
    line = f.readline()
    while line:
        fields = line.split("|")

        # fields 12, 14, 15 are all mniorities
        minority = float(fields[12]) + float(fields[14]) + float(fields[15])
        if minority > 100: minority = 100   # if the %s added up to >100
        areas.append(minority)
        
        # appen the values to the apropriate lists- if the field is empty
        # append a "0" so that they are all the same length  
        if fields[1]:      harv.append((int(fields[1])/int(fields[11])))
        if not fields[1]: harv.append(0)
        if fields[4]:     rib.append((int(fields[4])/int(fields[11])))
        if not fields[4]: rib.append(0)
        if fields[7]:     sov.append((int(fields[7])/int(fields[11])))
        if not fields[7]: sov.append(0)
        line = f.readline()

    
    plt.ylabel("Amount of Hep C Drug Prescribed")
    plt.xlabel("% Minority per Zip Code")
    plt.title("Hep C Drugs Per Capita Prescribed in Zip Codes by % Minority")
    
    # plotting with outliers
    maximum = max(max(harv), max(rib), max(sov))
    plt.scatter(areas, sov, color='m', alpha=0.3, label = "Sovaldi")
    plt.scatter(areas, rib, color='c', alpha=0.3, label = "Ribavirin")
    plt.scatter(areas, harv,  color='b', alpha=0.3, label = "Harvoni")
    axes.set_ylim([0, maximum])
    plt.legend()
    fig.savefig("graphRaceOutliers" + year + ".pdf")

    # plotting without the outliers
    axes.set_ylim([0, 0.175])
    plt.scatter(areas, sov, color='m', alpha=0.001)
    plt.scatter(areas, rib, color='c', alpha=0.001)
    plt.scatter(areas, harv, color='b',  alpha=0.001)
    plt.legend()
    fig.savefig("graphRace" + year + ".pdf")

    
