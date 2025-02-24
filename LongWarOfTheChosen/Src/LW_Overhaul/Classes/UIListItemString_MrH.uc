class UIListItemString_MrH extends UIListItemString;

simulated function AnimateIn(optional float Delay = -1.0)
{
	// Disable all delayed loading of list items
	super.AnimateIn(0);
}
