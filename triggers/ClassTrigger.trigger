trigger ClassTrigger on Class__c (before delete, after update) {
    if(Trigger.isbefore){
        if(Trigger.isdelete){
            map<id,class__C> mapOfStd  = new Map<id,class__c>([select id,(select id from students__r where sex__c = 'female') from class__c where id IN :Trigger.Old]);
            for(Class__C c : Trigger.old)
            {   
                List<student__c> std = mapOfStd.get(c.id).Students__r;
                if(std.size()>1){
                    c.addError('Not allowed to delete Class');
                }
            }
        }
    }     
    if(Trigger.isafter){
        if(Trigger.isupdate){
            Set<ID> setOFClassID = new Set<ID>();
            for(Class__C c: Trigger.new)
            {
                if(c.Custom_Status__c == 'Reset'){
                    setOFClassID.add(c.id);
                }
            }
            Delete [select id from student__c where class__r.id in :setOFClassID];
        }
    } 
}