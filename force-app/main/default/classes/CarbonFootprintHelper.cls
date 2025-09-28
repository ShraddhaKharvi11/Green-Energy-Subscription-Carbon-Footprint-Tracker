public class CarbonFootprintHelper {
    public static void updateSubscriptionTotals(List<CarbonFootprint__c> footprints) {
        Set<Id> subIds = new Set<Id>();
        for (CarbonFootprint__c cf : footprints) {
            if (cf.Subscription__c != null) {
                subIds.add(cf.Subscription__c);
            }
        }

        if (subIds.isEmpty()) return;

        // Aggregate CO2_Saved values
        Map<Id, Decimal> totals = new Map<Id, Decimal>();
        for (AggregateResult ar : [
            SELECT Subscription__c subId, SUM(CO2_Saved__c) total
            FROM CarbonFootprint__c
            WHERE Subscription__c IN :subIds
            GROUP BY Subscription__c
        ]) {
            totals.put((Id)ar.get('subId'), (Decimal)ar.get('total'));
        }

        // Update Subscriptions
        List<Subscription__c> updates = new List<Subscription__c>();
        for (Id subId : subIds) {
            Subscription__c s = new Subscription__c(Id = subId);
            s.Total_CO2_Saved__c = totals.containsKey(subId) ? totals.get(subId) : 0;
            updates.add(s);
        }

        if (!updates.isEmpty()) {
            update updates;
        }
    }
}
