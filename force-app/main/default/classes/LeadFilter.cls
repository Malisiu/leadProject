public with sharing class LeadFilter {
    List<Lead> leads;

    public LeadFilter(List<Lead> leads) {
        this.leads = leads;
    }

    public List<Lead> filterByLeadSource(String leadSource) {
        List<Lead> filtredLeads = new List<Lead>();
        for(Lead lead : this.leads) {
            if(lead.LeadSource == leadSource) {
                filtredLeads.add(lead);
            }
        }
        return filtredLeads;
    }
}