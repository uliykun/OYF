import { LightningElement, api, track, wire } from 'lwc';
import { getRecord, getFieldValue } from 'lightning/uiRecordApi';
import fetchWeatherInfoForContact from "@salesforce/apex/WeatherForecastController.fetchWeatherInfoForContact";

const FIELDS = ['Contact.MailingCity'];

export default class MyComponent extends LightningElement {
    @api recordId;
    @track result = {};
    @track errorMessage;
    wiredContactData;

    @wire(getRecord, { recordId: '$recordId', fields: FIELDS })
    wiredContact(result) {
        this.wiredContactData = result;
        const { data, error } = result;
        if (data) {
            const mailingCity = getFieldValue(data, 'Contact.MailingCity');
            // Handle specific field update for the MailingCity
            if (mailingCity && this.result.mailingCity !== mailingCity) {
                this.result.mailingCity = mailingCity;
                // Calling the loadWeatherInfo to refresh weather information
                this.loadWeatherInfo();
            }
        } else if (error) {
            this.errorMessage = error.body.message;
        }
    }

    connectedCallback() {
        this.loadWeatherInfo();
    }

    loadWeatherInfo() {
        fetchWeatherInfoForContact({ contactId: this.recordId })
            .then(result => {
                result.temp = (result.temp - 274.15).toFixed(2);
                result.sunset = this.convertUnixToTime(result.sunset);
                result.sunrise = this.convertUnixToTime(result.sunrise);

                this.result = result;
                this.errorMessage = '';
            })
            .catch(error => {
                this.errorMessage = error.body.message;
            });
    }

    convertUnixToTime(unixtimestamp) {
        const dt = unixtimestamp * 1000;
        const myDate = new Date(dt);
        return myDate.toLocaleString();
    }
}