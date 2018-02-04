/**
 * This class is Exposing Webservices
 * Created By : Akshay Phatak
 * created Date : 15/01/2018

*/
global class leadManipulatorService 
{
    /*This Class is for Response*/
    global class acknowledge
    {
        webservice Boolean isSuccess;
        webservice Id leadId;
        webservice String status;
        /*Constructor for Inner Class*/
        public acknowledge()
        {
            isSuccess=false;
            status='fail';
            leadId=null;
        }
    }
    /**
     * This webservice is for creating lead in org
     * @param is of type string and no. of parameters are 5
     * Return Type acknowledge
	 */
    WebService static acknowledge createLead(String FirstName,String LastName,String Phone,String Email,String Company)
    {
        lead lObj=new lead();
        acknowledge res=new acknowledge();
        try
        {
            
            lead leadObj=new lead();
            leadObj.FirstName=FirstName;
            leadObj.LastName=LastName;
            leadObj.Email=Email;
            leadObj.Phone=Phone;
            leadObj.Company=Company;
            Insert leadObj;
            res.isSuccess=true; 
            res.leadId=leadObj.Id;
            res.status='Success';
            return res;
        }
        catch(Exception ex)
        {
            system.debug('Error'+ex.getMessage());
        }
        return res;
    }
    
    /**
     * This webservice is for deleting lead from org
     * @param is of type string and no. of parameters are 4
     * Return Type acknowledge
	 */
    Webservice static acknowledge deleteLead(String FirstName,String LastName,String Email,String Phone)
    {
        acknowledge res=new acknowledge();
      	try
        {
            List<Lead> leadList =[Select id From Lead where FirstName=:FirstName AND LastName=:LastName AND Email=:Email AND Phone=:Phone ];
            System.debug(leadList);
            String leadId=leadList[0].Id;
            delete leadList;
            res.isSuccess=true; 
            res.leadId=leadId;
            res.status='Success';
            return res;
        }
        catch(Exception ex)
        {
            system.debug('Error'+ex.getMessage());
        }
        return res;
    }
}