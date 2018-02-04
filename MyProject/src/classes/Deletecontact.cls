/**
 * This Class is for Deleting the related Contacts
 * Created By : Akshay Phatak
 * Created Date : 05/01/2018
*/
public class Deletecontact 
{
    public string inputAccId{get;set;}
    public list<Account> accList{set;get;}
    public list<Account> accSearchList{set;get;}
    public list<Contact> contactList{set;get;}
    public list<Contact> showContactList{set;get;}
    public string accId{set;get;}
    public String accountName{set;get;}
    public list<string> alphabateList{set;get;}
    public string strchar{set;get;}
    /**
     * This is Constructor 
	 */
    public Deletecontact()
    {
        accList=[SELECT Id,Name FROM Account LIMIT 20];
    }
    /**
     * This Method Show All Related Contacts
     * @param Na
     * Return Type NA
	 */
    public PageReference showRelatedContacts()
    {
        accId=ApexPages.currentPage().getParameters().get('Id');
        PageReference pg=new PageReference('/apex/ContactPage');
        pg.getParameters().put('ACCid',accId);
        pg.setRedirect(true);
        return pg;
    }
    /**
     * This function display All Alphabets on page
     * @param Na
     * Return Type NA
	 */
    public void displayContacts()
    {
        alphabateList=new List<string>{'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z','ALL'};
            inputAccId=ApexPages.currentPage().getParameters().get('ACCid');
        contactList=[SELECT Id,Name FROM Contact WHERE Account.Id=:inputAccId]; 
    }
    /**
     * This Method shows all Related Contacts according to alphabet
     * @param NA
     * Return type NA
	 */
    public void showRecords()
    {
        System.debug(contactList);
        strchar=ApexPages.currentPage().getParameters().get('paramvar');
        List<Contact>showContacts=new List<Contact>();
        if(strchar.equals('ALL'))
        {
            System.debug(showContacts);
            if(contactList.size()!=null)
            {
                showContacts.addAll(contactList); 
            }
            showContactList=showContacts;
        }
        else
        {
            for(Contact c : contactList)
            {     
                {
                    if(c.FirstName.startsWith(strchar.toLowerCase()) || c.FirstName.startsWith(strchar))
                    {
                        showContacts.add(c);
                    }
                }
            }
            showContactList=showContacts;
        }
    }
    /**
     * This method delete related Contacts
     * @param type String
     * Return Type NA
	 */
    @RemoteAction
    public static void deletecnt(String cntId)
    {
        System.debug(cntId);
        System.debug('I am in Delete Operation');
        
        if(cntId!=null)
        {
            List<Contact> cntLst=new List<Contact>();
            cntLst=[Select id,Name from Contact where Id=:cntId];
            System.debug(cntLst.size());
            if(cntLst.size()!=0)
            {
                try
                {
                    delete cntLst;
                }
                catch(DmlException e)
                {
                    ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.ERROR,e.getMessage()));
                }
            }
            else
            {
                ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.Error,Label.RecordnotfoundError));  
            }
        }
        else
        {
            ApexPages.addMessage(new ApexPages.message(ApexPages.Severity.Error,'Record Id is Null'));  
        }
    }
}