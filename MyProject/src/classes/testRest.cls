/**
 * This testclass is for testing webservices of Leadmanipulator using REST
 * Created By : Akshay Phatak
 * Created Date : 15/01/2018
*/
@isTest
public class testRest
{
    /**
     * This testmethod is for get method of Webservice
     * @param NA
     * Return Type NA
	 */
    static testMethod void testGetMethod()
    {
        Lead newlead = new Lead(FirstName='a123', LastName='b123', Email='b@gmail.com',Phone='123',Company='ggg');
        insert newlead;
        System.debug(newLead.Id);
        RestRequest request = new RestRequest();
        request.requestUri ='/services/apexrest/v1/createLead';
        request.httpMethod = 'GET';
        request.params.put('Fname','a123');
        request.params.put('Lname','b123');
        request.params.put('Email','a@gmail.com');
        request.params.put('Phone','1234');
        RestContext.request = request;
        getContact.Response res=new  getContact.Response();
        res=getContact.UpdateLead();
        System.debug(newLead); 
        System.assertEquals('Success',res.status);
        System.assertEquals(true,res.isSuccess);
    }
    /**
     * this testmethos is for Post method 
     * @param NA
     * Return type NA
	 */
    static testMethod void testPostMethod()
    {
        RestRequest request = new RestRequest();
        request.requestUri ='/services/apexrest/v1/createLead';
        request.httpMethod = 'POST';
        RestContext.request = request;
        getContact.response res=new  getContact.response();
        res=getContact.dopost('LastName', 'Status','e@gmail.com','123','aaa');
        List<Lead> lList=[Select id,Name from Lead];
        System.assertEquals(1,lList.size());
        System.assertEquals('Success',res.status);
        System.assertEquals(true,res.isSuccess);
    }
    /**
     * This testmethod is for delete webservice
     * @param NA
     * Return Type NA
	 */
    static testMethod void testDeleteMethod()
    {
        Lead newlead = new Lead(FirstName='Fname',LastName='Lname',Company='kszjdhksz',Phone='12345',Email='s@gmail.com');
        insert newlead;
        RestRequest request = new RestRequest();
        request.requestUri ='/services/apexrest/DisplayRecords';
        request.params.put('Fname','Fname');
        request.params.put('Lname','Lname');
        request.params.put('Email','s@gmail.com');
        request.params.put('Phone','12345');
        request.params.put('Company','kszjdhksz');
        request.httpMethod = 'DELETE';
        RestContext.request = request;
        getContact.response res=new  getContact.response();
        res=getContact.deleteLead();
        List<Lead> lList=[Select id,Name from Lead];
        System.assertEquals(0,lList.size());
        System.assertEquals('Success',res.status);
        System.assertEquals(true,res.isSuccess);
    }
}