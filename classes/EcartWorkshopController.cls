public class EcartWorkshopController {
    public List<Order__c> totalOrders{get; set;}    
    public List<Product2> fechedProduct{get; set;}
    public List<Product2> product{get; set;}
    public string search{get;set;}
    public String proId{get;set;}
    public Decimal total{get;set;}
    public Integer invoiceNo{get;set;}
    public List<wrapper> wrapperRecordList{get;set;}
    public Map<Id, wrapper> mapHoldingSelectedRecords{get;set;}
    public Boolean mainview{get;set;}
    Public Integer pageNo{get;set;}
    public integer selectedSize { get { 
        if(mapHoldingSelectedRecords!=null)
            return mapHoldingSelectedRecords.size( ); 
        else
            return 0;
    } }
    
    public EcartWorkshopController(){    
        totalOrders = Database.query('select name,Order_Price__c,status__c from Order__c');
        invoiceNo=1;
        for(Order__c o : totalOrders){
            invoiceNo = integer.valueof(o.name)+1;
        } 
        orderController=new ApexPages.StandardSetController(totalOrders);
        orderController.setPageSize(8);
        mapHoldingSelectedRecords = new Map<Id, wrapper>();
        mainview=true;
    } 
    
    public List<Order__c> getlistOfOrder(){
        return  (List<Order__c>) orderController.getRecords();
    }
    
    public void showProduct(){
        fechedProduct = Database.query('select name,ProductCode,Description,Price_per_unit__c,quantity_Available__c from product2 where quantity_Available__c>0');
        product= fechedProduct;
        setCon=new ApexPages.StandardSetController(product);
        setCon.setPageSize(2);
        init();
    }
    
    public void init() {
        wrapperRecordList =  new List<wrapper>();
        maxQtyReachError='';
        for (Product2 pro : (List<Product2>)setCon.getRecords()) {
            if(mapHoldingSelectedRecords != null && mapHoldingSelectedRecords.containsKey(pro.id)){
                try{
                    wrapper wr = mapHoldingSelectedRecords.get(pro.id);
                    if(wr.qty<=0){
                        wrapperRecordList.add(new wrapper(pro, true, 0));
                        maxQtyReachError='Quantity can not be Zero or nagetive';
                    }
                    else if(wr.qty>wr.productRecord.quantity_Available__c){
                        wrapperRecordList.add(new wrapper(pro, true, wr.productRecord.quantity_Available__c));
                        maxQtyReachError+=wr.productRecord.name + ' is out of stock, maximum quantity is '+ wr.productRecord.quantity_Available__c +'.<br/>';
                    }else
                    {
                        wrapperRecordList.add(new wrapper(pro, true, wr.qty));
                    }
                }catch(Exception e){
                    wrapperRecordList.add(new wrapper(pro, true, 1));
                }
                
            }
            else{
                wrapperRecordList.add(new wrapper(pro, false, 0));
            }
        }
    }
    
    Public string maxQtyReachError{get;set;}
    
    public void checkout(){
        mainview=false;
        total=0;
        maxQtyReachError='';
        for(wrapper selItem : mapHoldingSelectedRecords.values()){
            try{
                if(selItem.qty>selItem.productRecord.quantity_Available__c){
                    maxQtyReachError+=selItem.productRecord.name + ' is out of stock, maximum quantity is '+ selItem.productRecord.quantity_Available__c +'.<br/>';
                    mainview=true;
                }
                selItem.total = selItem.productRecord.Price_per_unit__c * selItem.qty;
            }catch(Exception e){
                selItem.total = selItem.productRecord.Price_per_unit__c * 1;
            }
            total+=selItem.total;
        }
    }
    
    public PageReference placeOrder(){
        try{
            Order__c order=new Order__c(Order_Price__c	= TOtal);
            insert order;
            
            List<OrderItem__c> orderItems =new List<OrderItem__c>();
            for(wrapper selItem : mapHoldingSelectedRecords.values()){
                OrderItem__c item=new OrderItem__c();
                item.OrderId__c = order.id;
                item.Product2ID__c = selItem.productRecord.id;
                item.Total_Price__c = selItem.total;
                item.qty__c = selItem.qty;
                item.Order_Date__c = date.today();
                item.Unit_Price__c= selItem.productRecord.Price_per_unit__c;
                orderItems.add(item);
            }
            if(orderItems.size()>0){
                insert orderItems;
            }
        }catch(Exception e){
            
        }
        return new PageReference('https://c.ap15.visual.force.com/apex/EcartWorkshop?core.apexpages.request.devconsole=1');
    }
    
    public ApexPages.StandardSetController setCon {
        get {
            if(setCon == null) {
                List<Product2> products = new List<Product2>();
                return new ApexPages.StandardSetController(products);
            }
            return setCon;
        }
        set;
    }
    
    public ApexPages.StandardSetController orderController
    {
        get
        {
            if( orderController == null )
            {
                List<Order__c> orderlist = new List<Order__c>();
                return new ApexPages.StandardSetController(orderlist);
            }
            else
                return orderController;
        }
        set;
    }
    
    
    public Boolean hasNext {
        get {
            return setCon.getHasNext();
        }
        set;
    }
    
    public Boolean hasPrevious {
        get {
            return setCon.getHasPrevious();
        }
        set;
    }
    
    
    public Integer pageNumber {
        get {
            return setCon.getPageNumber();
        }
        set;
    }
    
    /* Public Integer getTotalPages(){
Decimal totalSize = setCon.getResultSize();
Decimal pageSize = setCon.getPageSize();
Decimal pages = totalSize/pageSize;
return (Integer)pages.round(System.RoundingMode.CEILING);
} */
    
    
    public void first() {
        setCon.first();
        init();
    }
    
    public void last() {
        setCon.last();
        init();
    }
    
    public void previous() {
        setCon.previous();
        init();
    }
    
    public void next() {
        setCon.next();
        init();
    }
    
    public void updateSearchItemsMap() {
        for(wrapper wrp : wrapperRecordList){
            if(wrp.selected){
                wrp.qty=1;
                mapHoldingSelectedRecords.put(wrp.productRecord.id, wrp);
            }
            if(wrp.selected == false && mapHoldingSelectedRecords.containsKey(wrp.productRecord.id)){
                mapHoldingSelectedRecords.remove(wrp.productRecord.id);
            }
        }
    }
    
    public void removeItemsMap() {
        for(wrapper wrp : wrapperRecordList){
            if(wrp.productRecord.id == proId)
                wrp.selected=false;
        }
        
        if(mapHoldingSelectedRecords.containsKey(proId)){
            mapHoldingSelectedRecords.remove(proId);
        }
        init();
    }
    
    public void dosearch(){
        if(search==''){
            product = fechedProduct;
            setCon=new ApexPages.StandardSetController(fechedProduct);
          //  system.assert(false,pageNo);
            setCon.setPageNumber(pageNo);
            setCon.setPageSize(2);
            init();
            pageNo=null;
        }else{
            if(pageNo==null)
            pageNo=setCon.getPageNumber();
            
            product=new List<Product2>();
            for(Product2 pro: fechedProduct){
                if((pro.name).toLowerCase().contains(search.toLowerCase()))
                    product.add(pro); 
            }
            setCon=new ApexPages.StandardSetController(product);
            
            setCon.setPageSize(2);
            init();
        }
    }
    
}