#!/usr/bin/env bash
# =============================================================================
# System Information Script
#
# Session 3 - Shell Scripting homework.
# Author: Hardik Jumnani  (Roll 10025)
#
# Collects basic system information, asks the user where to store a process
# snapshot, and writes that snapshot to a file.
#
# Demonstrates every construct the task asks for:
#   variables, read -p, mkdir, touch, echo, date, hostname, whoami, df, ps,
#   and > output redirection.
#
# Usage:
#   bash system-info.sh                    # prompts for a report directory
#   echo "myreport" | bash system-info.sh  # non-interactive, for a scripted run
# =============================================================================

# ---- Variables: collected once, reused throughout -------------------------
CURRENT_DATE=$(date '+%A, %d %B %Y  %H:%M:%S %Z')
HOST_NAME=$(hostname)
USER_NAME=$(whoami)
KERNEL=$(uname -r)
UPTIME=$(uptime -p)

echo "==========================================================="
echo "                 SYSTEM INFORMATION REPORT"
echo "==========================================================="
echo

# ---- Section 1: identity ---------------------------------------------------
echo "--- Identity ---"
echo "Date      : $CURRENT_DATE"
echo "Hostname  : $HOST_NAME"
echo "Username  : $USER_NAME"
echo "Kernel    : $KERNEL"
echo "Uptime    : $UPTIME"
echo

# ---- Section 2: disk usage -------------------------------------------------
echo "--- Disk Usage ---"
df -h | grep -vE '^(tmpfs|devtmpfs|overlay)'
echo

ROOT_USAGE=$(df -h / | awk 'NR==2 {print $5}')
echo "Root filesystem is ${ROOT_USAGE} full."
echo

# ---- Section 3: running processes -----------------------------------------
echo "--- Top 10 Processes by Memory ---"
ps aux --sort=-%mem | head -11
echo

PROCESS_COUNT=$(ps aux | wc -l)
echo "Total running processes: $((PROCESS_COUNT - 1))"
echo

# ---- Section 4: user input decides where the report is written ------------
echo "--- Saving the Report ---"
read -p "Enter a name for the report directory: " REPORT_DIR

# Fall back to a sensible default if the user just pressed Enter.
if [ -z "$REPORT_DIR" ]; then
    REPORT_DIR="system-report-$(date +%Y%m%d-%H%M%S)"
    echo "No name entered - defaulting to: $REPORT_DIR"
fi

# ---- Create the directory and the file ------------------------------------
mkdir -p "$REPORT_DIR"
echo "Created directory : $REPORT_DIR"

REPORT_FILE="${REPORT_DIR}/processes.txt"
touch "$REPORT_FILE"
echo "Created file      : $REPORT_FILE"
echo

# ---- Write the process list using > output redirection --------------------
# A single > truncates and writes; >> below appends the summary afterwards.
ps aux > "$REPORT_FILE"

# Append a short footer so the file records who generated it and when.
{
    echo ""
    echo "--- Report metadata ---"
    echo "Generated : $CURRENT_DATE"
    echo "Host      : $HOST_NAME"
    echo "User      : $USER_NAME"
} >> "$REPORT_FILE"

LINE_COUNT=$(wc -l < "$REPORT_FILE")
echo "Wrote $LINE_COUNT lines to $REPORT_FILE"
echo

echo "--- Verifying the saved file ---"
echo "\$ ls -lh $REPORT_DIR"
ls -lh "$REPORT_DIR"
echo
echo "\$ head -5 $REPORT_FILE"
head -5 "$REPORT_FILE"
echo
echo "\$ tail -6 $REPORT_FILE"
tail -6 "$REPORT_FILE"
echo

echo "==========================================================="
echo "Report complete: $REPORT_FILE"
echo "==========================================================="
