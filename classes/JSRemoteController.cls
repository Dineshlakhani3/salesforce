public class JSRemoteController {
   @RemoteAction
    public static string deleteStudents(String urlString){
        String[] stdIDs = urlString.substring(4).split('%2C');
        List<String> listOfIDs = new List<String>(stdIDs);
        List<Student__c> listofStd = [select id from student__C where id In :listOfIDs];
        delete listofStd;
        return 'Student Deleted Successfully';
    }
    
    
   @RemoteAction
    public static string goBack(String back){
        return back;
    }
}