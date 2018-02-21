clear
count=`ls|tail -n+2| wc -l`
echo "The total no. of files in the folder are : $count"
sleep 2
ls | tail -n+2 > ../tmp.csv
echo "Please wait.."
sleep 1
echo "Please wait...Deleting and adding new header"
	mkdir Result_Header
sleep 1
echo ".."
sleep 2
echo "..."
while read l
do
	#echo "Deleting header of $l"
	`sed '1d' $l > S_$l`
	#echo "Adding new header to $l"
	`sed '1iCOURSE-ID, SEAT-NO, UID, EVALUATOR-TOTAL' S_$l > Result_Header/Fina$l`
	rm -rf S_$l
done < ../tmp.csv
