@isTest
private class CampaignRepositoryTest {
    
    @isTest
    private static void findRecentCampaignTestWithExistingCampaign() {
        TestDataFactory.createLeads(1, LeadHandler.FOOBAR_LEAD_SOURCE);
        CampaignRepository campaignRepository = new CampaignRepository();
        Campaign campaignToCheck = campaignRepository.findRecentCampaign();

        System.assert(campaignToCheck != null);
    }

    @isTest
    private static void findRecentCampaignTestWithoutExistingCampaign() {
        CampaignRepository campaignRepository = new CampaignRepository();
        Campaign campaignToCheck = campaignRepository.findRecentCampaign();

        System.assert(campaignToCheck == null);
    }

    @isTest
    private static void createCampaignTest() {
        CampaignRepository campaignRepository = new CampaignRepository();
        Campaign campaignToCheck = campaignRepository.createCampaign(TestDataFactory.CAMPAIGN_NAME);

        System.assert(campaignToCheck != null);
        System.assertEquals(TestDataFactory.CAMPAIGN_NAME, campaignToCheck.Name);
    }
}