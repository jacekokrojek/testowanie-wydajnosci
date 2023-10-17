#!/bin/bash

if [ $# -ne 1 ]; then
  echo "Usage: $0 <start_directory>"
  exit 1
fi

# Get the start directory from the command-line argument
start_directory="$1"
echo "timeStamp,elapsed,label,responseCode,responseMessage,threadName,dataType,success,failureMessage,bytes,sentBytes,grpThreads,allThreads,URL,Latency,IdleTime,Connect" > "$start_directory/mergedResults.csv"

# Use find to locate all .txt files in subdirectories
find "$start_directory" -type f -name "performance_*.csv" | while read -r txt_file; do
  # Use the 'cat' command to display the contents of each .txt file
  cat "$txt_file" | grep -v 'timeStamp,elapsed' >> "$start_directory/mergedResults.csv"

done

# Set the working directory
WORKING_DIR=$(pwd)

# Set the JMeter home directory
JMETER_HOME="$WORKING_DIR/apache-jmeter-5.6.2"

"$JMETER_HOME/bin/jmeter" \
    -g "$start_directory/mergedResults.csv" \
    -o "$start_directory/mergedResults" \
#    -q "scripts/user.properties"