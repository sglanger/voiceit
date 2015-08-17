#!/bin/bash

#######  voiceIT authUser.sh ########################
# Author: Steve G Langer June 2015
# Purpose: automate User authentication on the VoiceIT voice recognition API
#	https://siv.voiceprintportal.com/sivservice/users-guide-preface.html#
# 	$1 = run mode (test or Prod)
#	$2 = the name of the folder containing the authentication wav(s)
# from 4.22.2015 email from Noel Grover
############################################
clear

################### do not touch from here down
if [[ $# -ne 2 ]] ; then
	echo "invalid options"
	echo "usage: ./authUser.sh run_mode (test or prod) folder_name (where folder contains target wav files)"
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
devID="200056"
	
cd $path
ret=$(ls  *_au*)
for f in $ret; do
	echo $f
	result=$($cmd --request POST --data-binary  @"$f"  --header "Content-Type:audio/wav" --header "VsitEmail: user1@200056.com" --header "VsitPassword: 8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92" --header "VsitDeveloperId: 200056" --header "VsitAccuracy: 0" --header "VsitAccuracyPasses: 2" --header "VsitAccuracyPassIncrement: 5" --header "VsitConfidence: 89" https://siv.voiceprintportal.com/sivservice/api/authentications)
	echo ""
	echo $result  >> ../results_auth.txt ; echo "" >> ../results_auth.txt
done
