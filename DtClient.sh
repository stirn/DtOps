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

    post_bom $apiUrl $apiKey $projectName $fileName | jq '.'
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

    get_bom_token_status $apiUrl $apiKey $bomToken | jq '.'
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

    get_project_metrics $apiUrl $apiKey $projectUuid | jq '.'
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

    get_project $api_url $api_key | jq '.'
}

GetProjectLookup() {
    local apiUrl=""
    local apiKey=""
    local projectName=""

    while getopts "u:k:n:" opt; do
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

    get_project_lookup $api_url $api_key $projectName | jq '.'
}

source $(dirname $(realpath $0))/Menu.sh
