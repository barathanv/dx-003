@isTest
public class SC_SingleRequestMock implements HttpCalloutMock {
        protected Integer code;
        protected String status;
        protected String bodyAsString;
        protected Blob bodyAsBlob;
        protected Map<String, String> responseHeaders;

        public SC_SingleRequestMock (Integer code, String status, String body,
                                         Map<String, String> responseHeaders) {
            this.code = code;
            this.status = status;
            this.bodyAsString = body;
            this.bodyAsBlob = null;
            this.responseHeaders = responseHeaders;
        }

     
        public HTTPResponse respond(HTTPRequest req) {
            HttpResponse resp = new HttpResponse();
            resp.setStatusCode(code);
            resp.setStatus(status);
            
            string strJSONResponse = '';
            strJSONResponse = '{ "SysParams" : [ { "paramValue__c" : "HCP", "paramName__c" : "AccountType0", "Id" : "a0LF000000JOUM2MAP" }, { ';
            strJSONResponse = strJSONResponse  +'  "paramValue__c" : "Ship To",    "paramName__c" : "AccountType1",    "Id" : "a0LF000000JOUM7MAP"  }, {';
            strJSONResponse = strJSONResponse  +'  "paramValue__c" : "eSign.CustomerSvc@gmail.com",    "paramName__c" : "eMail_dbg",    "Id" : "a0LF000000JNz3YMAT"  }, {';
            strJSONResponse = strJSONResponse  +'  "paramValue__c" : "YES",    "paramName__c" : "DebugMode",    "Id" : "a0LF000000JNz3TMAT"  }, {';
            strJSONResponse = strJSONResponse  +'  "paramValue__c" : "e-Sign", "paramName__c" : "emailSubject", "Id" : "a0LF000000JO0txMAD"  }, {';
            strJSONResponse = strJSONResponse  +'  "paramValue__c" : "eSign.CustomerSvc@gmail.com",    "paramName__c" : "Program_eMail",    "Id" : "a0LF000000JO0vtMAD"  }, {';
            strJSONResponse = strJSONResponse  +'  "paramValue__c" : "eSign.CustomerSvc@gmail.com",    "paramName__c" : "eMail_cc",    "Id" : "a0LF000000JO0tnMAD"  }, {';
            strJSONResponse = strJSONResponse  +'  "paramValue__c" : "/services/data/v32.0/sobjects/Attachment/$ID$/Body",    "paramName__c" : "AttachmentURL",    "Id" : "a0LF000000JODEUMA5"  } ],';
            strJSONResponse = strJSONResponse  +'  "SyncTimestamp" : "2015-04-16 17:34:16",  "message" : "Success",  "errorCode" : "0"}';
           system.debug('reeeeeeee'+req);
           
           if(req.getEndpoint().contains('/apexrest/blankresp'))  
              resp.setBody('[{}]');
            else
              resp.setBody(strJSONResponse );
                            
            /*if(req.getEndpoint().contains('/apexrest/blankresp'))  
              resp.setBody('[{}]');
            else if(req.getEndpoint().contains('/apexrest/xyz'))  
              resp.setBody('[{"programName":"Hyperhidrosis (UAT)","programId":"a06J00000087h1ZIAQ","programCode":null,"prgProducts":[],"period":null,"message":"Physician has not been targeted for Program","isEligibleBool":false,"isEligible":"No"},{"programName":"BDM Sample Vials (UAT)","programId":"a06J00000087fQOIAY","programCode":null,"prgProducts":[],"period":null,"message":"Physician has not been targeted for Program","isEligibleBool":false,"isEligible":"No"},{"programName":"First Trial Chronic Migraine (CM) (UAT)","programId":"a06J00000087h0vIAA","programCode":null,"prgProducts":[],"period":null,"message":"Physician has not been targeted for Program","isEligibleBool":false,"isEligible":"No"},{"programName":"First Trial Cervical Dystonia (CD) (UAT)","programId":"a06J00000087fQ8IAI","programCode":null,"prgProducts":[],"period":null,"message":"Physician has not been targeted for Program","isEligibleBool":false,"isEligible":"No"},{"programName":"UROLOGY SAMPLE PROGRAM","programId":"a06J0000007p8SDIAY","programCode":"PROGRAM CODE 6","prgProducts":[],"period":"Calendar Quarter","message":"Physician does not meet include criteria","isEligibleBool":false,"isEligible":"No"},{"programName":"BACKUP PROGRAM","programId":"a06J0000007vnSeIAI","programCode":"BU MED-DERM","prgProducts":[],"period":"Calendar Quarter","message":"Territory Allocated;","isEligibleBool":false,"isEligible":"No"},{"programName":"STAFF EXPERIENCE PROGRAM","programId":"a06J00000087OyGIAU","programCode":"LASH","prgProducts":[],"period":"Calendar Quarter","message":"Physician has pending AOR for the selected program","isEligibleBool":false,"isEligible":"No"},{"programName":"BOTOX NAIVE PATIENT","programId":"a06J00000087Te4IAE","programCode":"NAIVE","prgProducts":[],"period":"Calendar Quarter","message":"Physician has pending AOR for the selected program","isEligibleBool":false,"isEligible":"No"},{"programName":"PHYSICIAN EXPERIENCE","programId":"a06J00000087TeTIAU","programCode":"BDM","prgProducts":[],"period":"Calendar Quarter","message":"Physician has pending AOR for the selected program","isEligibleBool":false,"isEligible":"No"},{"programName":"FIRST TRIAL","programId":"a06J0000007p7kaIAA","programCode":"PROGRAM CODE 5","prgProducts":[],"period":"Calendar Quarter","message":"","isEligibleBool":true,"isEligible":"Yes"},{"programName":"BACKUP PROGRAM","programId":"a06J0000007vnSeIAI","programCode":"BU MED-DERM","prgProducts":[{"territoryAllocation":0,"required":false,"programProductId":"a0DJ000000CLsjAMAT","programId":"a06J0000007vnSeIAI","productName":"TAZORAC Gel 15 x 3.5g SAMPLE","productId":"a0AJ0000007E89aMAC","productDescription":"GEL 15 x 3.5g SAMPLE","productCode":"93090","minOrderQuantity":6,"maxOrderQuantity":6,"inFlightQuantity":0,"hcpAllocation":0,"hasBotox":false},{"territoryAllocation":0,"required":false,"programProductId":"a0DJ000000CLsjBMAT","programId":"a06J0000007vnSeIAI","productName":"TAZORAC Gel 15 x 3.5g SAMPLE","productId":"a0AJ0000007E89fMAC","productDescription":"GEL 15 x 3.5g SAMPLE","productCode":"93091","minOrderQuantity":6,"maxOrderQuantity":6,"inFlightQuantity":0,"hcpAllocation":0,"hasBotox":false},{"territoryAllocation":0,"required":false,"programProductId":"a0DJ000000CLsjCMAT","programId":"a06J0000007vnSeIAI","productName":"TAZORAC Cream 15 x 3.5g SAMPLE","productId":"a0AJ0000007E89kMAC","productDescription":"CREAM 15 x 3.5g SAMPLE","productCode":"93092","minOrderQuantity":6,"maxOrderQuantity":6,"inFlightQuantity":0,"hcpAllocation":0,"hasBotox":false},{"territoryAllocation":0,"required":false,"programProductId":"a0DJ000000CLsjDMAT","programId":"a06J0000007vnSeIAI","productName":"TAZORAC Cream 15 x 3.5g SAMPLE","productId":"a0AJ0000007E89pMAC","productDescription":"CREAM 15 x 3.5g SAMPLE","productCode":"93093","minOrderQuantity":6,"maxOrderQuantity":6,"inFlightQuantity":0,"hcpAllocation":0,"hasBotox":false},{"territoryAllocation":0,"required":false,"programProductId":"a0DJ000000CLsjEMAT","programId":"a06J0000007vnSeIAI","productName":"ACZONE GEL  - 15 x 3g SAMPLE","productId":"a0AJ0000007E89VMAS","productDescription":"ACZONE GEL - 15 x 3g SAMPLE","productCode":"93669","minOrderQuantity":6,"maxOrderQuantity":6,"inFlightQuantity":0,"hcpAllocation":0,"hasBotox":false}],"period":"Calendar Quarter","message":"Preceptor;","isEligibleBool":true,"isEligible":"Yes"},{"programName":"LATISSE® SAMPLING PROGRAM","programId":"a06J00000087OxXIAU","programCode":"LAT","prgProducts":[{"territoryAllocation":0,"required":true,"programProductId":"a0DJ000000CM3fSMAT","programId":"a06J00000087OxXIAU","productName":"LATISSE 3mL 70 APPLICATOR SAMPLE","productId":"a0AJ0000007GDzEMAW","productDescription":"3 mL 70 APPLICATOR SAMPLE","productCode":"94847DB","minOrderQuantity":1,"maxOrderQuantity":100,"inFlightQuantity":0,"hcpAllocation":0,"hasBotox":false}],"period":"Calendar Quarter","message":"","isEligibleBool":true,"isEligible":"Yes"},{"programName":"JUVEDERM ULTRA PLUS XC","programId":"a06J00000087WPkIAM","programCode":"START JUVEDERM","prgProducts":[{"territoryAllocation":0,"required":true,"programProductId":"a0DJ000000CM4fOMAT","programId":"a06J00000087WPkIAM","productName":"Juvederm Ultra Plus XC Sample","productId":"a0AJ0000007Im7tMAC","productDescription":"Juvederm Ultra Plus XC Sample","productCode":"94155DB","minOrderQuantity":1,"maxOrderQuantity":50,"inFlightQuantity":0,"hcpAllocation":0,"hasBotox":false}],"period":"Calendar Quarter","message":"","isEligibleBool":true,"isEligible":"Yes"},{"programName":"JUVEDERM ULTRA XC","programId":"a06J00000087YCxIAM","programCode":"JUVEDERM","prgProducts":[{"territoryAllocation":0,"required":true,"programProductId":"a0DJ000000CM4iBMAT","programId":"a06J00000087YCxIAM","productName":"Juvederm Ultra XC Sample","productId":"a0AJ0000007Im7yMAC","productDescription":"Juvederm Ultra XC Sample","productCode":"94154DB","minOrderQuantity":0,"maxOrderQuantity":10,"inFlightQuantity":0,"hcpAllocation":0,"hasBotox":false}],"period":"Calendar Quarter","message":"Territory Allocated;","isEligibleBool":true,"isEligible":"Yes"}]');
            else if(req.getEndpoint().contains('/apexrest/justid'))
              resp.setBody('"a04J00000072Zd9IAE"');
            else
              resp.setBody(bodyAsString);
              */
           
            

            if (responseHeaders != null) {
                 for (String key : responseHeaders.keySet()) {
                resp.setHeader(key, responseHeaders.get(key));
                 }
            }
            return resp;
        }
}