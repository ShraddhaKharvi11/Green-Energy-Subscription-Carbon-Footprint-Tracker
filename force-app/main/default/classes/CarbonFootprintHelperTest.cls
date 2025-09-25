@isTest
public class CarbonFootprintHelperTest {
    @isTest static void testUpdateSubscriptionTotals() {
        // Create any required records/fields for Subscription
        Contact c = new Contact(LastName='Test');
        insert c;

        Subscription__c sub = new Subscription__c(
            Name = 'Test Sub',
            Contact__c = c.Id,          // include required fields your org needs
            Cost__c = 100,              // numeric / currency
            Start_Date__c = Date.today(),
            End_Date__c = Date.today().addDays(30)
        );
        insert sub;

        // Insert carbon footprints; this will fire trigger and helper
        CarbonFootprint__c cf1 = new CarbonFootprint__c(
            Name='CF1', Subscription__c = sub.Id, CO2_Saved__c = 10
        );
        CarbonFootprint__c cf2 = new CarbonFootprint__c(
            Name='CF2', Subscription__c = sub.Id, CO2_Saved__c = 20
        );
        insert new List<CarbonFootprint__c>{cf1, cf2};

        // Verify total updated
        sub = [SELECT Id, Total_CO2_Saved__c FROM Subscription__c WHERE Id = :sub.Id];
        System.assertEquals(30, sub.Total_CO2_Saved__c);

        // Delete one and verify update
        delete cf1;
        sub = [SELECT Id, Total_CO2_Saved__c FROM Subscription__c WHERE Id = :sub.Id];
        System.assertEquals(20, sub.Total_CO2_Saved__c);
    }
}
