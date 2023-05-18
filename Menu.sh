#!/bin/bash

source $(dirname $(realpath $0))/DtClient.sh

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
    
    *)
        echo "Invalid option: $1"
        print_help
        exit 1
        ;;
esac

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
