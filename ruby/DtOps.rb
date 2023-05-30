require 'optparse'
require 'net/http'
require 'json'
require_relative 'Menu.rb'

def post_bom(api_url, api_key, project_name, file_name)
  uri = URI("https://#{api_url}/api/v1/bom")
  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true
  http.verify_mode = OpenSSL::SSL::VERIFY_PEER
  request = Net::HTTP::Post.new(uri.path)
  request['X-Api-Key'] = api_key
  request.set_form([
    ['projectName', project_name],
    ['autoCreate', 'true'],
    ['bom', File.open(file_name)]
  ], 'multipart/form-data')
  response = http.request(request)
  puts JSON.pretty_generate(JSON.parse(response.body))
end

def get_bom_token_status(api_url, api_key, bom_token)
  uri = URI("https://#{api_url}/api/v1/bom/token/#{bom_token}")
  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true
  http.verify_mode = OpenSSL::SSL::VERIFY_PEER
  request = Net::HTTP::Get.new(uri.path)
  request['X-Api-Key'] = api_key

  loop do
    response = http.request(request)
    processing = JSON.parse(response.body)['processing']
    break unless processing

    sleep 1
  end
end

def get_project_metrics(api_url, api_key, project_uuid)
  uri = URI("https://#{api_url}/api/v1/metrics/project/#{project_uuid}/current")
  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true
  http.verify_mode = OpenSSL::SSL::VERIFY_PEER
  request = Net::HTTP::Get.new(uri.path)
  request['X-Api-Key'] = api_key
  response = http.request(request)
  puts JSON.pretty_generate(JSON.parse(response.body))
end

def get_project(api_url, api_key)
  uri = URI("https://#{api_url}/api/v1/project")
  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true
  http.verify_mode = OpenSSL::SSL::VERIFY_PEER
  request = Net::HTTP::Get.new(uri.path)
  request['X-Api-Key'] = api_key
  response = http.request(request)
  puts JSON.pretty_generate(JSON.parse(response.body))
end

def get_project_lookup(api_url, api_key, project_name)
  uri = URI("https://#{api_url}/api/v1/project/lookup?name=#{project_name}")
  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true
  http.verify_mode = OpenSSL::SSL::VERIFY_PEER
  request = Net::HTTP::Get.new(uri.path)
  request['X-Api-Key'] = api_key
  response = http.request(request)
  puts JSON.pretty_generate(JSON.parse(response.body))
end

main()
