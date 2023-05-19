#!/bin/bash

PrintHelp() {
    echo "Usage: $0 <Command> [options]"
    echo "Commands:"
    echo "  PostBom                 Upload a supported bill of material format document"
    echo "  GetBomTokenStatus       Determines if there are any tasks associated with the token that are being processed"
    echo "  GetProjectMetrics       Returns current metrics for a specific project"
    echo "  GetProject              Returns a list of all projects"
    echo "  GetProjectLookup        Returns a specific project by its name and version"
    echo ""
    echo "Command Options:"
    echo "  Mandatory keys:"
    echo "      -u                  URL to connect to"
    echo "      -k                  API key to use"
    echo ""
    echo "  PostBom:"
    echo "      -n                  Name of the project"
    echo "      -f                  Name of the file to process"
    echo ""
    echo "  GetBomTokenStatus:"
    echo "      -b                  BOM token of the processing"
    echo ""
    echo "  GetProjectMetrics:"
    echo "      -d                  UUID of the project"
    echo ""
    echo "  GetProject:"
    echo "                          No keys required"
    echo ""
    echo "  GetProjectLookup:"
    echo "      -n                  Name of the project"
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
