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
    
    public static void updateStatus(Map<ID,Opportunity> mapOfOpt,List<Opportunity> newListOfOppt){
        if(mapOfOpt.size()>0){
            List<String> adrsMails = new List<String>();
            for(Opportunity opt : newListOfOppt){
                // for status
                if(mapOfOpt.containsKey(opt.Id)){
                    if(opt.DeliveryInstallationStatus__c != mapOfOpt.get(opt.Id).DeliveryInstallationStatus__c){
                        adrsMails.add([select owner.email from opportunity where id = :opt.id][0].owner.email);
                    }
                }
                //for stage
                if(mapOfOpt.get(opt.Id).StageName != 'Closed Won' && mapOfOpt.get(opt.Id).StageName != 'Closed Lost'){
                    if(opt.StageName == 'Closed Won' || opt.StageName == 'Closed Lost')
                        opt.CloseDate = System.today();
                }
            }
            if(adrsMails.size()>0){
               // System.assert(false,adrsMails.get(0));
                  EmailManager.sendMail(adrsMails);
            }
        } 
    }
}