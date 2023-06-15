public class WeatherForecastControllerMockHttp implements HttpCalloutMock {
    private Integer statusCode;
    private String statusReason;

    public WeatherForecastControllerMockHttp() {}

    public WeatherForecastControllerMockHttp(Integer statusCode, String statusReason) {
        this.statusCode = statusCode;
        this.statusReason = statusReason;
    }

    public HttpResponse respond(HttpRequest request) {
      
        HttpResponse response = new HttpResponse();
        if (statusCode == null) {
            response.setHeader('Content-Type', 'application/json');
            response.setBody('{"name":"CityName","main":{"temp":25,"humidity":75,"pressure":1010},"sys":{"sunrise":1623602444,"sunset":1623638470}}');
            response.setStatusCode(200);
        } else {
            response.setStatusCode(statusCode);
            response.setStatus(statusReason);
        }
        return response;
    }
}