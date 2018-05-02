local t = LoadFallbackB();

local screenName = Var "LoadingScreen";

if screenName ~= "ScreenMapControllers" then
t[#t+1] = LoadActor("base")..{
	InitCommand=cmd(Center;diffusealpha,0);
};
t[#t+1] = Def.ActorFrame{
	LoadActor("lines")..{
		InitCommand=cmd(Center;diffusealpha,0.25);
	};
	LoadActor("side")..{
		InitCommand=cmd(halign,0;xy,SCREEN_LEFT,SCREEN_CENTER_Y;diffusealpha,1);
	};
	LoadActor("explain")..{
		InitCommand=cmd(valign,1;xy,SCREEN_CENTER_X,SCREEN_BOTTOM;diffusealpha,1);
	};
	LoadActor("x")..{
		InitCommand=cmd(xy,SCREEN_CENTER_X+263,SCREEN_BOTTOM-36;diffusealpha,1);
		OnCommand=cmd(diffuseshift;effectcolor1,color("1,1,1,1");effectcolor2,color("1,1,1,0.25");effectperiod,2);
	};
};
end;

return t
