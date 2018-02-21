clear
count=`ls|tail -n+2| wc -l`
echo "The total no. of files in the folder are : $count"
sleep 2
ls | tail -n+2 > ../tmp.csv
echo "Please wait.."
sleep 1
echo "Please wait...Processing with result "
	mkdir Final_result
sleep 1
echo ".."
sleep 2
echo "..."
while read l
do
#	echo "Processing $l"
	`cat $l | cut -f1,3,4 -d, > F_$l`
	#########  extracting second column which contains barcode + UID #########
	`cat $l | cut -f2 -d , |awk -F "_" '{ print $1"_"$2"_"$3}' >First_column.csv`

	######### extracting barcode alone ########################
	`cat First_column.csv | awk -F "_" '{ print $1}' >  Barcode.csv`

	###########  extracting UID ##########################
	`cat First_column.csv | awk -F "_" '{ print $2"_"$3}' > UID.csv`

	sed -i 's/_/-/g' UID.csv
	paste -d, F_$l Barcode.csv UID.csv > FF_$l
	`cat FF_$l | awk -F "," '{ print $1","$4","$5","$3 }'> Final_result/l_$l`
	rm F_$l Barcode.csv UID.csv First_column.csv FF_$l
done < ../tmp.csv
