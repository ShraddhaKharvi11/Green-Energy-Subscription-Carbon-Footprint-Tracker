trigger CarbonFootprintTrigger on CarbonFootprint__c (after insert, after update, after delete, after undelete) {
    if (Trigger.isAfter) {
        if (Trigger.isInsert || Trigger.isUpdate || Trigger.isUndelete) {
            CarbonFootprintHelper.updateSubscriptionTotals(Trigger.new);
        }
        if (Trigger.isDelete) {
            CarbonFootprintHelper.updateSubscriptionTotals(Trigger.old);
        }
    }
}
