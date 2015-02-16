#include <a_samp>
#include <zcmd>

new PlayerText:StatsBar;
new PlayerText:KillsTD;
new PlayerText:DeathsTD;

enum PlayerInfo
{
	Kills,
	Deaths,
	Score
}
new pInfo[MAX_PLAYERS][PlayerInfo];

main()
{
	print("\n----------------------------------");
	print(" Never Rest Freeplay (Alpha 1.0)");
	print("----------------------------------\n");
}

public OnGameModeInit()
{
	// Don't use these lines if it's a filterscript
	SetGameModeText("Never Rest Scripts");
	AddPlayerClass(0, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	return 1;
}


public OnPlayerRequestClass(playerid, classid)
{
	SetPlayerPos(playerid, 1958.3783, 1343.1572, 15.3746);
	SetPlayerCameraPos(playerid, 1958.3783, 1343.1572, 15.3746);
	SetPlayerCameraLookAt(playerid, 1958.3783, 1343.1572, 15.3746);
	return 1;
}

public OnPlayerConnect(playerid)
{
	new kstr[128], dstr[128];

	// Kills TextDraw
    format(kstr, sizeof(kstr), "Kills: %i", pInfo[playerid][Kills]);
	KillsTD = CreatePlayerTextDraw(playerid,19.000000, 431.000000, kstr);
	PlayerTextDrawBackgroundColor(playerid,KillsTD, -16776961);
	PlayerTextDrawFont(playerid,KillsTD, 1);
	PlayerTextDrawLetterSize(playerid,KillsTD, 0.500000, 1.299999);
	PlayerTextDrawColor(playerid,KillsTD, 255);
	PlayerTextDrawSetOutline(playerid,KillsTD, 1);
	PlayerTextDrawSetProportional(playerid,KillsTD, 1);
	PlayerTextDrawSetSelectable(playerid,KillsTD, 0);

	// Deaths TextDraw
	format(dstr, sizeof(dstr), "Deaths: %i", pInfo[playerid][Deaths]);
	DeathsTD = CreatePlayerTextDraw(playerid,136.000000, 431.000000, dstr);
	PlayerTextDrawBackgroundColor(playerid,DeathsTD, -16776961);
	PlayerTextDrawFont(playerid,DeathsTD, 1);
	PlayerTextDrawLetterSize(playerid,DeathsTD, 0.500000, 1.299999);
	PlayerTextDrawColor(playerid,DeathsTD, 255);
	PlayerTextDrawSetOutline(playerid,DeathsTD, 1);
	PlayerTextDrawSetProportional(playerid,DeathsTD, 1);
	PlayerTextDrawSetSelectable(playerid,DeathsTD, 0);

	// Player Stats Box
	StatsBar = CreatePlayerTextDraw(playerid,-7.000000, 431.000000, "|");
	PlayerTextDrawBackgroundColor(playerid,StatsBar, -1);
	PlayerTextDrawFont(playerid,StatsBar, 1);
	PlayerTextDrawLetterSize(playerid,StatsBar, 0.529999, 1.500000);
	PlayerTextDrawColor(playerid,StatsBar, 255);
	PlayerTextDrawSetOutline(playerid,StatsBar, 1);
	PlayerTextDrawSetProportional(playerid,StatsBar, 1);
	PlayerTextDrawUseBox(playerid,StatsBar, 1);
	PlayerTextDrawBoxColor(playerid,StatsBar, 714);
	PlayerTextDrawTextSize(playerid,StatsBar, 702.000000, 5.000000);
	PlayerTextDrawSetSelectable(playerid,StatsBar, 0);
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	
	PlayerTextDrawDestroy(playerid, KillsTD);
	PlayerTextDrawDestroy(playerid, DeathsTD);
	PlayerTextDrawDestroy(playerid, StatsBar);
	return 1;
}

public OnPlayerSpawn(playerid)
{
	
	PlayerTextDrawShow(playerid, KillsTD);
	PlayerTextDrawShow(playerid, DeathsTD);
	PlayerTextDrawShow(playerid,StatsBar);
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	
	PlayerTextDrawHide(playerid, KillsTD);
	PlayerTextDrawHide(playerid, DeathsTD);
	PlayerTextDrawHide(playerid, StatsBar);
	pInfo[killerid][Kills] += 1;
	pInfo[killerid][Score] += 1;
	pInfo[playerid][Deaths] += 1;
	return 1;
}

public OnPlayerUpdate(playerid)
{
    new kstr[50], dstr[50];
    // Kill Textdraw Update
    PlayerTextDrawHide(playerid, KillsTD);
    format(kstr, sizeof kstr, "Kills: %i", pInfo[playerid][Kills]);
    PlayerTextDrawSetString(playerid, KillsTD, kstr);
    PlayerTextDrawShow(playerid, KillsTD);

    // Deaths Textdraw Update
    PlayerTextDrawHide(playerid, DeathsTD);
    format(dstr, sizeof dstr, "Deaths: %i", pInfo[playerid][Deaths]);
    PlayerTextDrawSetString(playerid, DeathsTD, dstr);
    PlayerTextDrawShow(playerid, DeathsTD);
    return 1;
}

CMD:kills(playerid, params[])
{
	pInfo[playerid][Kills] ++;
	return 1;
}

CMD:deaths(playerid, params[])
{
	pInfo[playerid][Deaths] ++;
	return 1;
}
