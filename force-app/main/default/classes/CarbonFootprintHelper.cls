public with sharing class CarbonFootprintHelper {
    public static void updateSubscriptionTotals(List<CarbonFootprint__c> footprints) {
        Set<Id> subscriptionIds = new Set<Id>();
        for (CarbonFootprint__c cf : footprints) {
            if (cf.Subscription__c != null) subscriptionIds.add(cf.Subscription__c);
        }
        if (subscriptionIds.isEmpty()) return;

        Map<Id, Decimal> totals = new Map<Id, Decimal>();
        for (AggregateResult ar : [
            SELECT Subscription__c subId, SUM(CO2_Saved__c) totalCO2
            FROM CarbonFootprint__c
            WHERE Subscription__c IN :subscriptionIds
            GROUP BY Subscription__c
        ]) {
            totals.put((Id) ar.get('subId'), (Decimal) ar.get('totalCO2'));
        }

        List<Subscription__c> subsToUpdate = new List<Subscription__c>();
        for (Id subId : subscriptionIds) {
            Decimal total = totals.containsKey(subId) ? totals.get(subId) : 0;
            subsToUpdate.add(new Subscription__c(Id = subId, Total_CO2_Saved__c = total));
        }
        if (!subsToUpdate.isEmpty()) update subsToUpdate;
    }
}
