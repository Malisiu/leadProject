@IsTest
public with sharing class TestDataFactory {
    public static final String LEAD_LAST_NAME = 'TestLeadName';
    public static final String LEAD_COMPANY_NAME = 'TestCompanyName';
    public static final String LEAD_LEAD_SOURCE = 'TestLeadSource';

    public static final String CAMPAIGN_NAME = 'TestCampaignName';
    
    public static final String OWNER_NAME = 'TestOwnerName';

    public static List<Lead> createLeads(Integer numOfRecords, String leadSource) {
        List<Lead> newLeads = new List<Lead>();
        for(Integer i = 0; i < numOfRecords; i++) {
            newLeads.add(new Lead(LastName = LEAD_LAST_NAME, Company = LEAD_COMPANY_NAME, LeadSource = leadSource));
        }      
        insert newLeads;
        return newLeads;
    }

    public static Campaign createCampaign() {
        Campaign newCampaign = new Campaign(Name = CAMPAIGN_NAME);
        insert newCampaign;
        return newCampaign;
    }
}