/**
 * This Class is for Testing Of Alphabetical search on the Related Contact Page
*/
/**
 * 1st Scenario : Record Present with that alphabet
 * 2nd Scenario : Record Not Present With that Alphabet
 * 3rd Scenario : Passing Null Alphabet
 * 4th Scenario : Passing 'ALL' string
 * 5th Scenario : check All Related contacts are getting
 */
@isTest
public class TestAlphaSearch 
{
    public class DataFactory
    {
        /**
         * This Method Creates Records Of Contacts
         * @param Integer No Of Records
         * Return Type List Of Contacts
		 */
        public List<Account> createAccounts(Integer numberOfAccounts)
        {
            /**
             * This Method creates Accounts
             * @param integer
             * Return Type List of Accounts
		     */
            List<Account> accList=new List<Account>();
            for(integer i=1 ; i<=numberOfAccounts ; i++)
            {
                 Account acc=new Account( 
            						name='gClass'+i,
            						SLA__c='Gold',
            						SLASerialNumber__c='5896',
            						SLAExpirationDate__c=Date.newInstance(2017,2,2)
        						);
                accList.add(acc);
            }
            return accList;
        }
        /**
         * This Method creates Contacts
         * @param integer
         * Return Type List of Contacts
		 */
        public  List<Contact> createContacts( Integer numberOfContacts)
        {
            List < Contact > conList = new List < Contact >();
            List<Account> accList=createAccounts(1);
            insert accList[0];
         	for (Integer i = 1 ; i <= numberOfContacts ; i++) 
        	{
          		Contact newCon = new Contact(
                						 		FirstName = 'Ali'+i,
                    							LastName ='l'+i,
                                         		Email = 'akshay@gmail' + i + '.com',
                    							AccountId=accList[0].Id
                                        	);

            	conList.add(newCon);
        	} 
            return conList;
        }
     }
   /**
 	 * Records available starting with this Alphabet
 	 * @param NA
 	 * Return Type NA
	 */	
    public static testmethod void checkForValidAlpha()
    {
        DataFactory df=new DataFactory();
        AlphaSearchController obj=new AlphaSearchController();
     	List<Contact> testContactList=df.createContacts(500);
        System.debug('testContactList '+testContactList);
        Insert testContactList;
        System.debug('testContactList[0] '+testContactList[0].name);
        obj.contactList=testContactList;
        System.debug(obj.contactList);
        PageReference pg=page.AccountPagePM5_2;
        pg.getParameters().put('paramvar','A');
        Test.setCurrentPage(pg);
        obj.showRecords();
       	system.assertEquals(testContactList.size(),obj.showContactList.size());
    }
 	/**
 	 * Negative Scenario : Records not available starting with this Alphabet
 	 * @param NA
 	 * Return Type NA
	 */	   
    public Static testmethod void checkForInvalidAlpha()
    {
     	DataFactory df=new DataFactory();
        AlphaSearchController obj=new AlphaSearchController();
     	List<Contact> testContactList=df.createContacts(500);
        System.debug(testContactList);
        Insert testContactList;
        obj.contactList=testContactList;
        System.debug(obj.contactList);
        PageReference pg=page.AccountPagePM5_2;
        pg.getParameters().put('paramvar','B');
        Test.setCurrentPage(pg);
        obj.showRecords();
       	system.assertEquals(0,obj.showContactList.size());   
    }
	/**
	 * This Method Search For Records with null value
	 * @param NA
	 * Return Type NA
	 */
 	public static testmethod void checkforblank()
    {
     	DataFactory df=new DataFactory();
        AlphaSearchController obj=new AlphaSearchController();
     	List<Contact> testContactList=df.createContacts(500);
    	Insert testContactList;
        obj.contactList=testContactList;
        System.debug('===='+obj.contactList);
        PageReference pg=page.AccountPagePM5_2;
        pg.getParameters().put('paramvar','');
        Test.setCurrentPage(pg);
        obj.showRecords();
       for(Apexpages.Message msgObj : Apexpages.getMessages())
      {
      	System.assertEquals('Record Not Found', msgObj.getSummary());
      }   	   
    }
    /**
     * This Method check for 'ALL' string
     * @param NA
     * Return Type NA
	 */
    public Static testmethod void checkALLstring()
    {
     	DataFactory df=new DataFactory();
        AlphaSearchController obj=new AlphaSearchController();
     	List<Contact> testContactList=df.createContacts(500);
        System.debug(testContactList);
        Insert testContactList;
        obj.contactList=testContactList;
        System.debug(obj.contactList);
        PageReference pg=page.AccountPagePM5_2;
        pg.getParameters().put('paramvar','ALL');
        Test.setCurrentPage(pg);
        obj.showRecords();
       	system.assertEquals(500,obj.showContactList.size());   
    }
    /**
     * This method checks whether All Related Contacts fetched
     * @param NA
     * Return Type NA
	 */
    public static testmethod void checkAllRelatedContacts()
    {
        DataFactory df=new DataFactory();
        AlphaSearchController obj=new AlphaSearchController();
     	List<Contact> testContactList=df.createContacts(500);
        System.debug(testContactList);
        Insert testContactList;
        obj.contactList=testContactList;
        System.debug('++++ '+obj.contactList);
        string AccId=testContactList[0].Id;
        PageReference pg=page.AccountPagePM5_2;
        pg.getParameters().put('Id',AccId);
        Test.setCurrentPage(pg);
        obj.showRelatedContacts();
       	system.assertEquals(500,obj.contactList.size()); 	
    }
    /* This method checks whether All Related Contacts fetched
     * @param NA
     * Return Type NA
	 */
    public static testmethod void checkdisplayContacts()
    {
        DataFactory df=new DataFactory();
        AlphaSearchController obj=new AlphaSearchController();
     	List<Contact> testContactList=df.createContacts(500);
        System.debug(testContactList);
        Insert testContactList;
        obj.contactList=testContactList;
        System.debug('++++ '+obj.contactList);
        string AccId=testContactList[0].AccountId;
        PageReference pg=page.ContactPagePM5_2;
        pg.getParameters().put('ACCid',AccId);
        Test.setCurrentPage(pg);
		obj.displayContacts();
       	system.assertEquals(500,obj.contactList.size()); 	
    }
}