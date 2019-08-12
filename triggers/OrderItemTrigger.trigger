trigger OrderItemTrigger on OrderItem__c (After insert) {
    if(Trigger.isAfter && Trigger.isInsert){
        Map<id,Decimal> mapOfqty =  new Map<id,Decimal>();
        for(OrderItem__c odr : Trigger.New){
            if(odr.Product2ID__c != null)
                mapOfqty.put(odr.Product2ID__c,odr.qty__c);
        }
        if(mapOfqty.size()>0){
            List<Product2> listOfProd =[select id, quantity_Available__c from Product2 where id IN :mapOfqty.keySet()];
            for(Product2 oItem : listOfProd){
                if(mapOfqty.containsKey(oItem.id))
                oItem.quantity_Available__c -= mapOfqty.get(oItem.id);
            }
            if(listOfProd.size()>0)
                update listOfProd;
        }
    }
}