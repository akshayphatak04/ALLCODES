/**
 * This class is for webservices of Leadmanipulator services using REST API
 * Created by : Akshay Phatak
 * Created Date : 15/01/2018
*/
@RestResource(urlMapping='/v1/createLead')
global with sharing class getContact
{
    /**
     * This class for Response 
	 */
    global class response
    {
        public Boolean isSuccess;
        public Id leadId;
        public String status;
        /*Constructor for inner class*/
        public response()
        {
            isSuccess=false;
            leadId=null;
            status='Fail';
        }
    }
    /**
     * This service is for deleting Lead
     * @param NA
     * Return Type NA
	 */
    @Httpdelete
    global static response deleteLead()
    {
        response res=new response();
        RestRequest req1=RestContext.request;
        String FirstName=req1.params.get('Fname');
        String LastName=req1.params.get('Lname');
        String Email=req1.params.get('Email');
        String Phone=req1.params.get('Phone');
        String Company=req1.params.get('Company');
        List<Lead> leadList =[Select id From Lead where FirstName=:FirstName AND LastName=:LastName AND Email=:Email AND Phone=:Phone AND Company=:Company];
        System.debug(leadList);
        String leadId=leadList[0].Id;
        delete leadList;
        res.isSuccess=true; 
        res.leadId=leadId;
        res.status='Success';
        return res;
    }
    /**
     * This webservice is for Creating the Lead
     * @param NA
     * Return Type NA
	 */
    @Httppost
    global static response dopost(String FirstName,String LastName,String Email,String Phone,String Company) 
    {
        response res=new response();
        RestRequest req=RestContext.request;
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
    /**
     * This webservice is for Updating Lead
     * @param Na
     * Return Type NA
	 */
    @httpget
    global static response UpdateLead()
    {
        response res=new response();
        RestRequest req1=RestContext.request;
        String FirstName=req1.params.get('Fname');
        String LastName=req1.params.get('Lname');
        String Email=req1.params.get('Email');
        String Phone=req1.params.get('Phone');
        List<Lead> leadList =[Select id,FirstName,LastName,Email,Phone From Lead where FirstName=:FirstName AND LastName=:LastName];
        leadList[0].Email=Email;
        leadList[0].Phone=Phone;
        Update leadList;
        String leadId=leadList[0].Id;
        res.isSuccess=true; 
        res.leadId=leadId;
        res.status='Success';
        return res;
    }
}