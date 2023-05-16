IncludeScript("dr_gooby_neo/vs_library");

VS.ListenToGameEvent("player_spawn", function(ev){
	local player = ToExtendedPlayer( VS.GetPlayerByUserid( ev.userid ) );
}, "test" );