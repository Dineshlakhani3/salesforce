public class NewCaseListController {
      
    public List<Case> getNewCases(){
        List<Case> caseList =Database.query('Select ID, CaseNumber from Case where status = \'New\' ');
        return caseList; 
                                            
    }
}