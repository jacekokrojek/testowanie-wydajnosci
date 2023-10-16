#!/bin/zsh

# Set the minimum and maximum number of users
MIN_USERS=1
START_USERS=$MIN_USERS
MAX_USERS=$START_USERS

# Set the JMeter home directory
JMETER_HOME="$PWD/apache-jmeter-5.6.2"
echo "$JMETER_HOME"

# Set the path to your JMeter script
JMETER_SCRIPT="$PWD/scripts/ContactsWS.jmx"

TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
TIMESTAMP=${TIMESTAMP//:/-}
LOG_FILE="jmeter_log_${TIMESTAMP%???}.log"
RESULTS_FILE="performance_${TIMESTAMP%???}.csv"

for ((v=START_USERS; v<=MAX_USERS; v+=10)); do
    REPORT_DIR="results/performance_${TIMESTAMP%???}/$v"
    mkdir -p "$REPORT_DIR"

    # Run JMeter with the specified script and store results in the timestamped file
    "$JMETER_HOME/bin/jmeter" \
        -n -t "$JMETER_SCRIPT" \
        -l "$RESULTS_FILE" \
        -j "$LOG_FILE" \
        -q "scripts/user.properties" \
        -e -o "$REPORT_DIR" \
        -Jip="$IP" \
        -Jduration=300 \
        -Jvu1=0 \
        -Jvu2="$v" \
        -Jusers=10

    mv "$LOG_FILE" "$REPORT_DIR"
    mv "$RESULTS_FILE" "$REPORT_DIR"

    echo "Test completed. Results saved to $REPORT_DIR"
done
