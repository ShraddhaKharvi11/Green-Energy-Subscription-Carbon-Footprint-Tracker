trigger CarbonFootprintTrigger on CarbonFootprint__c (after insert, after update) {
    for (CarbonFootprint__c cf : Trigger.new) {
        if (cf.Subscription__c != null) {
            Subscription__c sub = [
                SELECT Id, Name, OwnerId, Total_CO2_Saved__c
                FROM Subscription__c
                WHERE Id = :cf.Subscription__c
                LIMIT 1
            ];
            EmailHelper.sendSubscriptionUpdateEmail(sub);
        }
    }
}
