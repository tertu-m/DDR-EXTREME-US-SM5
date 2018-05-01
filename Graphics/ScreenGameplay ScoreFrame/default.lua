local t = Def.ActorFrame{};

if GAMESTATE:IsPlayerEnabled('PlayerNumber_P1') then
--P1 Score Frame
t[#t+1]=Def.ActorFrame{
	LoadActor("frame")..{
		InitCommand=cmd(x,SCREEN_CENTER_X-204;);
	};
};
end;

if GAMESTATE:IsPlayerEnabled('PlayerNumber_P2') then
--P2 Score Frame
t[#t+1]=Def.ActorFrame{
	LoadActor("frame")..{
		InitCommand=cmd(x,SCREEN_CENTER_X+204;);
	};
};
end;

return t;
