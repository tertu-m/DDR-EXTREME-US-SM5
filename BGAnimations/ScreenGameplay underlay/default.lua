local t = Def.ActorFrame{};

local screenName = Var "LoadingScreen";

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
