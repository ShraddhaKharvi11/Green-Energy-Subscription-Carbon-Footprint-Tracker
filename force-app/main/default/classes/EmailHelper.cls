public with sharing class EmailHelper {
    public static void sendSubscriptionUpdateEmail(Subscription__c sub) {
        // Defensive check
        if (sub == null) return;

        // Get fresh subscription record with Name and CO₂ field
        Subscription__c freshSub = [
            SELECT Id, Name, Total_CO2_Saved__c, Owner.Email
            FROM Subscription__c
            WHERE Id = :sub.Id
            LIMIT 1
        ];

        // Prepare email
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setToAddresses(new String[] { freshSub.Owner.Email });
        mail.setSubject('Subscription Update: ' + freshSub.Name);

        String body = 'Hello,' + '\n\n' +
                      'Your subscription "' + freshSub.Name + '" has been updated.' + '\n' +
                      'Total CO₂ Saved: ' + freshSub.Total_CO2_Saved__c + ' kg.' + '\n\n' +
                      'Thanks,' + '\n' +
                      'GreenEnergyTracker Team';

        mail.setPlainTextBody(body);

        // Send
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
    }
}
