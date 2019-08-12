public class paramtest {
    public string query { get; set;}
    
    public void testdirect(){
        system.debug(query);
    }
    public void testinput(){
        query = apexpages.currentPage().getParameters().get('inpval');
        system.debug(query);
    }
}