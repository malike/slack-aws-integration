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
USERS_COUNT=0
BIN_DIRECTORY="$( cd "$(dirname "$0")" ; pwd -P )"
USERS_MFA_FILE="${BIN_DIRECTORY}/MFA_ENABLED.txt"
USERS_NO_MFA_FILE="${BIN_DIRECTORY}/MFA_DISABLED.txt"

function main() {

  check_arguments
  get_users
  check_mfa  
  send_to_slack

  echo "COMPLETE!"
  exit 0
}

function check_arguments() {
  if [[ $ARGC -lt 1 ]]; then
    help
  fi

  SLACK_CHANNEL="${ARGV[0]}"
}

function help() {
  printf "\n\nUSAGE: aws-mfacheck.sh slack-channel-id \n\n"

  printf "\n\nEXAMPLE:\n"
  echo " aws-mfacheck.sh #devops-channel-id"

  printf "\n"
  exit 1
}

function get_users() {
  echo "Getting users ...."
  FILTERED_USERS=$(aws iam list-users)
  echo "Fetched $(echo $FILTERED_USERS | jq '.Users | length') users"
}

function check_mfa() {
  echo "Checking MFA for users"
  echo "">USERS_MFA_FILE
  echo "">USERS_NO_MFA_FILE
  for UNAME in $(echo "${FILTERED_USERS}" | jq -c '.Users[].UserName'); do
    AWS_USERAME=$(echo $UNAME | tr -d '"')
    MFA_DEVICE=$(aws iam list-mfa-devices --user-name $AWS_USERAME)
    MFA_DEVICE_COUNT=$(echo $MFA_DEVICE | jq '.MFADevices | length')
    if [[ $MFA_DEVICE_COUNT -lt 1 ]]; then
      echo "$AWS_USERAME">>USERS_NO_MFA_FILE
    else
      echo "$AWS_USERAME">>USERS_MFA_FILE
    fi
  done 
}

function send_to_slack() {
  echo "Sending list to Slack"
  printf "Fetch No MFA Users"
  echo "$(<USERS_NO_MFA_FILE)"  
  $(slack chat send --text $FILTERED_USERS --channel "#"$SLACK_CHANNEL)
}

main
