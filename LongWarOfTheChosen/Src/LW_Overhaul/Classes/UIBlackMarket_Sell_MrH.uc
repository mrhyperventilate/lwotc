class UIBlackMarket_Sell_MrH extends UIBlackMarket_Sell;

// Sort by interest first, then by price
function int SortByInterest(BlackMarketItemPrice BuyPriceA, BlackMarketItemPrice BuyPriceB)
{
	local XComGameState_BlackMarket BlackMarketState;
	local XComGameState_Item ItemA, ItemB;
	local bool InterestedInItemA, InterestedInItemB;

	History = `XCOMHISTORY;
	BlackMarketState = XComGameState_BlackMarket(History.GetGameStateForObjectID(BlackMarketReference.ObjectID));
	ItemA = XComGameState_Item(History.GetGameStateForObjectID(BuyPriceA.ItemRef.ObjectID));
	ItemB = XComGameState_Item(History.GetGameStateForObjectID(BuyPriceB.ItemRef.ObjectID));

	InterestedInItemA = BlackMarketState.InterestTemplates.Find(ItemA.GetMyTemplateName()) != INDEX_NONE;
	InterestedInItemB = BlackMarketState.InterestTemplates.Find(ItemB.GetMyTemplateName()) != INDEX_NONE;

	if (InterestedInItemA && !InterestedInItemB) {
		return 1;
	} else if (!InterestedInItemA && InterestedInItemB) {
		return -1;
	} else {
		return BuyPriceA.Price > BuyPriceB.Price ? 1 : (BuyPriceA.Price == BuyPriceB.Price ? 0 : -1);
	}
}
