@isTest
public class TestRestrictContactByName {
@isTest
    public static void checkName(){
        Contact newContact = new Contact(firstname='Dinesh', LastName = 'INVALIDNAME', Experience__c = 2);
        Test.startTest();
        insert newContact;
        Test.stopTest();
    }
}