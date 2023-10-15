@echo off
setlocal enabledelayedexpansion

set WORKING_DIR=%CD%
REM Set the JMeter home directory
set JMETER_HOME=%WORKING_DIR%\apache-jmeter-5.6.2
echo %JMETER_HOME%
REM Set the path to your JMeter script
set JMETER_SCRIPT=%WORKING_DIR%\scripts\ContactsWS.jmx

REM Set the results file name with a timestamp
set TIMESTAMP=%date:/=-%_%time::=-%
set TIMESTAMP=!TIMESTAMP: =_!
set LOG_FILE=jmeter_log_%TIMESTAMP:~0,-3%.log
set RESULTS_FILE=stability_%TIMESTAMP:~0,-3%.csv
set REPORT_DIR=results\stability_%TIMESTAMP:~0,-3%
mkdir %REPORT_DIR%
REM Run JMeter with the specified script and store results in the timestamped file

    call "%JMETER_HOME%\bin\jmeter.bat" ^
        -n -t "%JMETER_SCRIPT%" ^
        -l "%RESULTS_FILE%" ^
        -j "%LOG_FILE%" ^
        -e -o "%REPORT_DIR%" ^
        -Jip=%IP% ^
        -Jduration=300 ^
        -Jvu1=1 ^
        -Jvu2=0
         
move %LOG_FILE% %REPORT_DIR%
move %RESULTS_FILE% %REPORT_DIR%

echo Test completed. Results saved to %REPORT_DIR%
