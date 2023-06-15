@IsTest
public class WeatherForecastControllerTest {

    @IsTest
    public static void testFetchWeatherInfo() {
        String cityName = 'testCity';
        
        Test.setMock(HttpCalloutMock.class, new WeatherForecastControllerMockHttp());
        
        Models.WeatherForecastWrapper result = WeatherForecastController.fetchWeatherInfoByCity(cityName);
        
        System.assertEquals('CityName', result.name);
        System.assertEquals(25.0, result.temp);
        System.assertEquals(1623638470, result.sunset);
        System.assertEquals(1623602444, result.sunrise);
        System.assertEquals(75, result.humidity);
        System.assertEquals(1010, result.pressure);
    }

    @isTest
    static void testGetContactInfo() {
        Contact testContact = new Contact(
            FirstName = 'John',
            LastName = 'Doe',
            MailingCity = 'Test City'
        );
        insert testContact;

        Contact result = WeatherForecastController.getContactInfo(testContact.Id);

        System.assertEquals(testContact.Id, result.Id);
        System.assertEquals(testContact.MailingCity, result.MailingCity);
    }

    @IsTest
    public static void testFetchWeatherInfo_NegativeScenario() {
        String cityName = 'wrongCity';

        Test.setMock(HttpCalloutMock.class, new WeatherForecastControllerMockHttp(404, 'Not Found'));
        try {
            Test.startTest();
            Models.WeatherForecastWrapper result = WeatherForecastController.fetchWeatherInfoByCity(cityName);
            Test.stopTest();
            System.assert(false, 'Expected exception was not thrown');
        } catch (AuraHandledException e) {
            System.assertEquals('Error : Please check if Mailing City is correct', e.getMessage());
        }
    }
}

