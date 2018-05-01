local t = LoadFallbackB();

local function PlayerLabelName(pn)
	local name = GAMESTATE:IsHumanPlayer(pn) and string.lower(ToEnumShortString(pn))
	return name
end

t[#t+1] = LoadActor("base")..{
	InitCommand=cmd(Center;diffusealpha,0);
};

t[#t+1] = LoadActor(THEME:GetPathB("","ScreenSelectMusic decorations/frame"))..{
	InitCommand=cmd(Center;diffusealpha,1);
};

--BannerArea
t[#t+1] = Def.ActorFrame{
  InitCommand=cmd(playcommand,"Set";xy,SCREEN_CENTER_X+4,SCREEN_CENTER_Y-146);
  Def.Quad{
    InitCommand=cmd(xy,-2,-4;setsize,256,88;diffuse,color("0,0,0,1"));
  };
  Def.Sprite{
    InitCommand=cmd(xy,-2,-4);
    SetCommand=function(self)
      local song = GAMESTATE:GetCurrentSong();
      local course = GAMESTATE:GetCurrentCourse();
      if song then
        if song:HasBanner() then
          self:LoadFromSongBanner(song);
          self:setsize(256,88);
        else
          self:Load(THEME:GetPathG("","Common fallback banner"));
          self:setsize(256,88);
        end;
      elseif course then
        local courseName = course:GetBannerPath()
        if courseName then
          self:Load(courseName);
          self:setsize(256,88);
        else
          self:Load(THEME:GetPathG("","Common fallback banner"));
          self:setsize(256,88);
        end;
      else
        self:Load(THEME:GetPathG("","Common fallback banner"));
        self:setsize(256,88);
      end;
    end;
  };
  LoadActor("BannerFrame");
};

--OptionsFrame
t[#t+1] = Def.ActorFrame{
  InitCommand=cmd(xy,SCREEN_CENTER_X+4,SCREEN_CENTER_Y+24);
  LoadActor("Frames")..{
    InitCommand=cmd(croptop,0.1;);
  };
};

local PlayerXCoord = {
  P1 = SCREEN_CENTER_X-196,
  P2 = SCREEN_CENTER_X+196,
};

local factors = {-71, -40, -10, 22, 54, 84, 116, 146}

--1P Items
for i=1,9 do
  local ri = (i==9) and 8 or i
  t[#t+1] = Def.ActorFrame{
    InitCommand=cmd(x,SCREEN_CENTER_X-196;player,PLAYER_1);
    LoadActor("ItemUnder")..{
      OnCommand=cmd(y,SCREEN_CENTER_Y+factors[ri])
    };
  }
end;

--2PItems
for i=1,9 do
  local ri = (i==9) and 8 or i
  t[#t+1] = Def.ActorFrame{
    InitCommand=cmd(x,SCREEN_CENTER_X+196;zoomx,-1;player,PLAYER_2);
    LoadActor("ItemUnder")..{
      OnCommand=cmd(y,SCREEN_CENTER_Y+factors[ri])
    };
  }
end;

for _, pn in pairs(GAMESTATE:GetEnabledPlayers()) do
  t[#t+1] = Def.ActorFrame{
    Name = pn,
    InitCommand=function(self)
      local short = ToEnumShortString(pn)
      self:x(PlayerXCoord[short]):CenterY()
    end;
    LoadActor(PlayerLabelName(pn))..{
      InitCommand=cmd(y,-102);
    }
  };
end;

t[#t+1] = LoadActor("Help")..{
	InitCommand=function(self)
		self:CenterX():y(SCREEN_BOTTOM-18)
		:queuecommand("Animate")
	end;
	OnCommand=cmd(addy,50;sleep,0.1;linear,0.2;addy,-50);
	AnimateCommand=cmd(diffuseblink;effectcolor1,color("1,1,1,1");effectcolor2,color("0.5,0.5,0.5,1");effectperiod,1.5);
};

return t;
