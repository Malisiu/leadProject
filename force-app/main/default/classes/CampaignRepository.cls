public with sharing class CampaignRepository {
    public static final String FOOBAR_WILDCARD = '%Foobar%';

    public Campaign findRecentFoobarCampaign() {
        CampaignReuseIntervalSettings__c settings = CampaignReuseIntervalSettings__c.getInstance();
        Datetime reuseIntervalStart = System.now().addMinutes((Integer) - settings.minutes__c);
        List<Campaign> campaigns = [
            SELECT Id, Name
            FROM Campaign
            WHERE CreatedDate >= :reuseIntervalStart
                AND Name LIKE :FOOBAR_WILDCARD
                AND OwnerId =:UserInfo.getUserId()
            ORDER BY CreatedDate desc LIMIT 1
            ];
        if(campaigns.isEmpty()) {
            return null;
        }
        return campaigns[0];
    }

    public Campaign createCampaign(String campaignName) {
        Campaign campaign = new Campaign(Name = campaignName);
        insert campaign;
        return campaign;
    }
}