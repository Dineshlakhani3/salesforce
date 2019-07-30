public class PairClassStudent {
    public static Map<ID, Set<id>> getDataClassAndStudentID(){
      Map<ID, Set<id>> m = new Map<ID, Set<id>>();
        for(Student__c std : [Select id, class__r.id from student__c]){
            Set<id> setOfStdIDS = new set<ID>();
            if(m.containsKey(std.class__r.id)){
               setOfStdIDS.addAll(m.get(std.class__r.id));     
            }
            setOfStdIDS.add(std.id);
            m.put(std.class__r.id,setOfStdIDS);
        }        
        System.debug(m);
        return m;
    }
}
