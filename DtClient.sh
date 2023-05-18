#!/bin/bash

#source $(dirname $(realpath $0))/Menu.sh

print_help() {
    echo "Usage: $0 <Command> [options]"
    echo "Commands:"
    echo "  PostBom               Upload a supported bill of material format document"
    echo "  GetBomTokenStatus     Determines if there are any tasks associated with the token that are being processed"
    echo ""
    # Add descriptions for each command
    echo "Command Descriptions:"
    echo "  PostBom:              This command allows you to upload a supported bill of material format document."
    echo "                        Required options: -u/--url, -k/--apiKey, -n/--projectName, -f/--fileName"
    echo ""
    echo "  GetBomTokenStatus:    This command determines if there are any tasks associated with the token"
    echo "                        that are being processed."
    echo "                        Required options: -u/--url, -k/--apiKey, -t/--bomToken"
    echo ""
    # Add descriptions for other commands...
}

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

jparse() {
    local jKey="$1"

    # Add your code here to handle the "JParse" option
    echo "JParse selected"
    echo "Key: $jKey"
}

# Parse the command-line arguments and call the appropriate function

case $1 in
    PostBom)
        shift
        post_bom "$@"
        ;;
    GetBomTokenStatus)
        shift
        get_bom_token_status "$@"
        ;;
    GetProjectMetrics)
        shift
        get_project_metrics "$@"
        ;;
    GetProject)
        shift
        get_project "$@"
        ;;
    GetProjectLookup)
        shift
        get_project_lookup "$@"
        ;;
    JParse)
        shift
        jparse "$@"
        ;;
    *)
        echo "Invalid option: $1"
        exit 1
        ;;
esac

