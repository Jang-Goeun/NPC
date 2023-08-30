-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- json parsing
local json = require "json"

function jsonParse( src )
	local filename = system.pathForFile( src )
	
	local data, pos, msg = json.decodeFile(filename)

	-- 디버깅
	if data then
		return data
	else
		print("WARNING: " .. pos, msg)
		return nil
	end
end

-- show default status bar (iOS)
display.setStatusBar( display.DefaultStatusBar )


-- include Corona's "widget" library
local widget = require "widget"
local composer = require "composer"

font_Content = "font/PF스타더스트.ttf"
font_Speaker = "font/PF스타더스트 Bold.ttf"


mainBackgroundMusic = audio.loadSound( "sound/default_bgm.mp3" )
wrongSound = audio.loadSound( "sound/경고음 1 수정.mp3" )
warningSound_short = audio.loadSound("sound/경고음 2(short).mp3")
warningSound = audio.loadSound( "sound/경고음 2.mp3" )

insertItem = audio.loadSound( "sound/게임 시스템/딸깍 소리 1.mp3" )
buttonSound = audio.loadSound( "sound/게임 시스템/딸깍 소리 2.mp3" )
gameSuccess = audio.loadSound( "sound/게임 시스템/성공 소리.mp3" )
questSound = audio.loadSound( "sound/게임 시스템/알림 소리.mp3" )

garbageSound = audio.loadSound( "sound/낙엽 밟는 소리.mp3" )
keySound = audio.loadSound("sound/열쇠.mp3")


buttonSound2 = audio.loadSound( "sound/게임 시스템/버튼 소리 2.mp3" )
sucessSound = audio.loadSound( "sound/게임 시스템/성공 소리.mp3" )


-- event listeners for tab buttons:
local function onFirstView( event )
	--composer.gotoScene( "intro" ) 
	--composer.gotoScene( "picgame_start" )
	composer.gotoScene( "intro" )
	--composer.gotoScene( "picgame_re_1" )
end

onFirstView()	-- invoke first tab button's onPress event manually