local t = Def.ActorFrame{};

local screenName = Var "LoadingScreen"

local xPosPlayer = {
  P1 = (SCREEN_CENTER_X-214);
  P2 = (SCREEN_CENTER_X+214)
};

for _, pn in pairs(GAMESTATE:GetEnabledPlayers()) do
  t[#t+1] = Def.ActorFrame{
    InitCommand=function(self)
      local short = ToEnumShortString(pn)
      self:x(xPosPlayer[short]);
      self:y(SCREEN_CENTER_Y+44)
    end;
    Def.ActorFrame{
      InitCommand=cmd(queuecommand,"Stretch");
      StretchCommand=function(self)
        self:zoomy(1):linear(0.3):zoomy(1.1):linear(0.3):zoomy(1):queuecommand("Stretch")
      end;
      Def.Sprite{
        InitCommand=cmd(playcommand,"Set");
        SetCommand=function(self)
          local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn):GetGrade()
          self:Load(THEME:GetPathB("ScreenEvaluation decorations/Grades/GradeDisplayEval", ToEnumShortString(pss)));
        end;
      };
      Def.Sprite{
        InitCommand=cmd(playcommand,"Set");
        SetCommand=function(self)
          local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn):GetGrade()
          self:Load(THEME:GetPathB("ScreenEvaluation decorations/Grades/GradeDisplayEval", ToEnumShortString(pss)));
        end;
        OnCommand=cmd(queuecommand,"Anim");
        AnimCommand=function(self)
          self:blend(Blend.Add):diffuseshift():effectcolor1(color("1,1,1,0.5")):effectcolor2(color("1,1,1,0")):effectperiod(0.5)
        end;
      };
    };
    LoadActor("light")..{
      InitCommand=cmd(xy,-22,-84);
    };
    LoadActor("shadow")..{
      InitCommand=cmd(y,84);
    };
  };
end;

return t;
