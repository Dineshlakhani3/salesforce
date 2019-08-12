global  class wrapper{
    public Boolean selected{get;set;}
    public Decimal qty{get;set;}
    public Decimal total{get;set;}
    public Product2 productRecord {get;set;}
    
    global wrapper(Product2 productRecord, Boolean selected, Decimal qty) {
        this.qty=qty;
        this.productRecord = productRecord;
        this.selected = selected;
    }
}