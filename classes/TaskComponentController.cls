public class TaskComponentController {
 public List<sObject> lstObjs {get;set;}
    public String query {get;set;}
    public Integer page {get;set;}
    public String Sortby {get;set;}
    public String error {get;set;}
    public List<string> lstFlds {get;private set;}
    public ApexPages.StandardSetController dataController{get; set;}
    
    public TaskComponentController(){
        page = 1;
        query = 'select id from account';
    }
    
    public void getObjectData(){
        try{
            lstFlds = new List<String>();
            lstObjs = Database.query(query);
            Set<string> setFlds = new Set<String>();
            for(integer i=0;i<lstObjs.size();i++){
                setFlds.addAll(lstObjs[i].getPopulatedFieldsAsMap().keySet());
            }
            lstFlds.addAll(setFlds);
            dataController=new ApexPages.StandardSetController(lstObjs);
            dataController.setPageSize(5);
            error='';
            page = 1;
        }catch(Exception e){
            error=e.getStackTraceString();
        }
    }
    
    public void goToPage(){
        try{
            dataController.setPageNumber(page);
        }catch(Exception e){
            dataController.setPageNumber(1);
        }
    }
    
    public List<sObject> getlistOfObject(){
        if(dataController==null){
            return null;
        }
        else{
            return  (List<sObject>) dataController.getRecords();
        }
    }
    
    public void sortData(){
        if(!query.contains('ORDER')){
            query+=' ORDER BY ' + Sortby;
        }else{
            query=query.substring(0,query.lastIndexOf(' '));
            query+=' ' + Sortby;                      
        }
        getObjectData();
    }
}