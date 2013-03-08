
/**
 * vim: set ts=4 :
 * =============================================================================
 * SourceMod Favorite Class Plugin
 * Automatically asigns a player to a class when joining a server.
 *
 *
 * =============================================================================
 *
 */

#include <sourcemod>
#include <smlib>
#include <tf2>
#include <tf2_stocks>

#pragma semicolon 1

public Plugin:myinfo =
{
	name = "favclass",
	author = "Billehs",
	version = "0.1",
	description = "TF2 Favorite Class",
	url = "https://github.com/CrimsonTautology/sm_favclass"
};




public OnPluginStart()
{


	RegConsoleCmd("sm_favclass", Command_ChangeFavoriteClass);
	RegConsoleCmd("sm_tst2", Command_Tst2);
	RegConsoleCmd("sm_tst3", tst3);
	RegConsoleCmd("sm_tst4", tst4);
	RegConsoleCmd("sm_tst5", tst5);
}


/**
	Player is ingame and authenticated and ready to join a team and class.
*/
public OnClientPostAdminCheck(client){
	//If client is real player
	if(client && !IsClientReplay(client) && !IsClientSourceTV(client)){
		ChangeClientTeam(client, team:teamWithLeastPlayers());
		TF2_SetPlayerClass(client, randomClass());
	}

}

/**
	Determine which team has less players and return that one
*/
public TFTeam:teamWithLeastPlayers(){
	new red = 0;
	new blu = 0;
	new TFTeam:team;

	//For each player in the game
	for (new client=1; client <= MaxClients; client++) {
		if(!IsClientAuthorized(client)){
				continue;
		}

		team = TFTeam:GetClientTeam(client);
		if(team == TFTeam_Red){
			red++;
		}else if(team == TFTeam_Blue){
			blu++;
		}
	}

	return red < blu ? TFTeam_Red : TFTeam_Blue;
}

public TFClassType:randomClass(){
	switch( Math_GetRandomInt(0, 8)){
		case 0:
		{
			return TFClass_Scout;
		}
		case 1:
		{
			return TFClass_Sniper;
		}
		case 2:
		{
			return TFClass_Soldier;
		}
		case 3:
		{
			return TFClass_DemoMan;
		}
		case 4:
		{
			return TFClass_Medic;
		}
		case 5:
		{
			return TFClass_Heavy;
		}
		case 6:
		{
			return TFClass_Pyro;
		}
		case 7:
		{
			return TFClass_Spy;
		}
		case 8:
		{
			return TFClass_Engineer;
		}
	}

	return TFClass_Unknown;
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
