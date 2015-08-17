#!/bin/bash

#######  voiceIT doAll ########################
# Author: Steve G Langer June 2015
# Purpose: automate User acct deletion on the VoiceIT voice recognition API
#	https://siv.voiceprintportal.com/sivservice/users-guide-preface.html#
# 	$1 = run mode (test or Prod)
#	$2 = the name of the function to execute
# from 4.22.2015 email from Noel Grover
############################################
clear


################### do not touch from here down
if [[ $# -ne 2 ]] ; then
	echo "invalid options"
	echo "usage: ./doAll.sh run_mode (test | prod) function (create | nrol | auth | delU | delE | clean )"
	exit
fi

#use echo for debug, curl for Prod
if [[ $1 == "prod" ]] ; then
	cmd="prod"
else
	cmd="test"
fi

path=$(pwd)
ret=$(ls -d user*)
for f in $ret; do
	echo $f
	case $2 in
		#create user
		create)
			result=$( $path/createUser.sh $cmd $f  )
		;;

		#nrol user
		nrol)
			result=$( $path/nrolUser.sh $cmd $f  )
		;;

		#authenticate user
		auth)
			result=$( $path/authUser.sh $cmd $f  )
		;;
		
		#delete user
		delU)
			echo "scary and not implemented"
			exit
		;;
		
		#delete enrolment
		delE)
			echo "not yet implemented"
			exit
		;;
		
		#clean. If we clean at above cases, only the last acct run is logged
		clean)
			rm results_*.txt
			exit
		;;
				
		#unknown
		*)
			echo "unknown case $2"
			exit
		;;
	esac

done
