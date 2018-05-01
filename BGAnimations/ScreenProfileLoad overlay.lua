local x = Def.ActorFrame{
	Def.Quad{ InitCommand=cmd(FullScreen;diffuse,color("0,0,0,1"));};
};

x[#x+1] = Def.Actor {
	BeginCommand=function(self)
		if SCREENMAN:GetTopScreen():HaveProfileToLoad() then self:sleep(0.01); end;
		self:queuecommand("Load");
	end;
	LoadCommand=function() SCREENMAN:GetTopScreen():Continue(); end;
};

return x;
