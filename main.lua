-- Project: Undercover


--Require
local storyboard = require( "storyboard" )
local loadsave = require("loadsave")
local device = require("device")
local licensing = require( "licensing" )

if not device.isApple then

licensing.init( "google" )

local function alertListener ( event )
  if "clicked" == event.action then

    local i = event.index    
    if i == 1 then
      native.requestExit()
    end        
  end
end

local function licensingListener( event )

   local verified = event.isVerified
   if not event.isVerified then
      --failed verify app from the play store, we print a message
      native.showAlert ( "Not Authorized", "The app was not purchased from Google Play.", { "Close" }, alertListener)
   end
end

licensing.verify( licensingListener )
end

local timesOpen = loadsave.loadTable("timesOpen.json")
--timesOpen.opened = 0
  
  if (loadsave.loadTable("timesOpen.json") == nil) then
    timesOpen = {}
    timesOpen.opened = 0
    loadsave.saveTable(timesOpen, "timesOpen.json")
  elseif timesOpen.opened ~= "never" then
    --timesOpen.opened = 0
    if timesOpen.opened < 7 then
      timesOpen.opened = timesOpen.opened + 1
      loadsave.saveTable(timesOpen, "timesOpen.json")
    end
  end
 

storyboard.gotoScene( "menu", "fade", 800 )




