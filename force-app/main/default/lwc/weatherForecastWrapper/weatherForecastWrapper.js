import { LightningElement, api } from 'lwc';

export default class WeatherForecastWrapper extends LightningElement {
    @api weatherForecastData;
    @api errorMessage = '';
}