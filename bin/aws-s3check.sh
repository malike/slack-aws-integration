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
    send_to_slack

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
        BUCKET_NAME=$(echo $BUCKETS | tr -d '"')
        BUCKET_POLICY=$(aws s3api get-bucket-policy-status --bucket $BUCKET_NAME)
        BUCKET_POLICY_IS_PUBLIC=$(echo $BUCKET_POLICY | jq -c '.PolicyStatus.IsPublic')
        echo "Policy status for bucket $BUCKET_NAME is $BUCKET_POLICY_IS_PUBLIC"
        if [[ "$BUCKET_POLICY_IS_PUBLIC" = true ]]; then
            echo "$BUCKET_NAME" >>S3_PUBLIC
        else
            echo "$BUCKET_NAME" >>S3_PRIVATE
        fi
    done
}

function send_to_slack() {
    echo "Uploading response to slack channel"
}

main
