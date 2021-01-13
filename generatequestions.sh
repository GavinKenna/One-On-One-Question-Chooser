#!/bin/bash

####################################################################
##  Generate random questions for One on One Meetings.            ##
####################################################################


default_question_amount=5

Help()
{
   # Display Help
   echo "Generate random questions for One on One meeting."
   echo
   echo "Syntax: generatequestions [-q|h]"
   echo
   echo "options:"
   echo "   q     Set the amount of questions to generate. By default it is set to 5 questions per category."
   echo "   h     Print this Help."
   echo
}

generateFromCat(){
    echo "======== $1 =========="
    declare -a a
    readarray -t a  <<< $(shuf -n $2 $3)

    for i in "${a[@]}"
    do
        echo "Q. " $i
    done
    echo "======================"
    echo
}

generateQuestions(){
    echo "Generating $1 Questions"

    generateFromCat Manager $1 manager.txt
    generateFromCat Career $1 career.txt
    generateFromCat Satisfaction $1 satisfaction.txt
    generateFromCat Company $1 company.txt
    generateFromCat Worklife $1 worklife.txt
}

# Get the options
while getopts ":h:q:" option; do
   case $option in
      h) # display Help
         Help
         exit;;
      q) # display Help
         target=${OPTARG}
         generateQuestions $target
         exit;;
      \?) # incorrect option
         echo "Error: Invalid option"
         exit;;
      *)
        generateQuestions $default_question_amount
        exit;;
   esac
done
shift $((OPTIND-1))

if [ -z "${q}" ] ; then
    generateQuestions $default_question_amount
fi