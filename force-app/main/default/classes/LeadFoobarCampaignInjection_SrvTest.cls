@isTest
private class LeadFoobarCampaignInjection_SrvTest {

    @TestSetup
    static void makeData(){
        TestDataFactory.createLeads(5, TestDataFactory.LEAD_LEAD_SOURCE);
    }

    @isTest
    private static void getIdsFromLeadsTest() {
        List<Lead> leadsToTest = [SELECT Id FROM Lead];

        Test.startTest();
        LeadFoobarCampaignInjection_Srv leadFoobarCampaignInjection_Srv = LeadFoobarCampaignInjection_Srv.getNewInstance();
        List<Id> leadIds = leadFoobarCampaignInjection_Srv.getIdsFromLeads(leadsToTest);
        Test.stopTest();

        System.assertEquals(leadsToTest.size(), leadIds.size());
    }

    @isTest
    private static void setCampaignNameTest() {
        LeadFoobarCampaignInjection_Srv leadFoobarCampaignInjection_Srv = LeadFoobarCampaignInjection_Srv.getNewInstance();
        String campaignNameToCheck = leadFoobarCampaignInjection_Srv.setCampaignName(TestDataFactory.OWNER_NAME);

        System.assert(campaignNameToCheck.contains(LeadHandler.FOOBAR_LEAD_SOURCE + ' ' + TestDataFactory.OWNER_NAME));
    }

    @isTest
    private static void createNewCampaignTestWithExistingCampaign() {
        TestDataFactory.createLeads(1, LeadHandler.FOOBAR_LEAD_SOURCE);

        Test.startTest();
        LeadFoobarCampaignInjection_Srv leadFoobarCampaignInjection_Srv = LeadFoobarCampaignInjection_Srv.getNewInstance();
        leadFoobarCampaignInjection_Srv.createNewCampaign(TestDataFactory.CAMPAIGN_NAME);
        Test.stopTest();

        Campaign campaignToCheck = [SELECT Id, Name FROM Campaign];
        System.assertNotEquals(TestDataFactory.CAMPAIGN_NAME, campaignToCheck.Name);
    }

    @isTest
    private static void createNewCampaignTestWithoutExistingCampaign() {
        Test.startTest();
        LeadFoobarCampaignInjection_Srv leadFoobarCampaignInjection_Srv = LeadFoobarCampaignInjection_Srv.getNewInstance();
        leadFoobarCampaignInjection_Srv.createNewCampaign(TestDataFactory.CAMPAIGN_NAME);
        Test.stopTest();

        Campaign campaignToCheck = [SELECT Id, Name FROM Campaign];
        System.assertEquals(TestDataFactory.CAMPAIGN_NAME, campaignToCheck.Name);
    }

    @isTest
    private static void processFoobarLeadsTest() {
        List<Lead> leadsToTest = [SELECT Id, Owner.Name FROM Lead];

        Test.startTest();
        LeadFoobarCampaignInjection_Srv.getNewInstance().processFoobarLeads(leadsToTest);
        Test.stopTest();

        List<Campaign> campaignsToCheck = [SELECT Id, Name FROM Campaign];
        List<CampaignMember> campaignMembersToCheck = [SELECT Id FROM CampaignMember];

        System.assertEquals(1, campaignsToCheck.size());
        System.assert(campaignsToCheck[0].Name.contains(LeadHandler.FOOBAR_LEAD_SOURCE + ' ' + leadsToTest[0].Owner.Name));
        System.assertEquals(5, campaignMembersToCheck.size());
    }
}