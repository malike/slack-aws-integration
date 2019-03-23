#!/usr/bin/env bash
#
# This script generates list of user with mfa disabled and sends them to slack
#
# USAGE: ./aws-s3check.sh {slack-channel-id}
#

if [ $# -ne 1 ]; then
    echo $0: usage: aws-s3check.sh slack-channel-id
    exit 1
fi


FILTERED_BUCKETS=""
SLACK_CHANNEL=""

function main{

  echo "Getting buckets ...."
  get_buckets
  echo "Checking accessibility... "
  check_accessibility
  echo "Uploading response to slack channel"
  send_to_slack


  echo "COMPLETE!"
  exit 0
}

function check_accessibility_for_bucket {

}

function get_buckets {

}

function check_accessibility {

}

function send_to_slack {
slack chat send --text FILTERED_BUCKETS --channel '#'+$SLACK_CHANNEL
}


main
