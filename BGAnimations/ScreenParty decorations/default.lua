local t = LoadFallbackB();

t[#t+1] = LoadActor("base")..{
  InitCommand=cmd(Center;diffusealpha,0);
};

t[#t+1] = Def.ActorFrame{
  LoadActor("top")..{
    InitCommand=cmd(CenterX;valign,0;y,SCREEN_TOP);
  };
  LoadActor("explain")..{
    InitCommand=cmd(CenterX;valign,1;y,SCREEN_BOTTOM);
  };
};

return t;
