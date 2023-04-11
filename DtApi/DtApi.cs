namespace Selfmade.Security.DependencyTrack;

using Newtonsoft.Json.Linq;
using System.Net.Http.Headers;
using Selfmade.Utilities.Network;

public class Default
{
    protected HttpClientSync apiClient;
    protected string apiUrl;

    public Default(string apiUrl, string apiKey)
    {
        this.apiUrl = apiUrl;
        apiClient = new HttpClientSync();
        apiClient.AddHeaders("X-Api-Key", apiKey);
    }
}

public class Api : Default
{
    public Api(string apiUrl, string apiKey) : base(apiUrl, apiKey) { }

    //----- BOM SECTION
    //--- Upload a supported bill of material format document
    public JObject PostBom(string projectName, string fileName)
    {
        string url = $"{apiUrl}/api/v1/bom/";

        FileStream fileStream = File.OpenRead(fileName);
        StreamContent fileContent = new StreamContent(fileStream);
        fileContent.Headers.ContentType = new MediaTypeHeaderValue("application/json");

        MultipartFormDataContent httpContent = new MultipartFormDataContent();
        httpContent.Add(new StringContent(projectName), "projectName");
        httpContent.Add(new StringContent("true"), "autoCreate");
        httpContent.Add(fileContent, "bom");

        string responseBody = apiClient.Post(url, httpContent);
        return JObject.Parse(responseBody);
    }

    //--- Determines if there are any tasks associated with the token that are being processed
    public void GetBomTokenStatus(string processingToken)
    {
        var url = $"{apiUrl}/api/v1/bom/token/{processingToken}";
        var pollCounter = 0;
        while (true)
        {
            if (pollCounter > 300)
            {
                throw new Exception("Something went wrong - dtrack could not finish processing in 5 minutes");
            }
            string responseBody = apiClient.Get(url);
            var jsonObject = JObject.Parse(responseBody);
            if (!jsonObject.Value<bool>("processing"))
            {
                break;
            }
            Task.Delay(1000);
            pollCounter++;
        }
    }

    //--- METRICS SECTION
    //--- Returns current metrics for a specific project
    public JObject GetProjectMetrics(string projectUuid)
    {
        string url = $"{apiUrl}/api/v1/metrics/project/{projectUuid}/current";
        string responseBody = apiClient.Get(url);
        return JObject.Parse(responseBody);
    }

    //----- PROJECT SECTION
    //--- Returns a list of all projects
    public JArray GetProject()
    {
        string url = $"{apiUrl}/api/v1/project/";
        string responseBody = apiClient.Get(url);
        return JArray.Parse(responseBody);
    }

    //--- Returns a specific project by its name and version
    public JObject GetProjectLookup(string projectName)
    {
        string url = $"{apiUrl}/api/v1/project/lookup?name={Uri.EscapeDataString(projectName)}";
        string responseBody = apiClient.Get(url);
        return JObject.Parse(responseBody);
    }
}
