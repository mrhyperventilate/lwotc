class X2EventListener_BattleScars extends X2EventListener;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Templates;

	Templates.AddItem(CreateSoldierTacticalToStrategyListeners());

	return Templates;
}

static function CHEventListenerTemplate CreateSoldierTacticalToStrategyListeners()
{
	local CHEventListenerTemplate Template;

	`CREATE_X2TEMPLATE(class'CHEventListenerTemplate', Template, 'GainRandomScarOnGravelyInjuredListener');
	Template.AddCHEvent('SoldierTacticalToStrategy', GainRandomScarOnGravelyInjured, ELD_OnStateSubmitted);
	Template.RegisterInStrategy = true;
	Template.RegisterInTactical = false;

	return Template;
}

static function EventListenerReturn GainRandomScarOnGravelyInjured(Object EventData, Object EventSource, XComGameState GameState, Name InEventID, Object CallbackData)
{
	local XComGameState_Unit Unit;

	Unit = XComGameState_Unit(EventData);

	if (Unit.IsGravelyInjured() && (Unit.kAppearance.nmScars == '' || Unit.kAppearance.nmScars == 'Scars_BLANK')) {
		Unit.GainRandomScar();
	}

	return ELR_NoInterrupt;
}
