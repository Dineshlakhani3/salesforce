public class StudentPdfController {
    
    ApexPages.StandardController cont;
    
    public StudentPdfController(ApexPages.StandardController controller){
        cont=controller;
    }
    
   public PageReference createPdf(){
       ID recordId = (ID) ApexPages.CurrentPage().getparameters().get('id');
        PageReference defaultPage = new PageReference('/apex/PdfDemo'); 
        defaultPage.getParameters().put('id',recordId);
        Blob pageData; 
        if(!Test.isRunningTest()){
            pageData = defaultPage.getContentAsPDF();
        } else {
            pageData = Blob.valueOf('This is a Student Pdf.');
        }
       
       List<Attachment> preAtt =[select ParentId from Attachment where ParentId = :recordId];
       if(preAtt.size()>0){
           delete preAtt;
       }
       
        Attachment att = new Attachment(
            					ParentId=recordId,
            					Body=pageData,
            					Name=recordId+'_Detail' + '.pdf'
        					);
       	insert att;
        return null;
    }
}