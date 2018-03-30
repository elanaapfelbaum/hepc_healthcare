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
	while (("zcat sovaldi" file ".gz" | getline) > 0){
	    npi = $1
	    # make a dictionary of zipcode data  
	    if (npi in npiZip){
		# zipcode:claims | $ | $/claim
		hist[npiZip[npi]] = $11 "|" $14 "|" $14/$11
	    }
	}
	close("zcat sovaldi" file ".gz")
	FS = "|"
	
	while (("cat zipRibHist" file ".txt" | getline) > 0){
	    # if the zipcode from the file is in the dictionary from the ribavirin data
	    # then print out the line add the zipcode to a dictionary of zipcodes seen
	    # in the zipHist file
	    if ($1 in hist){
		print $0 "|" hist[$1] > "zipSovHist" file ".txt"
		rib[$1] = 1
	    }
		# if the zipcode is not in the ribavirin data add blanks for these cols
		# add the zipcode to a dictionary of zipcodes seen in the zipRibHist file
	    else if (!($1 in hist)){
		print $0 "|" "|" "|" > "zipSovHist" file ".txt"
		rib[$1] = 1
	    }
	}
	close("cat zipRibHist" file ".txt")
	    
	# looping through all the sovaldi zipcodes..
	for (key in hist){
		# if the zipcode is not in the zipRibHist file, then add a new col with blanks for harvoni
		# and ribavirin and add the sovaldi data after
	    if (!(key in rib)){
		print key "|" "|" "|" "|" "|" "|" "|" hist[key] > "zipSovHist" file ".txt"
	    }
	}
	close("zipSovHist" file ".txt")
    }
}

