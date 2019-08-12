public class RandomContactFactory {
    public static List<Contact> generateRandomContacts(integer n, String lstName){
        List<Contact> listOfContact=new List<Contact>();
        for(Integer i=0;i<n;i++){
            Contact newContact = new Contact(firstname='Test '+i, LastName = lstName, Experience__c = 2);
            listOfContact.add(newContact);
        }
        return listOfContact;
    }
}