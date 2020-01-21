@isTest
public class QueueableHandsOn_Tc {
    @istest
    public static void QueueableHandsOnTestcase1(){
          Limit__c lmt = new Limit__c();
          lmt.ThresHold__c = 25 ;  
          insert lmt;
        List<Contact>  conlist = new List<Contact>();
        for(Integer i = 0 ; i < 10 ; i++){
            contact con = new Contact();
            con.FirstName = 'test contact';
            con.LastName = string.valueOf(i);
            con.Total_Pay_Check__c = 4 ;
            conlist.add(con);  
        }
        
        insert conlist ; 
        Test.startTest();
         System.enqueueJob(new QueueableHandsOn());
        Test.stopTest();  
        
        List<Contact> Contactlist = [select Id , Name , Total_Pay_Check__c ,(select id , name from Pay_checks__r) from contact where  Total_Pay_Check__c != null];
        for(contact con : Contactlist){
            List<Pay_check__c> PaycheckList = con.Pay_checks__r;
            system.assertEquals(PaycheckList.size(), con.Total_Pay_Check__c );
        }
        
    }
    @istest
    public static void QueueableHandsOnTestcase2(){
         Limit__c lmt = new Limit__c();
          lmt.ThresHold__c = 25 ;  
          insert lmt;
        List<Contact>  conlist = new List<Contact>();
        for(Integer i = 0 ; i < 10 ; i++){
            contact con = new Contact();
            con.FirstName = 'test contact';
            con.LastName = string.valueOf(i);
            con.Total_Pay_Check__c = 30 ;
            conlist.add(con);
        } 
        insert conlist ; 
        Test.startTest();
          System.enqueueJob(new QueueableHandsOn());
        Test.stopTest(); 
        
        List<Contact> Contactlist = [select Id , Name , Total_Pay_Check__c ,(select id , name from Pay_checks__r) from contact where  Total_Pay_Check__c != null];
        for(contact con : Contactlist){
            List<Pay_check__c> PaycheckList = con.Pay_checks__r;
            system.assertEquals(PaycheckList.size(), con.Total_Pay_Check__c );
        }
      
    }
 
}