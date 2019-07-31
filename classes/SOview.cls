public class SOview {
    public static void showSobjects(){
        List<string> SObjectList = new List<string>();
        
        for(Schema.SObjectType objTyp : Schema.getGlobalDescribe().Values()){
            String name = objTyp.getDescribe().getName();
                   SobjectList.add(name);
                   System.debug( 'Object Name : ' + name);
        }
                   System.debug( 'All sObjects : ' + SObjectList);
    }
}
