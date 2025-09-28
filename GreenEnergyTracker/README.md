GreenEnergyTracker Salesforce DX Project
Project Overview

GreenEnergyTracker is a Salesforce application designed to track carbon footprint and energy-saving subscriptions. The project allows users to monitor CO2 reduction, manage subscriptions, generate reports, and visualize data through dashboards while maintaining robust security and integration features.

Phase 1: Problem Understanding & Industry Analysis

Requirement gathering from stakeholders.

Business process mapping for carbon footprint tracking.

Analysis of existing solutions and gaps.
_____________________________________________________________________________________________
Phase 2: Requirements & Planning

Defined functional requirements:

Carbon footprint logging.

Subscription management.

CO2 reduction analytics.

Defined non-functional requirements:

Security, scalability, and usability.
_______________________________________________________________________________________________
Phase 3: Data Modeling & Relationships

Created custom objects:

CarbonFootprint__c

Subscription__c

Defined fields:

CarbonFootprint__c: Name, CO2_Reduced__c, Entry_Date__c, Energy_Type__c, CO2_Saved__c, Subscription__c.

Subscription__c: Name, Owner, Status, Total_CO2_Saved__c, Contact, Cost, Start_Date, End_Date.

Established lookup relationships between objects.
________________________________________________________________________________________________________________
Phase 4: Automation & Business Logic

Created workflows, process builder rules, and approval processes.

Implemented Apex triggers:

CarbonFootprintTrigger with CarbonFootprintHelper for handling before insert/update operations.

Validations to ensure data accuracy.
__________________________________________________________________________________________________________
Phase 5: UI & User Experience

Designed Lightning Record Pages and App Pages.

Configured Lightning Components for enhanced usability.

Created custom tabs for Carbon Footprint and Subscription objects.
________________________________________________________________________________________________________________
Phase 6: Testing & Quality Assurance

Created Apex Test Classes for triggers and helper classes.

Performed unit testing:

Insert and update operations validated.

Field-level defaulting verified.

Verified 100% coverage on all Apex triggers and classes.
__________________________________________________________________________________________________________________
Phase 7: Integration & External Access

Configured Named Credentials for external APIs (GitHub integration example).

Implemented External Services and REST callouts.

Used Platform Events and Change Data Capture for real-time updates.

Managed API limits and OAuth authentication.

Configured Remote Site Settings for secure callouts.
______________________________________________________________________________________________________________________
Phase 8: Data Management & Deployment

Data Import Wizard used for small CSV uploads.

Data Loader for bulk import/export, update, or deletion.

Handled Duplicate Rules to prevent duplicate records.

Scheduled Data Export & Backup for Salesforce data.

Used Change Sets, Unmanaged/Managed Packages, and VS Code + SFDX for deployment.

Deployment process:

Authorize org via CLI.

Push code using sfdx force:source:deploy or sf project deploy start.

Run Apex tests to validate deployment.
______________________________________________________________________________________________________________
Phase 9: Reporting, Dashboards & Security Review

Reports:

Tabular, Summary, Matrix, and Joined reports on CarbonFootprint__c and Subscription__c.

Report Types: Custom report types created for combined data analysis.

Dashboards: Real-time visualization of CO2 reduction and subscriptions.

Dynamic Dashboards: User-specific data views.

Sharing Settings: Org-wide defaults, sharing rules configured.

Field-Level Security: Restricted sensitive fields per profile.

Session Settings: Timeout, browser logout, and IP restrictions.

Login IP Ranges: Configured safe ranges including current IP.

Audit Trail: Monitored setup changes for compliance.
____________________________________________________________________________________________________________________
Phase 10: Project Wrap-Up & Documentation

Compiled project documentation including:

CSV files for import testing.

DOCX and PDF reports for Phase 9.

Apex classes, triggers, and test classes.

Ensured complete Salesforce DX project structure:

force-app/
    main/
        default/
            classes/
            triggers/
            objects/
            layouts/
            reports/
            dashboards/
sfdx-project.json
README.md
docx/


Verified deployment workflow:

Code pushed via VS Code / SFDX CLI.

Tests executed with code coverage reports.

Final review of dashboards, reports, and security settings.
_________________________________________________________________________________________________________
Salesforce DX Project Setup References

Salesforce CLI Setup Guide

Salesforce DX Developer Guide

Salesforce Extensions for VS Code
