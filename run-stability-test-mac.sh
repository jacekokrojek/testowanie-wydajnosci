#!/bin/zsh

WORKING_DIR=$(pwd)

# Set the JMeter home directory
JMETER_HOME="$WORKING_DIR/apache-jmeter-5.6.2"
echo "$JMETER_HOME"

# Set the path to your JMeter script
JMETER_SCRIPT="$WORKING_DIR/scripts/ContactsWS.jmx"

# Set the results file name with a timestamp
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
TIMESTAMP=${TIMESTAMP//:/-}
LOG_FILE="jmeter_log_${TIMESTAMP%???}.log"
RESULTS_FILE="stability_${TIMESTAMP%???}.csv"
REPORT_DIR="results/stability_${TIMESTAMP%???}"
mkdir -p "$REPORT_DIR"

# Run JMeter with the specified script and store results in the timestamped file
"$JMETER_HOME/bin/jmeter" \
    -n -t "$JMETER_SCRIPT" \
    -l "$RESULTS_FILE" \
    -j "$LOG_FILE" \
    -e -o "$REPORT_DIR" \
    -Jip="$IP" \
    -Jduration=300 \
    -Jvu1=1 \
    -Jvu2=0

mv "$LOG_FILE" "$REPORT_DIR"
mv "$RESULTS_FILE" "$REPORT_DIR"

echo "Test completed. Results saved to $REPORT_DIR"
