public class AnimalLocator {
    public static string getAnimalNameById(Integer animalid){
        String name= 'Index Not Found';
        Http http = new Http();
        List<object> animals = new List<object>();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals/'+animalid);
        request.setMethod('GET');
        HttpResponse response = http.send(request);        
        if (response.getStatusCode() == 200) {
            Map<String, Object> result = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
            animals = (List<Object>) result.get('animal');
            System.debug(animals);
        }
        if (animals.size() > 0 && animals != NULL && animalid < animals.size()) {
			name = (String) animals.get(animalid);
		}
        return name;
    }
}