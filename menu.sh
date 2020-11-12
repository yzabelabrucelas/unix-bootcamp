#!/bin/bash

#Write a shell script that functions as a small restaurant menu.

FILE=order.txt
touch $FILE

#global var
VAR1="Hamburger"
VAR2="Spaghetti"
VAR3="Fried Chicken"
VAR4="Coke"
VAR5="Iced Tea"
VAR6="Bottled Water"

#Function of the main screen
MENU() {
        ctr=0
        while [ $ctr -eq 0 ]
        do
                clear
                echo "Menu for the day"
                echo "--------------------------"
                echo "1 - Hamburger"
                echo "2 - Spaghetti"
                echo "3 - Fried Chicken"
                echo "4 - Drinks"
                echo "5 - Exit"
                echo
                echo -e "Enter Choice: \c"
                read choice

                if [ "$choice" -ge 1 -a "$choice" -le 5 ]
                then
                        ctr=1
                else
                        echo -e "Incorrect option, Try again... \c"
                        sleep 2
                fi
        done
        CHOICE
}

#Function of the menu selection in case
CHOICE() {
        case $choice in
                1) HAMBURGER ;;
                2) SPAGHETTI ;;
                3) CHICKEN ;;
                4) DRINKS ;;
                5) EXIT   ;;
                *) USAGE  ;;
        esac
}

CHECKOUT()
{
    clear
    #print orders on 1st col"
    echo -e "You ordered:" 
    awk -F'|' '{print $1}' order.txt
    echo ""

    #add 2nd col
    echo -e "Total Billing is: \c" 
    awk -F'|' '{s+=$2}END{print s}' order.txt

    echo "Thank you for ordering!"
    sleep 5
    exit

}

#MAIN SCREEN 2
MORE()
{
        ctr=0
        while [ $ctr -eq 0 ]
        do
        
                clear
                echo "Menu for the day"
                echo "--------------------------"
                echo "1 - Hamburger"
                echo "2 - Spaghetti"
                echo "3 - Fried Chicken"
                echo "4 - Drinks"
                echo "5 - Proceed to checkout"
                echo
                echo -e "Enter Choice: \c"
                read choice
                
                #display running_bill 
                echo -e "Running Bill: \c"
                awk -F'|' '{s+=$2}END{print s}' order.txt
                

                if [ "$choice" -ge 1 -a "$choice" -le 5 ]
                then
                        ctr=1
                else
                        echo -e "Incorrect option, Try again... \c"
                        sleep 2
                fi
        done
        CHOICE


}

CANCEL()
{
    ctr=0
        while [ $ctr -eq 0 ]
        do
        
                clear
                echo "Menu for the day"
                echo "--------------------------"
                echo "1 - Hamburger"
                echo "2 - Spaghetti"
                echo "3 - Fried Chicken"
                echo "4 - Drinks"
                echo "5 - Proceed to checkout"
                echo
                echo -e "Enter Choice: \c"
                read choice

                #print orders on 1st col"
                echo -e "You ordered:" 
                awk -F'|' '{print $1}' order.txt
                echo ""

                #echo running_bill
                echo -e "Running Bill: \c"
                awk -F'|' '{s+=$2}END{print s}' order.txt

                #sed '$d' order.txt
 

                echo "Thank you for ordering!"

                if [ "$choice" -ge 1 -a "$choice" -le 5 ]
                then
                        ctr=1
                else
                        echo -e "Incorrect option, Try again... \c"
                        sleep 2
                fi
        done
}


#Function of the second option
WTD() {
        #ctr=0
        #while [ $ctr -eq 0 ]
        #do
                
                echo "What do you want to do?"
                echo "1 - Proceed to checkout"
                echo "2 - Add more"
                echo "3 - Cancel"
                echo 
                echo -e "Enter Choice: \c"
                read wtd

                case $wtd in
                1) CHECKOUT ;;
                2) MORE ;;
                3) CANCEL ;;
                esac

                sleep 5
                exit
        #esac
        #done
        
}


#Function of the second menu selection in case
TODO()
{
            case $wtd in
                1) CHECKOUT ;;
                2) MORE ;;
                3) CANCEL ;;
        esac
}

HAMBURGER() {
        clear
        echo "Hamburger price: \$1.50"
        echo "$VAR1|1.50" >> $FILE
        WTD 
}

SPAGHETTI() {
        clear
        echo "Spaghetti price: \$2.50"
        echo "$VAR2|2.50" >> $FILE
        WTD 
}

CHICKEN() {
        clear
        echo "Fried Chicken price: \$3.00"
        echo "$VAR3|3.00" >> $FILE
        WTD 
}

DRINKS()
{
    clear
    
    #Drinks choice
            ctr=0
        while [ $ctr -eq 0 ]
        do
                
                echo "Choose from the following Drinks price is \$.50"
                echo "1 - Coke"
                echo "2 - Iced Tea"
                echo "3 - Bottled Water"
                echo 
                echo -e "Enter Choice: \c"
                read drinks

                clear
                echo "Drinks price: \$.50"
                case $drinks in
                        1) 
                            #echo "You selected Coke!" 
                            echo "$VAR4|0.50" >> $FILE
                            WTD
                            ;;
                        2) 
                            #echo "You selected Iced Tea!"
                            echo "$VAR5|0.50" >> $FILE
                            WTD ;;
                        3) 
                            #echo "You selected Bottled Water!"
                            echo "$VAR6|0.50" >> $FILE
                            WTD ;;
                        *) echo "Invalid input!" ;;
                esac
    
            
            done

}


#Function that will exit from the Menu screen and from the script if ARG is invalid
EXIT() {
 exit
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