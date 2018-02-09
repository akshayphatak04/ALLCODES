/**
 * This class is controller for cityCountryPicker Page
 * Created By :Akshay Phatak
 * Created Date : 05/01/2018 
*/
public with sharing class CityCountryPickerController 
{
    
    /*Variables to store country and City selected by user*/
    public String city { get; set; }
    public String country {get; set;}   
    
    /** 
     * Generates country dropdown from country settings
     * @param NA
     * Return Type List Of Select Option
	 */
    public List<SelectOption> getCountriesSelectList() 
    {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('', '-- Select One --'));        
        
        // Find all the countries in the custom setting
        Map<String, Country__c> countries = Country__c.getAll();
       
        
        // Sort them by name
        List<String> countryNames = new List<String>();
        countryNames.addAll(countries.keySet());
      	countryNames.sort();
        
        // Create the Select Options.
        for (String countryName : countryNames) 
	{
            Country__c country = countries.get(countryName);
            options.add(new SelectOption(country.Name, country.Name));
        }
        return options;
    }
    
    /**
     * To generate the states picklist based on the country selected by user
     * @param NA
     * ReturnType List of Select Option
*/
    public List<SelectOption> getCitiesSelectList() 
    {
        List<SelectOption> options = new List<SelectOption>();
        // Find all the states we have in custom settings.
        Map<String, City__c> allcities = City__c.getAll();
        // Filter states that belong to the selected country
        Map<String, City__c> cities = new Map<String, City__c>();
        for(City__c city : allcities.values()) {
            if (city.country__c == this.country) {
                cities.put(city.name, city);
            }
        }
        // Sort the states based on their names
        List<String> cityNames = new List<String>();
        cityNames.addAll(cities.keySet());
        cityNames.sort();
        // Generate the Select Options based on the final sorted list
        for (String cityName : cityNames) 
	{
            City__c city = cities.get(cityName);
            options.add(new SelectOption(city.Name, city.Name));
        }
        
        // If no states are found, just say not required in the dropdown.
        if (options.size() > 0) 
	{
            options.add(0, new SelectOption('', '-- Select One --'));
        } 
	else 
	{
            options.add(new SelectOption('', 'Not Required'));
        }
        return options;
    }
}
