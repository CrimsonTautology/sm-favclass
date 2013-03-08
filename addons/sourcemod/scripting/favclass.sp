
/**
 * vim: set ts=4 :
 * =============================================================================
 * SourceMod Favorite Class Plugin
 * Automatically asigns a player to a team and a class when joining a server.
 *
 *
 * =============================================================================
 *
 */

#include <sourcemod>
#include <smlib>

#pragma semicolon 1

public Plugin:myinfo =
{
	name = "favclass",
	author = "Billehs",
	version = "0.1",
	description = "TF2 Favorite Class and Auto Team Assigner",
	url = "https://github.com/CrimsonTautology/sm_favclass"
};




public OnPluginStart()
{


	RegConsoleCmd("sm_favclass", Command_ChangeFavoriteClass);
	RegConsoleCmd("sm_tst1", tst1);
	RegConsoleCmd("sm_tst2", Command_Tst2);
	RegConsoleCmd("sm_tst3", tst3);
	RegConsoleCmd("sm_tst4", tst4);
	RegConsoleCmd("sm_tst5", tst5);
}


public Action:Command_ChangeFavoriteClass(client, args){
	if (!client) {
		return Plugin_Handled;
	}

	if (args == 0) {
		//TODO display menu
		//ReplyToCommand(client, "[SM]FFFFFFF Nomgrep Incorrect Syntax:  !nomsearch <searchstring>");
		return Plugin_Handled;
	}else{
			//TODO determine which class is the argument

			//TODO couldn't determine class, show menu
	}

	return Plugin_Continue;	
}




public Action:Command_Tst2(client, args){
	PrintToChatAll("Hit tst2");
	return Plugin_Handled;
}
public Action:tst3(client, args){
	PrintToChatAll("Hit tst3jk");
	return Plugin_Handled;
}
public Action:tst4(client, args){
	return Plugin_Handled;
}
public Action:tst5(client, args){
	return Plugin_Handled;
}
