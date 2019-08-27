trigger StudentTrigger on Student__c (after insert, after update) {
    if(trigger.isAfter && (trigger.isInsert || trigger.isUpdate)){
        List<Student__C> listOfStudent = [Select id,Class__c from student__C where id Not In :Trigger.New];
        Map<Id,Decimal> mapCount = new Map<Id,Decimal>();
        set<Id> classIds = new Set<ID>();
        for(Student__C std : listOfStudent){
            if(mapCount.containsKey(std.Class__c)){
                mapCount.put(std.Class__c, mapCount.get(std.Class__c)+1);
            }else{
                mapCount.put(std.Class__c, 1);
            }
        }
        for(student__c stdcls : trigger.new){
                classIds.add(stdcls.Class__c);
            if(mapCount.get(stdcls.class__c) >= stdcls.class__r.MaxSize__c) {
                stdcls.addError('Class is full');
            }else{
                mapCount.put(stdcls.Class__c, mapCount.get(stdcls.Class__c)+1);
            }
        }
        
        if(classIds.size()>0){
            List<Class__C> cls = [Select id,MyCount__C from Class__c where id In :classIds];
            for(Class__C c :  cls){
                c.MyCount__c = mapCount.get(c.id);
            }
            update cls;
        }    
    }
}