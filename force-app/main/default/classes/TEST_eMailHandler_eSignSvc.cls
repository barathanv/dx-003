/**
* 
* <p>
* This class is the test class for the 'SC_eSignSvceMailHandler ' class
* 
* @author          barathan v 
* @version         1.0
* @date            17-APR-2015
* @description     This class is the test class for 'SC_eSignSvceMailHandler ' class
*/

/*----------------
*Modification Log:
*----------------
*Developer            Date          Version               Description
*-----------------------------------------------------------------------------------------
* barathan v         02-APR-2015        1.0            Initial Version
*/

@isTest(SeeAllData=false)
private class TEST_eMailHandler_eSignSvc{

    static testMethod void TEST_eMailHandlereSignSvc() {
          
           
        test.starttest();
        Date tempDate = system.today();    
        
        
         // Create a new email 
        Messaging.InboundEmail email = new Messaging.InboundEmail();
        Messaging.InboundEnvelope envelope = new Messaging.InboundEnvelope();
        email.subject = 'eSign - Signed Document';
        email.plainTextBody = '-- The below data is for integration with other system. Please disregard.';
        envelope.fromAddress = 'test@test.test' ;  
        
        
                
        Datetime dt = system.now();
        string strDate = dt.format();
        Messaging.InboundEmail.header objeMailHeader = new Messaging.InboundEmail.header();
        objeMailHeader.name= 'Date' ;
        objeMailHeader.value = strDate ;
        Messaging.InboundEmail.header[] objHA = new Messaging.InboundEmail.header[1];
        Messaging.InboundEmail.BinaryAttachment objBA = new Messaging.InboundEmail.BinaryAttachment();
        objBA.fileName = 'test-dlt1-00PF000000J0eqPMAR-dlt2-.pdf';
        objBA.mimeTypeSubType  = 'application/pdf';
        objBA.body=Blob.valueof('test');
        
        Messaging.InboundEmail.BinaryAttachment objBA2 = new Messaging.InboundEmail.BinaryAttachment();
        objBA2.fileName = 'test.xls';
        objBA2.mimeTypeSubType  = 'application/vnd.ms-excel';
        objBA2.body=Blob.valueof('test');
        
        Messaging.InboundEmail.BinaryAttachment objBA3 = new Messaging.InboundEmail.BinaryAttachment();
        objBA3.fileName = 'test.doc';
        objBA3.mimeTypeSubType  = 'application/msword';
        objBA3.body=Blob.valueof('test');
        
        Messaging.InboundEmail.BinaryAttachment[] binaryAttachments = new Messaging.InboundEmail.BinaryAttachment[3];
        binaryAttachments[0] = objBA ;
        binaryAttachments[1] = objBA2 ;
        binaryAttachments[2] = objBA3 ;
        
        objHA[0]  =objeMailHeader;
        email.headers = objHA ;
        email.binaryAttachments = binaryAttachments;
        // setup controller object
        SC_eSignSvceMailHandler catcher = new SC_eSignSvceMailHandler();
        catcher.handleInboundEmail(email, envelope);
        
        try{
         List<Signed_Documents__c>   objSD = [select id, name from Signed_Documents__c limit 1];
         system.debug('objSD .size' + objSD .size());
        }
        catch(Exception ex){}
        
        Test.stopTest();     
    } //TEST_eMailHandlerWeb2Lead
    
    
     
}