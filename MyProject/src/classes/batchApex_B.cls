/**
* This class is for deleting the duplicate leads in database
* created by : Akshay Phatak
* created Date : 15/01/2018
*/
global class batchApex_B implements Database.Batchable<SObject>,Database.Stateful 
{
    global final String Query;
    static String value = '';
    List<DeleteLeads__c> lstDelete;
    public batchApex_B () 
    {
        lstDelete = DeleteLeads__c.getall().values();          
        for (DeleteLeads__c dd : lstDelete ) 
        {
            if (dd.IsActive__c == true) 
            {
                value = value + ',' + dd.Name   ;
            }       
        }  
        Query='SELECT Id' + value + ' FROM Lead WHERE Email != NULL' ;
    }
    global Database.QueryLocator start(Database.BatchableContext BC)
    {   
        return Database.getQueryLocator(Query);
    }
    global void execute(Database.BatchableContext BC, List<Lead> scope)
    {    
        List<String> namesapi = new List<String>();
        List<sObject> duplicatelist = new List<Lead>(); //List of lead records to be deleted
        
        Set<String> myemailNameSet = new Set<String>();   
        
        for(DeleteLeads__c s : lstDelete) 
        {
            if (s.IsActive__c == true) 
            {
                namesapi.add(s.Name);
            } 
        }   
        for (Sobject s : scope) 
        {
            String key = '';
            
            for(String str : namesapi ) 
            {
                key = key + s.get(str);
            }
            if(myemailNameSet.contains(key)) 
            {
                duplicatelist.add(s);
            }
            else 
            {
                myemailNameSet.add(key);
            }  
            
        }
        delete duplicatelist ;
    }
    global void finish(Database.BatchableContext BC){}
    
    
}