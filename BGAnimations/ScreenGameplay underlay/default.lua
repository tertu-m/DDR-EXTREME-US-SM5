local t = Def.ActorFrame{};

local screenName = Var "LoadingScreen";

t[#t+1] = Def.ActorFrame{
	Def.ActorFrame{
		Name="DangerP1";
		Def.ActorFrame{
			Name="Single";
			BeginCommand=function(self)
			local style = GAMESTATE:GetCurrentStyle()
			local styleType = style:GetStyleType()
			local bDoubles = (styleType == 'StyleType_OnePlayerTwoSides' or styleType == 'StyleType_TwoPlayersSharedSides')
				self:visible(not bDoubles)
			end;
		HealthStateChangedMessageCommand=function(self, param)
			if param.PlayerNumber == PLAYER_1 then
				if param.HealthState == "HealthState_Danger" then
					self:RunCommandsOnChildren(cmd(playcommand,"Show"))
				else
					self:RunCommandsOnChildren(cmd(playcommand,"Hide"))
				end
			end
		end;
			Def.Quad{
				InitCommand=cmd(visible,false;FullScreen;diffuse,color("0,0,0,1"));
				ShowCommand=cmd(visible,true;diffuseblink;effectperiod,1);
				HideCommand=cmd(visible,false);
			};
			LoadActor("_danger")..{
				InitCommand=cmd(visible,false;Center;zoomto,640,480);
				ShowCommand=cmd(visible,true;diffuseshift;effectcolor1,color("1,1,1,1");effectcolor2,color("0,0,0,0");effectperiod,0;effectclock,"music";);
				HideCommand=cmd(visible,false);
			};
		};
	};
	Def.ActorFrame{
		Name="DangerP2";
		Def.ActorFrame{
			Name="Single";
			BeginCommand=function(self)
			local style = GAMESTATE:GetCurrentStyle()
			local styleType = style:GetStyleType()
			local bDoubles = (styleType == 'StyleType_OnePlayerTwoSides' or styleType == 'StyleType_TwoPlayersSharedSides')
				self:visible(not bDoubles)
			end;
		HealthStateChangedMessageCommand=function(self, param)
			if param.PlayerNumber == PLAYER_2 then
				if param.HealthState == "HealthState_Danger" then
					self:RunCommandsOnChildren(cmd(playcommand,"Show"))
				else
					self:RunCommandsOnChildren(cmd(playcommand,"Hide"))
				end
			end
		end;
			Def.Quad{
				InitCommand=cmd(visible,false;FullScreen;diffuse,color("0,0,0,1"));
				ShowCommand=cmd(visible,true;diffuseblink;effectperiod,1);
				HideCommand=cmd(visible,false);
			};
			LoadActor("_danger")..{
				InitCommand=cmd(visible,false;Center;zoomto,640,480);
				ShowCommand=cmd(visible,true;diffuseshift;effectcolor1,color("0,0,0,1");effectcolor2,color("0,0,0,0")effectclock,"music";);
				HideCommand=cmd(visible,false);
			};
		};
	};
};

t[#t+1] = LoadActor("base")..{
	InitCommand=cmd(Center;diffusealpha,0);
};

t[#t+1] = Def.ActorFrame{
	InitCommand=function(self)
		self:xy(SCREEN_CENTER_X-172,SCREEN_TOP+30):diffusealpha(0.5)
		if screenName == "ScreenDemonstration" then
			self:visible(false)
		else
			self:visible(true)
		end;
	end;
	OnCommand=cmd(addy,-50;linear,0.6;addy,50);
	OffCommand=cmd(linear,1;addy,-100);
	LoadActor("Under_PlayerNumber_P1");
};

t[#t+1] = Def.ActorFrame{
	InitCommand=function(self)
		self:xy(SCREEN_CENTER_X+172,SCREEN_TOP+30):diffusealpha(0.5)
		if screenName == "ScreenDemonstration" then
			self:visible(false)
		else
			self:visible(true)
		end;
	end;
	OnCommand=cmd(addy,-50;linear,0.6;addy,50);
	OffCommand=cmd(linear,1;addy,-100);
	LoadActor("Under_PlayerNumber_P2");
};

return t;
