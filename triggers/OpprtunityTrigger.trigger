trigger OpprtunityTrigger on Opportunity (after update, before update) {
if (Trigger.isAFter  && Trigger.isUpdate) {
       // OpprtunityHandler.updateOpportunity(Trigger.Old,Trigger.New);
    }
    
    if (Trigger.isBefore  && Trigger.isUpdate) {
       // OpprtunityHandler.updateOpportunity(Trigger.New);
    }
}