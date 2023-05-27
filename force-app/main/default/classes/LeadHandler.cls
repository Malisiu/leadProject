public with sharing class LeadHandler {
    public static final String FOOBAR_LEAD_SOURCE = 'Foobar';

    public static void handleAfterInsert(List<Lead> newLeads) {
        LeadFilter leadFilter = new LeadFilter(newLeads);
        List<Lead> foobarLeads = leadFilter.filterByLeadSource(FOOBAR_LEAD_SOURCE);
        //FoobarLeadService.handleNewLeads(foobarLeads);
        if(!foobarLeads.isEmpty()) {
            LeadFoobarCampaignInjection_Srv.getNewInstance().processFoobarLeads(foobarLeads);
        }
    }
}