public class GetStudents {
  public static List<student__c> getStudentsFromClassID(String cid)
  {
      List<student__c> students=[SELECT Firstname__C, Lastname__c from student__c where class__c = :cid];
      system.debug('students '+students);
      
      return students;
  }
}