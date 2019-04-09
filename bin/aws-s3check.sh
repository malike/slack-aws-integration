#!/usr/bin/env bash
#
# This script generates list of user with mfa disabled and sends them to slack
#
# USAGE: ./aws-s3check.sh {slack-channel-id}
#
ARGC=$#
ARGV=($@)

SLACK_CHANNEL=""
FILTERED_BUCKETS=""

function check_arguments() {
    if [[ $ARGC -ne 1 ]]; then
        help
    fi

    SLACK_CHANNEL="${ARGV[0]}"
}

function help() {
    printf "\n\nUSAGE: aws-s3check.sh slack-channel-id \n\n"

    printf "\n\nEXAMPLE:\n"
    echo " aws-s3check.sh #devops-channel-id"

    printf "\n"
    exit 1
}

function main() {

    check_arguments
    echo "Getting buckets ...."
    get_buckets
    echo "Checking accessibility... "
    check_accessibility
    echo "Uploading response to slack channel"
    send_to_slack

    echo "COMPLETE!"
    exit 0
}

function check_accessibility_for_bucket() {

}

function get_buckets() {

}

function check_accessibility() {

}

function send_to_slack() {
    $(slack chat send --text $FILTERED_BUCKETS --channel "#"$SLACK_CHANNEL)
}

main
