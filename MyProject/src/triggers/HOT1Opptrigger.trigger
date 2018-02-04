trigger HOT1Opptrigger on Opportunity (before insert,before update) 
{
    if(HOT1Handleropptrigger.isUpdatedMap )
    {
        HOT1Handleropptrigger.changeOpportunityField(trigger.new);
    }
    HOT1Handleropptrigger.setIsUpdateopp();
}