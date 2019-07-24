public class UpdateContactIDS {
    public static void updateID(String i){
        List<Account> accts=[select id, ContactIDs__c from account];
        List<id> idWhichIsNull=new List<ID>();
        List<id> idWhichIsFill=new List<ID>();
        
        for(Account a : accts){
            if(a.ContactIDs__c == null){
                idWhichIsNull.add(a.id);
            }else{
                idWhichIsFill.add(a.id);
            }
        }
        
        List<Account> acctsUpdate=new List<Account>();
        for(ID inull:idWhichIsNull){
            Account acct=new Account();
            List<Contact> listOfContactID = [Select id from contact where Accountid = :inull];
                if(listOfContactID.size()>0){
               	  String ids ='';
                	for(Contact ctID : listOfContactID){
                    ids=ids+ ctID.id +  ',';
                	}  
                    acct.Id = inull;
                    acct.ContactIDs__c= ids;
                    acctsUpdate.add(acct);
                }
        }
        for(ID ifill:idWhichIsFill){
             List<Account> listOfContactID = [Select ContactIDs__c from account where id = :ifill];
            String str=listOfContactID[0].ContactIDs__c;
                String[] existIds= str.split(','); 
                Set<String> setOFIds=new Set<String>(existIds);
                if(!setOFIds.contains(i)){
                    str = str + i + ',';
                Account acct=new Account();
                acct.id=ifill;
                acct.ContactIDs__c = str ;
                acctsUpdate.add(acct);
              }
        }
        update accts;
    }
}