IncludeScript("dr_gooby_neo/vs_library");

function startRotatingEntity() {
    EntFire("trap1", "Start");
}

function endTrap() {
    EntFire("moving1", "Open");
	EntFire("moving2", "Open");
}

function spinTrap(){
	EntFire("spintrap", "Start");
}

function movingPlatforms(){
	EntFire("platform1", "Open");
	EntFire("platform2", "Open");
}

function mazeTrap(){
	EntFire("maze", "Open");
}

::activeFighter <- null;

::DeathTrigger <- function(inData){
	DeathHappened(inData.userid);
}


//function sniperRoom(){
::sniperRoom <- function(){
	ScriptPrintMessageCenterAll("a Jumper beat the map and selected SNIPER");
	local adestination = Entities.FindByName(null, "sniper_activator");
	local jdestination = Entities.FindByName(null, "sniper_jumper");
	local playerActivator = getActivator(null);
	playerActivator.SetOrigin(adestination.GetOrigin());
	activator.SetOrigin(jdestination.GetOrigin());
	EntFire("portal_s","enable");
	
	activeFighter = activator;
}

//function DeathHappened(userid){
::DeathHappened <- function(userid){
	local player = ToExtendedPlayer( activeFighter ).GetUserID();
	local playerDeath = userid;
	
	if(player != null){
		if(player == playerDeath){ // if active fighter dies
			ScriptPrintMessageCenterAll("The activator BEAT the JUMPER!");
			EntFire("portal_s", "disable");
		}else if (playerDeath == getActivator().GetUserID()){
			ScriptPrintMessageCenterAll("The jumper BEAT the ACTIVATOR!");
		}
	}
}

// USE https://github.com/samisalreadytaken/vs_library/blob/master/Documentation.md TO GET USERID


::jumpRoom <- function(){
	ScriptPrintMessageCenterAll("a Jumper beat the map and selected JUMP");
	local adestination = Entities.FindByName(null, "jumproom_activator");
	local jdestination = Entities.FindByName(null, "jumproom_jumper");
	local playerActivator = getActivator(null);
	playerActivator.SetOrigin(adestination.GetOrigin());
	activator.SetOrigin(jdestination.GetOrigin());
	EntFire("portal_s","enable");
	
	activeFighter = activator;
}

::weaponRoom <- function(){
	ScriptPrintMessageCenterAll("a Jumper beat the map and selected WEAPON");
	local adestination = Entities.FindByName(null, "weaponroom_activator");
	local jdestination = Entities.FindByName(null, "weaponroom_jumper");
	local playerActivator = getActivator(null);
	playerActivator.SetOrigin(adestination.GetOrigin());
	activator.SetOrigin(jdestination.GetOrigin());
	EntFire("portal_s","enable");
	
	activeFighter = activator;
}

function getActivator(previous){
	local player = Entities.FindByClassname(previous, "player"); // for bots use cs_bot for players use player
	if(player.GetTeam() == 2){
		return player;
	}else{
		return getActivator(player);
	}
}

function getPlayerCount(previous){
	local player = Entities.FindByClassname(previous, "player");
	if(player == null){
		return 0;
	}
	else{
		return 1 + getPlayerCount(player);
	}
}


function assignRandomActivator(){
	local newActivatorNum = RandomInt(0,getPlayerCount(null));
	local playerCount = getPlayerCount(null);
	local previous = null;
	local player = Entities.FindByClassname(previous, "player");
	for(local i = 1; i < newActivatorNum; i++){
		player = Entities.FindByClassname(player, "player");
	}
	local activator = getActivator(null);
	activator.SetTeam(3);
}

::RoundStartEvent <- function(inData){
	//activatorPlayer = getActivator(null);
	EntFire("portal_s","disable");
}

::RoundEndEvent <- function(inData){
	assignRandomActivator();
	//previousactivatorPlayer = activatorPlayer;
}

//make weapon room done
//fix end rooms (code activator teleport) done
//move hydrant activators closer done
//add death triggers -- done
//make activatr wall not wallbangable done

function GiveGun( weapon, playerarray )
{
	local equipper = Entities.CreateByClassname( "game_player_equip" )

	// set flags and keyvalues
	equipper.__KeyValueFromInt( "spawnflags", 5 ) // "Use Only" and "Only Strip Same Weapon Type"
	equipper.__KeyValueFromInt( weapon, 0 )
//	equipper.__KeyValueFromInt( "weapon_knife", 0 )
//	equipper.__KeyValueFromInt( "item_kevlar", 0 )

	equipper.ValidateScriptScope()

	foreach (player in playerarray)
	{
		EntFireByHandle( equipper, "Use", "", 0, player, null ) // each player "Use"s the equipper
	}
	
	EntFireByHandle( equipper, "Kill", "", 0.1, null, null ) // equipper is no longer needed, so remove it
}