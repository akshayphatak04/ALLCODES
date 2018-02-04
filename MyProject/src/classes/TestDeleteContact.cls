/**This testClass is for testing the Delete Operation
 * Created By : Akshay Phatak
 * Created Date : 06/01/2018
*/
/**
 * 1st Scenario : Valid Contact Delete
 * 2nd Scenario : Null Passed in the Parameter
 * 3rd Scenario : Invalid Contact Deletion
 */
@isTest
public class TestDeleteContact 
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
     * This testmethod is for Valid contact Deletion
     * @param NA
     * Return Type NA 
	*/
  public static testmethod void checkValidContact()
  {	  
      Contact contactObj=new Contact(LastName='hhh');
      insert contactObj;
      test.startTest();
      deletecontact.deletecnt(contactObj.Id);
      test.stopTest();
      List<Contact> lst=[Select name from contact where name='hhh'];
      System.assertEquals(0,lst.size());
  }
    /**
     * This Method is checks when Null Contact Id Passed
     * @param NA
     * Return Type NA
	 */
   public static testmethod void checkNullContact()
   {
       Contact contactObj=new Contact(LastName='hhh');
       insert contactObj;
        test.startTest();
       deletecontact.deletecnt(null);
       test.stopTest();
       List<Contact> lst=[Select name from contact where name='hhh'];
       
       System.assertEquals(1,lst.size());
       
       for(Apexpages.Message msgObj : Apexpages.getMessages())
       {
       	  System.assertEquals('Record Id is Null', msgObj.getSummary());
       }
   }
    /**
     * This Method checks for Invalid Contact Id
     * @param NA
     * Return Type NA
	 */
  public static testmethod void checkInvalidContact()
  {
      Contact contactObj1=new Contact(LastName='hhh');
      insert contactObj1;
      Contact contactObj2=new Contact(LastName='aaa');
      insert contactObj2;
      PageReference pg=page.ContactPage;
      Test.setCurrentPage(pg);
      deletecontact deleteObj=new deletecontact();
      test.startTest();
      deletecontact.deletecnt('abddascjk');
      test.stopTest();
      List<Contact> lst=[Select name from contact where name='hhh'];
      
      System.assertEquals(1,lst.size());
      
      for(Apexpages.Message msgObj : Apexpages.getMessages())
      {
      	System.assertEquals(Label.RecordnotfoundError, msgObj.getSummary());
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
        Deletecontact obj=new Deletecontact();
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
     * This Method check for 'ALL' string
     * @param NA
     * Return Type NA
	 */
    public Static testmethod void checkALLstring()
    {
     	DataFactory df=new DataFactory();
        Deletecontact obj=new Deletecontact();
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
        Deletecontact obj=new Deletecontact();
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
        Deletecontact obj=new Deletecontact();
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