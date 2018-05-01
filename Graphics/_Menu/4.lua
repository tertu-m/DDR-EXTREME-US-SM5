local t = Def.ActorFrame{
  LoadActor("../_MenuHL")..{
    InitCommand=cmd(visible,false;y,-94;diffusealpha,0.75);
    GainFocusCommand=cmd(visible,true);
    LoseFocusCommand=cmd(visible,false);
  };
  Def.Sprite{
    Texture="../_TitleSheet 2x12.png";
    InitCommand=cmd(pause,setstate,4;y,-94);
    GainFocusCommand=cmd(setstate,5);
    LoseFocusCommand=cmd(setstate,4);
  };
};

return t;
