-- ScreenHowToPlay background
local ar = GetScreenAspectRatio();

local t = Def.ActorFrame{
	-- bgtile
	LoadActor("bgtile")..{
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;FullScreen);
		OnCommand=function(self)
			local w = DISPLAY:GetDisplayWidth() / self:GetWidth();
			local h = DISPLAY:GetDisplayHeight() / self:GetHeight();
			self:customtexturerect(0,0,w,h);
			self:texcoordvelocity(0.6,-0.6);
		end;
	};
	LoadActor("pad")..{
		InitCommand=cmd(Center);
	};
	LoadActor("Life Under")..{
		InitCommand=cmd(CenterX;valign,0;y,SCREEN_TOP);
	};
	LoadActor("Under_PlayerNumber_P1")..{
		InitCommand=function(self)
				self:xy(SCREEN_CENTER_X-172,SCREEN_TOP+30):diffusealpha(0.5)
		end;
	};
	LoadActor("Under_PlayerNumber_P2")..{
		InitCommand=function(self)
			self:xy(SCREEN_CENTER_X+172,SCREEN_TOP+30):diffusealpha(0.5)
		end;
	};
};

t[#t+1] = Def.ActorFrame{
	LoadActor("stepcircle")..{
		InitCommand=cmd(x,SCREEN_CENTER_X-116;y,SCREEN_CENTER_Y-6);
		OnCommand=cmd(zoom,0;sleep,3.766;zoom,1;linear,0.366;zoom,0.7;sleep,0;zoom,0);
	};
	LoadActor("stepcircle")..{
		InitCommand=cmd(x,SCREEN_CENTER_X-116;y,SCREEN_CENTER_Y-6);
		OnCommand=cmd(blend,Blend.Add;;zoom,0;sleep,3.766;sleep,0.366;zoom,0.7;sleep,1.033;linear,0.4;zoom,0;diffusealpha,0);
	};
	LoadActor("stepcircle")..{
		InitCommand=cmd(x,SCREEN_CENTER_X-46;y,SCREEN_CENTER_Y+54);
		OnCommand=cmd(zoom,0;sleep,10.2;zoom,1;linear,0.366;zoom,0.7;sleep,0;zoom,0);
	};
	LoadActor("stepcircle")..{
		InitCommand=cmd(x,SCREEN_CENTER_X-46;y,SCREEN_CENTER_Y+54);
		OnCommand=cmd(blend,Blend.Add;;zoom,0;sleep,10.2;sleep,0.366;zoom,0.7;sleep,1.033;linear,0.4;zoom,0;diffusealpha,0);
	};
	LoadActor("stepcircle")..{
		InitCommand=cmd(x,SCREEN_CENTER_X-202;y,SCREEN_CENTER_Y+54);
		OnCommand=cmd(zoom,0;sleep,10.2;zoom,1;linear,0.366;zoom,0.7;sleep,0;zoom,0);
	};
	LoadActor("stepcircle")..{
		InitCommand=cmd(x,SCREEN_CENTER_X-202;y,SCREEN_CENTER_Y+54);
		OnCommand=cmd(blend,Blend.Add;;zoom,0;sleep,10.2;sleep,0.366;zoom,0.7;sleep,1.033;linear,0.4;zoom,0;diffusealpha,0);
	};
}
return t;
