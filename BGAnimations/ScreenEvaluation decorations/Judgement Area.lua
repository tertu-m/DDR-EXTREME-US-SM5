local t = Def.ActorFrame{}

local screenName = Var "LoadingScreen"

local xPosPlayer = {
  P1 = (SCREEN_CENTER_X-82);
  P2 = (SCREEN_CENTER_X+82)
};

local Space = '000';

--backer
t[#t+1] = Def.ActorFrame{
  LoadActor("Page")..{
    InitCommand=cmd(xy,SCREEN_CENTER_X+2,SCREEN_CENTER_Y+38;zoomx,1.05);
  };
  Def.ActorFrame{
    InitCommand=cmd(xy,SCREEN_CENTER_X+2,SCREEN_CENTER_Y+24;);
    Def.Sprite{
      Texture="Judgements 1x8.png";
      InitCommand=cmd(y,-99;pause;setstate,1);
    };
    Def.Sprite{
      Texture="Judgements 1x8.png";
      InitCommand=cmd(y,-66;pause;setstate,2);
    };
    Def.Sprite{
      Texture="Judgements 1x8.png";
      InitCommand=cmd(y,-33;pause;setstate,3);
    };
    Def.Sprite{
      Texture="Judgements 1x8.png";
      InitCommand=cmd(pause;setstate,4);
    };
    Def.Sprite{
      Texture="Judgements 1x8.png";
      InitCommand=cmd(y,33;pause;setstate,5);
    };
    Def.Sprite{
      Texture="Judgements 1x8.png";
      InitCommand=cmd(y,66;pause;setstate,6);
    };
    Def.Sprite{
      Texture="Judgements 1x8.png";
      InitCommand=cmd(y,99;pause;setstate,7);
    };
  };
}

--lines
local factors = {-99,-66,-33,0,33,66,99}

for i=1,7 do
  local ri = (i==9) and 8 or i
  t[#t+1] = Def.ActorFrame{
    InitCommand=cmd(xy,SCREEN_CENTER_X+2,SCREEN_CENTER_Y+37;);
    LoadActor("line")..{
      OnCommand=cmd(y,factors[ri]);
    };
  };
end;

