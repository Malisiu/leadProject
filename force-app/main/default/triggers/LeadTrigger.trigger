trigger LeadTrigger on Lead (after insert) {
    if(Trigger.isAfter && Trigger.isInsert) {
        LeadHandler.handleAfterInsert(Trigger.new);
    }
}