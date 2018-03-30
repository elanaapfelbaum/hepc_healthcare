#! /usr/bin/gawk -f

BEGIN{
    file = "zcat npiToZip.gz"
    FS = "|"
    # putting the zip codes and npis into an array- [npi:zip,]
    while ((file | getline) > 0){
	match($2, /(^[0-9]{5})/, arr)
	npiZip[$1] = arr[1]
    }
    close(file)
    FS = "\t"
    files["2015"]; files["2014"]; files["2013"]
    
    for (file in files){
    
	# looping through the Medicare data, if the npi is in the array, 
	while (("zcat harvoni" file ".gz" | getline) > 0){
	    npi = $1
	    if (npi in npiZip){
		# zipcode = zipcode | claims | total $ | $/claim
		hist[npiZip[npi]] =  $11 "|" $14 "|" $14/$11
	    }
	}
	# printing out the associated data for each zip code into a file
	for (key in hist){
	    if (key != None)
		# zipcode | claims | total $ | $/claim
		print key "|"  hist[key] > "zipHist" file ".txt"
   	}
	close("zcat harvoni" file ".gz")
	close("zipHist" file ".txt")
    }
}
