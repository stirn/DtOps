namespace Selfmade.Utilities.Network;

using System.Net.Http.Headers;

public class HttpClientSync
{
    private readonly HttpClient httpClient;

    public HttpClientSync() => httpClient = new HttpClient();

    public string Get(string path)
    {
        HttpResponseMessage response = httpClient.GetAsync(path).Result;
        response.EnsureSuccessStatusCode();
        return response.Content.ReadAsStringAsync().Result;
    }

    public string Post(string path, HttpContent httpContent)
    {
        HttpResponseMessage response = httpClient.PostAsync(path, httpContent).Result;
        response.EnsureSuccessStatusCode();
        return response.Content.ReadAsStringAsync().Result;
    }

    public string Put(string path, HttpContent httpContent)
    {
        HttpResponseMessage response = httpClient.PutAsync(path, httpContent).Result;
        response.EnsureSuccessStatusCode();
        return response.Content.ReadAsStringAsync().Result;
    }

    public string Delete(string path)
    {
        HttpResponseMessage response = httpClient.DeleteAsync(path).Result;
        response.EnsureSuccessStatusCode();
        return response.Content.ReadAsStringAsync().Result;
    }

    public void AddHeaders(string headerKey, string headerValue)
        => httpClient.DefaultRequestHeaders.Add(headerKey, headerValue);

    public void AddHeadersMediaType(string acceptType)
        => httpClient.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue(acceptType));
}


