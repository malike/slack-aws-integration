#!/usr/bin/env bash
#
# This script generates list of user with mfa disabled and sends them to slack
#
# USAGE: ./aws-mfacheck.sh {slack-channel-id}
#
ARGC=$#
ARGV=($@)

ACTION=""
AWS_LOAD_BALANCER=""
DESIRED_COUNT=1

function main() {

    check_arguments
    # scale
    # send_to_slack
    echo "COMPLETE!"
    exit 0
}

function check_arguments() {
    if [[ $ARGC -lt 2 ]]; then
        help
    fi

    ACTION="${ARGV[0]}"
    AWS_LOAD_BALANCER="${ARGV[1]}"
    DESIRED_COUNT="${ARGV[2]}"
}

function help() {
    printf "\n\nUSAGE: aws-lb-scale.sh down cluster-name desired-count \n\n"

    printf "\n\nEXAMPLE:\n"
    echo " aws-lb-scale.sh up staging-one 4\n"
    echo " aws-lb-scale.sh down staging-one 1"

    printf "\n"
    exit 1
}

function scale() {
    if [ "$ACTION" -eq "up" ]; then
        # aws autoscaling set-desired-capacity --auto-scaling-group-name ${AWS_LOAD_BALANCER} --desired-capacity ${DESIRED_COUNT} --honor-cooldown
    elif [ "$ACTION" -eq "down" ]; then
    # aws autoscaling set-desired-capacity --auto-scaling-group-name ${AWS_LOAD_BALANCER} --desired-capacity ${DESIRED_COUNT} --honor-cooldown
    else
        echo "Unknown parameter"
    fi
}

function send_to_slack() {
    # $(slack chat send --text $FILTERED_USERS --channel "#"$SLACK_CHANNEL)
}

main
