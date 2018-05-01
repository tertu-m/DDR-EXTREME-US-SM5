-- double
local t = Def.ActorFrame{
	GainFocusCommand=function(s) MESSAGEMAN:Broadcast("StyleDouble") end;
	Def.Sprite{
		Texture="icon 2x1.png";
		InitCommand=cmd(draworder,-1;x,SCREEN_CENTER_X+84;y,SCREEN_CENTER_Y+92;setstate,0;pause);
		OnCommand=cmd(addx,-640;sleep,0.133;linear,0.5;addx,640;);
		GainFocusCommand=cmd(finishtweening;setstate,1;linear,0.1;addy,-5;linear,0.1;addy,5);
		LoseFocusCommand=cmd(finishtweening;setstate,0);
		EnabledCommand=cmd(diffuse,color("1,1,1,1"));
		DisabledCommand=cmd(diffuse,color("0.2,0.2,0.2,1"));
		OffCommand=cmd();
	};
};
return t;
