#!/bin/bash

PrintHelp() {
    echo "Usage: $0 <Command> [options]"
    echo "Commands:"
    echo "  PostBom               Upload a supported bill of material format document"
    echo "  GetBomTokenStatus     Determines if there are any tasks associated with the token that are being processed"
    echo ""
    echo "Command Descriptions:"
    echo "  PostBom:              This command allows you to upload a supported bill of material format document."
    echo "                        Required options: -u/--url, -k/--apiKey, -n/--projectName, -f/--fileName"
    echo ""
    echo "  GetBomTokenStatus:    This command determines if there are any tasks associated with the token"
    echo "                        that are being processed."
    echo "                        Required options: -u/--url, -k/--apiKey, -t/--bomToken"
    echo ""
    # ...to be continued
}

case $1 in
    PostBom)
        shift
        PostBom "$@"
        ;;
    GetBomTokenStatus)
        shift
        GetBomTokenStatus "$@"
        ;;
    GetProjectMetrics)
        shift
        GetProjectMetrics "$@"
        ;;
    GetProject)
        shift
        GetProject "$@"
        ;;
    GetProjectLookup)
        shift
        GetProjectLookup "$@"
        ;;
    *)
        echo "Invalid option: $1"
        PrintHelp
        exit 1
        ;;
esac
