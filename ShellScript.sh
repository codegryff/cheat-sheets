# [ -z ] vs [ -n ]
[ -z "$var" ] && echo "Zero length"
[ -n "$var" ] && echo "Not Null"



# ------------------------------------------------------
# Delimiter separated file, save each column as variable
cat $FILE | while IFS="${DELIMITER}" read -r FIELD1 FIELD2 FIELD3; do
    # process $FIELD1 $FIELD2 etc
    echo "$FIELD1 $FIELD2"
done

#Example1/
SUM=0
cat FILE.txt | while IFS="|" read -r "NUM1" "NUM2"; do
    echo "$NUM1 $NUM2"
    SUM=$((SUM + NUM1))
done
echo $SUM #equal to 0

#Example2/
SUM=0
while IFS="|" read -r "NUM1" "NUM2"; do
    echo "$NUM1 $NUM2"
    SUM=$((SUM + NUM1))
done < FILE.txt
echo $SUM #non-zero



# ------------------------------------------------------
# Get file name without extension
SCRIPT_NAME=$(basename -- "$0")
BASE_WORD="${SCRIPT_NAME%.*}"



# ------------------------------------------------------
# Use variables inside "awk"
VAR1="..."
VAR2="..."

awk -v VAR1="$VAR1" -v VAR2="$VAR2" #....



# ------------------------------------------------------
# awk fixedwidth columns
cat $FILE | awk 'BEGIN { FIELDWIDTHS="10 20 30" } { $1=VAR1 ; $2=VAR2 ; print $1 $2 $3 }'



# ------------------------------------------------------
# tail/header
tail -n +2 #skip first line



# ------------------------------------------------------
# find + redirection
# multiple "-exec"
# redirect stdout and stderr to "tee"
( find "$DIR" -maxdepth 1 -type d -mtime "+1" -empty -exec ls -ld {} \; -exec rmdir -v {} \; ) 2>&1 | tee -a $LOGFILE