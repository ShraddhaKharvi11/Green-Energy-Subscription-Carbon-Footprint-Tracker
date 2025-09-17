public with sharing class CarbonFootprintHelper {
    
    public static void updateSubscriptionTotals(List<CarbonFootprint__c> footprints) {
        Set<Id> subscriptionIds = new Set<Id>();
        for(CarbonFootprint__c cf : footprints) {
            if(cf.Subscription__c != null) {
                subscriptionIds.add(cf.Subscription__c);
            }
        }

        Map<Id, Subscription__c> subsMap = new Map<Id, Subscription__c>(
            [SELECT Id, Total_CO2_Saved__c FROM Subscription__c WHERE Id IN :subscriptionIds]
        );

        for(CarbonFootprint__c cf : footprints) {
            if(cf.Subscription__c != null && subsMap.containsKey(cf.Subscription__c)) {
                Subscription__c sub = subsMap.get(cf.Subscription__c);
                sub.Total_CO2_Saved__c = (sub.Total_CO2_Saved__c == null ? 0 : sub.Total_CO2_Saved__c) + 
                                         (cf.CO2_Saved__c == null ? 0 : cf.CO2_Saved__c);
            }
        }

        if(!subsMap.isEmpty()) {
            update subsMap.values();
        }
    }
}
