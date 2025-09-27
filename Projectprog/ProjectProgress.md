Project Title:
Green Energy Subscription & Carbon Footprint Tracker

Problem Statement:
A Salesforce-powered platform for renewable energy subscriptions and carbon footprint tracking. Customers subscribe to solar/wind plans, earn badges for eco-friendly actions, and view CO₂ savings. Dashboards and alerts promote sustainability and green energy adoption

Phase 1 
Problem Understanding & Industry Analysis
1. Requirement Gathering
We need to define what your Salesforce app must achieve:
•	Customers can subscribe to solar/wind energy plans.
•	System tracks carbon savings (based on energy usage).
•	Gamification: customers earn points & badges for eco-friendly actions.
•	Reports/Dashboards: total CO₂ reduced, usage per customer, leaderboards.
•	Alerts/Notifications: when customer usage crosses limits.
•	Integration possibility: IoT/Smart Meter or manual energy data entry.
_______________________________________________________________________________________
2. Stakeholder Analysis
•	Primary Stakeholders:
o	Customers (end users who subscribe).
o	Company Admin (sets plans, manages subscriptions).
o	Sustainability Manager (reviews CO₂ savings).
•	Secondary Stakeholders:
o	Energy Providers (partners, optional).
o	Regulators (reporting compliance, optional).
_____________________________________________________________________________________
3. Business Process Mapping
Example flow:
1.	Customer subscribes to a renewable plan.
2.	Energy usage is tracked (manual input or integration).
3.	Carbon savings auto-calculated.
4.	System updates total savings + points.
5.	Customer receives badges/alerts.
6.	Admin monitors via dashboards.
_____________________________________________________________________________________________________
4. Industry-specific Use Case Analysis
•	Renewable Energy Industry: Growing focus on sustainability and carbon neutrality.
•	Salesforce Fit:
o	CRM to manage subscriptions.
o	Custom objects for carbon savings tracking.
o	Gamification via points/badges (could even extend to Loyalty Management if needed).
o	Reports for internal + external sustainability reporting.
______________________________________________________________________________________________________
5. AppExchange Exploration
Some apps on AppExchange (like Sustainability Cloud) already track emissions — but since we’re building a custom, student/project-focused version, we’ll design simpler custom objects and automation.
(If you want, we could also reference Sustainability Cloud in your final presentation to show “future upgrade path.”)

Phase 2
1. Salesforce Edition
•	Using Developer Edition
•	Supports Custom Objects like Subscription__c and CarbonFootprint__c, Apex, Flows, and LWC.
________________________________________________________________________________________________________
2. Company Profile Setup
•	Navigated to Setup → Company Information.
•	Verified and updated the Company Name, Default Locale, Language, Currency, and Time Zone.
________________________________________________________________________________________________________
3. Dev Org Setup
•	Created a Developer Edition Org (e.g., GreenEnergyTracker) and connected it to VS Code using Salesforce CLI (sf).
•	This org serves as the main development environment where all metadata (objects like CarbonFootprint__c, Subscription__c, tabs, layouts, and permission sets) is stored.
•	Create a Scratch Org (temporary org) for testing new features such as new fields, layouts, or Lightning pages before pushing them back to the main org.
_________________________________________________________________________________________________________________
4. Sandbox Usage
•	Since Developer Edition does not provide Sandboxes, you use a Scratch Org as a substitute.
•	Example: Before making big changes to the CarbonFootprint__c object (adding fields or layouts), you test it in the Scratch Org.
•	This prevents breaking the main Dev Org and allows experimentation with Flows, Apex, and Lightning App Builder changes.
•	Once tested, you push only stable metadata from Scratch Org → Dev Org.
____________________________________________________________________________________________________________________
5. Deployment Basics
•	Salesforce CLI (SFDX) used as the primary deployment method:
     1.sf project deploy start for pushing metadata.
     2. sf project retrieve start for pulling changes from org to local.
•	Awareness of Change Sets (admin-friendly) as an alternative deployment option. 
•	 Queues, Flows, Profiles, and LWC successfully deployed between scratch and main org.

Phase 3: Data Modeling & Relationships

1. Standard & Custom Objects
Confirmed presence of custom objects in Object Manager:
CarbonFootprint__c (tracks CO₂ saved/reduced per entry).
Subscription__c (tracks energy plans linked to users).
Standard objects like User and Contact are leveraged for lookups.
__________________________________________________________________________________________________
2. Fields
CarbonFootprint__c
CO2_Saved__c → Number(16,2), Required.
CO2_Reduced__c → Number(16,2).
Energy_Type__c → Picklist (Solar, Wind).
Entry_Date__c → Date/Time, Required.
Subscription__c → Lookup(Subscription__c), Required.
User__c → Lookup(User), Optional.

