trigger OpprtunityTrigger on Opportunity (before update) {
if (Trigger.isBefore  && Trigger.isUpdate) {
        OpprtunityHandler.updateOpportunity(Trigger.New);
    }
}