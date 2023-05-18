#!/bin/bash

source $(dirname $(realpath $0))/DtApi.sh

PostBom() {
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

    echo "PostBom selected"
    echo "API URL: $apiUrl"
    echo "API Key: $apiKey"
    echo "Project Name: $projectName"
    echo "File Name: $fileName"
}

GetBomTokenStatus() {
    local apiUrl=""
    local apiKey=""
    local bomToken=""

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

    echo "GetBomTokenStatus selected"
    echo "API URL: $apiUrl"
    echo "API Key: $apiKey"
    echo "BOM Token: $bomToken"
}

GetProjectMetrics() {
    local apiUrl=""
    local apiKey=""
    local projectUuid=""

    while getopts "u:k:t:" opt; do
        case $opt in
            u)
                apiUrl=$OPTARG
                ;;
            k)
                apiKey=$OPTARG
                ;;
            d)
                projectUuid=$OPTARG
                ;;
            *)
                ;;
        esac
    done
    shift $((OPTIND - 1))

    echo "GetProjectMetrics selected"
    echo "API URL: $apiUrl"
    echo "API Key: $apiKey"
    echo "Project UUID: $projectUuid"
}

GetProject() {
    local api_url="https://"
    local api_key=""

    while getopts "u:k:t:" opt; do
        case $opt in
            u)
                api_url=${api_url}${OPTARG}
                ;;
            k)
                api_key=$OPTARG
                ;;
            *)
                ;;
        esac
    done
    shift $((OPTIND - 1))

    get_project $api_url $api_key
}

GetProjectLookup() {
    local apiUrl=""
    local apiKey=""
    local projectName=""

    while getopts "u:k:t:" opt; do
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
            *)
                ;;
        esac
    done
    shift $((OPTIND - 1))

    echo "GetProjectLookup selected"
    echo "API URL: $apiUrl"
    echo "API Key: $apiKey"
    echo "Project Name: $projectName"
}

source $(dirname $(realpath $0))/Menu.sh
