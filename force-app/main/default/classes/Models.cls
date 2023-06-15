public with sharing class Models {

    public class WeatherForecastWrapper{
        @AuraEnabled
        public String name;
        @AuraEnabled
        public Double temp;
        @AuraEnabled
        public Integer sunset;
        @AuraEnabled
        public Integer sunrise;
        @AuraEnabled
        public Integer humidity;
        @AuraEnabled
        public Integer pressure;
        public WeatherForecastWrapper(Models.WeatherInfo parseData){
            Models.cls_main te = parseData.main;
            this.name = parseData.name;
            this.temp = te.temp;
            this.humidity = te.humidity;
            this.pressure = te.pressure;
            this.sunrise = parseData.sys.sunrise;
            this.sunset = parseData.sys.sunset;
        }
    }

    public class WeatherInfo{
        public cls_coord coord;
        public cls_weather[] weather;
        public String base; 
        public cls_main main;
        public Integer visibility;  
        public cls_wind wind;
        public cls_clouds clouds;
        public Integer dt;  
        public cls_sys sys;
        public Integer timezone;   
        public Integer id;  
        public String name; 
        public Integer cod;
    }
    
    public class cls_coord {
        public Double lon;  
        public Double lat; 
    }

    public class cls_weather {
        public Integer id;
        public String main;
        public String description;  
        public String icon;
    }

    public class cls_main {
        public Double temp; 
        public Double feels_like;  
        public Double temp_min; 
        public Double temp_max;
        public Integer pressure;    
        public Integer humidity;   
    }

    public class cls_wind {
        public Double speed;    
        public Integer deg;
        public Double gust; 
    }

    public class cls_clouds {
        public Integer all; 
    }

    public class cls_sys {
        public Integer type;   
        public Integer id;  
        public String country;  
        public Integer sunrise;
        public Integer sunset;  
    }
}