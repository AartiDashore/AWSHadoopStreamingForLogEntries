Hadoop Log Severity Analyzer:

This assignment uses Hadoop Streaming to analyze log entries from a Hadoop run. The goal is to count log severities (`INFO`, `WARN`, `ERROR`, `FATAL`) per minute between 6:01 PM and 6:10 PM on October 18, 2015.

Files Included:

- `process-log-file.sh` — Main driver script: uploads log file to HDFS, runs the MapReduce job, prints sorted output.
- `run-hadoop-streaming.sh` — Sub-script that launches the Hadoop Streaming job using mapper and reducer.
- `mapper.py` — Emits (minute, severity) for each log entry.
- `reducer.py` — Aggregates severity counts for each minute.

Prerequisites:

Make sure you have:

- Hadoop installed and running.
- The `hadoop-streaming.jar` file available (typically located at `/usr/lib/hadoop-mapreduce/hadoop-streaming.jar`).
- Python 3 installed.
- The log file `Hadoop_2k.log` available in your working directory.


How to Run

1. I have created a directory in hadoop named hw2 as:
   
   ```
   $ hadoop fs -mkdir /hw2
   ```

2. Then I placed all the 5 files - process-log-file.sh, run-hadoop-streaming.sh mapper.py, reducer.py and Hadoop_2k.log in HDFS as:
   
   ```
   $ hadoop fs -put process-log-file.sh run-hadoop-streaming.sh mapper.py reducer.py Hadoop_2k.log /hw2
   ```

2. Make all scripts executable (if not already):

   ```
   $ chmod +x process-log-file.sh run-hadoop-streaming.sh mapper.py reducer.py
   ```
   Do the same for all files in HDFS as well:
   ```
   $ hadoop fs -chmod +x /hw2/process-log-file.sh
   $ hadoop fs -chmod +x /hw2/run-hadoop-streaming.sh
   $ hadoop fs -chmod +x /hw2/mapper.py
   $ hadoop fs -chmod +x /hw2/reducer.py
   $ hadoop fs -chmod +x /hw2/Hadoop_2k.log
   ```

2. Run the main script:

   ```
   ./process-log-file.sh
   ```

   This will:
   - Copy `Hadoop_2k.log` to HDFS.
   - Run the MapReduce job.
   - Fetch and print the sorted results to the terminal.


Input file:

1st ten lines of Hadoop_2k.log file:

2015-10-18 18:01:47,978 INFO [main] org.apache.hadoop.mapreduce.v2.app.MRAppMaster: Created MRAppMaster for application appattempt_1445144423722_0020_000001
2015-10-18 18:01:48,963 INFO [main] org.apache.hadoop.mapreduce.v2.app.MRAppMaster: Executing with tokens:
2015-10-18 18:01:48,963 INFO [main] org.apache.hadoop.mapreduce.v2.app.MRAppMaster: Kind: YARN_AM_RM_TOKEN, Service: , Ident: (appAttemptId { application_id { id: 20 cluster_timestamp: 1445144423722 } attemptId: 1 } keyId: -127633188)
2015-10-18 18:01:49,228 INFO [main] org.apache.hadoop.mapreduce.v2.app.MRAppMaster: Using mapred newApiCommitter.
2015-10-18 18:01:50,353 INFO [main] org.apache.hadoop.mapreduce.v2.app.MRAppMaster: OutputCommitter set in config null


Output Format:

Each line in the output corresponds to one minute, with the following format:

```
<Minute> <Total> <INFO> <WARN> <ERROR> <FATAL>
```

The Output:

```
1       157     157     0       0       0
2       188     188     0       0       0
3       232     232     0       0       0
4       268     267     0       1       0
5       73      2       71      0       0
6       260     76      151     31      2
7       210     30      150     30      0
8       210     30      150     30      0
9       210     30      150     30      0
10      192     28      136     28      0
```

Notes:

- The 'minute' is calculated from 6:01 PM = 1 to 6:10 PM = 10.
- The script ensures the output is sorted numerically by minute.
- Output is checked to avoid displaying empty files.