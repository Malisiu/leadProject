@isTest
private class LeadRepositoryTest {
    @TestSetup
    static void makeData(){
        TestDataFactory.createLeads(5, TestDataFactory.LEAD_LEAD_SOURCE);
    }

    @isTest
    private static void findLeadsByIds() {
        List<Lead> leads = [SELECT Id FROM Lead];
        List<Id> leadIds = new List<Id>();
        for(Lead lead : leads) {
            leadIds.add(lead.Id);
        }

        LeadRepository leadRepository = new LeadRepository();
        List<Lead> leadsToCheck = leadRepository.findLeadsByIds(leadIds);

        System.assertEquals(leadIds.size(), leadsToCheck.size());
    }

}