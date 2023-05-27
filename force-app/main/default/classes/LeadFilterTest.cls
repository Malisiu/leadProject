@isTest
private class LeadFilterTest {
    
    @TestSetup
    static void makeData(){
        TestDataFactory.createLeads(5, LeadHandler.FOOBAR_LEAD_SOURCE);
        TestDataFactory.createLeads(5, TestDataFactory.LEAD_LEAD_SOURCE);
    }

    @isTest
    private static void filterByLeadSourceTest() {
        List<Lead> leadsToTest = [SELECT Id, LeadSource FROM Lead];

        Test.startTest();
        LeadFilter leadFilter = new LeadFilter(leadsToTest);
        List<Lead> leadsToCheck = leadFilter.filterByLeadSource(LeadHandler.FOOBAR_LEAD_SOURCE);
        Test.stopTest();

        System.assertEquals(5, leadsToCheck.size());
        for(Lead lead : leadsToCheck) {
            System.assertEquals(LeadHandler.FOOBAR_LEAD_SOURCE, lead.LeadSource);
        }
    }

}