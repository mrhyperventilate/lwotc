class XMBEffect_AddBonusBombardCharges extends XMBEffect_AddItemCharges;

// Add 2 heavy weapon charges if unit does not have Bombard
function int GetItemChargeModifier(XComGameState NewGameState, XComGameState_Unit NewUnit, XComGameState_Item ItemIter)
{
	if (ItemIter.Quantity == 0)
		return 0;

	if (ItemIter.InventorySlot == eInvSlot_HeavyWeapon) {
		return NewUnit.HasAbilityFromAnySource('Bombard') ? 1 : 2;
	}
}
