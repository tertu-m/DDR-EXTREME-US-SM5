local t = Def.ActorFrame{};

local screenName = Var "LoadingScreen"

local xPosPlayer = {
  P1 = (SCREEN_CENTER_X-196);
  P2 = (SCREEN_CENTER_X+196)
};

for _, pn in pairs(GAMESTATE:GetEnabledPlayers()) do
  t[#t+1] = Def.ActorFrame{
    Name = pn,
    InitCommand=function(self)
      local short = ToEnumShortString(pn)
      self:x(xPosPlayer[short]);
      self:y(SCREEN_CENTER_Y-148)
    end;
    Def.RollingNumbers {
			File = THEME:GetPathF("","ScreenEvaluation ScoreNumber");
			InitCommand=cmd(playcommand,"Set";);
			SetCommand = function (self)
				local score = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn):GetScore()
        local scoreSumm = STATSMAN:GetFinalEvalStageStats():GetPlayerStageStats(pn):GetScore()
        self:Load("RollingNumbersEval");
        if screenName == "ScreenEvaluationSummary" then
          self:targetnumber(scoreSumm);
        else
  				self:targetnumber(score);
        end;
			end;
		};
    Def.Sprite{
      Texture="Player 1x2.png";
      InitCommand=cmd(xy,pn=="PlayerNumber_P2" and 46 or -46,-27;pause;setstate,pn=="PlayerNumber_P2" and 1 or 0);
    }
  };
end;

return t;
