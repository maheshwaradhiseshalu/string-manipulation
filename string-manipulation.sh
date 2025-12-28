#!/bin/bash

# Fail the build if there is a non zero exit code
set -e

#Get the file name from user

# Store location of the input file in a variable
INPUT="/home/mahesh/Documents/shell-script-projects"
INPUTFILE="input.txt"

# Store location of the output file
OUTPUT="/home/mahesh/Documents/shell-script-projects"
OUTPUTFILE="output.txt"

# Counter variable
WORDCOUNTER=0

# Go to the location where the input files are stored
cd ${INPUT}

# start counting the words
count=1
#n should be equal to total no of charc
n=$(cat $INPUTFILE | wc -m)
while [ $count -le $n ]; do
  currentchar=$(tr -d '\n' < $INPUTFILE | cut -c"$count")

# condition statements
if [ "$currentchar" = " " ]; then
 WORDCOUNTER=$((WORDCOUNTER + 1))
fi
  count=$((count + 1))
done

# Store the count in output file
echo "THE NUMBER OF WORDS : $WORDCOUNTER" >> ${OUTPUTFILE}

# start counting the special characters
SPECIALCOUNT=0

while IFS= read -r -n1 char; do
# condition statements
  if [[ ! "$char" =~ [[:alnum:][:space:]] ]]; then
    SPECIALCOUNT=$((SPECIALCOUNT + 1))
  fi
done < "$INPUTFILE"

# Store the count in output file
echo "Special characters: $SPECIALCOUNT" >> ${OUTPUTFILE}

# Count the number of lines in the input file and print it
LINECOUNT=0
LINECOUNT=$(awk 'END {print NR}' "$INPUTFILE")
echo "Number of lines: $LINECOUNT" >> ${OUTPUTFILE}

# Paragraph count
PARACOUNT=0
PARACOUNT=$(awk 'NF {p=1} !NF && p {c++; p=0} END {print c+p}' "$INPUTFILE")
echo "Number of Paragraphs: $PARACOUNT" >> ${OUTPUTFILE}

# Exit code
exit 0