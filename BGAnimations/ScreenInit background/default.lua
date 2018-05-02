local t = Def.ActorFrame {};

t[#t+1] = Def.ActorFrame {
  InitCommand=cmd(Center);
	Def.Quad{
			OnCommand=cmd(zoomto,SCREEN_WIDTH,SCREEN_HEIGHT;diffuse,color("0,0,0,1"));
	};
	LoadActor("1") .. {
		OnCommand=cmd(diffusealpha,0;linear,0.5;diffusealpha,1;sleep,4;linear,0.5;diffusealpha,0);
	};
  LoadActor("2") .. {
		OnCommand=cmd(diffusealpha,0;sleep,5.5;linear,0.5;diffusealpha,1;sleep,3.5;linear,0.5;diffusealpha,0);
	};
};

return t
