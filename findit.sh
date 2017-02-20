#/bin/bash

# Here's the first line of code to write to do the first homework assignment.
#
# In /scratch2/scratchdirs/nugent/astro250/hwk1 we have a set of fits files as well as catalogs
# from these fits files. They are named the same save for the suffix (.fits or .cat). 
# Some of the .cat files are missing. Write a bash shell script which takes as input 
# the directory name and prints out the names of the .fits files which are missing their 
# corresponding .cat files. If the directory does not exist, the code should print
# out an error statement accordingly.
#

dir=$1

if [ -d "$dir" ]
then
    :
else
    echo "Nope. Next time try giving a directory name that exists."
    exit
fi

if [ -e  no_catalogues.list ]
then
    rm no_catalogues.list
fi

for file in $dir/*.fits
do
    cat="${file%%.fits}.cat"
    #if cat file exists, move on, otherwise copy filename to list
    if [ -e "$cat" ]
    then
	:
    else
	filename="${file##*/}"
	echo $filename >> no_catalogues.list
    fi
done

#check to make sure the numbers are right
fitnum=$(ls $dir | grep "fits" | wc -l)
catnum=$(ls $dir | grep "cat" | wc -l)

resnum1=$(($fitnum - $catnum))
resnum2=$(cat no_catalogues.list | wc -l)
if [ $resnum1 != $resnum2 ]
then
    echo "Numbers do not check out, check code."
fi
