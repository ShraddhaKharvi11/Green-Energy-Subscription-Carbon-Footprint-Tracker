import { LightningElement, wire } from 'lwc';
import getTotalCO2 from '@salesforce/apex/CarbonFootprintHelper.getTotalCO2';

export default class CO2Summary extends LightningElement {
    totalCO2;
    error;

    // Wire the Apex method to fetch total CO2 saved
    @wire(getTotalCO2)
    wiredCO2({ data, error }) {
        if (data) {
            this.totalCO2 = data;
            this.error = undefined;
        } else if (error) {
            this.error = error.body ? error.body.message : error;
            this.totalCO2 = undefined;
            console.error('Error fetching CO2:', error);
        }
    }
}
