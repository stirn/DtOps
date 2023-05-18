#!/bin/bash

# Define a function to upload the BOM file and retrieve the processing token
post_bom() {
  local uri="$1/api/v1/bom"
  local api_key="$2"
  local project_name="$3"
  local file_name="$4"
  local curl_params=(
    -s
    -X
    'POST'
    "$uri"
    -H "X-Api-Key: $api_key"
    -H "Content-Type:multipart/form-data"
    -F projectName=$project_name
    -F autoCreate=true
    -F bom=@$file_name
  )
  local response=$(curl "${curl_params[@]}")
  echo "$response"
}

# Define a function to poll for the processing status of the BOM file
get_bom_token_status() {
  local uri="$1/api/v1/bom/token/$token"
  local api_key="$2"
  local token="$3"
  declare -i poll_counter=0
  local curl_params=(
    -s
    -X
    'GET'
    "$uri"
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

# Define a function to retrieve the project metrics
get_project_metrics() {
  local uri="$1/api/v1/metrics/project/$project_uuid/current"
  local api_key="$2"
  local project_uuid="$3"
  local curl_params=(
    -s
    -X
    'GET'
    "$uri"
    -H "X-Api-Key: $api_key"
    -H "accept: application/json"
  )
  local response=$(curl "${curl_params[@]}")
  echo "$response"
}

get_project() {
  local uri="$1/api/v1/project"
  local api_key="$2"
  local curl_params=(
    -s
    -X
    'GET'
    "$uri"
    -H "X-Api-Key: $api_key"
    -H "accept: application/json"
  )
  local response=$(curl "${curl_params[@]}")
  echo "$response"
}

get_project_lookup() {
  echo $1
  echo $2
  echo $3


  local api_key="$2"
  local project_name="$3"
  local uri="$1/api/v1/project/lookup?name=$project_name"
  local curl_params=(
    -s
    -X
    'GET'
    "$uri"
    -H "X-Api-Key: $api_key"
    -H "accept: application/json"
  )
  local response=$(curl "${curl_params[@]}")
  echo "$response"
}
