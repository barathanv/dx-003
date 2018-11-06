global class SC_eSignSvceMailHandler implements Messaging.InboundEmailHandler {
  
      global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email, Messaging.InboundEnvelope envelope) {
          
          Messaging.InboundEmailResult result = new Messaging.InboundEmailresult();
          
          String strSubject = '';
          String emailContent = '';
          string htmlContent = '';
          string strStatus = '';
          string strFileName = '';
          Blob bContent ;
          string strMimeTypeSubType = '';
          string strFromAddress = '';

          try
          {                    
              emailContent = email.plainTextBody;
              htmlContent =  email.htmlBody ;
          }catch(Exception ex)
          {
              //ignore error
              system.debug(ex.getMessage());
          }
          strSubject = email.subject ;
          strFromAddress = email.fromAddress ;
          bContent = null;
          //string guid = SC_GlobalUtils.genGUID();
          string strRemarks = strSubject + '\n  ' ;
          integer nBinaryFileCounter = 0;
          integer nTextFileCounter = 0;
          
          // Add Request Log record
          if (htmlContent != null && htmlContent != '')
          {
              strRemarks = strRemarks + (htmlContent.length() > 5000?htmlContent.substring(0,5000):htmlContent) ; 
          }
          else if  (emailContent != null && emailContent != '')
          {
              strRemarks  = strRemarks + (emailContent.length() > 5000?emailContent.substring(0,5000):emailContent) ;
          }
          system.debug('strRemarks  ' + strRemarks  );
          system.debug('email.binaryAttachments' + email.binaryAttachments.size());
          if (email.binaryAttachments != null)
          {
              for (Messaging.InboundEmail.BinaryAttachment bA : email.binaryAttachments)
              {
                  bContent = ba.body ;
                  strFileName = ba.fileName ;
                  strMimeTypeSubType = bA.mimeTypeSubType ;
                  System.debug('Attachment info' + strFileName + '-'+ strMimeTypeSubType );

                  string strFileXtn = GetFileExtension(strMimeTypeSubType );
                  if (bContent != null)
                  {
                      AddToQueue( bContent, strFileName, strFileXtn, strMimeTypeSubType , strFromAddress ,strRemarks  );
                  }
                  nBinaryFileCounter = nBinaryFileCounter +1;
              }
          }// binary attachments exist
          else
          {
              system.debug('No binary attachments');
              strRemarks = 'No binary attachments';
          }
          
          
          
          return result;
      
      
      } //handleInboundEmail
      
    static void AddToQueue( blob bContent, string strFileName, string strFileXtn, string strContentType, string strFromAddress, string strRemarks   )
    {
         Signed_Documents__c qR = new Signed_Documents__c();
         qR.From__c    = strFromAddress ;
         qR.Status__c  = 'Pending Process';
         qr.Remarks__c = strRemarks   ;
         try{
              //string strFileName = 'SafetyInstructions001-dlt1-00PF000000J0eqPMAR-dlt2-.pdf' ;
             string strTemp = strFileName.subStringAfter('dlt1-');
             system.debug(strTemp);
             integer dlPos = strTemp.indexOf('-dlt2');
             system.debug(strTemp.substring(0,dlPos));
             string strInboxId = strTemp.substring(0,dlPos);
             Attachment a = [select parentId from Attachment where id = :strInboxId];
             //Inbox__c objTemp = [select id from Inbox__c where id = :a.parentId ];
             qr.Inbox__c  = a.parentId;
         }
         catch(Exception ex)
         {
             system.debug(ex.getMessage());
         }
         
         insert qR;
         
         Attachment fa = new Attachment();
         fa.ParentId = qR.id;
         fa.body = bContent;
         fa.Name = strFileName;
         fa.ContentType = strContentType;
         insert fa;
    }
    
    static string GetFileExtension(string  strMimeType)
    {
    
            string strCT1 = 'UNKNOWN';
            string strCT0 = '';   
                  
            //AggregateResult[] groupedResults = [select contenttype from attachment group by contenttype];
              //for (AggregateResult ar : groupedResults)  {
                //System.debug('contenttype' + ar.get('contenttype'));
                if (strMimeType != null)
                {
                    string strCT =  strMimeType ; //String.valueOf(ar.get('ContentType'));

                    system.debug('Content Type' +strCT);
                     
                    if ( (strCT.indexOf('/') >= 0) )    
                    {
                       strCT0 =  strCT.substringAfter('/');
                    }
                    if ( (strCT.indexOf('image/') >= 0) )
                    {
                        if (strCT0.indexOf('bmp') >= 0)
                        {
                            strCT1 = 'bmp';
                        }
                        strCT1 =  strCT0 ;
                    }
                    else if ( (strCT.indexOf('application/pdf') >= 0) )
                    {
                        strCT1 = strCT0 ;
                    }
                    else if ( (strCT.indexOf('text/plain') >= 0)  || (strCT.indexOf('text/rtf') >= 0))
                    {
                        strCT1 = 'txt';
                    }
                    else if ( (strCT.indexOf('text/html') >= 0) )
                    {
                        strCT1 = 'html';
                    }
                    else if ( (strCT == 'application/vnd.ms-excel') || (strCT.indexOf('spreadsheet') >= 0 ))
                    {
                        strCT1 = 'xls';
                    }
                    else if ( (strCT == 'application/ms-word') || (strCT.indexOf('msword') >= 0 ))
                    {
                        strCT1 = 'doc';
                    }
                    else if ( (strCT.indexOf('wordprocessingml.document') >= 0 ))
                    {
                        strCT1 = 'doc';
                    }
                    system.debug('Content Type Result : ' +strCT1);

                } //if strmimetype != null
                    return strCT1;                
            //} for
                
    }
      
    
        
  } // SC_eSignSvceMailHandler