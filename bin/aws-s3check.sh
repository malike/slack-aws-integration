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
USERS_COUNT=0
BIN_DIRECTORY="$(
    cd "$(dirname "$0")"
    pwd -P
)"
S3_PUBLIC="${BIN_DIRECTORY}/S3_PUBLIC.txt"
S3_PRIVATE="${BIN_DIRECTORY}/S3_PRIVATE.txt"

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
    get_buckets
    check_accessibility
    # send_to_slack

    echo "COMPLETE!"
    exit 0
}

function check_accessibility_for_bucket() {
    echo "Checking accessibility... "
}

function get_buckets() {
    echo "Getting buckets ...."
    FILTERED_BUCKETS=$(aws s3api list-buckets)
    echo "Fetched $(echo $FILTERED_BUCKETS | jq '.Buckets | length') buckets"
}

function check_accessibility() {
    echo "Checking accessibility... "
    echo "" >S3_PRIVATE
    echo "" >S3_PUBLIC
    for BUCKETS in $(echo "${FILTERED_BUCKETS}" | jq -c '.Buckets[].Name'); do
        BUCKET_PERMISSION=$(aws s3api get-bucket-acl --bucket $BUCKETS)
        # echo "MFA for $AWS_USERAME is $MFA_DEVICE_COUNT"
        if [[ $MFA_DEVICE_COUNT -lt 1 ]]; then
            echo "$AWS_USERAME" >>USERS_NO_MFA_FILE
        else
            echo "$AWS_USERAME" >>USERS_MFA_FILE
        fi
    done
}

function send_to_slack() {
    echo "Uploading response to slack channel"
    # $(slack chat send --text $FILTERED_BUCKETS --channel "#"$SLACK_CHANNEL)
}

main
