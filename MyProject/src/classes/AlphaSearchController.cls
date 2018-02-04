/**
* This Class is for Alphabetical search
* Created By : Akshay Phatak
* Created Date : 03/01/2018
*/
public class AlphaSearchController
{	
    public string inputAccId{get;set;}
    public list<Account> accList{set;get;}
    public list<Contact> contactList{set;get;}
    public list<Contact> showContactList{set;get;}
    public string accId{set;get;}
    public String accountName{set;get;}
    public list<string>alphabateList{set;get;}
    public string strchar{set;get;}
    /**
* This is Constructor
*/
    public AlphaSearchController()
    {
        showContactList=new List<contact>();
        contactList=new List<Contact>();
        accList=new List<account>();
        alphabateList=new List<String>();
        accList=[SELECT Id,Name FROM Account LIMIT 20];
    }
    /**
* This Method is for displaying all Related Contacts
* @param NA
* Return Type NA
*/
    public PageReference showRelatedContacts()
    {
        accId=ApexPages.currentPage().getParameters().get('Id');
        PageReference pg=new PageReference('/apex/ContactPagePM5_2');
        pg.getParameters().put('ACCid',accId);
        pg.setRedirect(true);
        return pg;
    }
    /**
* This Method Display Alphabets on page
* @param Na
* Return Type Na
*/
    public void displayContacts()
    {
        alphabateList=new List<string>{'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z','ALL'};
 		inputAccId=ApexPages.currentPage().getParameters().get('ACCid');
        System.debug('inputAccId=== '+inputAccId);
      	contactList=[SELECT Id,Name,LastName,FirstName FROM Contact WHERE Account.Id=:inputAccId];
        System.debug('contactList.size '+contactList.size());
        if(contactList.isEmpty())
        {
            Apexpages.addMessage(new ApexPages.message(ApexPages.Severity.INFO,Label.RecordnotfoundError));
        }
    }
    /**
* This Method Shows Related Contacts According to Alphabet
* @param NA
* Return Type NA
*/
    public void showRecords()
    {
       	System.debug('I am in show Records');
        strchar=ApexPages.currentPage().getParameters().get('paramvar');
        List<Contact>showContacts=new List<Contact>();
        System.debug('strchar '+strchar);
        System.debug('strchar.equals '+strchar.equals('ALL'));
        if(strchar.equals('ALL'))
        {
            if(contactList.size()!=null)
            {
                showContacts.addAll(contactList); 
            }
            showContactList=showContacts;
        }
        else
        {
            if(strchar!=null)
            {
                System.debug('----------contactList '+contactList);
                for(Contact c : contactList)
                {  
                    System.debug('I am in for loop');
                    System.debug('c.Name '+c.Name);
                    if(c.FirstName.startsWith(strchar.toLowerCase()) || c.FirstName.startsWith(strchar))
                    {
                        System.debug('I am in IF');
                        showContacts.add(c);
                    }
                }
                if(!(showContacts.isEmpty()))
                showContactList=showContacts;
            }
            else
            {
                System.debug('I am in Elkse');
                ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.ERROR,'Null Character'));   
            }
        }
        System.debug('I am out');
      }
}