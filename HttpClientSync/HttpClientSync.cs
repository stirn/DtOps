namespace Selfmade.Utilities.Network;

using System.Net.Http.Headers;

public class HttpClientSync
{
    protected readonly HttpClient httpClient;

    public HttpClientSync() => httpClient = new HttpClient();

    public string Send(HttpMethod httpMethod, string path, HttpContent? httpContent = null)
    {
        HttpRequestMessage request = new HttpRequestMessage(httpMethod, path);
        if (httpContent != null)
        {
            request.Content = httpContent;
        }
        HttpResponseMessage response = httpClient.Send(request);
        response.EnsureSuccessStatusCode();
        return response.Content.ReadAsStringAsync().Result;
    }

    public void AddHeaders(string headerKey, string headerValue) => httpClient.DefaultRequestHeaders.Add(headerKey, headerValue);
}


