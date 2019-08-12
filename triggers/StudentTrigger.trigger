trigger StudentTrigger on Student__c (before insert, after insert, after delete) {
        set<Id> classIds = new Set<ID>();
    if(trigger.isDelete){
        for(Student__c student : trigger.old) {
                 classIds.add(student.class__c);
            }
    }else{
        for(Student__c student : trigger.new) {
                 classIds.add(student.class__c);
            }
    }
         List<class__c> cls = [select NumberOfStudents__c,MaxSize__c from class__c where Id IN :classIds];
           Map<Id,class__c> classMap = new Map<Id,class__c>();
           Map<Id,Decimal> clsStudent = new Map<Id,Decimal>();
    
           for(class__c c : cls){
                 if(!classMap.containsKey(c.Id)) {
                      classMap.put(c.Id,c);
                 }
                 if(!clsStudent.containsKey(c.Id)) {
                      clsStudent.put(c.Id,c.NumberOfStudents__c);
                 }
             }
    
      if(trigger.isbefore && trigger.isinsert){
           for(student__c stdcls : trigger.new){
             if(classMap.get(stdcls.class__c).NumberOfStudents__c >= classMap.get(stdcls.class__c).MaxSize__c) {
                     stdcls.addError('Class is full');
             }else{
                 clsStudent.put(stdcls.class__c,classMap.get(stdcls.class__c).NumberOfStudents__c+1);
             }
         }
      } else if(trigger.isafter && trigger.isinsert){
         for(student__c  std : trigger.new){
             if(clsStudent.containsKey(std.Class__c))
                 clsStudent.put(std.Class__c, clsStudent.get(std.Class__c)+1);
             else
                 clsStudent.put(std.Class__c, 1);
        }
    }else if(Trigger.isafter && Trigger.isDelete)
    {
        for (Student__c stent : Trigger.old)
        {   
            Decimal dCurrentCount ;         
            if(clsStudent.containsKey(stent.Class__c)) {
                dCurrentCount = clsStudent.get(stent.Class__c)-1;
                
            } else {
                dCurrentCount = 0;          
            }
            
            clsStudent.put(stent.Class__c,dCurrentCount);
        }               
    }

    if(clsStudent.size()>0){
        for(Class__C c:cls){
            c.MyCount__c = clsStudent.get(c.id);
        }
        update cls;
    }    
}