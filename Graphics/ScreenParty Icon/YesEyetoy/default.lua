local t = Def.ActorFrame{};

t[#t+1] = Def.ActorFrame{
	InitCommand=cmd(xy,SCREEN_CENTER_X+162,SCREEN_CENTER_Y-34;diffusealpha,0.75);
	GainFocusCommand=cmd(zoom,1;x,SCREEN_CENTER_X+162);
	LoseFocusCommand=cmd(zoom,0.77;x,SCREEN_CENTER_X+126);
	LoadActor("pic");
	LoadActor("pic")..{
		GainFocusCommand=cmd(queuecommand,"Anim");
		LoseFocusCommand=cmd(stopeffect;visible,false);
		AnimCommand=function(self)
			self:visible(true):blend(Blend.Add):diffuseshift():effectcolor1(color("1,1,1,1")):effectcolor2(color("1,1,1,0")):effectperiod(2)
		end;
	};
	LoadActor("../border");
};

return t;
