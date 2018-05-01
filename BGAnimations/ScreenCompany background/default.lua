local t = Def.ActorFrame {};

t[#t+1] = Def.ActorFrame {
  InitCommand=cmd(Center);
	Def.Quad{
			OnCommand=cmd(zoomto,SCREEN_WIDTH,SCREEN_HEIGHT;diffuse,color("1,1,1,1"));
	};
	LoadActor("1") .. {
		OnCommand=cmd(diffusealpha,1;sleep,5.5;linear,0.3;diffusealpha,0);
	};
  LoadActor("2") .. {
		OnCommand=cmd(diffusealpha,0;sleep,5.8;linear,0.3;diffusealpha,1;sleep,6;);
	};
  LoadActor("ddrmax.png") .. {
    InitCommand=cmd(xy,110,80);
    OnCommand=cmd(xy,-640,480;sleep,6.2;linear,0.3;xy,110,80;);
	};
  LoadActor("ddrmax2.png") .. {
    InitCommand=cmd(xy,-164,-26);
    OnCommand=cmd(xy,640,-480;sleep,6;linear,0.3;xy,-164,-26;);
	};
  LoadActor("music.ogg") .. {
    OnCommand=cmd(sleep,6;queuecommand,"play");
    playCommand=cmd(play);
	};
};

return t
