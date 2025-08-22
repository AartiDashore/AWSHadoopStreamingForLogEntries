#!/bin/bash

INPUT_DIR=/hw2/Hadoop_2k.log
OUTPUT_DIR=/hw2/output

# Adjust this path
HADOOP_STREAMING_JAR=/usr/local/hadoop/share/hadoop/tools/lib/hadoop-streaming-3.4.1.jar

if [ ! -f "$HADOOP_STREAMING_JAR" ]; then
    echo "Error: Hadoop streaming JAR not found at $HADOOP_STREAMING_JAR"
    exit 1
fi

hadoop jar $HADOOP_STREAMING_JAR \
    -input $INPUT_DIR \
    -output $OUTPUT_DIR \
    -mapper mapper.py \
    -reducer reducer.py \
    -file mapper.py \
    -file reducer.py