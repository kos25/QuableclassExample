public class CreatePayCheck implements Database.Batchable<sObject> , Database.Stateful {
     public   List<String> Ids ; 
    
    public CreatePayCheck(){
        Ids = new List<String>();
    }
     public Database.QueryLocator start(Database.BatchableContext bc) {
        String Query = 'Select Id , Name , Email, Total_Pay_Check__c from contact Where  Id  IN : Ids ';
        return Database.getQueryLocator(Query);
             
     }
      public void execute(Database.BatchableContext BC,List<Contact> Conlist){
          List<Pay_check__c> payCheckToCreate  = new List<Pay_check__c>();
          try{
             
          for(Contact Con : Conlist ){
              for( Integer i = 0 ; i < con.Total_Pay_Check__c ; i++ ){
                  Pay_Check__c pc = new Pay_Check__c();
                  pc.Name = con.Name + string.valueOf(i);
                  pc.Contact__c = con.Id ; 
                  payCheckToCreate.add(pc); 
              }
                            
             }  
            Database.SaveResult[] srList = Database.insert(payCheckToCreate, false); 
          }catch(exception e ){
              system.debug('exception msg '+e.getMessage());
          }
          
      }
    
    
    
     public void finish(Database.BatchableContext BC){
     }
}