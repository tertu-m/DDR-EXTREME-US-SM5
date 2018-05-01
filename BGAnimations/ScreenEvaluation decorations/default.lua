local t = LoadFallbackB();

local screenName = Var "LoadingScreen"

t[#t+1] = LoadActor("Grade Area");

--Banner Stuff
t[#t+1] = Def.ActorFrame{
  InitCommand=cmd(CenterX;y,SCREEN_CENTER_Y-146;diffusealpha,1);
  Def.Sprite{
    OnCommand=cmd(xy,2,-20;playcommand,"Set");
    SetCommand=function(self)
      local song = GAMESTATE:GetCurrentSong();
      local course = GAMESTATE:GetCurrentCourse();
      if screenName == "ScreenEvaluationSummary" then
        self:Load(THEME:GetPathG("","Common fallback banner"));
        self:setsize(172,64);
      else
        if song then
          if song:HasBanner() then
            self:LoadFromSongBanner(song);
            self:setsize(172,64);
          else
            self:Load(THEME:GetPathG("","Common fallback banner"));
            self:setsize(172,64);
          end;
        elseif course then
          local courseName = course:GetBannerPath()
          if courseName then
            self:Load(courseName);
            self:setsize(172,64);
          else
            self:Load(THEME:GetPathG("","Common fallback banner"));
            self:setsize(172,64);
          end;
        else
          self:Load(THEME:GetPathG("","Common fallback banner"));
          self:setsize(172,64);
        end;
      end;
    end;
  };
  LoadActor("frame");
  Def.Sprite{
    Texture="Score text 1x2.png";
    InitCommand=cmd(xy,-2,-61;pause,setstate,0;playcommand,"Set");
    SetCommand=function(self)
      if screenName == "ScreenEvaluationSummary" then
        self:setstate(0)
      else
        self:setstate(1)
      end;
    end;
  }
};

t[#t+1] = Def.ActorFrame{
  LoadActor("Judgement Area");
  LoadActor("Score Area");
};

for pn in ivalues(PlayerNumber) do
	local MetricsName = "PersonalRecord" .. PlayerNumberToString(pn);
	t[#t+1] = LoadActor( THEME:GetPathG(Var "LoadingScreen", "PersonalRecord"), pn ) .. {
		InitCommand=function(self)
			self:player(pn);
			self:name(MetricsName);
			ActorUtil.LoadAllCommandsAndSetXY(self,Var "LoadingScreen");
		end;
	};
end

t[#t+1] = Def.ActorFrame {
	Condition=GAMESTATE:HasEarnedExtraStage() and GAMESTATE:IsExtraStage() and not GAMESTATE:IsExtraStage2();
	InitCommand=cmd(draworder,105);
	LoadActor( THEME:GetPathS("ScreenEvaluation","try Extra1" ) ) .. {
		Condition=THEME:GetMetric( Var "LoadingScreen","Summary" ) == false;
		OnCommand=cmd(play);
	};
};


return t;
