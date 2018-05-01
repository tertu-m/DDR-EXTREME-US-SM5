return Def.ActorFrame{
	Def.Quad{
		InitCommand=cmd(setsize,SCREEN_WIDTH,SCREEN_HEIGHT/2;diffuse,color("0,0,0,1");xy,SCREEN_CENTER_X,SCREEN_CENTER_Y;valign,1);
		OnCommand=cmd(y,SCREEN_CENTER_Y;linear,0.3;y,SCREEN_CENTER_Y-SCREEN_HEIGHT/2);
	};
	Def.Quad{
		InitCommand=cmd(setsize,SCREEN_WIDTH,SCREEN_HEIGHT/2;diffuse,color("0,0,0,1");xy,SCREEN_CENTER_X,SCREEN_CENTER_Y;valign,0);
		OnCommand=cmd(y,SCREEN_CENTER_Y;linear,0.3;y,SCREEN_CENTER_Y+SCREEN_HEIGHT/2);
	};
};
