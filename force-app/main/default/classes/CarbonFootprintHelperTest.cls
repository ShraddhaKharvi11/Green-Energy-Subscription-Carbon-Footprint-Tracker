@isTest
public class CarbonFootprintTriggerTest {

    @isTest
    static void testInsertCarbonFootprint() {
        CarbonFootprint__c cf = new CarbonFootprint__c(
            Name = 'Test Footprint',
            CO2_Reduced__c = 10
        );
        insert cf;

        CarbonFootprint__c insertedCF = [SELECT Id, CO2_Saved__c, Entry_Date__c FROM CarbonFootprint__c WHERE Id = :cf.Id];
        System.assertEquals('Yes', insertedCF.CO2_Saved__c);
        System.assertNotEquals(null, insertedCF.Entry_Date__c);
    }

    @isTest
    static void testUpdateCarbonFootprint() {
        CarbonFootprint__c cf = new CarbonFootprint__c(
            Name = 'Update Test Footprint',
            CO2_Reduced__c = 0
        );
        insert cf;

        cf.CO2_Reduced__c = 5;
        update cf;

        CarbonFootprint__c updatedCF = [SELECT Id, CO2_Saved__c FROM CarbonFootprint__c WHERE Id = :cf.Id];
        System.assertEquals('Yes', updatedCF.CO2_Saved__c);
    }
}
