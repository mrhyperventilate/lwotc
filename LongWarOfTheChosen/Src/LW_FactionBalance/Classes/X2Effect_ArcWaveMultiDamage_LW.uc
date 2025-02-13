//---------------------------------------------------------------------------------------
//  FILE:    X2Effect_ArcWaveMultiDamage_LW
//  AUTHOR:  Grobobobo
//  PURPOSE: Updates the Arcwave effect so that its damage depends on focus AND weapon tier
//---------------------------------------------------------------------------------------
class X2Effect_ArcWaveMultiDamage_LW extends X2Effect_ArcWaveMultiDamage;

var float T1DamagePerFocus;
var float T2DamagePerFocus;
var float T3DamagePerFocus;
function WeaponDamageValue GetBonusEffectDamageValue(XComGameState_Ability AbilityState, XComGameState_Unit SourceUnit, XComGameState_Item SourceWeapon, StateObjectReference TargetRef)
{
	local WeaponDamageValue Damage;
	local int FocusLevel;
	local float DamagePerFocus;

	if (TargetRef.ObjectID > 0)
	{
		SourceWeapon = AbilityState.GetSourceWeapon();
		FocusLevel = SourceUnit.GetTemplarFocusLevel();

		switch(SourceWeapon.GetMyTemplateName())
		{
			case 'ShardGauntlet_CV':
				DamagePerFocus = T1DamagePerFocus;
				break;
			case 'ShardGauntlet_MG':
				DamagePerFocus = T2DamagePerFocus;
				break;
			case 'ShardGauntlet_BM':
				DamagePerFocus = T3DamagePerFocus;
				break;
			default:
				DamagePerFocus = T1DamagePerFocus;
		}

		Damage.Damage = max(1, round(DamagePerFocus * FocusLevel));
	}
	return Damage;
}

