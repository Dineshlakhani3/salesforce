global class CreateContactFrmEmail implements Messaging.InboundEmailHandler {
    
    global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email,
                                                           Messaging.InboundEnvelope envelope) 
    { Messaging.InboundEmailResult result = new Messaging.InboundEmailresult();
     
     String s = '';
     for (Messaging.Inboundemail.TextAttachment tAttachment : email.textAttachments) {
         s= String.valueOf(tAttachment.body);
     }
     system.debug(s);
     
     if(s!=''){
         Dom.Document docx = new Dom.Document();
         docx.load(s);
         dom.XmlNode xroot = docx.getrootelement() ;
         
         dom.XmlNode [] xrec = xroot.getchildelements() ;
         
         List<Contact> newcontact = new List<Contact>();
         
         for(Dom.XMLNode child : xrec)
         {
             Contact c = new Contact();
             c.Experience__c = 2;
             for (dom.XmlNode awr : child.getchildren() ) {
                 if (awr.getname() == 'Firstname') {
                     system.debug('Firstname' + awr.gettext());
                     c.Firstname = awr.gettext();
                 }  
                 
                 if (awr.getname() == 'lastname') {
                     c.lastname = awr.gettext();
                 }  
                 
                 
                 if (awr.getname() == 'Phone') {
                     c.Phone = awr.gettext();
                 }  
                 
                 if (awr.getname() == 'MobilePhone') {
                     c.MobilePhone = awr.gettext();
                 }  
                 
                 if (awr.getname() == 'otherPhone') {
                     c.otherPhone = awr.gettext();
                 }  
             }
             newcontact.add(c);
         }
         if(newcontact.size()>0){
         insert newcontact;
         }
     }                                                               
     result.success = true;
     return result;
    }
}