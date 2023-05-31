#!/bin/bash

#- BOM SECTION
#--- Upload a supported bill of material format document
post_bom() {
  local uri="$1/api/v1/bom"
  local api_key="$2"
  local project_name="$3"
  local file_name="$4"
  local curl_params=(
    -s
    -w ":curl_output:http_code=%{http_code}"
    -X 'POST' "$uri"
    -H "X-Api-Key: $api_key"
    -H "Content-Type:multipart/form-data"
    -F projectName=$project_name
    -F autoCreate=true
    -F bom=@$file_name
  )
  local response=$(curl "${curl_params[@]}")
  echo "$response"
}

#--- Determines if there are any tasks associated with the token that are being processed
get_bom_token_status() {
  local api_key="$2"
  local token="$3"
  local uri="$1/api/v1/bom/token/$token"
  declare -i poll_counter=0
  local curl_params=(
    -s
    -X 'GET' "$uri"
    -H "X-Api-Key: $api_key"
    -H "accept: application/json"
  )
  while true; do
    [[ "$poll_counter" -gt 300 ]] && echo "--- Something went wrong - dtrack could not finish processing in 5 minutes" && exit 1
    local response=$(curl "${curl_params[@]}")
    local processing=$(echo "$response" | jq -r '.processing')
    [[ "$processing" == "false" ]] && break || sleep 1 && poll_counter=${poll_counter}+1
  done
}

#- METRICS SECTION
#--- Returns current metrics for a specific project
get_project_metrics() {
  local api_key="$2"
  local project_uuid="$3"
  local uri="$1/api/v1/metrics/project/$project_uuid/current"
  local curl_params=(
    -s
    -w ":curl_output:http_code=%{http_code}"
    -X 'GET' "$uri"
    -H "X-Api-Key: $api_key"
    -H "accept: application/json"
  )
  local response=$(curl "${curl_params[@]}")
  echo "$response"
}

#- PROJECT SECTION
#--- Returns a list of all projects
get_project() {
  local uri="$1/api/v1/project"
  local api_key="$2"
  local curl_params=(
    -s
    -w ":curl_output:http_code=%{http_code}"
    -X 'GET' "$uri"
    -H "X-Api-Key: $api_key"
    -H "accept: application/json"
  )
  local response=$(curl "${curl_params[@]}")
  echo "$response"
}

#--- Returns a specific project by its name and version
get_project_lookup() {
  local api_key="$2"
  local project_name="$3"
  local uri="$1/api/v1/project/lookup?name=$project_name"
  local curl_params=(
    -s
    -w ":curl_output:http_code=%{http_code}"
    -X 'GET' "$uri"
    -H "X-Api-Key: $api_key"
    -H "accept: application/json"
  )
  local response=$(curl "${curl_params[@]}")
  echo "$response"
}
