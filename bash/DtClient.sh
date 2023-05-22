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
    post_bom $apiUrl $apiKey $projectName $fileName | jq '.'
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
    get_project_metrics $apiUrl $apiKey $projectUuid | jq '.'
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
    get_project $apiUrl $apiKey | jq '.'
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
    get_project_lookup $apiUrl $apiKey $projectName | jq '.'
}

source $(dirname $(realpath $0))/Menu.sh
