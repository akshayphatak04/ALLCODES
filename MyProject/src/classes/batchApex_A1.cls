/**
* This is class for sending mail to primary contact of account whose opportunities are closed won
* Created by : Akshay Phatak
* Created Date : 05/01/2018
*/
global class batchApex_A1 implements Database.Batchable<sobject>, Database.Stateful 
{
    
    List<AggregateResult> oppList;
    global  Map<String,List<Opportunity>> mapEmailOpp = new map<String, List<Opportunity>>();
    global List<AggregateResult> myoppList; 
    Map<String,Integer>  mapEmailSum =  new  Map<String, Integer>();
    /**
* This is start method 
* @param is of type batchable Context
* Return type QueryLocator
*/
    global Database.QueryLocator start(Database.BatchableContext jobId) 
    {
        return Database.getQueryLocator('SELECT Name, Primary_Contact__r.Email, (SELECT ID,Name, Amount FROM Opportunities WHERE StageName = \'Closed Won\') opp FROM Account WHERE Primary_Contact__c != null ');
    }
    
    /**
* This is Execute method 
* @param is of type batchable Context and List of Account
* Return type NA
*/  
    global void execute(Database.BatchableContext BC, List<Account> scope) 
    {
        for (Account aitr : scope) 
        {
            mapEmailOpp.put(aitr.Primary_Contact__r.Email, aitr.Opportunities);
        }        
      
        myoppList =
            [  
                SELECT Account.Primary_Contact__r.Email email
                , SUM(Amount) aggramount
                , ID
                FROM Opportunity 
                WHERE Account.Primary_Contact__c != NULL
                AND StageName = 'Closed Won'
                GROUP BY Account.Primary_Contact__r.Email,Id           
            ];
 		for (AggregateResult aritr : myoppList) 
        {
            System.debug('aritr.get(aggramount) '+aritr.get('aggramount'));
            mapEmailSum.put((String)aritr.get('email'), Integer.valueOf(aritr.get('aggramount')));
        }     
    }     
    
/**
* This is Finish method 
* @param is of type batchableContext
* Return type NA
*/ 
    global void finish(Database.BatchableContext BC)
    { 
        List<Messaging.SingleEmailMessage> mailList = new List<Messaging.SingleEmailMessage>();
        List<String> listofEmails = new List<String>(mapEmailOpp.keySet());
        for (String emailitr : listofEmails ) 
        {
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            String[] arrayOfEmail = new String[]{emailitr};            
            mail.setToAddresses(arrayOfEmail);            
            mail.setSubject('Closed Won opportunities for your account ');
            String body = '';
           	for (Opportunity oitr : mapEmailOpp.get(emailitr)) 
            {
                System.debug('I am i for');
                body += 'Opportunity Name : ' + oitr.Name ;
                body += '  Amount : ' + oitr.Amount ;
                body += '  Aggregated Amount : ' + mapEmailSum.get(emailitr) ;
            }
            mail.setPlainTextBody(body);
            mailList.add(mail);
        }        
        Messaging.sendEmail(mailList);
    }
    
}