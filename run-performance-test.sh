#!/bin/bash

START_USERS=1
MAX_USERS=$START_USERS

# Set the working directory
WORKING_DIR=$(pwd)

# Set the JMeter home directory
JMETER_HOME="$WORKING_DIR/apache-jmeter-5.6.2"

# Set the path to your JMeter script
JMETER_SCRIPT="$WORKING_DIR/scripts/ContactsWS.jmx"
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
LOG_FILE="jmeter_log_${TIMESTAMP}.log"
RESULTS_FILE="performance_${TIMESTAMP}.csv"
REPORT_DIR="results/performance_${TIMESTAMP}"
mkdir -p "$REPORT_DIR"

CURRENT_USERS=$START_USERS

for ((i = $START_USERS; $CURRENT_USERS <= $MAX_USERS; i++))
do
    # Run JMeter with the specified script and store results in the timestamped file
    "$JMETER_HOME/bin/jmeter" \
        -n -t "$JMETER_SCRIPT" \
        -l "$RESULTS_FILE" \
        -j "$LOG_FILE" \
        -q "scripts/user.properties" \
        -e -o "$REPORT_DIR/$CURRENT_USERS" \
        -Jip="$IP" \
        -Jduration=300 \
        -Jvu1=0 \
        -Jvu2="$CURRENT_USERS" \
        -Jusers=10

    mv "$LOG_FILE" "$REPORT_DIR/$CURRENT_USERS"
    mv "$RESULTS_FILE" "$REPORT_DIR/$CURRENT_USERS"

    echo "Test completed. Results saved to $REPORT_DIR/$CURRENT_USERS"

    # Increment CURRENT_USERS by 10
    CURRENT_USERS=$((i * 10))
done

echo "Test completed. Results saved to $REPORT_DIR"