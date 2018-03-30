#! /usr/bin/gawk -f

BEGIN{
    FS = ","

    # reading through the race data, creating an array zip code: white|black|asian|hispanic
    while (("cat DEC_10_SF1_QTP3_with_ann.csv" | getline) > 0){
	match($3, /([0-9]{5})/, arr)
	# making sure that the cols are in the right format for graphing
	if ($9  == "(X)") $9  = 0
	if ($11 == "(X)") $11 = 0
	if ($23 == "(X)") $23 = 0
	if ($43 == "(X)") $43 = 0
	zipRace[arr[1]] = $9 "|" $11 "|" $23 "|" $43
    }
    close("cat DEC_10_SF1_QTP3_with_ann.csv")

    files["2015"]; files["2014"]; files["2013"]

    FS = "|"

    for (file in files){
	# for each zipcode, concatenate the racial data to the end of the line
	while (("cat zipHistIncome" file ".txt" | getline) > 0){
	    if ($1 in zipRace){
		print $0 "|" zipRace[$1] > "zipHistTotal" file ".txt"
	    }
	}
	close("zipHistIncome" file ".txt")
	close("zipHistTotal" file ".txt")
    }
}