Subscription__c
Start_Date__c → Date, Required.
End_Date__c → Date, Required.
Plan_Type__c → Picklist (Basic, Premium, Enterprise).
Cost__c → Currency(16,2), Required.
Contact__c → Lookup(Contact), Required.
Total_CO2_Saved__c → Formula (SUM from related CarbonFootprints via trigger/flow).
________________________________________________________________________________________________________
3. Page Layouts

CarbonFootprint__c Layout → Added related list: Subscriptions.
Subscription__c Layout → Added related list: CarbonFootprints.
Contact Layout (optional) → Added related list: Subscriptions.
Ensures relationships are visible when viewing records.
___________________________________________________________________________________________________________
4. Junction Objects

Junction objects allow many-to-many relationships (two master-detail fields).
Example (not implemented): Subscription_CarbonFootprint__c to connect multiple Subscriptions ↔ multiple CarbonFootprints.
In GreenEnergyTracker, junction objects are not required, since relationships are one-to-many.
____________________________________________________________________________________________________________
5. Hierarchical Relationships

Hierarchical relationships apply only to the User object.
Not used in GreenEnergyTracker.
Explained for completeness (useful in real projects for approval flows, reporting managers, etc.).
_______________________________________________________________________________________________________________


Phase 4: Process Automation 
Step 1: Validation Rules 
Validation Rules prevent wrong or incomplete data from being saved. 
A. CarbonFootprint – Prevent Negative CO₂ Saved 
• Goal: Ensure users don’t enter negative values. 
• Setup → Object Manager → CarbonFootprint__c → Validation Rules → New. 
• Rule Name: Prevent_Negative_CO2 
• Formula: 
ISBLANK(CO2_Saved__c) || CO2_Saved__c < 0 
• Error Message: “CO₂ Saved cannot be negative.” 
• Error Location: Field → CO2_Saved__c. 
• Save. 
________________________________________________________________________________________________________
Step 2: Workflow Rule + Email Alert 
Workflow Rule: Notify when a Subscription is expiring. 
• Setup → Workflow Rules → New Rule. 
• Object: Subscription__c. 
• Rule Name: Subscription_Expiry_Alert. 
• Rule Criteria: 
AND(NOT(ISBLANK(End_Date__c)),End_Date__c = TODAY() + 30)
______________________________________________________________________________________________________
Step 3: Process Builder  
Automation Process Builder automates record updates or actions. 
Start the Process 
• Object: Subscription__c 
• Start the process: when a record is created or edited.
_________________________________________________________________________________________________
Step 4: Record-Triggered Flow 
Flows are more advanced automation. 
Example: Update_Total_CO2_Subscription 
Create a New Flow 
1. Go to Setup → Flows → New Flow. 
2. Choose Record-Triggered Flow. 
3. Click Create 
Configure Trigger 
1. Object: Carbon_Footprint__c 
2. Trigger: A record is created or updated 
o Optionally: Run only if a record is updated to meet condition (e.g., CO₂ 
value is not null). 
3. Run the Flow: After the record is saved (so you can update related subscription 
records). 
Add Flow Logic 
1. Get Records: (Optional, if you need all CO₂ records for the subscription) 
o Object: Carbon_Footprint__c 
o Filter: Subscription__c = {!$Record.Subscription__c} 
o Store all records → All Records 
2. Assignment: Calculate total CO₂ 
o Loop through all Carbon_Footprint__c records (if using a collection) 
o Sum the CO₂ values → store in a variable varTotalCO2 
3. Update Records: 
o Record to Update: Subscription__c related to the Carbon_Footprint__c 
record ($Record.Subscription__c) 
o Field: Total_CO2__c = {!varTotalCO2}
_________________________________________________________________________________________________


Phase 5: Apex Programming (Developer) 

