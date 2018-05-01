local group;

local t = Def.ActorFrame{
  LoadActor("base")..{
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
  LoadFont("_eurostilet Bold 30px")..{
    InitCommand=cmd(maxwidth,160;wrapwidthpixels,2^24;strokecolor,color("#010f8c"));
    SetMessageCommand=function(self, params)
			local song = params.Song;
			group = params.Text;
			local so = GAMESTATE:GetSortOrder();
			if so == "SortOrder_Group" then
				self:settext(group);
				self:strokecolor(color("#000000"))
				self:diffuse(color("#FFFFFF"));
			else
				self:settext("");
			end;
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

return t;
