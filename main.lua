-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- json parsing
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

-- show default status bar (iOS)
display.setStatusBar( display.DefaultStatusBar )

-- include Corona's "widget" library
local widget = require "widget"
local composer = require "composer"

font_Content = "font/PF스타더스트.ttf"
font_Speaker = "font/PF스타더스트 Bold.ttf"

mainBackgroundMusic = audio.loadSound( "sound/밝은브금.mp3" )
liarroomSound = audio.loadSound( "sound/거짓말쟁이방.mp3 ")
default_bgm = audio.loadSound( "sound/default_bgm.mp3" )
wrongSound = audio.loadSound( "sound/경고음 1.mp3" )
warningSound = audio.loadSound( "sound/경고음 2.mp3" )
insertItem = audio.loadSound( "sound/게임 시스템/딸깍 소리 1.mp3" )
buttonSound = audio.loadSound( "sound/게임 시스템/딸깍 소리 2.mp3" )
gameSuccess = audio.loadSound( "sound/게임 시스템/성공 소리.mp3" )
questSound = audio.loadSound( "sound/게임 시스템/알림 소리.mp3" )
itemGetSound = audio.loadSound("sound/게임 시스템/아이템 얻는 소리 1.mp3")
garbageSound = audio.loadSound( "sound/낙엽 밟는 소리.mp3" )
keySound = audio.loadSound("sound/열쇠.mp3")
darkSound =  audio.loadSound("sound/게임 시스템/암전 될 때 소리.mp3")
sound_liar1 =  audio.loadSound("sound/거짓말쟁이 1.mp3")
sound_liar2 =  audio.loadSound("sound/거짓말쟁이 2.mp3")
dieSound =  audio.loadSound("sound/베는, 찔리는 소리 2.mp3")
sound_artist = audio.loadSound("sound/예술가의방.mp3")
mansionSound = audio.loadSound("sound/저택 브금.mp3")
itemNum = {}

cherry_interaction = 0
game1 = 0 --거짓말쟁이방
game2 = 0 --미로방
game3 = 0 --예술가의방
for i = 1, 6 do
	itemNum[i] = false
end

function rotateLoading() -- 로딩창 회전시키는 함수
	transition.to(loading, {
		rotation = loading.rotation + 720, --2바퀴 회전
		x = display.contentCenterX,
		y = display.contentCenterY,
		time = 3000, --3초간
		onComplete = nextScene --회전끝나면, nextScene함수로 이동
		}
	)
end

-- event listeners for tab buttons:
local function onFirstView( event )
	composer.gotoScene( "1층.game_start_loading" )
end

onFirstView()	-- invoke first tab button's onPress event manually