Step 1: Classes & Objects 
• Apex Classes are reusable units of code to implement business logic. 
1.CarbonFootprintHelper: 
• Purpose: Encapsulates all operations related to Carbon_Footprint__c, e.g., 
calculating total CO₂, updating related subscriptions, or performing bulk-safe 
operations. 
• Usage in Project: Called from triggers or flows to keep 
Subscription__c.Total_CO2__c accurate.
2. CarbonFootprintHelperTest 
• Purpose: Unit tests for CarbonFootprintHelper ensuring proper logic, bulk 
operations, and test coverage for deployment. 
3. EmailHelper 
• Purpose: Handles sending emails for notifications like subscription CO₂ updates or 
expiry alerts. 
_______________________________________________________________________________________________________
Step 2: Apex Trigger:  
Automate actions when records change. 
Example: CarbonFootprintTrigger 
Purpose: 
• Automatically updates the Total_CO2__c field on the related Subscription__c 
whenever a Carbon_Footprint__c record is inserted, updated, or deleted. 
• Ensures real-time aggregation of CO₂ for each subscription. 
• Can also trigger email notifications via EmailHelper if needed. 
____________________________________________________________________________________________________
Step 3: SOQL & SOSL 
SOQL: Query Salesforce objects. 
Code:   List<Subscription__c> subs = [SELECT Id, Name, Total_CO2__c  
FROM Subscription__c  
WHERE Total_CO2__c > 100]; 
SOSL: Search across multiple objects. 
Code: List<List<SObject>> results = [FIND 'GreenEnergy*' IN ALL FIELDS  
RETURNING Subscription__c(Name)]; 
________________________________________________________________________________________________________
Step 4: Collections: List, Set, Map 
• Location: Used inside Apex classes, triggers, or anonymous Apex. 
Example: 
List<Subscription__c> subsList = new List<Subscription__c>(); 
Set<Id> subIds = new Set<Id>(); 
Map<Id, Decimal> subCO2Map = new Map<Id, Decimal>(); 
_________________________________________________________________________________________________
Step 5: Batch Apex 
• Location: Setup → Apex Classes → New. 
• Purpose: Process large datasets asynchronously in batches. 
_________________________________________________________________________________________________________
Step 6: Queueable Apex 
• Purpose: Chain asynchronous jobs, more flexible than future methods. 
______________________________________________________________________________________________________
Step 7: Scheduled Apex 
• Purpose: Run batch/queueable jobs on a schedule. 
_________________________________________________________________________________________________________
Step 8: Future Methods 
• Purpose: Run callouts or asynchronous operations. 
________________________________________________________________________________________________________
Step 9: Exception Handling 
Step 10: Asynchronous Processing 
• Use Batch, Queueable, Scheduled, or Future Apex to handle large datasets or time
consuming operations without hitting governor limits. 
• Examples: updating total CO₂ across thousands of subscriptions, sending 
notifications, generating reports.
______________________________________________________________________________________________________________


Phase 6: User Interface Development 
Step 1: Lightning App Builder 
• Location: Setup → Lightning App Builder → New. 
• Purpose: Create custom apps combining pages, tabs, and components. 
• Steps: 
• Click New Lightning App. 
• Enter App Name: GreenEnergyTracker. 
• Select App Options: Navigation style (Standard or Console), Branding (logo, 
colors), Utility Bar (optional). 
• Add Tabs (Subscriptions, Carbon Footprints, Reports, Dashboard). 
• Set Visibility & Permissions. 
_____________________________________________________________________________________
Step 2: Record Pages 
• Purpose: Customize how individual records are displayed in Salesforce Lightning. 
• Steps: 
• Go to Object Manager → Subscription__c → Lightning Record Pages → 
New. 
• Choose Standard Page or clone existing. 
• Drag components like Tabs, Related Lists, Reports, or LWC onto the page. 
• Set component visibility based on profiles or permissions. 
• Save & activate as default for Org, App, or Profile. 
_______________________________________________________________________________________________
Step 3: Tabs 
• Purpose: Organize the navigation within your app. 
• Steps: 
1. Go to Setup → Tabs → New Tab. 
2. Select object (e.g., Subscription__c) or Visualforce/LWC tab. 
3. Name tab, choose icon, save. 
4. Add tab to GreenEnergyTracker app in App Manager.
________________________________________________________________________________________________________
Step 4: App Page Layouts 
• Purpose: Customize what users see on login. 
• Steps: 
1. Go to Setup → Lightning App Builder → App Page → New. 
2. Add components like Dashboards, Reports, Charts, or LWC components. 
3. Assign the page to profiles (Admin, User). 
4. Activate.
_________________________________________________________________________________________________________
Step 5: Utility Bar 
• Purpose: Quick-access tools at the bottom of your app. 
• Steps: 
1. Open App Manager → Edit GreenEnergyTracker → Utility Bar → Add 
Utility Items. 
2. Examples: Notifications, CO₂ Summary, Help, Chatbot. 
3. Configure icons, labels, and actions.
____________________________________________________________________________________________________
Step 6: Lightning Web Components (LWC) 
Purpose: Create dynamic, reusable UI components. 
Steps: 
1. Use VS Code with Salesforce Extensions. 
2. Create new LWC: 
sfdx force:lightning:component:create --type lwc --componentname CO2Summary -
outputdir force-app/main/default/lwc 
3.Structure: 
• HTML: Template for UI. 
• JS: Component logic. 
• Meta.xml: Visibility, targets, and API version. 
• CSS: Optional styling
__________________________________________________________________________________________________________
Step 7: Apex Integration with LWC 
• Purpose: Fetch or update Salesforce data dynamically. 
• Steps: 
1. Create Apex class with @AuraEnabled methods.
_________________________________________________________________________________________________
Step 8: Events in LWC 
• Purpose: Communicate between components. 
• Types: 
1. Custom Events: Child → Parent communication. 
2. Lightning Message Service: Publish-subscribe across unrelated components. 
_________________________________________________________________________________________
Step 9: Navigation Service 
• Purpose: Navigate programmatically between pages or records. 
______________________________________________________________________________________________________________________


