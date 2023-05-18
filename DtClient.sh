#!/bin/bash

post_bom() {
    local apiUrl=""
    local apiKey=""
    local projectName=""
    local fileName=""

    while getopts "u:k:n:f:" opt; do
        case $opt in
            u)
                apiUrl=$OPTARG
                ;;
            k)
                apiKey=$OPTARG
                ;;
            n)
                projectName=$OPTARG
                ;;
            f)
                fileName=$OPTARG
                ;;
            *)
                ;;
        esac
    done
    shift $((OPTIND - 1))

    # Add your code here to handle the "PostBom" option
    echo "PostBom selected"
    echo "API URL: $apiUrl"
    echo "API Key: $apiKey"
    echo "Project Name: $projectName"
    echo "File Name: $fileName"
}

get_bom_token_status() {
    local apiUrl=""
    local apiKey=""
    local bomToken=""

    # Parse command-line options and arguments
    while getopts "u:k:t:" opt; do
        case $opt in
            u)
                apiUrl=$OPTARG
                ;;
            k)
                apiKey=$OPTARG
                ;;
            t)
                bomToken=$OPTARG
                ;;
            *)
                ;;
        esac
    done
    shift $((OPTIND - 1))

    # Add your code here to handle the "GetBomTokenStatus" option
    echo "GetBomTokenStatus selected"
    echo "API URL: $apiUrl"
    echo "API Key: $apiKey"
    echo "BOM Token: $bomToken"
}

get_project_metrics() {
    local apiUrl="$1"
    local apiKey="$2"
    local projectUuid="$3"

    # Add your code here to handle the "GetProjectMetrics" option
    echo "GetProjectMetrics selected"
    echo "API URL: $apiUrl"
    echo "API Key: $apiKey"
    echo "Project UUID: $projectUuid"
}

get_project() {
    local apiUrl="$1"
    local apiKey="$2"

    # Add your code here to handle the "GetProject" option
    echo "GetProject selected"
    echo "API URL: $apiUrl"
    echo "API Key: $apiKey"
}

get_project_lookup() {
    local apiUrl="$1"
    local apiKey="$2"
    local projectName="$3"

    # Add your code here to handle the "GetProjectLookup" option
    echo "GetProjectLookup selected"
    echo "API URL: $apiUrl"
    echo "API Key: $apiKey"
    echo "Project Name: $projectName"
}

source $(dirname $(realpath $0))/Menu.sh
