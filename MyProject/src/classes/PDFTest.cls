/**
* This class for testing of PDF page controller
* Created By : Akshay Phatak
* Created Date : 22/12/2017
*/
@isTest
private class PDFTest 
{
    @testSetup static void myUnitTest() 
    {
        System.Test.startTest();
        List<BillTo__c> BillList=new List<BillTo__c>();
        for(Integer loopVar=0;loopVar<3;loopVar++)
        {
            BillTo__c billObj=new BillTo__c();
            billObj.Name='aaaa';
            billObj.City__c='Surat'; 
            billObj.Company_Name__c='CompanyName'+loopVar;
            billObj.Phone__c='12345'+loopVar;
            billObj.Street_Address__c='StreetAddress'+loopVar;
            billObj.Email__c='a'+loopVar+'@gmail.com';
        	BillList.add(billObj);
        }
        insert BillList;
        List<BillTo__c> billListRetrieved=[select Id from BillTo__c ]; 
        List<Invoice_Statements__c> invoiceList=new List<Invoice_Statements__c>();
        List<Merchandise__c> merchList=new  List<Merchandise__c>();
        for(integer i=0;i<3;i++)
        {
            Merchandise__c mObj=new Merchandise__c(Name='Merch'+i,City__c='Pune',phone__c='222',Description__c='aa',Price__c=25,Total_Invent__c=2);
            merchList.add(mObj);
        }
        insert merchList;
        for(Integer i=0;i<3;i++){
            Invoice_Statements__c invoiceObject=new Invoice_Statements__c();
           	invoiceObject.date__c=System.today();
            invoiceObject.BillTo__c=billListRetrieved[i].Id;
            invoiceObject.Merchandise__c=merchList[i].Id;
           	invoiceList.add(invoiceObject);
        }
        insert invoiceList;
        List<Invoice_Statements__c> invoiceList1=[select Id from Invoice_Statements__c];
        List<Line_Item__c> productList=new List<Line_Item__c>();
        Integer j=0;
        for(Invoice_Statements__c invoiceObject:invoiceList1)
        {
         	for(Integer i=0;i<3;i++)
            {
         	    Line_Item__c productObject=new Line_Item__c();
         	     productObject.Unit_Price__c=200;
         	     productObject.Name='productsnm'+i;
         	     productObject.Invoice_Statements__c=invoiceObject.Id;
                 productObject.Merchandise__c=merchList[i].Id;
         		 productList.add(productObject);
         	}
         	j++;
        }  
        insert productList;
        System.Test.stopTest();   
    }
    public static testMethod void Scenario1()
    {
        System.Test.startTest();
    	System.Test.setCurrentPage(Page.InvoiceBestPract2);         
        InvoiceController invObj=new InvoiceController();
        invObj.displayInvoiceList();
        system.assertEquals(invObj.invoiceList.size(),3); 
        List<Invoice_Statements__c> invoiceObjectList=[
                                                        select Id 
                                                        from Invoice_Statements__c 
                                                         Limit 2
                                                       ];
    	pagereference pg= page.InvoicePagePDFpage;
        pg.getParameters().put('Id',invoiceObjectList[0].Id);
        Test.setCurrentPage(pg); 
       	invObj.displaynvoice();
        system.assertEquals(invObj.sourceInput,invoiceObjectList[0].Id);    
        system.test.stopTest();
    }
    public static testMethod void Scenario2()
    {
        System.Test.startTest();
        System.Test.setCurrentPage(Page.InvoiceBestPract2);         
        InvoiceController invoiceObj=new InvoiceController();
        invoiceObj.displayInvoiceList();
        system.assertEquals(
            invoiceObj.invoiceList.size()
            ,3
        ); 
        List<Invoice_Statements__c> invoiceList=[
            select Id
              from Invoice_Statements__c 
                   LIMIT 1
        ];
        invoiceObj.billid=invoiceList[0].Id;
        pagereference pg= invoiceObj.redirecttoInvoicePdf();
        System.Test.setCurrentPage(pg); 
        InvoiceController invoiceView=new InvoiceController();
        invoiceView.displaynvoice();
        List<Line_Item__c> prodListtemp=[
            select Id
            ,Name
            ,Invoice_Statements__r.Id
            ,Merchandise__c
            ,Unit_Price__c
             from Line_Item__c 
             where Invoice_Statements__c=:invoiceView.sourceInput
        ];
        List<Line_Item__c> prodTestList=invoiceView.productList;
        system.assertEquals(
            prodListtemp.size()
            ,prodTestList.size()
        );
    }
   public static testMethod void Scenario3(){
        System.Test.startTest();
        System.Test.setCurrentPage(Page.InvoiceBestPract2);         
        InvoiceController invoiceObj=new InvoiceController();
        invoiceObj.displayInvoiceList();
        system.assertEquals(
            invoiceObj.invoiceList.size()
            ,3
        ); 
        List<Invoice_Statements__c> InvoiceList=[
            select Id 
              from Invoice_Statements__c 
                   LIMIT 1
        ];
        invoiceObj.billid=InvoiceList[0].Id;
        pagereference pg= invoiceObj.redirecttoInvoicePdf();
        System.Test.setCurrentPage(
            pg
        ); 
        InvoiceController invoiceView=new InvoiceController();
        invoiceView.displaynvoice();
        List<Line_Item__c> prodListtemp=[
            select Id
            ,Name
            ,Invoice_Statements__r.Id
            ,Merchandise__c
            ,Unit_Price__c
             from Line_Item__c 
             where Invoice_Statements__c=:invoiceView.sourceInput
        ];
        List<Line_Item__c> prodTestList=invoiceView.productList;
        Integer i=0;
      
       
        for(Line_Item__c prodListtest:prodListtemp)
        {
            system.assertEquals
                (
                    prodListtest.Invoice_Statements__r.Id
                   ,prodTestList[i].Invoice_Statements__r.Id
                );
            i++;
        }
        system.test.stopTest();
    }

}
