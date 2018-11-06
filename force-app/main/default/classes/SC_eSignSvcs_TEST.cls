@isTest(SeeAllData=false)
public class SC_eSignSvcs_TEST
{

   static testMethod void test_setSynchCompleteMethod() {
   
       dateTime currentDateTime =system.now();
       SC_eSignSvcs.setSynchCompleteTimestamp(currentDateTime.format('MM/dd/yyyy HH:mm:ss', 'America/New_York'));
       SC_eSignSvcs.setSynchCompleteTimestamp(currentDateTime.format('MM/dd/yyyy HH:mm:ss', 'America/New_York'));
       
   } // test method
   
   static testMethod void test_getListOfAccountsMethod() {
   
       Map<String, String> wsRespParam = new Map<String, String>();
       wsRespParam.put('Content-Type', 'application/xml'); 
       
        SC_SingleRequestMock  fakeResponse =  new SC_SingleRequestMock (200,'SUCCESS','',wsRespParam);
        //'{"id":"https://test.salesforce.com/id/00DJ0000001OYxLMAW/005J0000001RAEEIA4","issued_at":"1385978232454","instance_url":"https://cs10.salesforce.com","signature":"lp5tIGs5i7J8iEs6487wI1zfsTusaQrxDS+jU6Ux7Dk=","access_token":"00DJ0000001OYxL!ARsAQEBhJRrlrI7TYOHYZMVYiMb9JkgHfaHAb2p.tbvQh2tl4j8eb8PDpX68ymTRAqne9LBrIAgV8w_3ed494QBgn82wpfDs"}',
        // wsRespParam);
        
        Account aPersonObj = new Account();
        aPersonObj.firstname = 'Test Person Account001';
        aPersonObj.lastname = 'LN';        
        insert aPersonObj ;
        
        Account aObj = new Account();
        aObj.name = 'Test Business Account001';
        insert aObj;
        
        Inbox__c objInbox = new Inbox__c ();
        objInbox.account__C =  aObj.id;
        objInbox.status__c = 'Pending';
        objInbox.Fax_Number__c = '1800ABCTEST';
        objInbox.guid__c = 'GUID_12345';
        objInbox.eMail__c = 'test@test.com';
        insert objInbox ;
        
         Inbox__c objInbox2 = new Inbox__c ();
        objInbox2 .account__C =  aPersonObj .id;
        objInbox2 .status__c = 'Pending';
        objInbox2 .Fax_Number__c = '1800ABCTEST';
        objInbox2 .guid__c = 'GUID_12345';
        objInbox2 .eMail__c = 'test@test.com';
        insert objInbox2 ;
        
        
        
        SC_WrapperUtility.supersobjectWrapper objResponse = SC_eSignSvcs.getListOfAccounts();

        Test.startTest();  
          try{
             Test.setMock(HttpCalloutMock.class,fakeResponse);
             
             HttpRequest request = new HttpRequest(); 
   
                  request.setMethod('GET');
                  string instanceUrl  = 'https://na10.salesforce.com';
                  request.setEndpoint(instanceUrl + '/services/apexrest/eSign?SYNCOBJECTNAME=ALL');
                  request.setHeader('Authorization', 'OAuth '+ 'accessToken'); 
                  Http http = new Http();
    
                  HTTPResponse response = http.send(request);
                  System.debug('The response is'+response.getBody());
          
         
              if (response.getStatusCode() >= 300 ) {
                        // there was a problem and server responded with something other than success
                        throw new SC_GlobalUtils.Application_Exception(response.getBody());  
                  }
      
                  System.debug('BODY: '+response.getBody());
                  System.debug('STATUS: '+response.getStatus());
                  System.debug('STATUS_CODE: '+response.getStatusCode());
                  System.debug('response' + response.getBody());
              
              
                  
                  
         }catch(Exception e){} 
         
         Test.stopTest();
   
   } // test method

} // class