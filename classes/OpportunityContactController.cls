public class OpportunityContactController {
    public ID recordId{get;set;}
    public List<Contact> conList{get;set;}
    public List<Opportunity> oppList{get;set;}
    public String ConId;
    public OpportunityContactController(){
        conList = new List<Contact>();
        oppList = new List<Opportunity>();
        recordId = ApexPages.CurrentPage().getparameters().get('id');
        oppList = [select manager__r.id from opportunity where id = :recordId];
        set<ID> accSet=new set<ID>();
        for(Opportunity opp : oppList){
            accSet.add(opp.manager__r.id);
        }
        if(accSet.size()>0){
            conList = new list<Contact>([SELECT id,FirstName,LastName FROM COntact WHERE AccountId in :accSet]);
        }
    }
    
    public List<SelectOption> getItems() {
        List<SelectOption> options = new List<SelectOption>();
        for(Contact con : conList){
            options.add(new SelectOption(con.id,con.LastName));    
        }
        return options; 
    }
    
    public pageReference saveOpp(){
        if(conId != null && recordId != null){
            try{
                update new Opportunity(id=recordId, BillToContact__c=conId);
            }catch(Exception e){}
            PageReference pg = new PageReference('/'+recordId);
            return pg;
        }else{
            return null;
        }
    }
    
    public pageReference  clearOpp(){      
        try{
            if(recordId != null){
                update new Opportunity(id=recordId, BillToContact__c=conId);
            }
            
        }catch(Exception e){}
        PageReference pg = new PageReference('/'+recordId);
        return pg;
    }
    
    
    public pageReference  cancelOpp(){
        PageReference pg = new PageReference('/'+recordId);
        return pg;
    }
    
    public String getConId() {
        return ConId;
    }
    
    public void setConId(String ConId) 
    { this.ConId = ConId; }
}