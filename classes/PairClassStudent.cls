public class PairClassStudent {
    public static Map<String, List<Student__c>> getDataClassAndStudentID(){
      Map<String, List<Student__c>> m = new Map<String, List<Student__c>>();
        List<Class__c> c =  [select Name, ID from class__c];
          for(Integer i=0;i<c.size();i++){
              List<student__c> students=[SELECT ID from student__c];
              m.put(c[i].Name,students);
          }
        System.debug(m);
        return m;
    }
}