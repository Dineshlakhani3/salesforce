public class JsonController {
     public String jsonStr {get;set;}
    
    public JsonController(){
        jsonStr = prepareJSON();
    }
    
    private String prepareJSON() {
        String jsonInput = '{\n' +
    ' "description" :"An appliance",\n' +
    ' "accessories" : [ "powerCord", ' + 
      '{ "right":"door handle1", ' + 
        '"left":"door handle2" } ],\n' +
    ' "dimensions" : ' + 
      '{ "height" : 5.5 , ' + 
        '"width" : 3.0 , ' + 
        '"depth" : 2.2 },\n' +
    ' "type" : null,\n' +
    ' "inventory" : 2000,\n' +
    ' "price" : 1023.45,\n' +
    ' "isShipped" : true,\n' +
    ' "modelNumber" : "123"\n' +
    '}';
        
        Map<Id,Student__c> listOFStd = new Map<Id,Student__c>([Select id, FirstName__C, LastName__C from Student__C]);
      
        jsonStr = JSON.serialize(listOFStd);

        Boolean a= jsonStr.equals(jsonInput);
        System.assert(false,jsonInput+ '                   ??????????????????????????????????????     '+ jsonStr);
		return jsonStr;
       
    }
}