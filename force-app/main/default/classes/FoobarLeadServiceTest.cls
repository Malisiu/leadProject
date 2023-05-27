@isTest
private class FoobarLeadServiceTest {
    private static final String OWNER_NAME = 'TestOwnerName';

    @TestSetup
    static void makeData(){
        TestDataFactory.createLeads(200, LeadUtils.FOOBAR_LEAD_SOURCE);
        TestDataFactory.createCampaign();
    }

    @isTest
    private static void createNewCampaignTest() {
        Campaign newCampaign = FoobarLeadService.createNewCampaign(TestDataFactory.CAMPAIGN_NAME);

        System.assertEquals(TestDataFactory.CAMPAIGN_NAME, newCampaign.Name);
    }

    @isTest
    private static void setCampaignNameTest() {
        String campaignName = FoobarLeadService.setCampaignName(OWNER_NAME);

        System.assert(campaignName.contains(LeadUtils.FOOBAR_LEAD_SOURCE + OWNER_NAME));
    }

    @isTest
    private static void createCampaignMembersTest() {
        List<Lead> leadsToTest = [SELECT Id FROM Lead];
        Campaign campaignToTest = [SELECT Id FROM Campaign LIMIT 1];

        Test.startTest();
        FoobarLeadService.createCampaignMembers(leadsToTest, campaignToTest.Id);
        Test.stopTest();

        List<CampaignMember> campaignMembersToCheck = [SELECT Id, CampaignId FROM CampaignMember];
        
        System.assertEquals(200, campaignMembersToCheck.size());
        for(CampaignMember campaignMember : campaignMembersToCheck) {
            System.assertEquals(campaignToTest.Id, campaignMember.CampaignId);
        }
    }

    @isTest
    private static void handleNewLeadsTest() {
        List<Lead> leadsToTest = [SELECT Id, Owner.Name FROM Lead];

        Test.startTest();
        FoobarLeadService.handleNewLeads(leadsToTest);
        Test.stopTest();

        List<Campaign> campaignToCheck = [SELECT Id FROM Campaign];
        List<CampaignMember> campaignMembersToCheck = [SELECT Id FROM CampaignMember];

        System.assertEquals(leadsToTest.size(), campaignMembersToCheck.size());
    }
}