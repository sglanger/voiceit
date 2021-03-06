#!/bin/bash

#######  voiceIT nrolUser.sh ########################
# Author: Steve G Langer June 2015
# Purpose: automate User enrolment on the VoiceIT voice recognition API
#	https://siv.voiceprintportal.com/sivservice/users-guide-preface.html#
# 	$1 = run mode (test or Prod)
#	$2 = the name of the folder with target wav files
# from 4.22.2015 email from Noel Grover
############################################
clear

################### do not touch from here down
if [[ $# -ne 2 ]] ; then
	echo "invalid options"
	echo "usage: ./nrolUser.sh run_mode (test or prod) folder_name (where folder contains target wav files)"
	exit
fi

#use echo for debug, curl for Prod
if [[ $1 == "prod" ]] ; then
	cmd="curl"
else
	cmd="echo"
fi

user=$2
path=$(pwd)
path=$path/$user
# insert your ID below
devID="2000xx"

cd $path
ret=$(ls  *_nrol*)
for f in $ret; do
  echo $f
  result=$($cmd   --request POST --data-binary @"$f" --header "Content-Type:audio/wav" --header "VsitEmail: $user@$devID.com" --header "VsitPassword: 8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92" --header "VsitDeveloperId: $devID" https://siv.voiceprintportal.com/sivservice/api/enrollments )
  echo ""
  echo $result  >> ../results_nrol.txt ; echo "" >> ../results_nrol.txt
done
