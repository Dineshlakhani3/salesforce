trigger TeacherTrigger on Teach__c (before insert, before update) {
        for(Teach__c t : Trigger.New){
        if((t.Subject__c).contains('Hindi')){
            t.addError('Please not Insert/Update hindi subject.');
        }
   }
}