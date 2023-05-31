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
        try
        {
            Api Api = new Api($"https://{opts.apiUrl}", opts.apiKey);
            JObject token = Api.PostBom(opts.projectName, opts.fileName);
            Console.WriteLine(token);
            return token;
        }
        catch (HttpRequestException ex)
        {
            Console.WriteLine("--- HTTP request error occurred: " + ex.Message);
            return null;
        }
        catch (Exception ex)
        {
            // Handle non-HTTP errors
            Console.WriteLine("--- Something went wrong: " + ex.Message + "\n--- Please check command options");
            return null;
        }
    }

    static void GetBomTokenStatus(GetBomTokenStatusOptions opts)
    {
        try
        {
            Api Api = new Api($"https://{opts.apiUrl}", opts.apiKey);
            Api.GetBomTokenStatus(opts.bomToken);
        }
        catch (HttpRequestException ex)
        {
            Console.WriteLine("--- HTTP request error occurred: " + ex.Message);
        }
        catch (Exception ex)
        {
            // Handle non-HTTP errors
            Console.WriteLine("--- Something went wrong: " + ex.Message + "\n--- Please check command options");
        }
    }

    static JObject GetProjectMetrics(GetProjectMetricsOptions opts)
    {
        try
        {
            Api Api = new Api($"https://{opts.apiUrl}", opts.apiKey);
            JObject projectMetrics = Api.GetProjectMetrics(opts.projectUuid);
            Console.WriteLine(projectMetrics);
            return projectMetrics;
        }
        catch (HttpRequestException ex)
        {
            Console.WriteLine("--- HTTP request error occurred: " + ex.Message);
            return null;
        }
        catch (Exception ex)
        {
            // Handle non-HTTP errors
            Console.WriteLine("--- Something went wrong: " + ex.Message + "\n--- Please check command options");
            return null;
        }
    }

    static JArray GetProject(GetProjectOptions opts)
    {
        try
        {
            Api Api = new Api($"https://{opts.apiUrl}", opts.apiKey);
            JArray projectList = Api.GetProject();
            Console.WriteLine(projectList);
            return projectList;
        }
        catch (HttpRequestException ex)
        {
            Console.WriteLine("--- HTTP request error occurred: " + ex.Message);
            return null;
        }
        catch (Exception ex)
        {
            // Handle non-HTTP errors
            Console.WriteLine("--- Something went wrong: " + ex.Message + "\n--- Please check command options");
            return null;
        }
    }

    static JObject GetProjectLookup(GetProjectLookupOptions opts)
    {
        try
        {
            Api Api = new Api($"https://{opts.apiUrl}", opts.apiKey);
            JObject project = Api.GetProjectLookup(opts.projectName);
            Console.WriteLine(project);
            return project;
        }
        catch (HttpRequestException ex)
        {
            Console.WriteLine("--- HTTP request error occurred: " + ex.Message);
            return null;
        }
        catch (Exception ex)
        {
            // Handle non-HTTP errors
            Console.WriteLine("--- Something went wrong: " + ex.Message + "\n--- Please check command options");
            return null;
        }
    }

    static string JParse(JParseOptions opts)
    {
        JObject json = JObject.Parse(Console.In.ReadToEnd());
        string value = json.Value<string>(opts.jKey);
        Console.WriteLine(value);
        return value;
    }
}