Phase 7: Integration & External Access 
1. Named Credentials 
Purpose: 
Named Credentials provide a secure way to store authentication details for external services 
and simplify callouts from Apex or Flows. 
Implementation Details: 
• Named Credential Name: GitHubAPI 
• External Credential: GitHubExternalCredential 
• Authentication Protocol: OAuth 2.0 
• Authentication Provider: ExternalAuthIDE 
• URL: https://api.github.com 
• Scopes: read:user user:email 
• Callout Enabled:    
Yes 
• Test: Verified using Apex test class NamedCredentialTester → received HTTP 200 
response. 
_______________________________________________________________________________________________
2. External Services 
Purpose: 
Integrate REST/SOAP services declaratively using Salesforce External Services 
without writing Apex code. 
Implementation in Project: 
• Registered external services (e.g., GitHub APIs, other REST endpoints) using 
OpenAPI specification. 
• Enabled declarative actions in Flows and Apex for automation. 
Outcome: 
External Services are available in Flows for automated CO₂ data fetch and reporting. 
___________________________________________________________________________________________________
3. Web Services (REST/SOAP) 
Purpose: 
Expose Salesforce data to external systems or fetch data from external APIs. 
Implementation: 
• REST API: 
o Apex REST endpoints for CarbonFootprint__c and Subscription__c objects. 
o Methods: GET (fetch), POST (create), PATCH (update). 
• SOAP API: 
o Exposed for legacy integration systems if needed. 
o WSDL generated and tested via SOAP client. 
Outcome: 
External systems can securely read/update CO₂ and subscription data. 
_____________________________________________________________________________________________
4. Callouts 
Purpose: 
Programmatically access external APIs from Apex. 
Implementation: 
• Named Credential used for authentication. 
• Apex example for GitHub: 
______________________________________________________________________________________
6. Change Data Capture (CDC) 
Purpose: 
Track changes to Salesforce records in real-time. 
Implementation: 
• Enabled CDC on CarbonFootprint__c and Subscription__c objects. 
• Listeners capture create/update/delete events. 
• Used in combination with Platform Events for analytics dashboards. 
Outcome: 
All critical object changes are captured in real-time for integration. 
___________________________________________________________________________________________________________
7. OAuth & Authentication 
Purpose: 
Secure authentication for external system access. 
Implementation: 
• Auth Provider: ExternalAuthIDE (GitHub OAuth 2.0) 
• Callback URl:https://<org>.my.salesforce.com/services/authcallback/ExternalAuthIDE 
• Scopes: read:user user:email 
• Named Credential linked to External Credential for OAuth token management. 
Outcome: 
Users can authenticate securely; Apex callouts automatically handle OAuth tokens. 
___________________________________________________________________________________________________________
8. Remote Site Settings 
Purpose: 
Allow Salesforce to access external endpoints not covered by Named Credentials. 
Implementation: 
• Added https://api.github.com as Remote Site (required if Named Credential not used). 
• Verified connectivity via test Apex callouts. 
Outcome: 
External services accessible securely; callouts succeed without errors.
_________________________________________________________________________________________________________________
