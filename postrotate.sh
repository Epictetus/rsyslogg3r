/sbin/service rsyslog restart

TEMPFILE=/tmp/logrotate-$RANDOM.bz2
S3_FiLE=s3://<%= @bucket_name %>/$(date +%Y/%m/%Y-%m-%d-%H-%M-%S).log.bz2

nice bzip2 -9 -c /var/log/heroku.log.1 >$TEMPFILE
/usr/bin/s3cmd put $TEMPFILE $S3_FILE
rm -f $TEMPFILE