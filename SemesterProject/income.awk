#! /usr/bin/gawk -f

BEGIN{
    FS = "|"
    
   # print "zipcode | total claims | total $ | avg $ per person | income | population" > "zipHistIncome2015.txt"
    while (("zcat IncomePop.gz" | getline) > 0){
	income[$1] = $3 "|" $4  #zipcode:mean income,pop, income/pop
    }
    close("zcat IncomePop.gz")

    files["2015"]; files["2014"]; files["2013"]

    # for each year's data...
    for (file in files){
	# print the key to the columns data
	print "zipcode | total claims drug #1 | total $ | avg $ per person |...other drugs...| income | population" > "zipHistIncome" file ".txt"

	# looping through the latest file with the drug data
	while (("cat zipSovHist" file ".txt" | getline) > 0){
	    # if the zipcode is in the array of income zipcodes, print the line with
	    # income data to a new file
	    if ($1 in income){
		print $0 "|" income[$1] > "zipHistIncome" file ".txt"
	    }
	}
	close("zipHistIncome" file ".txt")
	close("cat zipSovHist" file ".txt")
    }
}
