#!/bin/bash

cfgRepoName="MSE-WS$(date +%y)-SWE"
cfgRepoTestPattern="MSE-WS[0-9][0-9]-SWE$"
cfgName1="se99x999"
cfgName2="se00x000"

echo "Setting up remotes"
echo "=================="

repoName=$1
mainRepoUserName=$2
secondaryRepoUserName=$3
myUserName=$4

while [  -z $repoName ]; do
	echo ""
    echo "Name of the git-repository. Name must include the current year."
	echo "Example: $cfgRepoName"
    echo -n "RepoName (ENTER for $cfgRepoName): "
    read repoName
	
	if [ -z $repoName ]; then 
		repoName=$cfgRepoName
	fi

	if [[ ! $repoName =~ $cfgRepoTestPattern ]]; then
		echo "** ERROR: Parameter is not in a valid format!"
		repoName=""
	fi
done

while [  -z $mainRepoUserName ]; do
	echo ""
    echo "se-number of your groups main repository."
	echo "Example: $cfgName1"
    echo -n "Main repo: "
    read mainRepoUserName
done

while [  -z $secondaryRepoUserName ]; do
	echo ""
    echo "se-number of your groups second repository."
	echo "Example: $cfgName2"
    echo -n "Second repo: "
    read secondaryRepoUserName
done

while [  -z $myUserName ]; do
	echo ""
    echo "se-number of your user name."
	echo "Example: $cfgName1"
    echo -n "Username: "
    read myUserName
done

echo ""

git remote set-url origin "https://$myUserName@inf-swe-git.technikum-wien.at/r/~$mainRepoUserName/$repoName.git"

git remote remove $secondaryRepoUserName
git remote remove all

git remote add $secondaryRepoUserName https://$myUserName@inf-swe-git.technikum-wien.at/r/~$secondaryRepoUserName/$repoName.git
git remote add all "https://$myUserName@inf-swe-git.technikum-wien.at/r/~$mainRepoUserName/$repoName.git"
git remote set-url --add all "https://$myUserName@inf-swe-git.technikum-wien.at/r/~$secondaryRepoUserName/$repoName.git"

echo "Result:"
git remote -v
