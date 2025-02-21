//---------------------------------------------------------------------------------------
//  FILE:    X2Condition_EvacZoneIsClear
//  AUTHOR:  mrhyperventilate
//  PURPOSE: Condition to prevent units from evacuating while hostiles are in the
//           evac zone or adjacent to the unit
//---------------------------------------------------------------------------------------

class X2Condition_EvacZoneIsClear extends X2Condition;

event name CallMeetsCondition(XComGameState_BaseObject kTarget)
{
	local XComGameState_Unit Unit;
	local XComGameState_EvacZone EvacState;
	local TTile UnitTile;

	Unit = XComGameState_Unit(kTarget);

	EvacState = class'XComGameState_EvacZone'.static.GetEvacZone();
	if (EvacState == none) {
		return 'AA_AbilityUnavailable';
	}

	if (!EvacPointValid(EvacState.CenterLocation, Unit)) {
		return 'AA_AbilityUnavailable';
	}

	Unit.GetKeystoneVisibilityLocation(UnitTile);
	if (!EvacPointValid(UnitTile, Unit)) {
		return 'AA_AbilityUnavailable';
	}

	return 'AA_Success';
}

// Adapted from Delayed EVAC WOTC by Maluco Marinero:
// https://steamcommunity.com/sharedfiles/filedetails/?id=1146417836
function bool EvacPointValid(TTile CenterTile, XComGameState_Unit FriendlyUnit)
{
	local XComGameState_Unit Unit;
	local TTile UnitTile;
	local int Zdiff;
	local float Distance, Ax, Bx;

	// class'Helpers'.static.OutputMsg("Checking EVAC at (" $ CenterTile.X $ ", " $ CenterTile.Y $ ", " $ CenterTile.Z $ ")");

	foreach `XCOMHISTORY.IterateByClassType(class'XComGameState_Unit', Unit) {
		if (Unit.IsEnemyUnit(FriendlyUnit) && Unit.IsAlive() && !Unit.bRemovedFromPlay && !Unit.IsIncapacitated()) {
			Unit.GetKeystoneVisibilityLocation(UnitTile);
			// class'Helpers'.static.OutputMsg("Enemy: (" $ UnitTile.X $ ", " $ UnitTile.Y $ ", " $ UnitTile.Z $ ")");
			Zdiff = UnitTile.Z - CenterTile.Z;
			if (Abs(Zdiff) >= class'X2TacticalGameRuleset'.default.UnitHeightAdvantage) {
				// Ignore enemies that are not on the same level as the EVAC zone
				continue;
			}
			Ax = Square(float(UnitTile.X - CenterTile.X));
			Bx = Square(float(UnitTile.Y - CenterTile.Y));
			Distance = Sqrt(Ax + Bx);
			if (Distance < 1.5) {
				// class'Helpers'.static.OutputMsg("Enemy at (" $ UnitTile.X $ ", " $ UnitTile.Y $ ", " $ UnitTile.Z $ ") is blocking EVAC because it is " $ Distance $ " tiles away from (" $ CenterTile.X $ ", " $ CenterTile.Y $ ", " $ CenterTile.Z $ ")");
				return false;
			}
		}
	}

	return true;
}
