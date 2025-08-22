#!/usr/bin/env python3
import sys
import re

try:
    for line in sys.stdin:
        line = line.strip()
        # Match pattern like: 2015-10-18 18:01:47,978 INFO ...
        match = re.match(r'^2015-10-18 18:(\d{2}):\d{2},\d+\s+(INFO|WARN|ERROR|FATAL)', line)
        if match:
            minute_str = match.group(1)
            severity = match.group(2)
            minute_num = int(minute_str) - 1 + 1  # Convert 01–10 to 1–10
            if 1 <= minute_num <= 10:
                print(f"{minute_num}\t{severity}")
except Exception as e:
    print(f"Error in mapper: {e}", file=sys.stderr)