public class AccountController {
    public Integer count{get; set;}
    public String billingCity{get; set;}
    public String billingState{get; set;}
    public String billingCountry{get; set;}
    public ApexPages.StandardSetController controller
    {
        get
        {
            if( controller == null )
            {
                List<Account> accountlist = new List<Account>();
                return new ApexPages.StandardSetController(accountlist);
            }
            else
                return controller;
        }
        set;
    }
    
    public Pagereference getAccountsList() {
        if(count==null || count==0)
            count=10;
        String query= 'SELECT Name, billingCity,  BillingState, BillingCountry FROM Account'; 
        if(billingCity!='' || billingState!='' || billingCountry!='')
            query+=' where ';
        if(billingCity!=null && billingCity!=''){
            query+='billingCity like \''+billingCity+'%\'';
            if(billingState!='' || billingCountry!='')
                query+=' AND ';
        }
        if(billingState!=null && billingState!=''){
            query+='billingState like \''+billingState+'%\'';
            if(billingCountry!='')
                query+=' AND ';
        }
        if(billingCountry!=null && billingCountry!=''){
            query+='billingCountry like \''+billingCountry+'%\'';
        }
        
        controller=new ApexPages.StandardSetController(Database.getQueryLocator(query));
        controller.setPageSize(count);
        return null;
    }
    
    public List<Account> getlistOfAccounts(){
        return  (List<Account>) controller.getRecords();
    }
    
}