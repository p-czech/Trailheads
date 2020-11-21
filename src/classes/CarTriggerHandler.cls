public class CarTriggerHandler {
    
    public void handleBeforeInsert(List<Car__c> cars) {
        for(Car__c car : cars) {
            car.Car_Name__c = car.Brand__c + ' ' + car.Model__c + ' ' + car.Engine__c; 
        }
        
    }
    public void handleBeforeUpdate(List<Car__c> cars) {
        
    }
    
    public void handleAfterUpdate(List<Car__c> cars) {
        
    }

}