def print_help
    puts "Usage: #{$PROGRAM_NAME} <Command> [options]"
    puts "Commands:"
    puts "  PostBom                 Upload a supported bill of material format document"
    puts "  GetBomTokenStatus       Determines if there are any tasks associated with the token that are being processed"
    puts "  GetProjectMetrics       Returns current metrics for a specific project"
    puts "  GetProject              Returns a list of all projects"
    puts "  GetProjectLookup        Returns a specific project by its name and version"
    puts ""
    puts "Command Options:"
    puts "  Mandatory keys:"
    puts "      -u                  URL to connect to"
    puts "      -k                  API key to use"
    puts ""
    puts "  PostBom:"
    puts "      -n                  Name of the project"
    puts "      -f                  Name of the file to process"
    puts ""
    puts "  GetBomTokenStatus:"
    puts "      -t                  BOM token of the processing"
    puts ""
    puts "  GetProjectMetrics:"
    puts "      -d                  UUID of the project"
    puts ""
    puts "  GetProject:"
    puts "                          No keys required"
    puts ""
    puts "  GetProjectLookup:"
    puts "      -n                  Name of the project"
    puts ""
end
  
def post_bom_command(args)
  options = {}
  OptionParser.new do |opts|
    opts.on('-u URL', 'URL to connect to') { |url| options[:api_url] = url }
    opts.on('-k API_KEY', 'API key to use') { |api_key| options[:api_key] = api_key }
    opts.on('-n PROJECT_NAME', 'Name of the project') { |project_name| options[:project_name] = project_name }
    opts.on('-f FILE_NAME', 'Name of the file to process') { |file_name| options[:file_name] = file_name }
  end.parse!(args)

  post_bom(options[:api_url], options[:api_key], options[:project_name], options[:file_name])
end

def get_bom_token_status_command(args)
  options = {}
  OptionParser.new do |opts|
    opts.on('-u URL', 'URL to connect to') { |url| options[:api_url] = url }
    opts.on('-k API_KEY', 'API key to use') { |api_key| options[:api_key] = api_key }
    opts.on('-t BOM_TOKEN', 'BOM token of the processing') { |bom_token| options[:bom_token] = bom_token }
  end.parse!(args)

  get_bom_token_status(options[:api_url], options[:api_key], options[:bom_token])
end

def get_project_metrics_command(args)
  options = {}
  OptionParser.new do |opts|
    opts.on('-u URL', 'URL to connect to') { |url| options[:api_url] = url }
    opts.on('-k API_KEY', 'API key to use') { |api_key| options[:api_key] = api_key }
    opts.on('-d PROJECT_UUID', 'UUID of the project') { |project_uuid| options[:project_uuid] = project_uuid }
  end.parse!(args)

  get_project_metrics(options[:api_url], options[:api_key], options[:project_uuid])
end

def get_project_command(args)
  options = {}
  OptionParser.new do |opts|
    opts.on('-u URL', 'URL to connect to') { |url| options[:api_url] = url }
    opts.on('-k API_KEY', 'API key to use') { |api_key| options[:api_key] = api_key }
  end.parse!(args)

  get_project(options[:api_url], options[:api_key])
end
  
def get_project_lookup_command(args)
  options = {}
  OptionParser.new do |opts|
    opts.on('-u URL', 'URL to connect to') { |url| options[:api_url] = url }
    opts.on('-k API_KEY', 'API key to use') { |api_key| options[:api_key] = api_key }
    opts.on('-n PROJECT_NAME', 'Name of the project') { |project_name| options[:project_name] = project_name }
  end.parse!(args)

  get_project_lookup(options[:api_url], options[:api_key], options[:project_name])
end

def main
    command = ARGV.shift
  
    case command
    when 'PostBom'
      post_bom_command(ARGV)
    when 'GetBomTokenStatus'
      get_bom_token_status_command(ARGV)
    when 'GetProjectMetrics'
      get_project_metrics_command(ARGV)
    when 'GetProject'
      get_project_command(ARGV)
    when 'GetProjectLookup'
      get_project_lookup_command(ARGV)
    else
      puts "Invalid option: #{command}"
      print_help
      exit 1
    end
end