public with sharing class LeadRepository {
    public List<Lead> findLeadsByIds(List<Id> leadIds) {
        return [SELECT Id, Owner.Name FROM Lead WHERE Id IN :leadIds];
    }
}