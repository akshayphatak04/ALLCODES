/**
 * This Class is for checking the Functionality Of BatchClassOfJason
 * Created By : Akshay Phatak
 * Created Date : 15/01/2017
*/
@isTest
public class JasonBAtchTest
{
    /**
     * Scenario : Jason is not Null
     * this method checks when Jason is not null
     * @param NA
     * Return Type NA
	 */
    public static testmethod void checkWhenJasonNotNull()
    {
        Eventsobject__c eObj=new Eventsobject__c(name='account',Json_Script__c='{"Name":"ffff","Object Name":"Account"}');
        insert eObj;
        test.startTest();
        BatchClassOFJSON batchObj=new BatchClassOFJSON();
        database.executeBatch(batchObj);
        test.stopTest();
        List<Account> accList=[Select Id,Name from Account];
        System.assertEquals(1,accList.size());
        System.assertEquals('ffff',accList[0].Name);
    }
    
     /**
     * Scenario : Jason is  Null
     * this method checks when Jason is  null
     * @param NA
     * Return Type NA
	 */
    public static testmethod void checkWhenJasonNull()
    {
        Eventsobject__c eObj=new Eventsobject__c(Name='account');
        insert eObj;
        test.startTest();
        BatchClassOFJSON batchObj=new BatchClassOFJSON();
        database.executeBatch(batchObj);
        test.stopTest();
        List<Account> accList=[Select Id,Name from Account];
        System.debug('-----------'+accList);
        System.assertEquals(0,accList.size());
   }
	
}