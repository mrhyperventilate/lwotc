class X2Effect_ModifyTemplarFocus_MrH extends X2Effect_ModifyTemplarFocus;

simulated protected function OnEffectAdded(const out EffectAppliedData ApplyEffectParameters, XComGameState_BaseObject kNewTargetState, XComGameState NewGameState, XComGameState_Effect NewEffectState)
{
	local XComGameState_Unit Templar;

	Templar = XComGameState_Unit(NewGameState.GetGameStateForObjectID(ApplyEffectParameters.SourceStateObjectRef.ObjectID));

	// Templar Ghosts must not gain focus
	if (Templar.kAppearance.bGhostPawn) return;

	ModifyFocus = Templar.HasAbilityFromAnySource('DoubleRendFocus') ? 2 : 1;
	super.OnEffectAdded(ApplyEffectParameters, kNewTargetState, NewGameState, NewEffectState);
}
