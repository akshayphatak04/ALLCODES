/**
* This class is for testing the functionality of Lead manipulator Services Using SOAP
* Created By : Akshay Phatak
* Created Date : 15/01/2018
*/
@isTest 
public class TestSoapWebservice 
{
    /**
* This method is used to test the createLead functionality in the SOAPWebservice  class(Positive Scenario) 
* @param NA
* Return Type NA
*/   
    @isTest static void testCreateLead() 
    { 
        test.startTest();
        leadManipulatorService.acknowledge ackObj=new leadManipulatorService.acknowledge();
        ackObj =  leadManipulatorService.createLead('pp1111','Google','1234','a@gamil.com','cc');
        test.stopTest();
        List<Lead> leadList=[Select id from Lead where id = :ackObj.leadId];
        System.assertEquals(1,leadList.size());
        System.assertEquals('Success',ackObj.status);
        System.assertEquals(true,ackObj.isSuccess);
    }
    /**
* This method is used to test the createLead functionality in the SOAPWebservice  class(Negative Scenario) 
* @param NA
* Return Type NA
*/ 
    @isTest static void testCreateLeadneg() 
    { 
        test.startTest();
        leadManipulatorService.acknowledge ackObj=new leadManipulatorService.acknowledge();
        ackObj =  leadManipulatorService.createLead('pp1111','Google','1234','a@gamil.com','');
        test.stopTest();
        List<Lead> leadList=[Select id from Lead where id = :ackObj.leadId];
        System.assertEquals(0,leadList.size());
        System.assertEquals('fail',ackObj.status);
        System.assertEquals(false,ackObj.isSuccess);
    }
    /**
* This method is used to test the DeleteLead functionality in the SOAPWebservice  class(Positive Scenario) 
* @param NA
* Return Type NA
*/ 
    @isTest static void testDeleteLead() 
    { 
        Lead l = new Lead(FirstName='demo',LastName = 'test',Email='v@gmail.com',Phone='1234',Company = 'Google', Status = 'Closed-Converted');
        insert l;
        test.startTest();
        leadManipulatorService.acknowledge ackObj=new leadManipulatorService.acknowledge();
        ackObj =  leadManipulatorService.deleteLead('demo', 'test', 'v@gmail.com','1234');
        test.stopTest();
        List<Lead> leadList=[Select id from Lead];
        System.assertEquals(0,leadList.size());
        System.assertEquals('Success',ackObj.status);
        System.assertEquals(true,ackObj.isSuccess);
        
    }
    /**
* This method is used to test the DeleteLead functionality in the SOAPWebservice  class(Negative Scenario) 
* @param NA
* Return Type NA
*/ 
    @isTest static void testDeleteLeadNeg() 
    { 
        test.startTest();
        leadManipulatorService.acknowledge ackObj=new leadManipulatorService.acknowledge();
        ackObj =  leadManipulatorService.deleteLead('demo', 'test', 'v@gmail.com','1234');
        test.stopTest();
        List<Lead> leadList=[Select id from Lead];
        System.assertEquals(0,leadList.size());
        System.assertEquals('fail',ackObj.status);
        System.assertEquals(false,ackObj.isSuccess);
    }
}