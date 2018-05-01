local t = LoadFallbackB();

t[#t+1] = StandardDecorationFromFileOptional("StageDisplay","StageDisplay")
t[#t+1] = StandardDecorationFromFile("BannerFrame","BannerFrame")
t[#t+1] = StandardDecorationFromFileOptional("BPMDisplay","BPMDisplay")
t[#t+1] = StandardDecorationFromFileOptional("SortDisplay","SortDisplay")

--the delay counter is a hack to prevent crashes
local delayCounter = 0
t[#t+1] = Def.Actor{
	CurrentSongChangedMessageCommand=cmd(queuecommand,"Set");
	SetCommand=function(self)
		if delayCounter < 3 then
			delayCounter = delayCounter + 1
			return
		end
		local wheel = SCREENMAN:GetTopScreen():GetChild('MusicWheel')
		if wheel:GetSelectedType() == 'WheelItemDataType_Custom' then
			SOUND:DimMusic(0,math.huge);
		else
			SOUND:DimMusic(1,math.huge);
		end;
	end;
};

local normal = Var "LoadingScreen" == "ScreenSelectMusic"

-- other items (balloons, etc.)
if normal then
t[#t+1] = StandardDecorationFromFile( "Balloon", "Balloon" );

t[#t+1] = Def.ActorFrame{
	Def.ActorFrame{
		InitCommand=cmd(draworder,99;x,SCREEN_CENTER_X+194;y,SCREEN_CENTER_Y-94);
		NextSongMessageCommand=cmd(finishtweening;linear,0;x,SCREEN_CENTER_X+194+5;y,SCREEN_CENTER_Y-94+2;sleep,0.2;decelerate,0.2;x,SCREEN_CENTER_X+194;y,SCREEN_CENTER_Y-94);
		LoadActor("RightArrow");
	};
	Def.ActorFrame{
		InitCommand=cmd(draworder,99;x,SCREEN_CENTER_X-184;y,SCREEN_CENTER_Y-94);
		PreviousSongMessageCommand=cmd(finishtweening;linear,0;x,SCREEN_CENTER_X-184-5;y,SCREEN_CENTER_Y-94+2;sleep,0.2;decelerate,0.2;x,SCREEN_CENTER_X-184;y,SCREEN_CENTER_Y-94);
		LoadActor("LeftArrow");
	};
};

--Hacky Way to have Artists
t[#t+1] = Def.ActorFrame{
	LoadFont("_eurostilet Bold 30px")..{
		InitCommand=cmd(x,SCREEN_CENTER_X+4;y,SCREEN_CENTER_Y-56;draworder,2;maxwidth,300;zoom,0.5;wrapwidthpixels,2^24;strokecolor,color("#010f8c"));
		OnCommand=cmd(diffusealpha,1);
		CurrentSongChangedMessageCommand=cmd(queuecommand,"SetBefore");
		SetBeforeCommand=function(self)
			self:stoptweening():settext(""):queuecommand("Set")
		end;
		SetCommand=function(self)
			local song = GAMESTATE:GetCurrentSong();
			if song then
				local art = song:GetDisplayArtist();
				self:stoptweening();
				self:diffusealpha(0);
				self:settext(art);
				self:sleep(0.35):diffusealpha(1);
			else
				self:settext("");
			end;
		end;
	};
};

--Diff Frame
t[#t+1] = Def.ActorFrame{
	LoadActor("Diff frame")..{
		InitCommand=cmd(draworder,2;x,SCREEN_CENTER_X+4;y,SCREEN_CENTER_Y+100;diffusealpha,1);
	};
	LoadActor("X2DifficultyList.lua");
	--P1 Start
	Def.ActorFrame{
		InitCommand=function(self)
			self:xy(SCREEN_CENTER_X-108,SCREEN_CENTER_Y+100)
			self:queuecommand("Set")
			self:visible(false)
			self:draworder(2)
		end;
		OnCommand=cmd(queuecommand,"Animate");
	  AnimateCommand=cmd(diffuseshift;effectcolor1,color("1,1,1,1");effectcolor2,color("0.5,0.5,0.5,1");effectperiod,1.5);
		SetCommand=function(self)
	    if GAMESTATE:IsPlayerEnabled(PLAYER_1) then
	      self:visible(false);
	    else
	      self:visible(true)
	    end;
	  end;
		PlayerJoinedMessageCommand=function(self,param)
	    if param.Player == PLAYER_1 then
	      (cmd(linear,0.15;zoomy,0;))(self);
	    end;
	  end;
		LoadActor("1P Start")..{
			InitCommand=cmd(y,-54);
		};
		LoadActor("Start");
	};
	--P2 Start
	Def.ActorFrame{
		InitCommand=function(self)
			self:xy(SCREEN_CENTER_X+108,SCREEN_CENTER_Y+100)
			self:queuecommand("Set")
			self:visible(false)
			self:draworder(2)
		end;
		OnCommand=cmd(queuecommand,"Animate");
	  AnimateCommand=cmd(diffuseshift;effectcolor1,color("1,1,1,1");effectcolor2,color("0.5,0.5,0.5,1");effectperiod,1.5);
		SetCommand=function(self)
	    if GAMESTATE:IsPlayerEnabled(PLAYER_2) then
	      self:visible(false);
	    else
	      self:visible(true)
	    end;
	  end;
		PlayerJoinedMessageCommand=function(self,param)
	    if param.Player == PLAYER_2 then
	      (cmd(linear,0.15;zoomy,0;))(self);
	    end;
	  end;
		LoadActor("2P Start")..{
			InitCommand=cmd(y,-54);
		};
		LoadActor("Start");
	};
};

--Surround Frame
t[#t+1] = LoadActor("frame")..{
	InitCommand=cmd(Center;diffusealpha,1);
};

t[#t+1] = LoadActor("Banner under")..{
	InitCommand=cmd(xy,SCREEN_CENTER_X+4,SCREEN_CENTER_Y-120;diffusealpha,1);
};

t[#t+1] = LoadActor("Help")..{
	InitCommand=function(self)
		self:CenterX():y(SCREEN_BOTTOM-16)
		:queuecommand("Animate")
	end;
	OnCommand=cmd(addy,50;sleep,0.1;linear,0.2;addy,-50);
	AnimateCommand=cmd(diffuseblink;effectcolor1,color("1,1,1,1");effectcolor2,color("0.5,0.5,0.5,1");effectperiod,1.5);
};



t[#t+1] = LoadActor("Warning")..{
	InitCommand=cmd(draworder,100;CenterX;y,SCREEN_CENTER_Y+100;zoomy,0);
	CurrentSongChangedMessageCommand=cmd(queuecommand,"Set");
	SetCommand=function(self)
		if delayCounter < 3 then
			delayCounter = delayCounter + 1
			return
		end
		local wheel = SCREENMAN:GetTopScreen():GetChild('MusicWheel')
		if wheel:GetSelectedType() == 'WheelItemDataType_Custom' then
			self:finishtweening()
			self:decelerate(0.3)
			self:zoomy(1)
		else
			self:finishtweening()
			self:zoomy(0)
		end;
	end;
};

end;

return t
