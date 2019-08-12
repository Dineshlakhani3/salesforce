@isTest
public class TestVerifyDate {
@isTest
    public static void checkDate(){
        VerifyDate.CheckDates(System.today(),System.today().addDays(20));
       	VerifyDate.CheckDates(System.today(),System.today().addDays(31));
    }
}