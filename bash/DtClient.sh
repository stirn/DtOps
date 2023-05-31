#!/bin/bash

source $(dirname $(realpath $0))/DtApi.sh

PostBom() {
    while getopts "u:k:n:f:" opt; do
        case $opt in
            u)
                local apiUrl="https://"${OPTARG}
                ;;
            k)
                local apiKey=$OPTARG
                ;;
            n)
                local projectName=$OPTARG
                ;;
            f)
                local fileName=$OPTARG
                ;;
            *)
                ;;
        esac
    done
    shift $((OPTIND - 1))
    local response=$(post_bom $apiUrl $apiKey $projectName $fileName)
    local response_body=$(echo $response | awk -F":curl_output:" '{print $1}')
    local curl_output=$(echo $response | awk -F":curl_output:" '{print $2}')
    if [[ -n $response_body ]]; then
        echo $response_body | jq '.'
    else
        echo "--- Error: $curl_output" >&2
        exit 1
    fi
}

GetBomTokenStatus() {
    while getopts "u:k:t:" opt; do
        case $opt in
            u)
                local apiUrl="https://"${OPTARG}
                ;;
            k)
                local apiKey=$OPTARG
                ;;
            t)
                local bomToken=$OPTARG
                ;;
            *)
                ;;
        esac
    done
    shift $((OPTIND - 1))
    get_bom_token_status $apiUrl $apiKey $bomToken
}

GetProjectMetrics() {
    while getopts "u:k:d:" opt; do
        case $opt in
            u)
                local apiUrl="https://"${OPTARG}
                ;;
            k)
                local apiKey=$OPTARG
                ;;
            d)
                local projectUuid=$OPTARG
                ;;
            *)
                ;;
        esac
    done
    shift $((OPTIND - 1))
    local response=$(get_project_metrics $apiUrl $apiKey $projectUuid)
    local response_body=$(echo $response | awk -F":curl_output:" '{print $1}')
    local curl_output=$(echo $response | awk -F":curl_output:" '{print $2}')
    if [[ -n $response_body ]]; then
        echo $response_body | jq '.'
    else
        echo "--- Error: $curl_output" >&2
        exit 1
    fi
}

GetProject() {
    while getopts "u:k:" opt; do
        case $opt in
            u)
                local apiUrl="https://"${OPTARG}
                ;;
            k)
                local apiKey=$OPTARG
                ;;
            *)
                ;;
        esac
    done
    shift $((OPTIND - 1))
    local response=$(get_project $apiUrl $apiKey)
    local response_body=$(echo $response | awk -F":curl_output:" '{print $1}')
    local curl_output=$(echo $response | awk -F":curl_output:" '{print $2}')
    if [[ -n $response_body ]]; then
        echo $response_body | jq '.'
    else
        echo "--- Error: $curl_output" >&2
        exit 1
    fi
}

GetProjectLookup() {
    while getopts "u:k:n:" opt; do
        case $opt in
            u)
                local apiUrl="https://"${OPTARG}
                ;;
            k)
                local apiKey=$OPTARG
                ;;
            n)
                local projectName=$OPTARG
                ;;
            *)
                ;;
        esac
    done
    shift $((OPTIND - 1))
    local response=$(get_project_lookup $apiUrl $apiKey $projectName)
    local response_body=$(echo $response | awk -F":curl_output:" '{print $1}')
    local curl_output=$(echo $response | awk -F":curl_output:" '{print $2}')
    if [[ -n $response_body ]]; then
        echo $response_body | jq '.'
    else
        echo "--- Error: $curl_output" >&2
        exit 1
    fi
}

source $(dirname $(realpath $0))/Menu.sh
