local t = Def.ActorFrame{
  LoadActor("../_MenuHL")..{
    InitCommand=cmd(visible,false;y,-34;diffusealpha,0.75);
    GainFocusCommand=cmd(visible,true);
    LoseFocusCommand=cmd(visible,false);
  };
  Def.Sprite{
    Texture="../_TitleSheet 2x12.png";
    InitCommand=cmd(pause,setstate,8;y,-34);
    GainFocusCommand=cmd(setstate,9);
    LoseFocusCommand=cmd(setstate,8);
  };
};

return t;
