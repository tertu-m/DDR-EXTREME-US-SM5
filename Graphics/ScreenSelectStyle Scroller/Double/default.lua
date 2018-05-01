local masterPlayer = GAMESTATE:GetMasterPlayerNumber() == PLAYER_1 and "P1" or "P2"
local unjoinedPlayer = GAMESTATE:GetMasterPlayerNumber() == PLAYER_1 and "P2" or "P1"

local t = Def.ActorFrame{
	-- Panel
	LoadActor("_panel")..{
		InitCommand=cmd(x,SCREEN_CENTER_X+206;y,SCREEN_CENTER_Y+4;);
		OnCommand=function(self)
			if GAMESTATE:GetNumSidesJoined() == 2 then
				self:playcommand("GainFocus")
			end
		end;
		GainFocusCommand=cmd(stoptweening;diffusealpha,1;);
		LoseFocusCommand=cmd(stoptweening;diffusealpha,0;);
	};

	-- Picture
	LoadActor("dancer"..masterPlayer)..{
		InitCommand=cmd(x,SCREEN_CENTER_X+200;y,SCREEN_CENTER_Y-74;diffusealpha,0.5);
		BeginCommand=cmd(playcommand,"CheckNumPlayers");
		GainFocusCommand=cmd(stoptweening;visible,true);
		LoseFocusCommand=cmd(stoptweening;visible,false);
		CheckNumPlayersCommand=function(self,param)
			if GAMESTATE:GetNumPlayersEnabled() > 1 then
				self:visible(false)
			end
		end;
	};

};

return t;
