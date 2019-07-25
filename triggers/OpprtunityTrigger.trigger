trigger OpprtunityTrigger on Opportunity (after update) {
if (Trigger.isAFter  && Trigger.isUpdate) {
        OpprtunityHandler.updateOpportunity(Trigger.New);
        OpprtunityHandler.updateOpportunity(Trigger.Old,Trigger.New);
    }
}