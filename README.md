voiceIT Scripts
----------------------------
createUser.sh
nrolUser.sh
authUser.sh
delUser.sh
doAll.sh

Other then doAll, each other script takes one command line arg, the folder of the target wav files

doAll also takes one arg which tells it what to do: create all user accounts, enroll all users, authenticate
all users, or delete a specific user account. For doAll to work it assumes the following folder structure. For every 
user there is a folder called "userN" where N is some integer. WIthin the folder are the .wav files that follow
"the WAV rules" for that user. The file naming conventions are:

	a) Three enrolment wav files that have the patterm *_nrol* in their filename
	b) One or more authentication wav files that have the pattern *_au* in their filename

The above scripts log their results (the JSON returned from VoiceIT) to log files which later will be parsed for stats
on accuracy, etc for the paper


the WAV rules
--------------------------------

for enrollment of a user:
	a) have to pick an approved pass phrase from here https://siv.voiceprintportal.com/sivservice/att/en-US-grammar.grxml
	b) have to have 3 different recordings of that one phrase
	c) 3s to 5s recording time duration.
	d) First 500ms and Last 500ms need only background noise. No speaking/talking.

for user authentication:
	a) has to be a fresh recording
	b) has to be the same passphrase as above
	c) other properties as above

