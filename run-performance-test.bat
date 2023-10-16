@echo off
setlocal enabledelayedexpansion

set "START_USERS=1"
set "MAX_USERS=%START_USERS%"

set WORKING_DIR=%CD%

REM Set the JMeter home directory
set JMETER_HOME=%WORKING_DIR%\apache-jmeter-5.6.2
echo %JMETER_HOME%

REM Set the path to your JMeter script
set JMETER_SCRIPT=%WORKING_DIR%\scripts\ContactsWS.jmx
set TIMESTAMP=%date:/=-%_%time::=-%
set TIMESTAMP=!TIMESTAMP: =_!
set LOG_FILE=jmeter_log_%TIMESTAMP:~0,-3%.log
set RESULTS_FILE=performance_%TIMESTAMP:~0,-3%.csv
set REPORT_DIR=results\performance_%TIMESTAMP:~0,-3%

mkdir %REPORT_DIR%

for /l %%v in (%MIN_USERS%,10,%MAX_USERS%) do (
    REM Run JMeter with the specified script and store results in the timestamped file
    call "%JMETER_HOME%\bin\jmeter.bat" ^
        -n -t "%JMETER_SCRIPT%" ^
        -l "%RESULTS_FILE%" ^
        -j "%LOG_FILE%" ^
        -q "scripts\user.properties" ^
        -e -o "%REPORT_DIR%\%%v" ^
        -Jip=%IP% ^
        -Jduration=300 ^
        -Jvu1=0 ^
        -Jvu2=%%v ^
        -Jusers=10

    move %LOG_FILE% %REPORT_DIR%\%%v
    move %RESULTS_FILE% %REPORT_DIR%\%%v

    echo Test completed. Results saved to %REPORT_DIR%\%%v
)

endlocal
