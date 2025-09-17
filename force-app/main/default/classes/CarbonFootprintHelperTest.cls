@IsTest
private class CarbonFootprintHelperTest {
    
    @IsTest
    static void testUpdateSubscriptionTotals() {
        Subscription__c sub = new Subscription__c(Name='Test Sub');
        insert sub;

        CarbonFootprint__c cf1 = new CarbonFootprint__c(
            Name='CF1', Subscription__c=sub.Id, CO2_Saved__c=10
        );
        CarbonFootprint__c cf2 = new CarbonFootprint__c(
            Name='CF2', Subscription__c=sub.Id, CO2_Saved__c=20
        );

        insert new List<CarbonFootprint__c>{cf1, cf2};

        sub = [SELECT Id, Total_CO2_Saved__c FROM Subscription__c WHERE Id=:sub.Id];
        System.assertEquals(30, sub.Total_CO2_Saved__c);
    }
}
