public with sharing class FoobarLeadService {
    public static String campaignName;
    public static Campaign newCampaign;

    public static void handleNewLeads(List<Lead> foobarLeads) {
        if(!foobarLeads.isEmpty()) {
            // TODO: Current implementation assumes leads have the same owner. This assumption should be validated in the future.
            campaignName = setCampaignName(foobarLeads[0].Owner.Name);
            newCampaign = createNewCampaign(campaignName);       
            createCampaignMembers(foobarLeads, newCampaign.Id);            
        }
    }

    @TestVisible
    private static Campaign createNewCampaign(String campaignName) {
        if(newCampaign == null) {
            Campaign newCampaign = new Campaign(Name = campaignName);
            //TODO: Consider implementing exception handling here in the future
            insert newCampaign;
            return newCampaign;
        }
        return newCampaign;
    }
    
    @TestVisible
    private static String setCampaignName(String ownerName) {
        if(campaignName == null) {
            campaignName = LeadUtils.FOOBAR_LEAD_SOURCE + ownerName + Datetime.now();
            return campaignName;
        }
        return campaignName;
    }

    @TestVisible
    private static void createCampaignMembers(List<Lead> foobarLeads, String campaignId) {
        List<CampaignMember> campaignMembersToInsert = new List<CampaignMember>();
        for(Lead newLead : foobarLeads) {
            campaignMembersToInsert.add(new CampaignMember(LeadId = newLead.Id, CampaignId = campaignId));
        }
        if(!campaignMembersToInsert.isEmpty()) {
            //TODO: Consider implementing exception handling here in the future
            insert campaignMembersToInsert;
        }
    }
}