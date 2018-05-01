-- EXTREME colors
function PlayerColor( pn )
	if pn == PLAYER_1 then return color("#1FEFB6") end
	if pn == PLAYER_2 then return color("#FFBD18") end
	return color("1,1,1,1")
end

CustomDifficultyColor = {
	Beginner	= color("#01adf0"),	-- cyan
	Easy		= color("#fffb02"),		-- light yellow
	Medium		= color("#d80080"),		-- light pink-red
	Hard		= color("#46df2d"),		-- light green
	Challenge	= color("#a458ce"),	-- purple blue
	Edit		= color("#7068F8"),		-- grey

	-- alternate names
	Light		= color("#F8A800"),			-- yellow
	Standard	= color("#F800A0"),			-- red
	Heavy		= color("#68F800"),			-- green
};

function CustomDifficultyToColor( sCustomDifficulty )
	return CustomDifficultyColor[sCustomDifficulty] or color("#FFFFFF")
end
