local t = Def.ActorFrame{
  LoadActor("../_MenuHL")..{
    InitCommand=cmd(visible,false;y,-64;diffusealpha,0.75);
    GainFocusCommand=cmd(visible,true);
    LoseFocusCommand=cmd(visible,false);
  };
  Def.Sprite{
    Texture="../_TitleSheet 2x12.png";
    InitCommand=cmd(pause,setstate,6;y,-64);
    GainFocusCommand=cmd(setstate,7);
    LoseFocusCommand=cmd(setstate,6);
  };
};

return t;
