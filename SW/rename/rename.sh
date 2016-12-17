#!/bin/bash
# rename all files in a directory to a sequence
# i : input directory
# o : output directory
# p : prefix file name
# s : starting index
# l : number prefix length


# ./rename.sh  -i ./files  -o ./output  -p "mca_ugc_"  -s 5  -l 3


function prependString {
	local str="$1"
	local chars="$2"
	local maxLen="$3"
	local len=${#str}
	while [ "$len" -lt "$maxLen" ]
	do
		str="$chars""$str"
		len=${#str}
	done
	echo "$str"
}

STARTING_INDEX=0
INPUT_DIRECTORY=""
OUTPUT_DIRECTORY=""
NAME_PREFIX=""
PREFIX_LENGTH=5

ARGUMENT_I='-i'
ARGUMENT_O='-o'
ARGUMENT_S='-s'
ARGUMENT_P='-p'
ARGUMENT_L='-l'
CURRENT_COMMAND=''

for arg in "$@"
do
	if [ "$arg" == "$ARGUMENT_I" ]; then
		CURRENT_COMMAND="$ARGUMENT_I"
	fi
	if [ "$arg" == "$ARGUMENT_O" ]; then
		CURRENT_COMMAND="$ARGUMENT_O"
	fi
	if [ "$arg" == "$ARGUMENT_P" ]; then
		CURRENT_COMMAND="$ARGUMENT_P"
	fi
	if [ "$arg" == "$ARGUMENT_S" ]; then
		CURRENT_COMMAND="$ARGUMENT_S"
	fi
	if [ "$arg" == "$ARGUMENT_L" ]; then
		CURRENT_COMMAND="$ARGUMENT_L"
	fi

		# INPUT DIRECTORY
		if [ "$CURRENT_COMMAND" == "$ARGUMENT_I" ]; then
			if [ "$arg" != "$ARGUMENT_I" ]; then
				CURRENT_COMMAND=""
				INPUT_DIRECTORY="$arg"
			fi
		fi

		# OUTPUT DIRECTORY
		if [ "$CURRENT_COMMAND" == "$ARGUMENT_O" ]; then
			if [ "$arg" != "$ARGUMENT_O" ]; then
				CURRENT_COMMAND=""
				OUTPUT_DIRECTORY="$arg"
			fi
		fi

		# PREFIX
		if [ "$CURRENT_COMMAND" == "$ARGUMENT_P" ]; then
			if [ "$arg" != "$ARGUMENT_P" ]; then
				CURRENT_COMMAND=""
				NAME_PREFIX="$arg"
			fi
		fi

		# INDEX
		if [ "$CURRENT_COMMAND" == "$ARGUMENT_S" ]; then
			if [ "$arg" != "$ARGUMENT_S" ]; then
				CURRENT_COMMAND=""
				STARTING_INDEX="$arg"
			fi
		fi

		# PREFIX LENGTH
		if [ "$CURRENT_COMMAND" == "$ARGUMENT_L" ]; then
			if [ "$arg" != "$ARGUMENT_L" ]; then
				CURRENT_COMMAND=""
				PREFIX_LENGTH="$arg"
			fi
		fi
done

# echo ".............."
# echo $INPUT_DIRECTORY
# echo $OUTPUT_DIRECTORY
# echo $NAME_PREFIX
# echo $STARTING_INDEX
# echo ".............."
index=$STARTING_INDEX

# make directory if not exist
mkdir -p $OUTPUT_DIRECTORY

# GET INPUT FILE LISTING
FILE_LIST=()
for file in "$INPUT_DIRECTORY"/*
do
	FILE_LIST+=($file)
done

fileCount=${#FILE_LIST[@]}
echo "copying $fileCount files"
i=0
while [ $i -lt $fileCount ]
do
	source_path=${FILE_LIST[$i]}
	filetype=$(echo "$source_path" | sed 's/.*\.//' )

	ending=$(prependString $index "0" $PREFIX_LENGTH)
	filename="$NAME_PREFIX""$ending"".""$filetype"
	
	dest_path="$OUTPUT_DIRECTORY""/""$filename"
	command="cp $source_path $dest_path"
	
	echo "$source_path => $dest_path"

	`$command`

	i=$((i + 1))
	index=$((index + 1))
done


