return Def.ActorFrame{
	Def.Actor{
		OnCommand=cmd(sleep,1.8);
	};

	LoadActor(THEME:GetPathS("","_moreswoosh"))..{
		StartTransitioningCommand=cmd(play);
	};

	LoadActor("_fade out");
};
