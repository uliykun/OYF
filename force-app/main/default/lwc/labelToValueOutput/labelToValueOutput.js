import { LightningElement, api } from 'lwc';

export default class LabelToValueOutput extends LightningElement {
    @api label;
    @api value;
}