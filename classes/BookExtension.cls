public with sharing class BookExtension {

    private ApexPages.StandardController stdController;
    
    public BookExtension (ApexPages.StandardController ct) {
        this.stdController = ct;
        if( ! Test.isRunningTest()) {
            // You can't call addFields() in a test context, it's a bug
            stdController.addFields(accessibleFields);
        }
    }
    
    public List<String> accessibleFields {
        get {
            if (accessibleFields == null) {
                Map<String, Schema.SobjectField> fields = 
                    Schema.SobjectType.Book__c.fields.getMap();
        
                Set<String> availableFieldsSet = new Set<String>();
                for (String s : fields.keySet()) {
                    if (fields.get(s).getDescribe().isAccessible() 
                        && fields.get(s).getDescribe().isCustom()
                    ){
                            availableFieldsSet.add(s.toLowerCase());
                            if(Test.isRunningTest()) System.debug('Field: ' + s);
                    }
                }
                accessibleFields = new List<String>(availableFieldsSet);
            }
            return accessibleFields;
        }
        private set;
    }
}