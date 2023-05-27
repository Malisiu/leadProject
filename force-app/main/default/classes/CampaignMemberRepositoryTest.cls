@isTest
private class CampaignMemberRepositoryTest {
    @TestSetup
    static void makeData(){
        TestDataFactory.createLeads(5, TestDataFactory.LEAD_LEAD_SOURCE);
        TestDataFactory.createCampaign();
    }

    @isTest
    private static void createCampaignMembersTest() {
        List<Lead> leads = [SELECT Id FROM Lead];
        Campaign campaign = [SELECT Id FROM Campaign];
        
        Test.startTest();
        CampaignMemberRepository campaignMemberRepository = new CampaignMemberRepository();
        campaignMemberRepository.createCampaignMembers(leads, campaign.Id);
        Test.stopTest();

        List<CampaignMember> campaignMembersToCheck = [SELECT Id FROM CampaignMember];

        System.assertEquals(leads.size(), campaignMembersToCheck.size());
    }

}