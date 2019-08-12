@isTest
public class BookExtensionTest {
    
    public static testMethod void testBookExtension() {

        // Create a book to test with
        Book__c book = new Book__c();
        book.Author__c = 'Harry Lime';
        insert book;
        
        Test.startTest();
        
        // Add the page to the test context
        PageReference testPage = Page.booksView;
        testPage.getParameters().put('id', String.valueOf(book.Id));
        Test.setCurrentPage(testPage);
        
        // Create a controller for the book
        ApexPages.StandardController sc = new ApexPages.StandardController(book);
        
        // Real start of testing BookExtension
        // BookExtension has only two methods; to get 100% code coverage, we need
        // to call the constructor and get the accessibleFields property
        
        // Create an extension with the controller
        BookExtension bookExt = new BookExtension(sc);
        
        // Get the list of accessible fields from the extension
        Set<String> fields = new Set<String>(bookExt.accessibleFields);
        
        Test.stopTest();
        
    }
    
}