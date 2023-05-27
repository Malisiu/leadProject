public with sharing class CampaignMemberRepository {
    public List<CampaignMember> createCampaignMembers(List<Lead> leads, String campaignId) {
        List<CampaignMember> campaignMembersToInsert = new List<CampaignMember>();
        for(Lead lead : leads) {
            campaignMembersToInsert.add(new CampaignMember(LeadId = lead.Id, CampaignId = campaignId));
        }
        insert campaignMembersToInsert;
        return campaignMembersToInsert;
    }
}