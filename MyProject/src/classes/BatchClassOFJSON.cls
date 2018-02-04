/**
 * This batch class is for account creation with Jason
 * Created By : Akshay Phatak
 * Created Date : 15/01/2018 
*/
global class BatchClassOFJSON implements Database.Batchable<sobject>
{
 
  /**
   * start method
   * @param batchableContext
   * Return type Querylocator 
   */
  global Database.QueryLocator start(Database.BatchableContext jobId) 
  {
      return Database.getQueryLocator('SELECT Json_Script__c FROM Eventsobject__c');
  }
   /**
   * Execute method
   * @param batchableContext and scope
   * Return type NA
   */ 
  global void execute(Database.BatchableContext BC,List<Eventsobject__c> scope) {
      List<Account> accList=new List<Account>();
         for (Eventsobject__c ee : scope)
         {
             if(ee.Json_Script__c !=null)
             {
               Account accountObj=new Account();
               accountObj =(Account)System.JSON.deserialize(ee.Json_Script__c , Account.class);
               accList.add(accountObj); 
             }
         }
      	if(accList.size()>0)
        {
          insert accList; 
        }
        System.debug(accList);
  }     
  global void finish(Database.BatchableContext BC){}
}