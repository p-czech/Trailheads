public class TestObject1Batch implements Database.Batchable <sObject> {
    
    
    public Database.QueryLocator start (Database.BatchableContext info){
        System.debug('start method: ');
        String SOQL = 'SELECT  Name, MappedName__c FROM TestObject1__c'; // could be WITH SECURITY_ENFORCED
        return Database.getQueryLocator(SOQL);
    }    
    
    public void execute(Database.BatchableContext bc, List<TestObject1__c> scope){
        System.debug('execute method: ');
        List<TestObject1__c> tObjectsToUpdate = new List<TestObject1__c>();
        	      
        for(TestObject1__c obj : scope) {
            System.debug(obj);
            obj.MappedName__c = obj.Name;
            tObjectsToUpdate.add(obj);
        }
        
        Database.SaveResult[] srList = Database.update(tObjectsToUpdate, false);
        
        for(Database.SaveResult sr : srList) {
            if(sr.isSuccess()) {
                System.debug('Success: ' + sr.getId());
            }else {
                for(Database.Error err : sr.getErrors()) {
                    System.debug('Error' + err);
                }
            }
        }
    }
    public void finish (Database.BatchableContext bc) {
        System.debug('Batch finished');
        AsyncApexJob job = [SELECT Id, Status, NumberOfErrors,
            JobItemsProcessed,
            TotalJobItems, CreatedBy.Email
            FROM AsyncApexJob
            WHERE Id = :bc.getJobId()];
        
    }

}