for _, pn in pairs(GAMESTATE:GetEnabledPlayers()) do
  local Perfect = string.sub(Space..STATSMAN:GetCurStageStats():GetPlayerStageStats(pn):GetTapNoteScores("TapNoteScore_W2"), -3);
  local Great = string.sub(Space..STATSMAN:GetCurStageStats():GetPlayerStageStats(pn):GetTapNoteScores("TapNoteScore_W3"), -3);
  local Good = string.sub(Space..STATSMAN:GetCurStageStats():GetPlayerStageStats(pn):GetTapNoteScores("TapNoteScore_W4"), -3);
  local Almost = string.sub(Space..STATSMAN:GetCurStageStats():GetPlayerStageStats(pn):GetTapNoteScores("TapNoteScore_W5"), -3);
  local Boo = string.sub(Space..STATSMAN:GetCurStageStats():GetPlayerStageStats(pn):GetTapNoteScores("TapNoteScore_Miss"), -3);
  local Held = string.sub(Space..STATSMAN:GetCurStageStats():GetPlayerStageStats(pn):GetHoldNoteScores("HoldNoteScore_Held"), -3);
  local LetGo = string.sub(Space..STATSMAN:GetCurStageStats():GetPlayerStageStats(pn):GetHoldNoteScores("HoldNoteScore_LetGo"), -3);
  local Combo = string.sub(Space..STATSMAN:GetCurStageStats():GetPlayerStageStats(pn):MaxCombo(), -3);

  local PerfectSumm = string.sub(Space..STATSMAN:GetFinalEvalStageStats():GetPlayerStageStats(pn):GetTapNoteScores("TapNoteScore_W2"), -3);
  local GreatSumm = string.sub(Space..STATSMAN:GetFinalEvalStageStats():GetPlayerStageStats(pn):GetTapNoteScores("TapNoteScore_W3"), -3);
  local GoodSumm = string.sub(Space..STATSMAN:GetFinalEvalStageStats():GetPlayerStageStats(pn):GetTapNoteScores("TapNoteScore_W4"), -3);
  local AlmostSumm = string.sub(Space..STATSMAN:GetFinalEvalStageStats():GetPlayerStageStats(pn):GetTapNoteScores("TapNoteScore_W5"), -3);
  local BooSumm = string.sub(Space..STATSMAN:GetFinalEvalStageStats():GetPlayerStageStats(pn):GetTapNoteScores("TapNoteScore_Miss"), -3);
  local HeldSumm = string.sub(Space..STATSMAN:GetFinalEvalStageStats():GetPlayerStageStats(pn):GetHoldNoteScores("HoldNoteScore_Held"), -3);
  local LetGoSumm = string.sub(Space..STATSMAN:GetFinalEvalStageStats():GetPlayerStageStats(pn):GetHoldNoteScores("HoldNoteScore_LetGo"), -3);
  local ComboSumm = string.sub(Space..STATSMAN:GetFinalEvalStageStats():GetPlayerStageStats(pn):MaxCombo(), -3);
  t[#t+1] = Def.ActorFrame{
    Name = pn,
    InitCommand=function(self)
      local short = ToEnumShortString(pn)
      self:x(xPosPlayer[short]);
      self:y(SCREEN_CENTER_Y+24)
    end;
    --Spacing = 33px
    Def.BitmapText{
      Font="_eurostilet 18px",
      OnCommand=cmd(y,-99;zoomx,1.2;zoomy,1.1;playcommand,"Set");
      SetCommand=function(self)
        if screenName == "ScreenEvaluationSummary" then
          self:settext(PerfectSumm);
        else
          self:settext(Perfect);
        end;
    	end;
    };
    Def.BitmapText{
      Font="_eurostilet 18px",
      OnCommand=cmd(y,-66;zoomx,1.2;zoomy,1.1;playcommand,"Set");
      SetCommand=function(self)
        if screenName == "ScreenEvaluationSummary" then
          self:settext(GreatSumm);
        else
          self:settext(Great);
        end;
  		end;
    };
    Def.BitmapText{
      Font="_eurostilet 18px",
      OnCommand=cmd(y,-33;zoomx,1.2;zoomy,1.1;playcommand,"Set");
      SetCommand=function(self)
        if screenName == "ScreenEvaluationSummary" then
          self:settext(GoodSumm);
        else
          self:settext(Good);
        end;
  		end;
    };
    Def.BitmapText{
      Font="_eurostilet 18px",
      OnCommand=cmd(zoomx,1.2;zoomy,1.1;playcommand,"Set");
      SetCommand=function(self)
        if screenName == "ScreenEvaluationSummary" then
          self:settext(AlmostSumm);
        else
          self:settext(Almost);
        end;
  		end;
    };
    Def.BitmapText{
      Font="_eurostilet 18px",
      OnCommand=cmd(y,33;zoomx,1.2;zoomy,1.1;playcommand,"Set");
      SetCommand=function(self)
        if screenName == "ScreenEvaluationSummary" then
          self:settext(BooSumm);
        else
          self:settext(Boo);
        end;
  		end;
    };
    Def.BitmapText{
      Font="_eurostilet 18px",
      OnCommand=cmd(y,66;zoomx,1.2;zoomy,1.1;playcommand,"Set");
      SetCommand=function(self)
        if screenName == "ScreenEvaluationSummary" then
          self:settext(HeldSumm);
        else
          self:settext(Held);
        end;
  		end;
    };
    Def.BitmapText{
      Font="_eurostilet 18px",
      OnCommand=cmd(y,99;zoomx,1.2;zoomy,1.1;playcommand,"Set");
      SetCommand=function(self)
        if screenName == "ScreenEvaluationSummary" then
          self:settext(ComboSumm);
        else
          self:settext(Combo);
        end;
  		end;
    };
  }
end;
return t;
