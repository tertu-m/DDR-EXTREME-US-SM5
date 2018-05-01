local masterPlayer = GAMESTATE:GetMasterPlayerNumber() == PLAYER_1 and "P1" or "P2"
local unjoinedPlayer = GAMESTATE:GetMasterPlayerNumber() == PLAYER_1 and "P2" or "P1"

local t = Def.ActorFrame{
	-- Panel
	LoadActor("_panel")..{
		InitCommand=cmd(x,SCREEN_CENTER_X+206;y,SCREEN_CENTER_Y+4;);
		OnCommand=cmd(addx,300;sleep,0.133;linear,0.3;addx,-320;linear,0.05;addx,20);
		GainFocusCommand=cmd(stoptweening;visible,true);
		LoseFocusCommand=cmd(stoptweening;visible,false);
	};

	-- Picture
	LoadActor("dancer"..masterPlayer)..{
		InitCommand=cmd(x,SCREEN_CENTER_X+218;y,SCREEN_CENTER_Y-90;diffusealpha,0.5);
		BeginCommand=cmd(playcommand,"CheckNumPlayers");
		OnCommand=cmd(cropbottom,1;addy,104;sleep,0.8;linear,0.2;addy,-114;cropbottom,0;linear,0.05;addy,10;linear,0.05;addy,-10;linear,0.05;addy,10);
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
