local t = Def.ActorFrame{
  LoadActor("base")..{
    InitCommand=cmd(Center;diffusealpha,0);
  };
};

local normal = Var "LoadingScreen" == "ScreenSelectMusic"

-- other items (balloons, etc.)
if normal then
t[#t+1] = Def.ActorFrame{
  LoadActor("Banner under")..{
    InitCommand=cmd(xy,SCREEN_CENTER_X+4,SCREEN_CENTER_Y-120;diffusealpha,1);
  };
};
end;

return t;
