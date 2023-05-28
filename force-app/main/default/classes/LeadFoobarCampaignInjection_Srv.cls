public with sharing class LeadFoobarCampaignInjection_Srv {
    private static LeadFoobarCampaignInjection_Srv instance;
    private static String existingCampaignId;
    private CampaignRepository campaignRepository = new CampaignRepository();
    private CampaignMemberRepository campaignMemberRepository = new CampaignMemberRepository();


    private LeadFoobarCampaignInjection_Srv() {}

    public static LeadFoobarCampaignInjection_Srv getNewInstance() {
        if(instance == null) {
            instance = new LeadFoobarCampaignInjection_Srv();
        }
        return instance;
    }

    public void processFoobarLeads(List<Lead> leads) {
        // TODO: Current implementation assumes leads have the same owner. This assumption should be validated in the future.
        if(existingCampaignId == null) {
            existingCampaignId = getCampaignId();
        }   
        campaignMemberRepository.createCampaignMembers(leads, existingCampaignId);            
    }

    //ta metoda mi się nie podoba, wydaje mi się że jest za długa.Zastanawiam się czy nie powinienem najpierw sprawdzać czy istnieje a pozniej jakby nie zwróciło wyników to tworzyć nowe
    @TestVisible
    private Id getCampaignId() {
        Campaign recentCampaign = campaignRepository.findRecentFoobarCampaign();
        if(recentCampaign != null) {
            return recentCampaign.Id;
        }
        return campaignRepository.createCampaign(setCampaignName()).Id;
    }
    
    @TestVisible
    private String setCampaignName() {
        return LeadHandler.FOOBAR_LEAD_SOURCE + ' ' + UserInfo.getName() + ' ' + Datetime.now();
    }
}