@RestResource(urlMapping='/eSign/*')
global with sharing class SC_eSignSvcs
{

@HttpPost
    global static void setSynchCompleteTimestamp(string strClientDateTime)
    {
       RestRequest req = RestContext.request;
       
       List<Inbox_Synch_Tracker__c> lST = new List< Inbox_Synch_Tracker__c>();
       lST = [Select id, user__c , Last_Synch_Date__c , Client_Synch_Date__c
                                             from Inbox_Synch_Tracker__c where user__c = :userinfo.getUserId() ];
        
       
        dateTime currentDateTime =system.now();
        if (lST.size()  == 0)
        {
          Inbox_Synch_Tracker__c  objSynchTrk = new Inbox_Synch_Tracker__c();
          objSynchTrk.user__c  = userinfo.getUserId();
          objSynchTrk.Last_Synch_Date__c = currentDateTime;
          objSynchTrk.Client_Synch_Date__c  = strClientDateTime ; 
          Insert objSynchTrk ;
        }
        else
        {
         Inbox_Synch_Tracker__c  objSynchTrk = lST[0];
         objSynchTrk.Last_Synch_Date__c = currentDateTime;
         objSynchTrk.Client_Synch_Date__c = strClientDateTime ; 
         Update objSynchTrk;
        }
        
    }

@HttpGet
    global static SC_WrapperUtility.supersobjectWrapper  getListOfAccounts()
    {
        String strAccountID = '' ;
        RestRequest req = RestContext.request;
         string strObject;
        if (Test.IsRunningTest())
         strObject = null;
        else{
          strObject = req.params.get('SYNCOBJECTNAME');
          strAccountID = req.params.get('ACCOUNTID');
          if (strAccountID == null || strAccountID == '') strAccountID = 'NA';
        }
        if (strObject == null )
        strObject = 'ALL' ;
        //List<SC_WrapperUtility.sobjectWrapper> lstWrapAccounts=new List<SC_WrapperUtility.sobjectWrapper>();
        List<SObject> lstWrapSysParams=new List<SObject >(); 
        List<SObject> lstWrapAccounts=new List<SObject >(); 
        List<SObject> lstWrapAttachments =new List<SObject >();  
        List<SObject> lstWrapInboxItems =new List<SObject >(); 
        String strComments = '';
        //List< SysParam__c > lP 
        
        if (strObject == 'ALL' || strObject  == 'SP'){
            lstWrapSysParams = [Select id, paramName__c, paramValue__c
                            from SysParam__c
                            Where ParamType__c = true
                            ];
        }
                            
        List<Account> lA;
        boolean bPersonAccountEnabled = SC_GlobalUtils.personAccountsEnabled() ;
        
        //if (bPersonAccountEnabled )
        {
            string strQuery = '';
            strQuery = 'Select id, isPersonAccount ,Name, PersonTitle, Salutation, firstname, lastname, recordType.name ,comments__c , comments2__c from Account';
            If (strAccountID != null && strAccountID != '' && strAccountID != 'NA'){
              strQuery = strQuery  + ' Where Id = \'' + strAccountID + '\'' ;
            }
            else{
               strQuery = strQuery  + ' Where Id in (Select account__c from Inbox__c ) Limit 10 ' ;
            }
            lA = Database.Query(strQuery);
        }
       /* else
        {
            lA = [Select id, Name,  Salutation, 
                                   firstname, lastname, recordType.name ,
                                   comments__c , comments2__c
                            from Account
                            Where Id in (Select account__c from Inbox__c )
                            //order by name
                            Limit 10
                            ];
        }*/
                                    
        
        //List<Inbox__c> lInboxItems
        if (strObject == 'ALL' || strObject  == 'INBOX'){
            if (strObject == 'INBOX' && strAccountID != 'NA'){
               lstWrapInboxItems = [SELECT id, Name , Account__r.name, Account__r.Id , status__c , Fax_Number__c , eMail__c 
                                      FROM Inbox__c where status__c = 'Pending'  
                                      and Account__c = : strAccountID
                                      ];
            }
            else{
            lstWrapInboxItems = [SELECT id, Name , Account__r.name, Account__r.Id , status__c , Fax_Number__c , eMail__c 
                                      FROM Inbox__c where status__c = 'Pending'  
                                      //and Account__r.isPersonAccount = true 
                                      ];
            }
        }
               
        //List<Attachment> lFiles 
        if (strObject == 'ALL' || strObject  == 'FILES'){
            lstWrapAttachments = [SELECT Id, ParentId, Name // , Body 
                                   from Attachment 
                                   where    parentid !=  null 
                                   and ParentId in ( Select id FROM Inbox__c where status__c = 'Pending'  
                                                      and Account__c in : lA )   //  and Account__r.isPersonAccount = true )
                                   and contenttype in ('application/pdf' )                   
                                   ];
        }
             
        /*
        for (SysParam__c obj  : lP )
        {
           SObject objWrapper = obj;
           lstWrapSysParams.add(objWrapper );
        }
        */
        if (strObject == 'ALL' || strObject  == 'ACCOUNT'){    
            if (bPersonAccountEnabled ){                       
            for (Account objAccount : lA)
            {
                  strComments = '';
                 /*  if ((objAccount.comments__c == null || objAccount.comments__c == '') && objAccount.isPersonAccount) 
                   {
                           strComments = objAccount.Salutation + ' ' +  objAccount.firstName + ' ' + objAccount.LastName + ' ' ;
                           objAccount.comments__c =     strComments;
                   }*/
                   if ((objAccount.comments__c == null || objAccount.comments__c == ''))// && !objAccount.isPersonAccount) 
                   {
                       strComments = objAccount.Name  ;
                       objAccount.comments__c = strComments;
                   }
                   if (objAccount.comments2__c == null || objAccount.comments2__c == '') 
                   {
                       
                       objAccount.comments2__c = 'No Info available';
                   }
                   //SObject objWrapper = objAccount;
                   lstWrapAccounts.add(objAccount);
            } // for
            } //if (bPersonAccountEnabled )
            else {
            for (Account objAccount : lA)
            {
                  strComments = '';
                   if ((objAccount.comments__c == null || objAccount.comments__c == '')) 
                   {
                       strComments = objAccount.Name  ;
                       objAccount.comments__c = strComments;
                   }
                   if (objAccount.comments2__c == null || objAccount.comments2__c == '') 
                   {
                       
                       objAccount.comments2__c = 'No Info available';
                   }
                   //SObject objWrapper = objAccount;
                   lstWrapAccounts.add(objAccount);
            } // for
            } //if  bPersonAccountEnabled   == false
                        
        } // if all or account
        System.debug('lstWrapAccounts.size ' + lstWrapAccounts.size());
        // System.debug('lstWrapAccounts.size ' + lstWrapAccounts );
        /*
        for (Inbox__c objInbox : lInboxItems)
        {
           SObject objWrapper = objInbox;
           lstWrapInboxItems.add(objWrapper );
        }
        
        for (Attachment objFile : lFiles)
        {
           // SC_WrapperUtility.sobjectWrapper wrapper=new SC_WrapperUtility.sobjectWrapper(objAccount);
           SObject objWrapper = objFile;
           lstWrapAttachments.add(objWrapper );
        }
        */
        dateTime newDate=system.now();
        String dateInFormat = newDate.formatGMT('yyyy-MM-dd HH:mm:ss');
        
        SC_WrapperUtility.supersobjectWrapper superWrap=new SC_WrapperUtility.supersobjectWrapper();//Instantiating the superclass
    
        if (strObject == 'ALL' || strObject  == 'SP'){
            superWrap.SysParams = lstWrapSysParams ;
        }
        
        if (strObject == 'ALL' || strObject  == 'ACCOUNT'){
            superWrap.Accounts = lstWrapAccounts; 
        }
        
        if (strObject == 'ALL' || strObject  == 'INBOX'){
            superWrap.InboxItems = lstWrapInboxItems; 
        }
        
        if (strObject == 'ALL' || strObject  == 'FILES'){
            superWrap.Attachments = lstWrapAttachments; 
        }
        
        superWrap.SyncTimestamp=dateInFormat;//Current UTC timestamp of the server  
        superWrap.message     = 'Success';
        superWrap.errorCode = '0' ;              
        system.debug('superWrap ' + superWrap );
        return superWrap ;
    
    } // getListOfAccounts

}