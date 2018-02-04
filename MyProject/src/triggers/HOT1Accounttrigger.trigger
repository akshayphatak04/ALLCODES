trigger HOT1Accounttrigger on Account (before insert,before Update) 
{
     if(HOT1HandleraccountTrigger.isUpdatedMap)
    {
        System.debug('Account Trigger Fired');
        HOT1HandleraccountTrigger.updateFields(trigger.new);
    }
    HOT1HandleraccountTrigger.setIsUpdatecnt();
}