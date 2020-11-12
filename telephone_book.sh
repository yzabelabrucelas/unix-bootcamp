#!/bin/sh


#Create the temporary outfile
FILE=list.txt
touch $FILE

#Get the current record number from the report file
GET_REC_NO() {
	#Extract the latest Record number from the TB file
        REC_NO=`cut -d, -f1 $FILE | sort -n | tail -1`
        if [ -z "$REC_NO" ]
        then
                REC_NO=1
        else
                REC_NO=`expr $REC_NO + 1`
        fi
}

#Function of the main screen
MENU() {
        ctr=0
        while [ $ctr -eq 0 ]
        do
                clear
                echo "TELEPHONE BOOK"
                echo "--------------"
                echo "(1) Add"
                echo "(2) Update"
                echo "(3) Delete"
                echo "(4) Report"
                echo "(5) Exit"
                echo
                echo -e "Enter Choice: \c"
                read choice

                if [ "$choice" -ge 1 -a "$choice" -le 5 ]
                then
                        ctr=1
                else
                        echo -e "Selection Error, try again! \c"
                        sleep 2
                fi
        done
        CHOICE
}

#Function of the menu selection in case
CHOICE() {
        case $choice in
                1) ADD    ;;
                2) UPDATE ;;
                3) DELETE ;;
                4) REPORT ;;
                5) EXIT   ;;
                *) USAGE  ;;
        esac
}


#Function of the usage details, if user inputed invalid option
USAGE() {
        if [ $ARG -eq 0 ]
        then
                ctr=0
                MENU
        else
                echo "Syntax error!"
                echo "Usage: exercise2.sh [arg]"
                echo "[arg]: 1 - Add"
                echo "2 - Update"
                echo "3 - Delete"
                echo "4 - Report"
        fi
}

#Function that will add a new record
ADD() {
        echo -e "Name: \c"
        read name

        if [ -z "$name" ]
        then
                echo "Name cannot be empty!"
                sleep 2
        else
                #Check if there is existing name
                line=`grep -i "$name," $FILE`
        
                if [ -z "$line" ]
                then
                        echo -e "Contact Number: \c"
                        read contact
                        
                        if [ -z "$contact" ]
                        then
                                echo "Contact Number cannot be empty!"
                                sleep 2
                        else
                                GET_REC_NO
                                echo "$REC_NO,$name,$contact" >> $FILE
                                echo "Record Added!"

                        fi
                else
                        echo
                        echo "Record already exist!"
                        sleep 2
                fi
        fi


        if [ $ARG -eq 0 ]
        then
                ctr=0
                MENU
        fi
}


#Function that will update existing record
UPDATE() {
        echo -e "Name: \c"
        read name
        
        #test -n "$name" && 
	old_record=`grep -i "$name," $FILE | head -1`
        
        if [ -z "$old_record" -o -z "$name" ]
        then
                echo "Record does not exist!"
                sleep 2
        else
                clear
                REC_NO=`echo $old_record | cut -d, -f1`
                name=`echo $old_record | cut -d, -f2`
                old_number=`echo $old_record | cut -d, -f3`
                echo "Name: $name"
                echo "Old Contact Number: $old_number"
                echo -e "New Contact Number: \c"
                read new_number

                if [ -z "$new_number" ]
                then
                        echo -e "New number cannot be blank! \c"
                        sleep 2
                else
                        grep -iv "$old_record" $FILE > ${FILE}.tmp
                        echo "$REC_NO,$name,$new_number" >> ${FILE}.tmp
                        mv ${FILE}.tmp $FILE
                        echo "Record updated!"
                        sleep 1
                fi
        fi      

        if [ $ARG -eq 0 ]
        then
                ctr=0
                MENU
        fi
}

#Function that will delete a record
DELETE() {
        echo -e "Name: \c"
        read name

        #test -n "$name" && 
	old_record=`grep -i "$name," $FILE | head -1`

        if [ -z "$old_record" -o -z "$name" ]
        then
                echo "Name does not exists!"
                sleep 2
        else
                clear
                REC_NO=`echo $old_record | cut -d, -f1`
                name=`echo $old_record | cut -d, -f2`
                old_number=`echo $old_record | cut -d, -f3`
                echo "Name: $name"
                echo "Contact Number: $old_number"
                echo -e "Delete Record [Y/N]: \c"
                read confirm_ans

                case $confirm_ans in
                        Y|y)
                                grep -iv "$old_record" $FILE > ${FILE}.tmp
                                mv ${FILE}.tmp $FILE
                                echo "Record Deleted!" ;;
                        [Yy][Ee][Ss])
                                grep -iv "$old_record" $FILE > ${FILE}.tmp
                                mv ${FILE}.tmp $FILE
                                echo "Record Deleted!" ;;
                        N|n) ;;
                        [Nn][Oo]) ;;
                        *) echo "Invalid input!" ;;
                esac
                sleep 2
        fi

        if [ $ARG -eq 0 ]
        then
                ctr=0
                MENU
        fi
}

#Function that will print out the report file TB*
REPORT() {
        DATE=`date '+%m/%d/%y %H:%M:%S'`
        RE_DATE=`echo $DATE | sed -e 's/\//-/g' -e 's/ /_/g'`
        UNAME=`uname`
        OUTFILE1=`echo "TB_${UNAME}_${RE_DATE}.txt"`

	if [ ! -d reports ] 
	then
		mkdir reports
	fi
        
        OUTFILE=reports/$OUTFILE1
	echo "REPORT" > $OUTFILE
	echo "-----------------------------------------------------" >> $OUTFILE
        echo "Telephone Book of "`uname` >> $OUTFILE
        echo "Report Generation Date: $DATE" >> $OUTFILE
        echo "" >> $OUTFILE
        echo "RECORD NUMBER   NAME                    CONTACT NUMBER" >> $OUTFILE
        sort -t',' -k 2 list.txt | awk 'BEGIN{FS="," ; OFS="\t\t"}{print $1,$2,$3}' >> $OUTFILE

        clear
        cat $OUTFILE

        sleep 5
        if [ $ARG -eq 0 ]
        then
                ctr=0
                MENU
        fi
}

#Function that will exit from the Menu screen and from the script if ARG is invalid
EXIT() {
        if [ $ARG -eq 1 ]
        then
                USAGE
                exit
        fi
}


if [ -z "$1" ]
then
        ARG=0
        MENU
else
        ARG=1
        choice=$1
        CHOICE
fi

test -s ${FILE}.tmp && rm ${FILE}.tmp
