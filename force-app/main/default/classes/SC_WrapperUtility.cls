global class SC_WrapperUtility {

 global virtual class sobjectWrapper{
            public sobject sobjectDetails;
            public String RefreshFlag='';
            public sobjectWrapper(sobject r){
                sobjectDetails=r;
            }
        }
        
global class supersobjectWrapper{
            public String SyncTimestamp;
            public String message;
            public String errorCode;
            public List<sobject> SysParams   =    new List<sobject>();
            public List<sobject> Attachments =    new List<sobject>();
            public List<sobject> Accounts    =    new List<sobject>();
            public List<sobject> InboxItems  =    new List<sobject>();
            //public List<SC_WrapperUtility.sobjectWrapper> Accounts    =    new List<SC_WrapperUtility.sobjectWrapper>();
            //public List<SC_WrapperUtility.sobjectWrapper> InboxItems  =    new List<SC_WrapperUtility.sobjectWrapper>();
            //public List<SC_WrapperUtility.sobjectWrapper> Attachments =    new List<SC_WrapperUtility.sobjectWrapper>();
        }
        
          
  
        

} //SCWrapperUtility