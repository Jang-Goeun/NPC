-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- show default status bar (iOS)
--display.setStatusBar( display.DefaultStatusBar )

-- include Corona's "widget" library
--local widget = require "widget"

	font_Speaker = "font/PF스타더스트 Bold.ttf"
	font_Content = "font/PF스타더스트.ttf"

	-- json parsing↓
	local json = require "json"

	function jsonParse( src )
		local filename = system.pathForFile( src )
		
		local data, pos, msg
		data, pos, msg = json.decodeFile(filename)

		-- 디버깅
		if data then
			return data
		else
			print("WARNING: " .. pos, msg)
			return nil
		end
	end
	-- json parsing↑

	local composer = require "composer"


	-- event listeners for tab buttons:
	local function onFirstView( event )
		composer.gotoScene( "1층.game_lobby" )
		--composer.gotoScene( "배경화면.computerScreen" )
	end

	onFirstView()	-- invoke first tab button's onPress event manually
