public class SOview {
    public static void pd(){
        List<org__c> l=[select id from org__c];
            System.debug(l);
    }

}