public class CloneController {
    private Contact con;
    public CloneController(apexpages.standardcontroller std){
        this.con = (Contact)std.getrecord();
    }
    
    public PageReference cloneContact(){        
        Contact conClone = new Contact();
        conClone =con.clone();
        try{  
            insert conClone;
        }catch(Exception e){}
        return new PageReference('/apex/EditDeleteClone?id='+conClone.id);
    }
}