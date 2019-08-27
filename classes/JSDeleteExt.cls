public class JSDeleteExt {
    public ID recordId{get;set;}
    public List<Student__c> memList {get;set;}
    private ApexPages.StandardSetController standardController;
    private Set<Id> memIds = new Set<Id>();

    public JSDeleteExt(ApexPages.StandardSetController standardController){
        recordId = ApexPages.CurrentPage().getparameters().get('fcf');
        this.standardController = standardController;
        memList = new List<Student__c>();
        for (Student__c mem : (List<Student__c>)standardController.getSelected()){ 
            memIds.add(mem.Id);
        }
        memList = [SELECT FirstName__C,LastName__C FROM Student__c WHERE ID IN: memIds];
    }
    
    Public pageReference deleteRecords(){
        if(memList!=null && memList.size()>0)
            Delete memList;
        return backToList();
    }
    
    public pageReference  backToList(){
        PageReference pg = new PageReference('/a02?fcf='+recordId);
        return pg;
    }
    
    
}