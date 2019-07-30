global class MailScheduler implements Schedulable{
    global void execute(SchedulableContext ctx){
        List<Opportunity> listOfOppty= [Select owner.email from Opportunity where LastModifiedDate < Last_n_days:30];
        List<String> accountMails = new List<String>();
        for(Opportunity opp : listOfOppty){
            accountMails.add(opp.owner.email);
        }  
        
        if(accountMails.size()>0)
            EmailManager.sendMail(accountMails, 'Modify' , 'Please modify your opprtunity');
}
}
