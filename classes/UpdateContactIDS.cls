public class UpdateContactIDS {
    public static void updateID(String contactID){
        List<Contact> loc=[select AccountId from Contact where id = :contactID];
        Set<ID> setOfAcctIDS=new Set<ID>();
        for(Contact c: loc){
            setOfAcctIDS.add(c.AccountId);
        }
        
        Map<Id,Account> acctWhichIsNullMap =new Map<Id,Account>();
        List<Account> acctWhichIsFill=new List<Account>();
        
        List<Account> accts=[Select id, ContactIDs__c from Account where id in :setOfAcctIDS];
        
        for(Account a : accts){
            if(a.ContactIDs__c == null){
                acctWhichIsNullMap.put(a.Id, a);
            }else{
                acctWhichIsFill.add(a);
            }
        }
        List<Account> acctsUpdate=new List<Account>();
        
        Map<Id, String> mapOfModifiedValues = new Map<Id,String>();
        List<Contact> listOfContactID = [Select id, AccountID from contact where Accountid IN : acctWhichIsNullMap.keySet()];
        if(listOfContactID.size()>0){
            for(Contact ctID : listOfContactID){
                String ids ='';
                if(mapOfModifiedValues.containsKey(ctID.AccountID)){
                    ids=mapOfModifiedValues.get(ctID.AccountID);
                }
                ids+=ctID.id+',';
                mapOfModifiedValues.put(ctID.AccountID, ids);
            }
        }
        
        for(Account acct:acctWhichIsNullMap.values()){
                    acct.ContactIDs__c= mapOfModifiedValues.get(acct.id);
                    acctsUpdate.add(acct);
        }
        
        for(Account fillAcct:acctWhichIsFill){            
            String str=fillAcct.ContactIDs__c;
                String[] existIds= str.split(','); 
                Set<String> setOFIds=new Set<String>(existIds);
                if(!setOFIds.contains(contactID)){
                str += contactID + ',';
                fillAcct.ContactIDs__c = str ;
                acctsUpdate.add(fillAcct);
              }
        }
        if(acctsUpdate.size()>0){
        	update acctsUpdate;
        }
    }
}