return Def.ActorFrame{
  Def.Sprite{
    Texture="roulette 1x4.png",
    InitCommand=function(self)
			self:SetAllStateDelays(0.1)
		end,
    SetMessageCommand=function(self,params)
      if params.HasFocus then
        self:x(2);
        self:y(-6.4);
      else
        self:x(0);
        self:y(-6.4)
      end;
    end;
  };
};
