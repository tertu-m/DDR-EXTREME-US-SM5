local screenName = Var "LoadingScreen"
local headerTextImage

--this should probably be a metric
if screenName == "ScreenSelectMusic" then
    headerTextImage = "Music.png"
elseif screenName == "ScreenPlayerOptions" then
    headerTextImage = "Options.png"
elseif screenName == "ScreenMapControllers" then
	headerTextImage = "Options.png"
elseif screenName == "ScreenOptionsService" then
	headerTextImage = "optionsserv.png"
elseif screenName == "ScreenOptionsServiceChild" then
	headerTextImage = "optionsserv.png"
elseif screenName == "ScreenSelectStyle" then
    headerTextImage = "style.png"
elseif screenName == "ScreenSelectDifficulty" then
    headerTextImage = "diff.png"
elseif screenName == "ScreenEvaluationNormal" then
	headerTextImage = "eval.png"
elseif screenName == "ScreenEvaluationSummary" then
	headerTextImage = "eval.png"
elseif screenName == "ScreenEvaluationOni" then
	headerTextImage = "eval.png"
elseif screenName == "ScreenEvaluationNonstop" then
	headerTextImage = "eval.png"
end

--Base Anchoring
local out = Def.ActorFrame{
  LoadActor("time_slash")..{
    InitCommand=cmd(x,SCREEN_RIGHT-54;y,SCREEN_TOP+26;draworder,99);
  };
}


--Text Anchoring
if headerTextImage then
	table.insert(out,LoadActor(headerTextImage)..{
		InitCommand=function(self)
			self:x(SCREEN_CENTER_X-160):y(SCREEN_TOP+40):diffusealpha(1)
		end;
	})
end

return out
