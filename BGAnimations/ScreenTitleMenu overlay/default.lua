local counter = 0;
local t = Def.ActorFrame{
	LoadActor("home_warn")..{
		InitCommand=cmd(CenterX;y,SCREEN_BOTTOM-44);
		OffCommand=cmd(linear,0.4;diffusealpha,0);
	};
	LoadActor("home_warn")..{
		InitCommand=cmd(CenterX;y,SCREEN_BOTTOM-44;diffusealpha,0;zoom,1.02);
		OffCommand=cmd(diffusealpha,0.5;linear,0.4;diffusealpha,0);
	};LoadActor("home_warn")..{
		InitCommand=cmd(CenterX;y,SCREEN_BOTTOM-44;diffusealpha,0;zoom,1.04);
		OffCommand=cmd(diffusealpha,0.5;linear,0.4;diffusealpha,0);
	};
};

return t;
