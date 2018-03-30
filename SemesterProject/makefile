all: npiToZip.gz harvoni2014.gz harvoni2015.gz harvoni2013.gz ribavirin2015.gz ribavirin2014.gz ribavirin2013.gz sovaldi2015.gz sovaldi2014.gz sovaldi2013.gz zipHist2015.txt zipHist2014.txt zipHistIncome2015.txt zipHistIncome2014.txt zipHistIncome2013.txt zipRibHist2015.txt zipRibHist2014.txt zipRibHist2013.txt zipSovHist2015.txt zipSovHist2014.txt zipSovHist2013.txt zipHistTotal2015.txt zipHistTotal2014.txt zipHistTotal2013.txt graph2015.pdf graph2014.pdf graph2013.pdf graphOutliers2015.pdf graphOutliers2014.pdf graphOutliers2013.pdf graphRace2015.pdf graphRace2014.pdf graphRace2013.pdf graphRaceOutliers2015.pdf graphRaceOutliers2014.pdf graphRaceOutliers2013.pdf

npiToZip.gz: npi.gz	
	zcat npi.gz | cut -d '|' -f 1,25 | gzip >npiToZip.gz

harvoni2015.gz: PartD_Prescriber_PUF_NPI_Drug_2015.txt.gz
	zcat PartD_Prescriber_PUF_NPI_Drug_2015.txt.gz | grep -i NY | grep -i HARVONI | gzip >harvoni2015.gz

harvoni2014.gz: PartD_Prescriber_PUF_NPI_Drug_2014.txt.gz
	zcat PartD_Prescriber_PUF_NPI_Drug_2014.txt.gz | grep -i NY | grep -i HARVONI | gzip >harvoni2014.gz

harvoni2013.gz: PartD_Prescriber_PUF_NPI_Drug_2013.txt.gz
	zcat PartD_Prescriber_PUF_NPI_Drug_2013.txt.gz | grep -i NY | grep -i HARVONI | gzip >harvoni2013.gz

ribavirin2015.gz: PartD_Prescriber_PUF_NPI_Drug_2015.txt.gz
	zcat PartD_Prescriber_PUF_NPI_Drug_2015.txt.gz | grep -i NY | grep -i RIBAVIRIN | gzip >ribavirin2015.gz

ribavirin2014.gz:PartD_Prescriber_PUF_NPI_Drug_2014.txt.gz
	zcat PartD_Prescriber_PUF_NPI_Drug_2014.txt.gz | grep -i NY | grep -i RIBAVIRIN | gzip >ribavirin2014.gz

ribavirin2013.gz:PartD_Prescriber_PUF_NPI_Drug_2013.txt.gz
	zcat PartD_Prescriber_PUF_NPI_Drug_2013.txt.gz | grep -i NY | grep -i RIBAVIRIN | gzip >ribavirin2013.gz

sovaldi2015.gz: PartD_Prescriber_PUF_NPI_Drug_2015.txt.gz
	zcat PartD_Prescriber_PUF_NPI_Drug_2015.txt.gz | grep -i NY | grep -i SOVALDI | gzip >sovaldi2015.gz

sovaldi2014.gz: PartD_Prescriber_PUF_NPI_Drug_2014.txt.gz
	zcat PartD_Prescriber_PUF_NPI_Drug_2014.txt.gz | grep -i NY | grep -i SOVALDI | gzip >sovaldi2014.gz

sovaldi2013.gz: PartD_Prescriber_PUF_NPI_Drug_2013.txt.gz
	zcat PartD_Prescriber_PUF_NPI_Drug_2013.txt.gz | grep -i NY | grep -i SOVALDI | gzip >sovaldi2013.gz

zipHist2015.txt zipHist2014.txt: npiToZip.gz harvoni2015.gz harvoni2014.gz
	./harvByZipHist.awk

zipRibHist2015.txt zipRibHist2014.txt zipRibHist2013.txt: npiToZip.gz ribavirin2015.gz ribavirin2014.gz ribavirin2013.gz zipHist2015.txt zipHist2014.txt
	./ribByZipHist.awk

zipSovHist2015.txt zipSovHist2014.txt zipSovHist2013.txt: npiToZip.gz sovaldi2015.gz sovaldi2014.gz sovaldi2013.gz zipRibHist2015.txt zipRibHist2014.txt zipRibHist2013.txt
	./sovByZipHist.awk

zipHistIncome2015.txt zipHistIncome2014.txt zipHistIncome2013.txt: IncomePop.gz zipSovHist2015.txt zipSovHist2014.txt zipSovHist2013.txt
	./income.awk

zipHistTotal2015.txt zipHistTotal2014.txt zipHistTotal2013.txt: DEC_10_SF1_QTP3_with_ann.csv zipHistIncome2015.txt zipHistIncome2014.txt zipHistIncome2013.txt
	./race.awk

graph2015.pdf graph2014.pdf graph2013.pdf graphOutliers2015.pdf graphOutliers2014.pdf graphOutliers2013.pdf: zipHistTotal2015.txt zipHistTotal2014.txt zipHistTotal2013.txt
	./plot.py

graphRace2015.pdf graphRace2014.pdf graphRace2013.pdf graphRaceOutliers2015.pdf graphRaceOutliers2014.pdf graphRaceOutliers2013.pdf: zipHistIncome2015.txt zipHistIncome2014.txt zipHistIncome2013.txt
	./racePlot.py

clean:
	rm harvoni* ribavirin* sovaldi* npiToZip.gz
