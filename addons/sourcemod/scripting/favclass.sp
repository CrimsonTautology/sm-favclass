
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
#include <clientprefs>
#include <smlib>
#include <tf2>
#include <tf2_stocks>

#pragma semicolon 1

#define RANDOM_CLASS 0
new Handle:g_FavClassCookie;

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
	g_FavClassCookie = RegClientCookie("favclass_class", "Favorite Class", CookieAccess_Protected);
}


/**
	Player is ingame and authenticated and ready to join a team and class.
*/
public OnClientPostAdminCheck(client){
	//If client is real player
	if(client && !IsClientReplay(client) && !IsClientSourceTV(client)){
		ChangeClientTeam(client, team:teamWithLeastPlayers());

		new favClass = 0;
		//Determine if we can get cookie info
		if (AreClientCookiesCached(client)){
			decl String:sFavClass[11];
			GetClientCookie(client, g_FavClassCookie, sFavClass, sizeof(sFavClass));
			favClass = StringToInt(sFavClass);

		}

		//Set class
		if(favClass == RANDOM_CLASS){
			TF2_SetPlayerClass(client, randomClass());
		}else{
			TF2_SetPlayerClass(client, intToClass(favClass));
		}
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

public TFClassType:intToClass(i){
	switch(i){
		case 1:
			{
				return TFClass_Scout;
			}
		case 2:
			{
				return TFClass_Soldier;
			}
		case 3:
			{
				return TFClass_Pyro;
			}
		case 4:
			{
				return TFClass_DemoMan;
			}
		case 5:
			{
				return TFClass_Heavy;
			}
		case 6:
			{
				return TFClass_Engineer;
			}
		case 7:
			{
				return TFClass_Medic;
			}
		case 8:
			{
				return TFClass_Sniper;
			}
		case 9:
			{
				return TFClass_Spy;
			}
	}

	return TFClass_Unknown;
}

public TFClassType:randomClass(){
	return intToClass( Math_GetRandomInt(1, 9));
}


public Action:Command_ChangeFavoriteClass(client, args){
	if (!client) {
		return Plugin_Handled;
	}

	if (args == 0) {
		new Handle:menu = CreateMenu(ClassMenuHandler);
		SetMenuTitle(menu, "Select Favorite Class");
		AddMenuItem(menu, "1", "Scout");
		AddMenuItem(menu, "2", "Soldier");
		AddMenuItem(menu, "3", "Pyro");
		AddMenuItem(menu, "4", "Demoman");
		AddMenuItem(menu, "5", "Heavy");
		AddMenuItem(menu, "6", "Engineer");
		AddMenuItem(menu, "7", "Medic");
		AddMenuItem(menu, "8", "Sniper");
		AddMenuItem(menu, "9", "Spy");
		AddMenuItem(menu, "0", "Random");
		SetMenuExitButton(menu, false);
		SetMenuPagination(menu, MENU_NO_PAGINATION);
		DisplayMenu(menu, client, 20);
	}else{
		//TODO determine which class is the argument

		//TODO couldn't determine class, show menu
	}

	return Plugin_Handled;
}

public ClassMenuHandler(Handle:menu, MenuAction:action, client, param){
	if(action == MenuAction_Select){
		new String:sClass[32];
		new bool:found = GetMenuItem(menu, param, sClass, sizeof(sClass));
		//PrintToChat(client, "You selected item: %d (found? %d info: %s)", param, found, info);
	
		//TODO is this cookie-safe?
		SetClientCookie(client, g_FavClassCookie, sClass);

	}else if (action == MenuAction_End){
		CloseHandle(menu);
	}

}
