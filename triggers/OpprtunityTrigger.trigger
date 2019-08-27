trigger OpprtunityTrigger on Opportunity (after update, before update) {
    if (Trigger.isBefore  && Trigger.isUpdate) { 
        OpprtunityHandler.updateOpportunity(Trigger.New);
        OpprtunityHandler.updateStatus(Trigger.oldMap, Trigger.New);
    }
}