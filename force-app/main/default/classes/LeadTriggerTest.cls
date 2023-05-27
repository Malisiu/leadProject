@isTest
private class LeadTriggerTest {
    
    @isTest
    private static void leadTriggerTest() {
        List<Lead> leadsToInsert = new List<Lead>{
            new Lead(LastName =  TestDataFactory.LEAD_LAST_NAME, Company = TestDataFactory.LEAD_COMPANY_NAME, LeadSource = LeadHandler.FOOBAR_LEAD_SOURCE),
            new Lead(LastName =  TestDataFactory.LEAD_LAST_NAME, Company = TestDataFactory.LEAD_COMPANY_NAME, LeadSource = LeadHandler.FOOBAR_LEAD_SOURCE),
            new Lead(LastName =  TestDataFactory.LEAD_LAST_NAME, Company = TestDataFactory.LEAD_COMPANY_NAME, LeadSource = TestDataFactory.LEAD_LEAD_SOURCE),
            new Lead(LastName =  TestDataFactory.LEAD_LAST_NAME, Company = TestDataFactory.LEAD_COMPANY_NAME, LeadSource = TestDataFactory.LEAD_LEAD_SOURCE)
        };
        
        Test.startTest();
        insert leadsToInsert;
        Test.stopTest();

        List<Campaign> campaignsToCheck = [SELECT Id, Name FROM Campaign];
        List<CampaignMember> campaignMemberToCheck = [SELECT Id FROM CampaignMember];
        
        System.assertEquals(1, campaignsToCheck.size());
        System.assert(campaignsToCheck[0].Name.contains(LeadHandler.FOOBAR_LEAD_SOURCE));
        System.assertEquals(2, campaignMemberToCheck.size());
    }

}