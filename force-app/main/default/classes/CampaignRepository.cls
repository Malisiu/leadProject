public with sharing class CampaignRepository {
    public static final String FOOBAR_WILDCARD = '%Foobar%';

    public Campaign findRecentCampaign() {
        Datetime thirtyMinutesAgo = System.now().addMinutes(-5);
        List<Campaign> campaigns = [SELECT Id, Name
                                    FROM Campaign
                                    WHERE CreatedDate >= :thirtyMinutesAgo
                                    AND Name LIKE :FOOBAR_WILDCARD
                                    ORDER BY CreatedDate desc LIMIT 1];
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