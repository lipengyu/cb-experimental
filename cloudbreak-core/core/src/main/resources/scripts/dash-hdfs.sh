#!/bin/bash -e

: ${LOGFILE:=/var/log/consul-watch/consul_handler.log}

: ${SOURCE_DIR:=/data/jars}
: ${STORAGE_JAR:=dash-azure-storage-2.2.0.jar}
: ${MR_TAR_NAME:=mapreduce.tar.gz}
: ${TEZ_TAR_NAME:=tez.tar.gz}
: ${TMP_EXTRACT_DIR:=temp_extract_dir}

main(){
  SOURCE_JAR="$SOURCE_DIR/$STORAGE_JAR"
  if [ ! -f "$SOURCE_JAR" ]; then
    echo 'DASH storage jar not found in the source directory, downloading it to /tmp.'
    SOURCE_JAR="/tmp/$STORAGE_JAR"
    curl "https://www.dash-update.net/client/Latest/StorageSDK2.0/$STORAGE_JAR" > "$SOURCE_JAR";
  fi

  hdp_version=$(ls /usr/hdp/ | head -1);
  echo "Found HDP version: $hdp_version"

  MR_TAR_PATH="/hdp/apps/$hdp_version/mapreduce/$MR_TAR_NAME"
  TEZ_TAR_PATH="/hdp/apps/$hdp_version/tez/$TEZ_TAR_NAME"

  echo "HDFS path to $MR_TAR_NAME: $MR_TAR_PATH"
  echo "HDFS path to $TEZ_TAR_NAME: $TEZ_TAR_PATH"

  cd /tmp
  for tar_file_path in $MR_TAR_PATH $TEZ_TAR_PATH; do

    tar_file=$(basename $tar_file_path)

    echo "Copying $tar_file from HDFS to local fs."
    [[ -f "/tmp/$tar_file" ]] && rm "/tmp/$tar_file"
    hadoop fs -copyToLocal "$tar_file_path" /tmp

    rm -rf $TMP_EXTRACT_DIR && mkdir $TMP_EXTRACT_DIR && cd $TMP_EXTRACT_DIR
    echo "Extracting $tar_file."
    tar -zxf ../$tar_file

    echo "Replacing azure-storage.jar with $STORAGE_JAR."
    find . -name "azure-storage*.jar" | while read line; do echo Replace $line; \cp -f $SOURCE_JAR ${line%azure*}; rm -f $line; done

    echo "Removing $tar_file."
    rm -f "../$tar_file"

    echo "Creating new $tar_file with the replaced libs."
    tar -zcf "../$tar_file" $(ls)

    echo "Replacing $tar_file on HDFS."
    su -c "hadoop fs -put -f ../$tar_file $tar_file_path" hdfs

    echo "Cleaning up local fs."
    rm -f "../$tar_file"
    cd .. && rm -rf $TM_EXTRACT_DIR
  done
}

exec &>> "$LOGFILE"
[[ "$0" == "$BASH_SOURCE" ]] && main "$@"
