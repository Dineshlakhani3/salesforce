public class ContactComponentController {
 @AuraEnabled
    public static List<contact> getContact() {
        return [SELECT firstname, lastname, email, phone, fax, Experience__c FROM contact];
    }
    
    @AuraEnabled
    public static contact saveContact(contact con) {
        System.debug(con);
        insert con;
        return con;
    }
}