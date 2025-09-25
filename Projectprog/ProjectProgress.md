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
