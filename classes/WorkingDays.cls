public class WorkingDays {
    public static Integer getDays(Datetime startDate, Datetime endDate){
    Integer i = 0;
    while (startDate < endDate) {
        if (startDate.format('E') != 'Sat' && startDate.format('E') != 'Sun') {
            i++;
        }
        startDate = startDate.addDays(1);
    }
	System.debug(i);
    return i;
    }
}