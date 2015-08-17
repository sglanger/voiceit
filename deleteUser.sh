#!/bin/bash

#######  voiceIT deleteUser ########################
# Author: Steve G Langer June 2015
# Purpose: automate User acct deletion on the VoiceIT voice recognition API
#	https://siv.voiceprintportal.com/sivservice/users-guide-preface.html#
# 	$1 = run mode (test or Prod)
#	$2 = the name of the user to create
# from 4.22.2015 email from Noel Grover
############################################
clear

################### do not touch from here down
if [[ $# -ne 2 ]] ; then
	echo "invalid options"
	echo "usage: ./delUser.sh run_mode (test or prod) acct_name (name of user account to delete) "
	exit
fi

#use echo for debug, curl for Prod
if [[ $1 == "prod" ]] ; then
	cmd="curl"
else
	cmd="echo"
fi

user=$2
devID="200056"
result=$($cmd --request DELETE --header "VsitEmail: $user@$devID.com" --header "VsitPassword: 8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92" --header "VsitDeveloperId: $devID" https://siv.voiceprintportal.com/sivservice/api/users )
echo ""
echo $result  >> results_del.txt ; echo "" >> results_del.txt