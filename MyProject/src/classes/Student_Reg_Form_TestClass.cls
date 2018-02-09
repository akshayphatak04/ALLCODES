/**
* This class is for testing student form Controller
* Created By : Akshay Phatak
* Created Date : 24/12/2017
*/
@isTest
public with sharing class Student_Reg_Form_TestClass {
    /**
    * This is Datafactory for creating Data*/
    public class Test_Data_Factory
    {
        public  List<Student__c> insertStudentRecords(){
        List<Student__c> studentList = new List<Student__c>();
            
            for(Integer i=0; i<10; i++)
            {
                Student__c studObj = new Student__c(Name='demo'+i, City__c='City'+i);
                studentList.add(studObj);
            }
            System.debug('stud list:'+studentList);
            insert studentList;
            return studentList;
        }
        public  List<SelectOption> getLanguageList()
        {
            List<SelectOption> lstOptions=new List<SelectOption>();
            lstOptions.add(new selectOption('English','English'));
            lstOptions.add(new selectOption('Spanish','spanish'));
            lstOptions.add(new selectOption('french','french'));                
            return lstOptions;
        }
    }
/**Method to test if records are successfully inserted or not
  * @param NA
  * Return type NA
  */
    @isTest
    public static void insertionTestforStudentRecords()
    {
        Test.startTest();
        Test.setCurrentPage(Page.StudentRegPage);
        ApexPages.StandardController sc = new ApexPages.StandardController(new Student__c(Name='demo',City__c='Test',Country__c='India'));
        StudenRegistrationForm_Ext studRegObj = new StudenRegistrationForm_Ext(sc);
        studRegObj.insertStudentRecords();
        Test.stopTest();
        
        List<ApexPages.Message> msgs = ApexPages.getMessages();
        boolean hasMessage = false;
        for(ApexPages.Message msg : msgs){
            if(msg.getDetail().contains('successfully submitted')){
                hasMessage = true;
            }
        }
        System.assert(hasMessage);
    }
    
    @isTest
    /**
      * Method to test if the language translation is working properly or not
      * @param NA
      * Return Type NA
      */
    public static void testTranslationOfStud_RegPage()
    {
        ApexPages.StandardController sc = new ApexPages.StandardController(new Student__c());
        StudenRegistrationForm_Ext studRegObj = new StudenRegistrationForm_Ext(sc);
        Test_Data_Factory df=new Test_Data_Factory();
        List<SelectOption> langList=df.getLanguageList();
        studRegObj.languageSelectList = langList;
        studRegObj.lang = 'Spanish';
        Test.startTest();
        Test.setCurrentPage(Page.StudentRegPage);
        studRegObj.changeLang();
        
        Test.stopTest();
        boolean gotLangSet = false;
        if(studRegObj.language=='es')
        {
            gotLangSet = true;
        }
        System.assert(gotLangSet);
    }
    
    /**
* method check forUnsuccessfull Record
* @param NA
* Return Type NA
*/
    @isTest
    public static void testforUnsuccesful_Reco_Submission(){
        Test_Data_Factory df=new Test_Data_Factory();
        List<Student__c> studentList = df.insertStudentRecords();
        Test.startTest();
        Test.setCurrentPage(Page.StudentRegPage);
        ApexPages.StandardController sc = new ApexPages.StandardController(new Student__c());
        StudenRegistrationForm_Ext studObj = new StudenRegistrationForm_Ext(sc);
        studObj.insertStudentRecords();
        Test.stopTest();
        List<ApexPages.Message> msgs = ApexPages.getMessages();
        boolean hasMessage = false;
        for(ApexPages.Message msg : msgs)
        {
            if(msg.getDetail().contains(StudenRegistrationForm_Ext.exceptionMessage))
            {
                hasMessage = true;
            }
        }
        System.assert(hasMessage);
    }
}
