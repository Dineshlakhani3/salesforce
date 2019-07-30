public class SOview {
    public static void pd(){
     Map<String, Schema.SObjectType> gd = Schema.getGlobalDescribe();
        System.debug(gd);
    }
}
