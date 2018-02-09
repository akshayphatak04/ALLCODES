/**
* This is  Testclass for BatchApex_A1
* Created By : Akshay Phatak
* Created Date : 05/01/2018 
*/
@isTest
public class TestbatchApex_A1 implements Database.Stateful
{
/**
* This is class for creating Records of different Objects
*/
    public class DataFactory
    {
        public List<Account> accountList;
        /**
         * This is method which creates Accounts
         * @param is of type Integer
         * Return type List of Account
         */
        public List<Account> createAccounts(Integer noOfAccounts)
        {
            Contact cntObj=new Contact(LastName='demo',Email='akshayphatak04@gmail.com');
            insert cntObj;
            accountList=new List<Account>();
            for(Integer i=0;i<noOfAccounts;i++)
            {
                Account accObj=new Account(name='Espl',SLA__c='GOld', SLAExpirationDate__c=System.today(),SLASerialNumber__c='5896',Primary_Contact__c=cntObj.Id);  
                accountList.add(accObj);
            }
            return accountList;
        }
        /**
          * This method creates Opportunity Record
          * @param is of type integer
          * Return Type List of Opportunity
          */
        public List<Opportunity> createOpportunities(Integer noOfOpportunities)
        {
            List<Opportunity> oppList=new List<Opportunity>();
            for(Integer i=0;i<noOfOpportunities ;i++)
            {
                for(integer j=0;j<200;j++)
                {
                    Opportunity oppObj = new Opportunity(Name='TestOpp', AccountId=accountList[j].Id,Amount=100, CloseDate = System.today(), StageName = 'Closed Won'); 
                    oppList.add(oppObj);
                }
            }
            return oppList;
         }
    }
    /**
     * this test method is for testing batch of 200 records
     * @param NA
     * Return type NA
     */
    static public testmethod void batchClassTest() 
    {  
        DataFactory df=new DataFactory();
        List<Account> accList= df.createAccounts(200);
        insert accList;
        List<Opportunity> oppList= df.createOpportunities(3);
        insert oppList;
        List<Account> accList1=[SELECT Name, Primary_Contact__r.Email, (SELECT ID,Name, Amount FROM Opportunities WHERE StageName ='Closed Won') opp FROM Account WHERE Primary_Contact__c != null];
        Test.startTest();
        batchApex_A1 bc= new batchApex_A1 ();        
        Database.executeBatch(bc);
        Test.stopTest();
        System.assertEquals(200,accList1.size());
    }
}
