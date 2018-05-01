local t = Def.ActorFrame{};

local Nonstop = GAMESTATE:GetPlayMode() == "PlayMode_Nonstop";
local Oni = GAMESTATE:GetPlayMode() == "PlayMode_Oni";

--Load music here because I don't want to mess with conditional music.
t[#t+1] = LoadActor(THEME:GetPathS("","_NonstopItem (loop)"))..{
  InitCommand=cmd(stop);
  OnCommand=function(self)
    if Nonstop then
      self:play()
    else
      self:stop()
    end;
  end;
};

t[#t+1] = LoadActor(THEME:GetPathS("","_ChallengeItem (loop)"))..{
  InitCommand=cmd(stop);
  OnCommand=function(self)
    if Oni then
      self:play()
    else
      self:stop()
    end;
  end;
};

--Header and Siding.
if Nonstop then
  t[#t+1] = Def.ActorFrame{
    LoadActor("base Non.png")..{
      InitCommand=cmd(Center;diffusealpha,0);
    };
    LoadActor("Siding Nonstop.png")..{
      InitCommand=cmd(Center;diffusealpha,1);
    };
    LoadActor("Nonstop.png")..{
      InitCommand=cmd(xy,SCREEN_CENTER_X-176,SCREEN_CENTER_Y-202);
    };
  };
end;

if Oni then
  t[#t+1] = Def.ActorFrame{
    LoadActor("base Cha.png")..{
      InitCommand=cmd(Center;diffusealpha,0);
    };
    LoadActor("Siding Oni.png")..{
      InitCommand=cmd(Center;diffusealpha,1);
    };
    LoadActor("Challenge.png");
  };
end;

--BannerFrame
t[#t+1] = Def.ActorFrame{
  LoadActor("BannerUnder")..{
    InitCommand=cmd(xy,SCREEN_CENTER_X-166,SCREEN_CENTER_Y-80);
  };
  LoadActor("WheelMask")..{
    InitCommand=cmd(CenterX;y,SCREEN_CENTER_Y-40);
    OnCommand=function(self)
      self:clearzbuffer(true);
      self:zwrite(true);
      self:blend('BlendMode_NoEffect');
    end;
  };
};

--CourseContents
t[#t+1] = Def.ActorFrame{
  LoadActor("Song backer")..{
    InitCommand=cmd(halign,1;xy,SCREEN_CENTER_X+320,SCREEN_CENTER_Y-10)
  };
};

t[#t+1] = StandardDecorationFromFile("CourseContentsList","CourseContentsList")
t[#t+1] = StandardDecorationFromFile("BannerFrame","BannerFrame")

return t
