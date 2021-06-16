#!/bin/bash
IFS=$'\n'

center() {
  termwidth="$(tput cols)"
  padding="$(printf '%0.1s' " "{1..500})"
  printf '%*.*s %s %*.*s\n' 0 "$(((termwidth-2-${#1})/2))" "$padding" "$1" 0 "$(((termwidth-1-${#1})/2))" "$padding"
}

seprator() {
	printf %"$COLUMNS"s | tr " " "="
}

command_status() {
status=$?
sucess=0
if [[ $status -eq 0 ]]
then
	sucess=1
elif [[ $status -eq 2  || $status -eq 126 ]]
then
	center "Failure status,it seems like there is permission error."
	seprator;
elif [[ $status -eq 127 ]]
then
	center "Failure status,it seems like command doesnot exist or its not in ur PATH."
	seprator;
else
	center "It seems like there is some kind of error."
	seprator;
fi

}

function filecheck() {
local line=0
global_file_found=0

			while (( 0!=1 ))
			do
				line=$[$line + 1]
				if (( $line %4==0 ))
				then
					clear;
				fi

				read -p "Enter the absoulute path of file/Dir[q to quit]: " file_checks
				file_checks=$( echo $file_checks | tr '[:upper:]' '[:lower:]')
				#echo "checkpoint 1:$file_checks"
			
				if [ -e $file_checks ]
					then
						global_file_found=$[ $global_file_found + 1 ]
						break;
							
				elif [[ $file_checks == "q" ]] || [[ $file_checks == "quit" ]]
					then
						break;
						
				else
					seprator;
						center "The give file doesnot seems to exist!!!"
					seprator;
						continue
				fi
			done

			if [[ $global_file_found -eq 1 ]]                                  #calling the variable from function filecheck
					then
						dirname=`dirname $file_checks`
						basename=`basename $file_checks`

			fi

}



function system_lookup 
{
local flag=0
while (( $flag!=1 ))
	do
		cat basic_system_lookup;
		read -p "Enter option# " option
		option=$(echo $option | tr '[:upper:]' '[:lower:]')
		clear	
		case $option in
			1|"uptime")
				center 'UPTIME'
				seprator ;
				center `eval uptime`
				seprator ;;
			
			2|"uname")
				center "Sys Info"
				seprator ;
				center `eval uname -a`
				seprator ;;
			
			3|"size")
			  seprator;
				center "System Size"
				seprator ;
				df -h
				seprator ;;
			
			4|"free")
				seprator;
				center "Memory Usage"
				seprator
				free -h
				seprator;;
			5|"process")
				seprator
				center "Processes"
				seprator
				ps -aux
				seprator;echo "";seprator;;
				
			6|"top")
				top
				seprator;echo "";seprator;;
			
			7|"logged")	
				center "Logged User"
				seprator
				center `eval who`
				seprator;;
				
			8|"Memory")
				seprator;
				center "Memory Information"
				seprator;
				cat /proc/meminfo
				seprator;echo " ";seprator;;
		  
			9|"cpu")
				seprator;
				center "Cpu Information";
				seprator;
				eval lscpu
				seprator;echo " ";seprator;;
				
			10|"overview")
				seprator;
				center "System Overview"
				seprator;
				eval inxi -Fxz
				seprator;echo " ";seprator;;
				
			11|"back")
				case_option;;
			
			12|"exit"|"quit")
				exit;;

			*)
				center "Invalid option!please select the valid number"

		esac
	done
}


function compression {
			
	while (( 1!=0 )) 
	do
		cat compression
		read -p "Enter option# " option
		option=$(echo $option | tr '[:upper:]' '[:lower:]')
		clear

		case $option in
			1|"archive")
				filecheck;
				seprator;
				center "Compressing the file"
				tar -cvf $basename.tar -C $dirname $basename > /dev/null 2>&1
				command_status
				if [[ $sucess -eq 1 ]]
				then
					center "Archive file created on $dirname/$basename."
					seprator
				fi;;
					
			2|"gzip")
				filecheck;
				seprator;
				center "Compressing the file"
				tar -cvzf $basename.tar.gz $file_checks > /dev/null 2>&1
				command_status
				if [[ $sucess -eq 1 ]]
				then
					center "gzip file created on $dirname/$basename.gz."
					seprator
				fi;;
		  
			3|"zip"|"bz2")
				filecheck;
				seprator;
				center "Compressing the file"
				tar -cvjf $basename.tar.bz2 $file_checks > /dev/null 2>&1
				command_status;
				if [[ $sucess -eq 1 ]]
				then
					center "bz2 file created on $dirname/$basename.bz2."
				seprator
				fi;;

			4|"xz")
				filecheck;
				seprator;
				center "Compressing the file"
				tar -cvJf $basename.xz $file_checks > /dev/null 2>&1
				command_status;
				if [[ $sucess -eq 1 ]]
				then
					center "xz file created on $dirname/$basename.xz"
					seprator
				fi;;

			7|"extract")
				filecheck;
				seprator;
				center "Extracting the file"
				tar -xvf $file_checks > /dev/null 2>&1
				command_status;
				if [[ $sucess -eq 1 ]]
				then
					center "Files has been sucessfully extracted on $dirname."
					seprator
				fi;;
			16|"back")
		 		case_option;;

			17|"exit"|"quit")
			center "Bye"
			seprator;
			exit;;
		 
		 *)
			seprator;
			echo "Not a valid option"
			seprator;
		
		esac
	done	
}


function case_option 
{
local flag=0
clear

while (( $flag!=1 )) 
do
	cat show_file	
	read -p "Enter option# " option
	case $option in
		1|"basic system lookup"|"Basic System Lookup")
			clear;
			system_lookup
			$((flag++));;
		
		2|"Compression"|"compression"|"COMPRESSION" )
			clear;
			compression;
			$((flag++))
			;;		
		
		3|"hardware lookup"|"Hardware lookup")
			;;
		4|"exit"|"quit")
			break;;
		*)	
			clear;
	esac

done
}
case_option

