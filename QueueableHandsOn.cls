public class QueueableHandsOn implements Queueable {
    public void execute(QueueableContext context) {
        Limit__c lmt = 	Limit__c.getOrgDefaults();
        List<Pay_check__C> payCheckToCreate = new List<Pay_Check__C>();
        List<String> conIdToPassInBatchCls = new List<String>();
        for(Contact Con : [Select Id , Name , Total_Pay_Check__c from Contact Where Total_Pay_Check__c != null ]){
            if(con.Total_Pay_Check__c < lmt.ThresHold__c){
                for( Integer i = 0 ; i < con.Total_Pay_Check__c ; i++ ){
                    Pay_check__c  PayCheck = new Pay_check__c();
                    PayCheck.Name = con.Name + string.valueOf(i);
                    PayCheck.Contact__c = con.Id ; 
                    payCheckToCreate.add(PayCheck);
                }
            }else if(con.Total_Pay_Check__c >= lmt.ThresHold__c){
               conIdToPassInBatchCls.add(con.Id); 
            }
        }
        
        try{
            if(!payCheckToCreate.isEmpty()){
                Database.SaveResult[] srList = Database.insert(payCheckToCreate, false); 
            }
            if(!conIdToPassInBatchCls.isEmpty()){
                CreatePayCheck pc = new CreatePayCheck();
                pc.Ids = conIdToPassInBatchCls;
                Database.executeBatch(pc);                
            }
        }catch(exception e ){
            system.debug('exception msg ' +e.getMessage());
        }
        
    }
    
}