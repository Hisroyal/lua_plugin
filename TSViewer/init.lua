-- written by https://github.com/r3n3pde
 
-- Author: René Preuß
-- Website: http://renepreuss.net
 
-- Installation:
-- Go to your Teamspeak program folder -> plugins -> lua_plugin
-- Create a new folder, rename it to "TSViewer"
-- Put this init.lua file in the "TSViewer" folder
-- Adjust user config below to your needs
-- Start Teamspeak, make sure the lua plugin is enabled in options->plugins
-- Enter the plugin settings, enable the TSViewer script
 
-- Copyright (c) 2014 René Preuß
-- Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
-- The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 
require("ts3init")
require("ts3defs")
require("ts3errors")
function onTalkStatusChangeEvent(serverConnectionHandlerID, status, isReceivedWhisper, clientID)
local name = ts3.getClientVariableAsString(serverConnectionHandlerID, clientID, ts3defs.ClientProperties.CLIENT_NICKNAME)
local channelID = ts3.getChannelOfClient(serverConnectionHandlerID, clientID)
local clientList = ts3.getChannelClientList(serverConnectionHandlerID, channelID)
local file = io.open("C:/Users/Timo/AppData/Roaming/TS3Client/files/TSViewer.txt", "w")
io.output(file)
for i=1, #clientList do
local tempClientId = clientList[i]
local tempClientTalk = 0
if tempClientId == clientID then
tempClientTalk = status
else
tempClientTalk = ts3.getClientVariableAsString(serverConnectionHandlerID, tempClientId, ts3defs.ClientProperties.CLIENT_FLAG_TALKING)
end
local tempClientName = ts3.getClientVariableAsString(serverConnectionHandlerID, tempClientId, ts3defs.ClientProperties.CLIENT_NICKNAME)
local tempClientMuted = ts3.getClientVariableAsString(serverConnectionHandlerID, tempClientId, ts3defs.ClientProperties.CLIENT_IS_MUTED)
if tempClientTalk == 1 then
io.write("" .. tempClientName .. "\n")
else
io.write("\n")
end
end
io.close()
end
local registeredEvents = {
["onTalkStatusChangeEvent"] = onTalkStatusChangeEvent
}
ts3RegisterModule(MODULE_NAME, registeredEvents)
-- test
notifier = {}
notifier.test = function(serverConnectionHandlerID)
onClientMoveEvent(serverConnectionHandlerID,23,0,1,1,"Move It.")
end