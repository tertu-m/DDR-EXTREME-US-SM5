local t = ...;
t = Def.ActorFrame{
	Def.Quad{
		InitCommand=cmd(x,188;y,1;setsize,188,24);
		OnCommand=cmd(queuecommand,"Animate");
		AnimateCommand=cmd(diffuseshift;effectcolor1,color("#d4d400");effectcolor2,color("#717100");effectperiod,1.5);
	};
	LoadActor("HL")..{
		InitCommand=cmd(x,188;y,1);
	}
};
return t;
