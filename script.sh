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


function system_lookup 
{
flag=0
while (( flag!=1 ))
	do
		cat basic_system_lookup;
		read -p "Enter option# " option
		clear	
		case $option in
			1|"uptime"|"Uptime")
				center 'UPTIME'
				seprator ;
				center `eval uptime`
				seprator ;;
			
			2|"uname"|"version")
				center "Sys Info"
				seprator ;
				center `eval uname -a`
				seprator ;;
			
			3|"size"|"Size")
			  seprator;
				center "System Size"
				seprator ;
				df -h
				seprator ;;
			
			4|"free"|"free"|"FREE")
				seprator;
				center "Memory Usage"
				seprator
				free -h
				seprator;;
			5|"process"|"Process"|"PROCESS")
				seprator
				center "Processes"
				seprator
				ps -aux
				seprator;echo "";seprator;;
				
			6|"top"|"Top"|"TOP")
				top
				seprator;echo "";seprator;;
			
			7|"logged"|"Logged"|"LOGGED")	
				center "Logged User"
				seprator
				center `eval who`
				seprator;;
				
			8|"Memory"|"memory"|"MEMORY"|"meminfo")
				seprator;
				center "Memory Information"
				seprator;
				cat /proc/meminfo
				seprator;echo " ";seprator;;
		  
			9|"cpu"|"Cpuinfo"|"cpuinfo")
				seprator;
				center "Cpu Information";
				seprator;
				eval lscpu
				seprator;echo " ";seprator;;
				
			10|"overview"|"sysinfo"|"sysoverview")
				seprator;
				center "System Overview"
				seprator;
				eval inxi -Fxz
				seprator;echo " ";seprator;;
				
			11|"back"|"Back")
				case_option;;
			
			12|"exit"|"quit")
				exit;;

			*)
				echo "Invalid option!please select the valid number"

		esac
	done
}


function case_option 
{
flag=0
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
		
		2|"Network Lookup"|"network lookup" )
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

