namespace Selfmade.Security.DependencyTrack;

using CommandLine;

public class BaseOptions
{
    [Option('u', "url", Required = true, HelpText = "URL to connect to")]
    public string? apiUrl { get; set; }

    [Option('k', "apiKey", Required = true, HelpText = "API key to use")]
    public string? apiKey { get; set; }
}

public class Menu
{
    [Verb("PostBom", HelpText = "Upload a supported bill of material format document")]
    public class PostBomOptions : BaseOptions
    {
        [Option('n', "projectName", Required = false, HelpText = "Name of the project")]
        public string? projectName { get; set; }

        [Option('f', "fileName", Required = false, HelpText = "Name of the file to process")]
        public string? fileName { get; set; }
    }

    [Verb("GetBomTokenStatus", HelpText = "Determines if there are any tasks associated with the token that are being processed")]
    public class GetBomTokenStatusOptions : BaseOptions
    {
        [Option('t', "bomToken", Required = true, HelpText = "BOM token of the processing")]
        public string? bomToken { get; set; }
    }

    [Verb("GetProjectMetrics", HelpText = "Returns current metrics for a specific project")]
    public class GetProjectMetricsOptions : BaseOptions
    {
        [Option('d', "projectUuid", Required = true, HelpText = "UUID of the project")]
        public string? projectUuid { get; set; }
    }

    [Verb("GetProject", HelpText = "Returns a list of all projects")]
    public class GetProjectOptions : BaseOptions
    {
    }

    [Verb("GetProjectLookup", HelpText = "Returns a specific project by its name and version")]
    public class GetProjectLookupOptions : BaseOptions
    {
        [Option('n', "projectName", Required = true, HelpText = "Name of the project")]
        public string? projectName { get; set; }
    }

    [Verb("JParse", HelpText = "Returns a value by key from json")]
    public class JParseOptions
    {
        [Option('j', "jKey", Required = true, HelpText = "Key")]
        public string? jKey { get; set; }
    }
}

