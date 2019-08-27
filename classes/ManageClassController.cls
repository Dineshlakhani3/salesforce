public class ManageClassController {
    
    public string clsId{get; set;}
    public Class__c Cls{get; set;}
    public Map<ID,Class__C> mapOfCls{get;set;} 
    
    public ManageClassController(){
        clsId = '';
        mapOfCls = new Map<ID,Class__C>([Select class__c.name,Class__c.Board__c,Class__c.ClassTeacher__c,Class__c.Custom_Status__c from class__C]);
    }
    
    
    public void classDetail(){
        this.cls = mapOfCls.get(clsId);
    }
    
    
    public void classDelete(){
        this.cls = mapOfCls.get(clsId);
        delete cls;
        mapOfCls.remove(clsId);
            clsId = '';
    }
    
    public Void saveClass(){
        try{
            update Cls;
            clsId = '';
        }catch(Exception e){
        }
    }
    
}