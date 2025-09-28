public class CarbonFootprintHandler {
    // Method to handle before insert and update
    public static void handleBeforeInsertOrUpdate(List<CarbonFootprint__c> records) {
        for (CarbonFootprint__c cf : records) {
            // Example logic: calculate CO2 saved
            if (cf.Energy_Saved__c != null && cf.Emission_Factor__c != null) {
                cf.CO2_Saved__c = cf.Energy_Saved__c * cf.Emission_Factor__c;
            }
        }
    }
}
