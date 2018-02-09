/**
* This class is testing for CityCountryPickerController
* Created By : Akshay Phatak
* Created Date : 05/01/2018
*/
@istest
/**
* scenario 1st : When no country Selected
* Scenario 2nd : when Country Selected
* Scenario 3rd : getAllcountry test
* 
*/
public class TestcityCountrypick 
{
    /*This method is for setup*/
    @testSetup static void myUnitTest()
    {
        Country__c c1=new Country__c(name='India');
        insert c1; 
        Country__c c2=new Country__c(name='france');
        insert c2; 
        city__c city1=new city__c(Name='Delhi',Country__c='india');
        insert city1;
        city__c city2=new city__c(Name='Mumbai',Country__c='india');
        insert city2;
        city__c city3=new city__c(Name='Paris',Country__c='France');
        insert city3;
        city__c city4=new city__c(Name='Lyon',Country__c='France');
        insert city4;
        
    }
/**
* When Country Selected
* @param NA
* Return Type NA
*/
    public static testmethod void checkIfCountrySelected()
    {
        CityCountryPickerController ccObj=new CityCountryPickerController();
        ccObj.country='India';
        List<SelectOption> optionList=ccObj.getCitiesSelectList();
        System.assertEquals(3,optionList.size());
        ccObj.country='France';
        List<SelectOption> optionList1=ccObj.getCitiesSelectList();
      	System.assertEquals(3,optionList1.size());
    }
/**
* When Country not Selected
* @param NA
* Return Type NA
*/
    public static testmethod void checkIfCountryNotSelected()
    {
        CityCountryPickerController ccObj=new CityCountryPickerController();
        ccObj.country='';
        List<SelectOption> lst=ccObj.getCitiesSelectList();
      	System.assertEquals(1,lst.size());
    }
    /*
* Test For getAllCountries
* @param NA
* Return Type NA
*/
    public static testmethod void checkgetAllCountries()
    {
        CityCountryPickerController ccObj=new CityCountryPickerController();
        List<SelectOption> lst=ccObj.getCountriesSelectList();
        System.assertEquals(3,lst.size());
    }
}
