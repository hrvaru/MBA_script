chmod +x $0
#set -x
Create_Studentlist ()
{
read -p "Enter master file name:" a
head $a
read -p "Select the course-id column and subject name column. Separate it by comma:" b

clear
	echo "############### Sorting the data on basis of column ########################"
sleep 1
echo "Please wait..."
sleep 1
echo "Please wait.."
cat $a | cut -f5 -d, | sort | uniq | head -n -1 > total_sub.csv
echo "Total subject are: $(cat total_sub.csv | wc -l) "
sleep 1
clear
############ Reformatting the codes ###############################
sed -i 's/^/,/g' total_sub.csv
sed -i 's/\s/_/g' total_sub.csv
if [ -d Student_list ]
then
    rm -rf Student_list
else
	mkdir Student_list
fi
cat $a | cut -f5 -d, > hitesh.csv
sed -i 's/^/,/g' hitesh.csv
sed -i 's/\s/_/g' hitesh.csv

######################## Merging the data #############################

paste MBA.csv hitesh.csv > Final.csv

sed -i 's/\t//g' Final.csv
cat Final.csv | cut -f1,2,3,4,6,7 -d, > Final_Data.csv
rm hitesh.csv
#c=Final_Data.csv
sed -i 's/,//g' total_sub.csv
while read l
do
          cat Final_Data.csv | grep -w $l > Student_list/users_$l.csv
done < total_sub.csv
rm Final.csv
rm total_sub.csv
rm Final_Data.csv
echo "All student list is created in Student_list directory"
}
#cd ~hitesh/Desktop/scripts/MBA_Student_list/Student_list
#set +x
Response ()
{
	echo "Do you still want to continue ?: [ yes | no ]"
        read respo
        if [ $respo = y -o $respo = Y -o $respo = Yes -o $respo = YES -o $respo = yes ]; then
           Count
        else
           exit
        fi

}
	
Count ()
{
		echo "1] Create Student list:"
		echo "2] Exit the script:"
		echo "Which option do you want to select:"
		read z
		case $z in
			1) Create_Studentlist
			   ;;
			2) exit
			   ;;
                        *) echo "Wrong choice entered"
			   ;;	
			
		esac
}
while [ 0 ];
do
	Count
        Response
done
