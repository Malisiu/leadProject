trigger LeadTrigger on Lead (after insert) {
    if(Trigger.isAfter && Trigger.isInsert && TriggerControl.isTriggerActive) {
        LeadHandler.handleAfterInsert(Trigger.new);
    }
}