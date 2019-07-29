public class OpprtunityHandler {
    public static void updateOpportunity(List<Opportunity> listOfOppt){
        Set<Id> setOfIds = new Set<Id>();
        for(Opportunity opt : listOfOppt){
            if(opt.BillToContact__c != null && opt.Manager__c == null){
                setOfIds.add(opt.Id);
            }
        }
        Map<Id, Id> idsMap = new Map<Id,Id>();
        if(setOfIds.size()>0){
             list<Opportunity> OpptyLisst = new List<Opportunity>([Select id, BillToContact__r.AccountId from Opportunity where id IN : setOfIds]);
            for(Opportunity opt : OpptyLisst){
               idsMap.put(opt.Id, opt.BillToContact__r.AccountId);
            }
        } 
        
        for(Opportunity opt : listOfOppt){
            opt.Manager__c = idsMap.get(opt.Id);            
        }
        
    }
    
    public static void updateOpportunity(List<Opportunity> oldListOfOppt,List<Opportunity> newListOfOppt){
        set<Id> setOfOptIds = new set<Id>();
        set<Id> setOfOptUpdateIds = new set<Id>();
        
        for(Opportunity opt : oldListOfOppt){
            if(opt.StageName != 'Closed Won' && opt.StageName != 'Closed Lost'){
                setOfOptIds.add(opt.Id);
            }
        }
        
        for(Opportunity opt : newListOfOppt){
            if(opt.StageName == 'Closed Won' || opt.StageName == 'Closed Lost'){
                if(setOfOptIds.contains(opt.Id))
                setOfOptUpdateIds.add(opt.Id);
            }
        }
        
        
        if(setOfOptIds.size()>0	){
            List<Opportunity> listOfOppoty = [select CloseDate from  opportunity where Id IN :setOfOptUpdateIds];
            for(Opportunity opt : listOfOppoty){
                opt.CloseDate = System.today();
            }
           update listOfOppoty;
        }   
    }
}
