public with sharing class CarbonFootprintTriggerHandler {

    // Handles before insert trigger
    public static void handleBeforeInsert(List<CarbonFootprint__c> newRecords) {
        for (CarbonFootprint__c cf : newRecords) {
            // Example logic: default status
            cf.Status__c = 'Pending';
            
            // Example: calculate carbon savings
            if (cf.EnergyConsumed__c != null && cf.RenewableFactor__c != null) {
                cf.CarbonSaved__c = cf.EnergyConsumed__c * cf.RenewableFactor__c;
            }
        }
    }

    // Handles before update trigger
    public static void handleBeforeUpdate(List<CarbonFootprint__c> updatedRecords, Map<Id, CarbonFootprint__c> oldMap) {
        for (CarbonFootprint__c cf : updatedRecords) {
            CarbonFootprint__c oldCF = oldMap.get(cf.Id);

            // Example: if energy consumed changed, recalc carbon savings
            if (cf.EnergyConsumed__c != oldCF.EnergyConsumed__c && cf.RenewableFactor__c != null) {
                cf.CarbonSaved__c = cf.EnergyConsumed__c * cf.RenewableFactor__c;
            }
        }
    }
}
