#!/usr/bin/env bash
#
# This script generates list of user with mfa disabled and sends them to slack
#
# USAGE: ./aws-mfacheck.sh {slack-channel-id}
#

if [ $# -ne 1 ]; then
    echo $0: usage: aws-mfacheck.sh slack-channel-id
    exit 1
fi


FILTERED_USERS=""
SLACK_CHANNEL=""

function main{

  echo "Getting users ...."
  get_users
  echo "Checking mfa status for users"
  check_mfa
  echo "Uploading response to slack channel"
  send_to_slack


  echo "COMPLETE!"
  exit 0
}

function check_mfa_for_user {

}

function get_users {

}

function check_mfa {

}

function send_to_slack {
slack chat send --text $FILTERED_USERS --channel '#'+$SLACK_CHANNEL
}


main