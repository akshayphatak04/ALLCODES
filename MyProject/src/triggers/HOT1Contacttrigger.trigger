trigger HOT1Contacttrigger on Contact (before insert,before Update) 
{
     if(HOT1HandlerContactTrigger.isUpdatedMap)
    {
        HOT1HandlerContactTrigger.changeContactField(trigger.new);
    }
    HOT1HandlerContactTrigger.setIsUpdatecnt();
}