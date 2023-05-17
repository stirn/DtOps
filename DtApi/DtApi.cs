namespace Selfmade.Security.DependencyTrack;

using Newtonsoft.Json.Linq;
using System.Net.Http.Headers;

public class Api
{
    protected HttpClient apiClient;
    protected string apiUrl;
    protected HttpRequestMessage request;

    public Api(string apiUrl, string apiKey)
    {
        this.apiUrl = apiUrl;
        apiClient = new HttpClient();
        apiClient.DefaultRequestHeaders.Add("X-Api-Key", apiKey);
        request = new HttpRequestMessage();
    }

    //----- BOM SECTION
    //--- Upload a supported bill of material format document
    public JObject PostBom(string projectName, string fileName)
    {
        FileStream fileStream = File.OpenRead(fileName);
        StreamContent fileContent = new StreamContent(fileStream);
        fileContent.Headers.ContentType = new MediaTypeHeaderValue("application/json");

        MultipartFormDataContent httpContent = new MultipartFormDataContent();
        httpContent.Add(new StringContent(projectName), "projectName");
        httpContent.Add(new StringContent("true"), "autoCreate");
        httpContent.Add(fileContent, "bom");

        request.Method = HttpMethod.Post;
        request.RequestUri = new Uri($"{apiUrl}/api/v1/bom/");
        request.Content = httpContent;

        string responseBody = apiClient.Send(request).Content.ReadAsStringAsync().Result;
        return JObject.Parse(responseBody);
    }

    //--- Determines if there are any tasks associated with the token that are being processed
    public void GetBomTokenStatus(string processingToken)
    {
        request.Method = HttpMethod.Get;
        request.RequestUri = new Uri($"{apiUrl}/api/v1/bom/token/{processingToken}");
        int pollCounter = 0;
        while (true)
        {
            if (pollCounter > 300)
            {
                throw new Exception("Something went wrong - dtrack could not finish processing in 5 minutes");
            }
            string responseBody = apiClient.Send(request).Content.ReadAsStringAsync().Result;
            JObject jsonObject = JObject.Parse(responseBody);
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
        request.Method = HttpMethod.Get;
        request.RequestUri = new Uri($"{apiUrl}/api/v1/metrics/project/{projectUuid}/current");
        string responseBody = apiClient.Send(request).Content.ReadAsStringAsync().Result;
        return JObject.Parse(responseBody);
    }

    //----- PROJECT SECTION
    //--- Returns a list of all projects
    public JArray GetProject()
    {
        request.Method = HttpMethod.Get;
        request.RequestUri = new Uri($"{apiUrl}/api/v1/project/");
        string responseBody = apiClient.Send(request).Content.ReadAsStringAsync().Result;
        return JArray.Parse(responseBody);
    }

    //--- Returns a specific project by its name and version
    public JObject GetProjectLookup(string projectName)
    {
        request.Method = HttpMethod.Get;
        request.RequestUri = new Uri($"{apiUrl}/api/v1/project/lookup?name={Uri.EscapeDataString(projectName)}");
        string responseBody = apiClient.Send(request).Content.ReadAsStringAsync().Result;
        return JObject.Parse(responseBody);
    }

    public void Dispose()
    {
        throw new NotImplementedException();
    }
}
