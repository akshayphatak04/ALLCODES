/**
 * This Class tests all method relatrd to searching
 * Created By : Akshay Phatak
 * Created Date : 10/01/2018
*/
/**
 * 1st scenario : search for valid account
 * 2nd scenario : search for null Account
 * 3rd scenario : Search for unavilable Account
 * 4th scenario : clear list test
 * 5th Scenario : Check Count
 */
@isTest
public class SearchAccountTest
{
    /**
     * Class creates Bulk Records 
	 */
    public class Datafactory
    {
        /**
         * Method is for creating Bulk records
         * @param integer No of Accounts
         * Return Type NA
		 */
        public List<Account> getAccount(Integer noOfAccounts)
        {
            List<Account> accList=new List<Account>();
            for(integer i=0;i<noOfAccounts;i++)
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
    }
    /**
     * This Method search for Available Account in database
     * @param NA
     * Return Type NA
	*/
    public static testmethod void checkAvailableAcc()
    {
		Datafactory df=new datafactory();
        List<Account> accList=df.getAccount(12);
        System.debug(accList);
        Insert accList;
        SearchAccController m=new SearchAccController();
        m.accountName='gClass';
        m.searchAccount();
        System.assertEquals(10,m.accSearchList.size());
    }
    /**
     * This Method test for Unavailable Account in database
     * @param NA
     * Return type NA
	*/
    public static testmethod void checkUnavailAcc()
    {
		Datafactory df=new datafactory();
        List<Account> accList=df.getAccount(12);
        System.debug(accList);
        Insert accList;
        SearchAccController m=new SearchAccController();
        m.accountName='vvvv';
        m.searchAccount();
        System.assertEquals(0,m.accSearchList.size());
    }
    /**
     *  This Method tests for null string
     * @param NA
     * Return Type NA
	 */
    public static testmethod void checkNullAcc()
    {
		Datafactory df=new datafactory();
        List<Account> accList=df.getAccount(12);
        System.debug(accList);
        Insert accList;
        SearchAccController m=new SearchAccController();
        m.accountName='';
        m.searchAccount();
        for(Apexpages.Message msgObj : Apexpages.getMessages())
        {
            System.assertEquals(Label.StringLengthError, msgObj.getSummary());
            
        }
   }
    /**
     * This Method tests For clear function
     * @param NA
     * Return Type NA
	 */
     public static testmethod void checkClear()
    {
		Datafactory df=new datafactory();
        List<Account> accList=df.getAccount(12);
        System.debug(accList);
        Insert accList;
        SearchAccController m=new SearchAccController();
        m.accountName='gclass';
        m.searchAccount();
        m.clearList();
        System.assertEquals(0,m.accSearchList.size());
        m.clearList();
       for(Apexpages.Message msgObj : Apexpages.getMessages())
        {
            System.assertEquals(Label.Errormsg1, msgObj.getSummary());
            
        }
    }
    /**
     * This testmethod tests for count of searched records
     * @param NA
     * Return Type NA
	 */
    public static testmethod void checkCount()
    {
        Datafactory df=new datafactory();
        List<Account> accList=df.getAccount(12);
        System.debug(accList);
        Insert accList;
        SearchAccController m=new SearchAccController();
        m.accountName='gclass';
        m.searchAccount();
       	System.assertEquals(10,m.countsearchedAccount);
 	}
    /**
     * This testmethod tests for fetching all Accounts 
     * @param NA
     * Return Type NA
	 */
    public static testmethod void ckeckAccRecordsfetch()
    {
        Datafactory df=new datafactory();
        List<Account> accList=df.getAccount(10);
        System.debug(accList);
        Insert accList;
        SearchAccController m=new SearchAccController();
        m.showAllRecords();
        System.assertEquals(accList.size(),m.accList.size());
    }
}