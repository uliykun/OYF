public class WeatherForecastController{

    private static final String API_KEY = OpenWeatherApi__mdt.getInstance('OpenWeatherApiKey').OpenWeatherApiKey__c;

    @AuraEnabled
    public static Models.WeatherForecastWrapper fetchWeatherInfoForContact(Id contactId){
        Contact contact = getContactInfo(contactId);
        return fetchWeatherInfoByCity(contact.MailingCity);
    }

    @TestVisible 
    private static Contact getContactInfo(Id contactId){
        return [SELECT Id, MailingCity FROM Contact WHERE Id=:contactId];
    }
    
     
    public static Models.WeatherForecastWrapper fetchWeatherInfoByCity(String cityName){

        String endPoint = 'https://api.openweathermap.org/data/2.5/weather?q=' + cityName + '&appid=' + API_KEY;
        HttpRequest request = new HttpRequest();
        HttpResponse response = new HttpResponse();
        Http http = new Http();
        request.setEndpoint(endPoint);
        request.setMethod('POST');
        response = http.send(request);

        if (response.getStatusCode() == 200) {
            String jsonResponse = response.getBody();
            Models.WeatherInfo jsonParsedData = (Models.WeatherInfo)parseWeatherInfo(jsonResponse);
            Models.WeatherForecastWrapper weatherForecastWrapper = new Models.WeatherForecastWrapper(jsonParsedData);
            return weatherForecastWrapper;
        } else{
            throw weatherForecastException('Error : Please check if Mailing City is correct');
        }
    }
 
    private static AuraHandledException weatherForecastException(String message) {
        AuraHandledException e = new AuraHandledException(message);
        e.setMessage(message);
        return e;
    }

    private static Models.WeatherInfo parseWeatherInfo(String json){
        return (Models.WeatherInfo) System.JSON.deserialize(json, Models.WeatherInfo.class);
    }
}