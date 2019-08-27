public class ParkLocator {
    public Static List<String> country(String con){
        ParkService.ParksImplPort park = new ParkService.ParksImplPort();
        System.debug(park.byCountry(con));
        return park.byCountry(con);
    }
}