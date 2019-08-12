public class ClassEditController {
    
    public string clsId{get; set;}
    public Class__c Cls{get; set;}
    
    
    ApexPages.StandardSetController controller;
    public ClassEditController(ApexPages.StandardSetController controller){
        this.controller=controller;
    }
    
    public void accountDetail(){
        List<class__C> editCls =[select class__c.name,Class__c.Board__c,Class__c.ClassTeacher__c,Class__c.Custom_Status__c from class__C where id =:clsId];
        for(class__c cls :editCls){
            this.cls = cls;
        }
    }
    
    public PageReference saveClass(){
        try{
        update Cls; 
        }catch(Exception e){
        }
        PageReference pr=new PageReference('/'+cls.id);
        return pr;
    }
    
}