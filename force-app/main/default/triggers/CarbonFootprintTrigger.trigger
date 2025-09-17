trigger CarbonFootprintTrigger on CarbonFootprint__c (after insert, after update, after delete) {
    if(Trigger.isInsert || Trigger.isUpdate) {
        CarbonFootprintHelper.updateSubscriptionTotals(Trigger.new);
    }

    if(Trigger.isDelete) {
        CarbonFootprintHelper.updateSubscriptionTotals(Trigger.old);
    }
}
