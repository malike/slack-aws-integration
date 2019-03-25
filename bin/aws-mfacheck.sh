#!/usr/bin/env bash
#
# This script generates list of user with mfa disabled and sends them to slack
#
# USAGE: ./aws-mfacheck.sh {slack-channel-id}
#
ARGC=$#
ARGV=($@)

SLACK_CHANNEL=""
FILTERED_USERS=""


function main{

  check_arguments
  echo "Getting users ...."
  get_users
  echo "Checking mfa status for users"
  check_mfa
  echo "Uploading response to slack channel"
  send_to_slack


  echo "COMPLETE!"
  exit 0
}


function check_arguments{
    if [[ $ARGC -ne 1 ]]; then
        help
    fi

    SLACK_CHANNEL="${ARGV[0]}"
}

function help {
    printf "\n\nUSAGE: aws-mfacheck.sh slack-channel-id \n\n"

    printf "\n\nEXAMPLE:\n"
    echo " aws-mfacheck.sh #devops-channel-id"

    printf "\n"
    exit 1
}

function check_mfa_for_user{

}

function get_users{

}

function check_mfa{

}

function send_to_slack {
$(slack chat send --text $FILTERED_USERS --channel "#"$SLACK_CHANNEL)
}


main