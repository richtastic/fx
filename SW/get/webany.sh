# !/bin/bash
# download all references with specific extension
# ./webany.sh URL png
# 
TEMPFILE=".TEMP"
if [ $# == 2 ]; then
LINK=$1
EXTE=$2
echo "getting any file with extension: ."$EXTE
# download main file and place in TEMPFILE
COMMAND="wget "$LINK" -O "$TEMPFILE" -q"
$COMMAND
# find all related internal links
STRING="((href|src)[=\\"a-zA-Z0-9._-=/\\"]*)\\."$EXTE'"'
RESULT=`cat $TEMPFILE | egrep $STRING -o | sed "s/\\(href\\|src\\)=\\"//g" | sed "s/\\"//g"`
FOLDER=`echo $LINK | sed "s/\\/[0-9_a-zA-Z.]*$//"`
# for each found file
for FILE in $RESULT ; do
# need to check if there is a http prefix before appending
#FULL=$FOLDER"/"$FILE
FULL=$FILE
echo "getting file: "$FULL
wget $FULL -q -N # -q=quiet, -N=allowOverwrite
# --timestamping 
done
# clean up temp file
rm $TEMPFILE
else
echo $0" URL extension"
fi	


# could use an index to keep track of downloaded stuff, and ignore duplicates rather than specify -N 


