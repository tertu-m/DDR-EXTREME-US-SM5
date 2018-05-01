local t = Def.ActorFrame{
  LoadActor("../_MenuHL")..{
    InitCommand=cmd(visible,false;y,174;diffusealpha,0.75);
    GainFocusCommand=cmd(visible,true);
    LoseFocusCommand=cmd(visible,false);
  };
  Def.Sprite{
    Texture="_Exit 2x1.png";
    InitCommand=cmd(pause,setstate,0;y,174);
    GainFocusCommand=cmd(setstate,1);
    LoseFocusCommand=cmd(setstate,0);
  };
};

return t;
