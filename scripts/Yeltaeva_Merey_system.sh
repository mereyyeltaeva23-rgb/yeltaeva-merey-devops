#!/bin/bash
# =============================================================
#  Yeltaeva_Merey_system.sh — student & system information
#  Author: Merey Yeltaeva, group IT2-2301
# =============================================================

# Folder of this script and the project root (one level up)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"
INFO_FILE="$PROJECT_DIR/Yeltaeva_Merey_info.txt"

NAME="Merey"
SURNAME="Yeltaeva"
GROUP="IT2-2301"
STUDENT_ID="37603"
LINE="=============================="

echo "$LINE"
echo "Student Information"
echo "$LINE"
echo "Name: $NAME"
echo "Surname: $SURNAME"
echo "Group: $GROUP"
echo "Student ID: $STUDENT_ID"

echo "$LINE"
echo "System Information"
echo "$LINE"
echo "Username: $(whoami)"
echo "Hostname: $(hostname 2>/dev/null || uname -n)"
echo "Current Date: $(date)"

# Operating system: nice name from /etc/os-release if it exists
if [ -f /etc/os-release ]; then
    OS_NAME=$(. /etc/os-release && echo "$PRETTY_NAME")
else
    OS_NAME=$(uname -s)
fi
echo "Operating System: $OS_NAME ($(uname -sr))"

echo "Disk Usage:"
df -h /

echo "Memory Usage:"
if command -v free >/dev/null 2>&1; then
    free -h
else
    echo "  'free' is not available on this system"
fi

echo "$LINE"
# Check whether the student information file exists
if [ -f "$INFO_FILE" ]; then
    echo "Student information file exists."
else
    echo "Student information file does not exist."
fi
