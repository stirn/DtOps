namespace Selfmade.Security.DependencyTrack;

using Newtonsoft.Json.Linq;
using CommandLine;
using static Selfmade.Security.DependencyTrack.Menu;

class Program
{
    static void HandleParseError(IEnumerable<Error> errs)
    {
        // Handle parse errors here
        // For example, display an error message and exit the application
    }

    static void Main(string[] args)
    {
        Parser.Default.ParseArguments<
            PostBomOptions,
            GetBomTokenStatusOptions,
            GetProjectMetricsOptions,
            GetProjectOptions,
            GetProjectLookupOptions,
            JParseOptions>(args)
           .WithParsed<PostBomOptions>(opts => PostBom(opts))
           .WithParsed<GetBomTokenStatusOptions>(opts => GetBomTokenStatus(opts))
           .WithParsed<GetProjectMetricsOptions>(opts => GetProjectMetrics(opts))
           .WithParsed<GetProjectOptions>(opts => GetProject(opts))
           .WithParsed<GetProjectLookupOptions>(opts => GetProjectLookup(opts))
           .WithParsed<JParseOptions>(opts => JParse(opts))
           .WithNotParsed(errs => HandleParseError(errs));
    }

    static JObject PostBom(PostBomOptions opts)
    {
        Api Api = new Api($"https://{opts.apiUrl}", opts.apiKey);
        JObject token = Api.PostBom(opts.projectName, opts.fileName);
        Console.WriteLine(token);
        return token;
    }

    static void GetBomTokenStatus(GetBomTokenStatusOptions opts)
    {
        Api Api = new Api($"https://{opts.apiUrl}", opts.apiKey);
        Api.GetBomTokenStatus(opts.bomToken);
    }

    static JObject GetProjectMetrics(GetProjectMetricsOptions opts)
    {
        Api Api = new Api($"https://{opts.apiUrl}", opts.apiKey);
        JObject projectMetrics = Api.GetProjectMetrics(opts.projectUuid);
        Console.WriteLine(projectMetrics);
        return projectMetrics;
    }

    static JArray GetProject(GetProjectOptions opts)
    {
        Api Api = new Api($"https://{opts.apiUrl}", opts.apiKey);
        JArray projectList = Api.GetProject();
        Console.WriteLine(projectList);
        return projectList;
    }

    static JObject GetProjectLookup(GetProjectLookupOptions opts)
    {
        Api Api = new Api($"https://{opts.apiUrl}", opts.apiKey);
        JObject project = Api.GetProjectLookup(opts.projectName);
        Console.WriteLine(project);
        return project;
    }

    static string JParse(JParseOptions opts)
    {
        JObject json = JObject.Parse(Console.In.ReadToEnd());
        string value = json.Value<string>(opts.jKey);
        Console.WriteLine(value);
        return value;
    }
}