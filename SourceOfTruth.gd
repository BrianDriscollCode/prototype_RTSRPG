extends Node

var mousePosition;

var party;
var partyMembers = [];

func getMousePosition():
	mousePosition = get_viewport().get_mouse_position();
	return mousePosition;
	
func getParty():
	party = get_node("../Party");
	return party;
	
func getPartyMembers():
	party = get_node("../Party");
	partyMembers = [];
	for member in party.get_children():
		partyMembers.append(member);
	
	return partyMembers;
	
	
