/**
 * This Class is For checking the Functionality Of BatchApex_B
 * Created By : Akshay Phatak
 * Created Date : 15/01/2017
*/
@isTest
public class TestbatchApex_B 
{
    public static DeleteLeads__c dd1;
    @testSetup static void myUnitTest()
    {
     dd1=new DeleteLeads__c(name='Name',IsActive__c=true);
     insert dd1;
     DeleteLeads__c dd2=new DeleteLeads__c(name='Email',IsActive__c=true);
     insert dd2;
     lead l1=new lead(LastName='hhh',Company='eternus',Status='Closed-Converted',Email='Akshay@gmail.com');
     insert l1;
     lead l2=new lead(LastName='hhh',Company='eternus',Status='Closed-Converted',Email='Akshay@gmail.com');
  	insert l2;
}
    /**
     * Test when IsActive__c is true for Email of custom setting records
     * @param NA
     * Return Type NA
     */
   public static testmethod void scenario1()
   {
       test.startTest();
       batchApex_B batchObj=new batchApex_B();
       Database.executeBatch(batchObj);
       test.stopTest();
       List<lead> leadList=[Select Id,Name from Lead];
       System.debug('leadList '+leadList);
       System.assertEquals(1,leadList.size());
   }
    
        /**
     * Test when IsActive__c is true for Name of custom setting records
     * @param NA
     * Return Type NA
     */
   public static testmethod void scenario2()
   {
      
       test.startTest();
       batchApex_B batchObj=new batchApex_B();
       Database.executeBatch(batchObj);
       test.stopTest();
       List<lead> leadList=[Select Id,Name from Lead];
       System.debug('leadList '+leadList);
       System.assertEquals(1,leadList.size());
   }
    

}