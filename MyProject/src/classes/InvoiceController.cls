public class InvoiceController 
{
    public List<BillTo__c> BillList{get;set;}
    public List<Line_Item__c> productList{get;set;}
    //public List<InvoiceComplains__c> invoicecomplainList{get;set;}
    public List<Invoice_Statements__c> invoiceList{get;set;} 
    public string billid{get;set;}
    public string MerchName{set;get;}
    public string sourceInput{get;set;}
    public string billCity{get;set;}
    public string billCompany{get;set;}
    public string billphno{get;set;}
    public string  billStreetAddr{get;set;}
    public string billName{get;set;}
    public string billEmail{get;set;}
    public decimal totalamt{get;set;}
    public string merchCity{get;set;}
    public string invoiceDate{get;set;}
    public string invoiceNo{get;set;}
    public string merchPhone{get;set;}
    public string merchAddress{get;set;}
    public string invoiceComapayName{get;set;}
    public void displayInvoiceList()
    {
        invoiceList=
            [
            select 
                Id
            ,Name
            ,Status__c
              , Merchandise__r.Name
              , Total_Amt__c
           	from Invoice_Statements__c
        ];
    }
    public pagereference redirecttoInvoicePdf(){
        //system.debug('========================'+billid);
      	pagereference pg=new pagereference('https://c.ap5.visual.force.com/apex/InvoicePagePDFpage');
      	pg.getParameters().put('Id',billid);
      	return pg;
    }   
    public void displaynvoice()
    {
        System.debug('I am in displaynvoice');
        sourceInput=ApexPages.currentPage().getParameters().get('Id');
        System.debug('sourceInput'+sourceInput);
        List<Invoice_Statements__c> invoiceList=[
            		     select Id 
            	        ,Name
          	            ,Status__c
          	            ,Total_Amt__c
                        ,Date__c
        		        ,BillTo__r.Name__c
                        ,BillTo__r.Company_Name__c
                        ,BillTo__r.City__c
                        ,BillTo__r.Email__c
                        ,BillTo__r.phone__c
                        ,BillTo__r.Street_Address__c
                        ,Merchandise__r.Name
                        ,Merchandise__r.City__c
                        ,Merchandise__r.phone__c
                        ,Merchandise__r.Street_Address__c
                        ,(Select Id,Name,Unit_Price__c from Line_Items__r) 
                        from Invoice_Statements__c where Id=:sourceInput
        ];
       	MerchName=invoiceList[0].Merchandise__r.Name;
       	merchAddress=invoiceList[0].Merchandise__r.Street_Address__c;
        merchCity=invoiceList[0].Merchandise__r.City__c;
       	merchPhone=invoiceList[0].Merchandise__r.phone__c;
     	invoiceNo=invoiceList[0].Name;
     	date d=invoiceList[0].date__c;
        string datefm=DateTime.newInstance(d.year(),d.month(),d.day()).format('dd/MM/YYYY');
        invoiceDate=datefm;
      	billName=invoiceList[0].BillTo__r.Name__c;
     	billCompany=invoiceList[0].BillTo__r.Company_Name__c;
       	billStreetAddr=invoiceList[0].BillTo__r.Street_Address__c;
        billCity=invoiceList[0].BillTo__r.City__c;
        billphno=invoiceList[0].BillTo__r.phone__c;
        billEmail=invoiceList[0].BillTo__r.Email__c;
       	productList=invoiceList[0].Line_Items__r;
      	totalamt=0;
        for(Line_Item__c productObj:productList)
        {
            totalamt=totalamt+productObj.Unit_Price__c;
        }
 	}
}