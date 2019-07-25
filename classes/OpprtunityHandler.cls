public class OpprtunityHandler {
    public static void updateOpportunity(List<Opportunity> listOfOppt){
        set<Id> setOfOptIds = new set<Id>();
        for(Opportunity opt : listOfOppt){
            if(opt.BillToContact__c != '' && opt.Manager__c == ''){
                setOfOptIds.add(opt.Id);
            }
        }
        if(setOfOptIds.size()>0	){
            List<Opportunity> listOfOppoty = [select BillToContact__c, Manager__c from  opportunity where Id IN :setOfOptIds];
           
            for(Opportunity opt : listOfOppoty){
                opt.Manager__c = opt.BillToContact__c;
            }
           update listOfOppoty;
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