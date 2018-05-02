return Def.ActorFrame{
	LoadActor("demo")..{
		InitCommand=cmd(x,SCREEN_CENTER_X-164;y,SCREEN_TOP+30);
	};
	LoadActor("demo")..{
		InitCommand=cmd(x,SCREEN_CENTER_X+166;y,SCREEN_BOTTOM-36);
	};
};
