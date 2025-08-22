#!/usr/bin/env python3
import sys
from collections import defaultdict

def emit(minute, counts):
    total = sum(counts.values())
    print(f"{minute}\t{total}\t{counts['INFO']}\t{counts['WARN']}\t{counts['ERROR']}\t{counts['FATAL']}")

try:
    current_minute = None
    counts = defaultdict(int)

    for line in sys.stdin:
        line = line.strip()
        if not line:
            continue
        minute, severity = line.split("\t")
        if current_minute != minute:
            if current_minute is not None:
                emit(current_minute, counts)
            current_minute = minute
            counts = defaultdict(int)
        counts[severity] += 1

    if current_minute is not None:
        emit(current_minute, counts)

except Exception as e:
    print(f"Error in reducer: {e}", file=sys.stderr)