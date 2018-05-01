local gc = Var("GameCommand");
local t = Def.ActorFrame {};

t[#t+1] = Def.ActorFrame {
	LoadActor(THEME:GetPathG("","_Menu/"..gc:GetName()..".lua" )) .. {
		DisabledCommand=cmd(diffuse,color("0.0,0.0,0.0,0"));
		EnabledCommand=cmd(diffuse,color("1,1,1,1"));
		OnCommand=cmd(CenterX;y,SCREEN_CENTER_Y-33);
		OffCommand=cmd(diffusealpha,0.5;linear,0.4;diffusealpha,0);
	};
};

return t
