public class StudenRegistrationForm_Ext
{
    public Student__c studentRecord    {get; set;}
    public  String language     {get; set;}
    public String lang          {get; set;}
    public static String successfulSubmission = 'Form has been submtted';
    public static String exceptionMessage;
    ApexPages.standardController sc;

    public StudenRegistrationForm_Ext(ApexPages.standardController sc) 
    {
        this.sc = sc;
        this.studentRecord = (Student__c)sc.getRecord();
        System.debug(sc);
    }
	public void changeLang() 
    {
        if(lang=='Spanish')
        {
           language='es'; 
        }
        else
        {
          language = lang.subString(0,2).toLowerCase();
           System.debug('language '+language);  
        }
        
    }

     public List<selectOption> languageSelectList 
     {
        get 
        {
            List<selectOption> options = new List<selectOption>();
             options.add(new SelectOption('-- Select Language --', '-- Select Language --')); 
            for (Language__c lg : Language__c.getAll().values())
            {
                options.add(new SelectOption(lg.Name,lg.Name));
            }
            return options;
        }
        set;
      }

    
    public void insertStudentRecords() 
    {
        try 
        {
            insert studentRecord;
            ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM,'successfully submitted'));
       } 
        catch(Exception ex) 
        {
            exceptionMessage=ex.getMessage();
            ApexPages.AddMessage( new ApexPages.Message(ApexPages.Severity.ERROR, StudenRegistrationForm_Ext.exceptionMessage) );
        }
      }
}