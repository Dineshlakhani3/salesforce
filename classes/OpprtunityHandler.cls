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
}