/**
* This Class is for searching Accounts by Name 
* Created By : Akshay Phatak
* Created Date : 10/01/2018
*/
public class SearchAccController
{
    public list<Account> accList{set;get;}
    public list<Account> accSearchList{set;get;}
    public String accountName{set;get;}
    public integer countsearchedAccount{set;get;}
    public integer countAllAccount{set;get;}
    /**
* Constructor
*/
    public SearchAccController()
    {
        accList=new List<Account>();
        accSearchList=new List<Account>();
        countsearchedAccount=0;
    }
    /**
* This Method Show All Accounts in the Org
* @param NA
* Return Type NA
*/
    public void showAllRecords()
    {
        accList=[SELECT Id,Name FROM Account LIMIT 10];
        countAllAccount=accList.size();
    }
    /**
* This Method search Account in List
* @param NA
* Return Type NA
*/
    public void  searchAccount()
    {
        if(accountName.length()<3)
        {
            accSearchList.clear();
            ApexPages.addMessage( new ApexPages.message(ApexPages.Severity.WARNING,Label.StringLengthError));
        }
        else
        {
            accSearchList=[SELECT Id,Name FROM Account WHERE Name like :accountName+'%' LIMIT 10];
            countsearchedAccount=accSearchList.size();
            if(accSearchList.size()==0)
            {
                Apexpages.addMessage(new ApexPages.message(ApexPages.Severity.INFO,Label.RecordnotfoundError));
            }
        }
        
    }
    /**
* This Methos Clear search List
* @param NA
* Return Type NA
*/
    public void clearList()
    {
        
        if(accSearchList.isEmpty())
        {
            ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.WARNING,Label.Errormsg1));
        }
        else
        {
            accSearchList.clear(); 
        }
    }
}