#! /usr/bin/gawk -f

BEGIN{
    files["2015"]; files["2014"]; files["2013"]
    
    FS = "|"
    # putting the zip codes and npis into an array- [npi:zip,]
    while (("zcat npiToZip.gz" | getline) > 0){
	match($2, /(^[0-9]{5})/, arr)
	npiZip[$1] = arr[1]  # npi:zipcode
    }
    close("zcat npiToZip.gz")

    # for each year...
    for (file in files){
	FS = "\t"
	while (("zcat ribavirin" file ".gz" | getline) > 0){
	    npi = $1
	    # make a dictionary of zipcode data
	    if (npi in npiZip){
		# zipcode:claims | $ | $/claim
		hist[npiZip[npi]] = $11 "|" $14 "|" $14/$11
	    }
        }
	close("zcat ribavirin" file ".gz")
	
	FS = "|"
	# if the file is from 2013, print out the ribavirin data
	# with blanks for harvoni bc harvoni does not appear in the 2013 data 
	if (file == "2013"){
	    for (key in hist)
		print key "|" "|" "|" "|" hist[key] > "zipRibHist" file ".txt"
	}
	# otherwise...
	else{
	    while (("cat zipHist" file ".txt" | getline) > 0){
		# if the zipcode from the file is in the dictionary from the ribavirin data
		# then print out the line
		# add the zipcode to a dictionary of zipcodes seen in the zipHist file
		if ($1 in hist){
		    print $0 "|" hist[$1] > "zipRibHist" file ".txt"
		    rib[$1] = 1
		}
		# if the zipcode is not in the ribavirin data add blanks for these cols
		# add the zipcode to a dictionary of zipcodes seen in the zipHist file
		else if (!($1 in hist)){
		    print $0 "|" "|" "|" > "zipRibHist" file ".txt"
		    rib[$1] = 1
		}
	    }
	    # looping through all the ribavirin zipcodes..
	    for (key in hist){
		# if the zipcode is not in the zipHist file, then add a new col with blanks for harvoni
		# and add the ribavirin data after
		if (!(key in rib)){
		    print key "|" "|" "|" "|" hist[key] > "zipRibHist" file ".txt"
		}
	    }
	    close("cat zipHist" file ".txt")
	    close("zipRibHist" file ".txt")
	}
    }
}
