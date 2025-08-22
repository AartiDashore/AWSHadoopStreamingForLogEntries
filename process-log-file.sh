#!/bin/bash

set -e

INPUT_FILE=Hadoop_2k.log
HDFS_DIR=/hw2
OUTPUT_FILE=output.txt

# Remove old input/output in HDFS
hadoop fs -rm -f ${HDFS_DIR}/${INPUT_FILE} || true
hadoop fs -rm -r -f ${HDFS_DIR}/output || true

# Put new input
hadoop fs -mkdir -p ${HDFS_DIR}
hadoop fs -put ${INPUT_FILE} ${HDFS_DIR}/

# Run streaming job
./run-hadoop-streaming.sh

# Merge output
if hadoop fs -test -e ${HDFS_DIR}/output; then
    hadoop fs -getmerge ${HDFS_DIR}/output ${OUTPUT_FILE}
    if [ -s ${OUTPUT_FILE} ]; then
        sort -n ${OUTPUT_FILE}
    else
        echo "Error: Output file is empty!" >&2
        exit 1
    fi
else
    echo "Error: Output directory not created!" >&2
    exit 1
fi