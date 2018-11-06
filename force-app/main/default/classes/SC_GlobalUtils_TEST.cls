@isTest(SeeAllData=false)
public class SC_GlobalUtils_TEST
{

   static testMethod void test_method() {
   
       SC_GlobalUtils.Application_Exception objAE =  new SC_GlobalUtils.Application_Exception('TEST Exception');

       string s ;
       string strRetVal = SC_GlobalUtils.checkNull(s);
       System.AssertEquals(strRetVal ,'');
        
        string strError  = 'Test Error' ;
        SC_Error_Log__c objErrorLog =  SC_GlobalUtils.CreateErrorLog('ERROR', strError  , 'TEST class','Test Obj','TestRecordID'  );
        
        boolean bRetVal = SC_GlobalUtils.personAccountsEnabled() ;
        string strGUID = SC_GlobalUtils.genguid();
        
   } // test method

} // class