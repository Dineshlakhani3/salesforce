trigger accountTestTrigger2 on Account (before delete, before insert, before update) {
   /* List<Opportunity> oppty = [select id, name, closedate, stagename from Opportunity
                               where accountId IN :Trigger.newMap.keySet() and (StageName='Closed - Lost' OR StageName='Closed - Won')];
    
    Map<Id,Opportunity> mapOfOppty = new Map<Id,Opportunity>();
    for(Opportunity o: oppty){
        if(!mapOfOppty.containsKey(o.accountid))
            mapofOppty.put(o.accountid, o);
    }
    
    for(Account a : Trigger.new){
        if(mapOfOppty.containsKey(a.id)){
            if(mapOfOppty.get(a.id).StageName == 'Closed - Lost')
                System.debug('Do more logic here...');
            else
                System.debug('Do more logic here...');
        }
    }  */
}