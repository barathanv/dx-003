public without sharing class SC_GlobalUtils {

    // Created By : 
    // class Application_Exception 
    //
    public without sharing class Application_Exception extends Exception{
    
    } // re-usable class to handle logging of exceptions


    public static Boolean nullOrEmpty(Object o) {
      return (null == o) ||
        ((o instanceof String) && (0 == ((String)o).trim().length())) ||
        ((o instanceof List<object>) && (0 == ((List<object>)o).size()));
    }
    
    
    // Created By : 
    // checkNull 
    //
    public static String checkNull(String s){
       system.debug('String sent in: '+s);
       return s==null?'':s;  
    } // Check If Input is null
    
    public static string genGUID()    
    {
        Blob b = Crypto.GenerateAESKey(128);
        String h = EncodingUtil.ConvertTohex(b);
        String guid = h.SubString(0,8)+ '-' + h.SubString(8,12) + '-' + h.SubString(12,16) + '-' + h.SubString(16,20) + '-' + h.substring(20);
        system.debug(guid);
        return guid ;
    } //genGUID
    
    // Created By : 
    // CreateErrorLog
    //   
    public static SC_Error_Log__c  CreateErrorLog(string Type,string Message, string Source,string objName,String recId){
      system.debug('Start of UpdateApplicationLog method');
      system.debug('Parameters passed:-');
      system.debug('Source='+Source);
      system.debug('objName='+objName);
      system.debug('Type='+Type);
      system.debug('Message='+Message);
      
      datetime nowDateTime = datetime.now();
      
      SC_Error_Log__c applog = new SC_Error_Log__c();
      applog.RecordDate__c = nowDateTime;
      applog.Type__c       =     Type;
      applog.Message__c    =     Message;
      applog.Source__c     =     Source;
      applog.Object__c     =     objName;
      applog.RecordId__c   =    recId;
      return applog;
   } // CreateErrorLog
   
   public static Boolean personAccountsEnabled()
{
    // Describe the Account object to get a map of all fields
    // then check to see if the map contains the field 'isPersonAccount'
    return Schema.sObjectType.Account.fields.getMap().containsKey( 'isPersonAccount' );
}
   
   

} // class