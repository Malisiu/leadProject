@isTest
private class LeadHandlerTest {
    @isTest
    private static void handleAfterInsertTest() {
        TriggerControl.isTriggerActive = false;
        List<Lead> leadsToTest = new List<Lead>();
        leadsToTest.addAll(TestDataFactory.createLeads(5, LeadHandler.FOOBAR_LEAD_SOURCE));
        leadsToTest.addAll(TestDataFactory.createLeads(5, TestDataFactory.LEAD_LEAD_SOURCE));
        TriggerControl.isTriggerActive = true;
        
        Test.startTest();
        LeadHandler.handleAfterInsert(leadsToTest);
        Test.stopTest();

        List<Campaign> campaignsToCheck = [SELECT Id FROM Campaign];
        List<CampaignMember> campaignMemberToCheck = [SELECT Id FROM CampaignMember];

        System.assertEquals(1, campaignsToCheck.size());
        System.assertEquals(100, campaignMemberToCheck.size());
    }
}