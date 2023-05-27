public with sharing class LeadFoobarCampaignInjection_Srv {
    private static LeadFoobarCampaignInjection_Srv instance;
    private LeadRepository leadRepository = new LeadRepository();
    private CampaignRepository campaignRepository = new CampaignRepository();
    private CampaignMemberRepository campaignMemberRepository = new CampaignMemberRepository();

    public static final String FOOBAR_WILDCARD = '%Foobar%';

    private LeadFoobarCampaignInjection_Srv() {}

    public static LeadFoobarCampaignInjection_Srv getNewInstance() {
        if(instance == null) {
            instance = new LeadFoobarCampaignInjection_Srv();
        }
        return instance;
    }

    public void processFoobarLeads(List<Lead> leads) {
        List<Lead> foobarLeads = leadRepository.findLeadsByIds(getIdsFromLeads(leads));
        // TODO: Current implementation assumes leads have the same owner. This assumption should be validated in the future.
        String campaignName = setCampaignName(foobarLeads[0].Owner.Name);
        Campaign newCampaign = createNewCampaign(campaignName);      
        campaignMemberRepository.createCampaignMembers(foobarLeads, newCampaign.Id);            
    }

    //ta metoda mi się nie podoba, wydaje mi się że jest za długa.Zastanawiam się czy nie powinienem najpierw sprawdzać czy istnieje a pozniej jakby nie zwróciło wyników to tworzyć nowe
    @TestVisible
    private Campaign createNewCampaign(String campaignName) {
        Campaign recentCampaign = campaignRepository.findRecentCampaign();
        if(recentCampaign != null) {
            return recentCampaign;
        }
        return campaignRepository.createCampaign(campaignName);
    }
    
    @TestVisible
    private String setCampaignName(String ownerName) {
        return LeadHandler.FOOBAR_LEAD_SOURCE + ' ' + ownerName + ' ' + Datetime.now();
    }

    @TestVisible
    private List<Id> getIdsFromLeads(List<Lead> leads) {
        List<Id> leadIds = new List<Id>();
        for(Lead lead : leads) {
            leadIds.add(lead.Id);
        }
        return leadIds;
    }
}