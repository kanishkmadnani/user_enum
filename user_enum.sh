#!/bin/bash
#################################################################################################
#	Gather User information from the system		#
#	Created By: Kanishk Madnani		#
#	Created On: 3rd NOV 2020		#
#	Github Acc: https://github.com/kanishkmadnani		#
#################################################################################################
clear
red='\e[41m'
green='\e[42m'
end='\e[0m'
#function start
m1 () { 
	echo "--------------------------------------"
	echo "|[+] GETTING USERS INFORMATION       |"
	echo "--------------------------------------"
	a=$(cat /etc/passwd | awk -F ':' '$3>=1000 {print "Valid User :"$1","$3}')
	echo "$a"
}

m2 () {
 	echo "------------------------------------------------"
	echo "|GETTING USERS WITH SHELL ACCESS               |"
	echo "------------------------------------------------"
	g=$(cat /etc/passwd | grep "/bin/sh\|/bin/bash" | cut -d':' -f1)
	echo "[+] USERS:
$g"

}

m3 () {
	echo "------------------------------------------------"
	echo "|GETTING USERS WITH PASSWORD INFO              |"
	echo "------------------------------------------------"
	users=$(cat /etc/passwd | awk -F ":" '{if ($3 >= 1000) print $1}')
	for a in $users
	do
	blank=$(cat /etc/shadow | grep "$a" | awk -F ":" '{if (-z $2) print $2}')
	nopwd=$(cat /etc/shadow | grep "$a" | awk -F ":" '{if ($2 == "!") print $2}')
	strpwd=$(cat /etc/shadow | grep "$a" | awk -F ":" '{if ($2 == "*") print $2}')
	if [ "!" == "$nopwd" ]; then
	echo "$a : No Password"
	elif [ "*" == "$strpwd" ]; then
	echo "$a : Service Account, No Password"
	elif [ -z "$blank" ]; then
	echo "$a : Blank Password"
	else 
	echo "$a : Has Password" 
	fi
	done

}

m4 () {
	echo "------------------------------------------------"
	echo "|GETTING ALL INFORMATION./././././././././././ |"
	echo "------------------------------------------------"
	g=$(cat /etc/passwd | awk -F ':' '$3>=1000 {print "Valid User :"$1","$3}' ; 
echo "<<<<<<Users with no shell>>>>>>" ;
cat /etc/passwd | grep "/bin/bash" | cut -d':' -f1)
	echo "[+] USERS:
$g"

}
#function end

func() {
#menu
echo ""
figlet "Users Information"             
echo ""
echo -e "${red}1. Users with UID 999+
2. Users with shell access
3. Users with password info
4. Get all information
0. Exit ${end}"
read -p "Option: " method

case $method in
	1)
	 m1
	 func
	 ;;
	2)
	 m2 
	 func
	 ;;
	3)
	 m3
	 func
	 ;;
	4)
	 m4
	 func
	 ;;
	0)
	 echo "byebye"
	 ;;
	*)
	 echo "Option is out of range, please try with 1, 2, 3 & 4"
	 func
	 ;;
esac
}
func
