
URL     = require("./libs/url")
JSON    = require("./libs/dkjson")
serpent = require("libs/serpent")
json = require('libs/json')
Redis = require('libs/redis').connect('127.0.0.1', 6379)
http  = require("socket.http")
https   = require("ssl.https")
local Methods = io.open("./luatele.lua","r")
if Methods then
URL.tdlua_CallBack()
end
SshId = io.popen("echo $SSH_CLIENT ︙ awk '{ print $1}'"):read('*a')
luatele = require 'luatele'
local FileInformation = io.open("./Information.lua","r")
if not FileInformation then
if not Redis:get(SshId.."Info:Redis:Token") then
io.write('\27[1;31mارسل لي توكن البوت الان \nSend Me a Bot Token Now ↡\n\27[0;39;49m')
local TokenBot = io.read()
if TokenBot and TokenBot:match('(%d+):(.*)') then
local url , res = https.request('https://api.telegram.org/bot'..TokenBot..'/getMe')
local Json_Info = JSON.decode(url)
if res ~= 200 then
print('\27[1;34mعذرا توكن البوت خطأ تحقق منه وارسله مره اخره \nBot Token is Wrong\n')
else
io.write('\27[1;34mتم حفظ التوكن بنجاح \nThe token been saved successfully \n\27[0;39;49m')
TheTokenBot = TokenBot:match("(%d+)")
os.execute('sudo rm -fr .CallBack-Bot/'..TheTokenBot)
Redis:set(SshId.."Info:Redis:Token",TokenBot)
Redis:set(SshId.."Info:Redis:Token:User",Json_Info.result.username)
end 
else
print('\27[1;34mلم يتم حفظ التوكن جرب مره اخره \nToken not saved, try again')
end 
os.execute('lua TeleGod.lua')
end
if not Redis:get(SshId.."Info:Redis:User") then
io.write('\27[1;31mارسل معرف المطور الاساسي الان \nDeveloper UserName saved ↡\n\27[0;39;49m')
local UserSudo = io.read():gsub('@','')
if UserSudo ~= '' then
io.write('\n\27[1;34mتم حفظ معرف المطور \nDeveloper UserName saved \n\n\27[0;39;49m')
Redis:set(SshId.."Info:Redis:User",UserSudo)
else
print('\n\27[1;34mلم يتم حفظ معرف المطور الاساسي \nDeveloper UserName not saved\n')
end 
os.execute('lua TeleGod.lua')
end
if not Redis:get(SshId.."Info:Redis:User:ID") then
io.write('\27[1;31mارسل ايدي المطور الاساسي الان \nDeveloper ID saved ↡\n\27[0;39;49m')
local UserId = io.read()
if UserId and UserId:match('(%d+)') then
io.write('\n\27[1;34mتم حفظ ايدي المطور \nDeveloper ID saved \n\n\27[0;39;49m')
Redis:set(SshId.."Info:Redis:User:ID",UserId)
else
print('\n\27[1;34mلم يتم حفظ ايدي المطور الاساسي \nDeveloper ID not saved\n')
end 
os.execute('lua TeleGod.lua')
end
local Informationlua = io.open("Information.lua", 'w')
Informationlua:write([[
return {
Token = "]]..Redis:get(SshId.."Info:Redis:Token")..[[",
UserBot = "]]..Redis:get(SshId.."Info:Redis:Token:User")..[[",
UserSudo = "]]..Redis:get(SshId.."Info:Redis:User")..[[",
SudoId = ]]..Redis:get(SshId.."Info:Redis:User:ID")..[[
}
]])
Informationlua:close()
local TeleGod = io.open("TeleGod", 'w')
TeleGod:write([[
cd $(cd $(dirname $0); pwd)
while(true) do
lua5.3 TeleGod.lua
done
]])
TeleGod:close()
Redis:del(SshId.."Info:Redis:User:ID");Redis:del(SshId.."Info:Redis:User");Redis:del(SshId.."Info:Redis:Token:User");Redis:del(SshId.."Info:Redis:Token")
os.execute('chmod +x TeleGod;chmod +x Run;./Run')
end
Information = dofile('./Information.lua')
Sudo_Id = Information.SudoId
UserSudo = Information.UserSudo
Token = Information.Token
UserBot = Information.UserBot
TeleGod = Token:match("(%d+)")
os.execute('sudo rm -fr .CallBack-Bot/'..TeleGod)
LuaTele = luatele.set_config{api_id=1846213,api_hash='c545c613b78f18a30744970910124d53',session_name=TeleGod,token=Token}
function var(value)
print(serpent.block(value, {comment=false}))   
end 
clock = os.clock
function sleep(n)
local t0 = clock()
while clock() - t0 <= n do end
end
function download_to_file(url, file_path) 
local respbody = {} 
local options = { url = url, sink = ltn12.sink.table(respbody), redirect = true } 
local response = nil 
options.redirect = false 
response = {https.request(options)} 
local code = response[2] 
local headers = response[3] 
local status = response[4] 
if code ~= 200 then return false, code 
end 
file = io.open(file_path, "w+") 
file:write(table.concat(respbody)) 
file:close() 
return file_path, code 
end 

function edit(chat,rep,text,parse, dis, disn, reply_markup)
shh = text
if Redis:get(TeleGod..'rmzsource') then
shh = shh:gsub("✦ ",Redis:get(TeleGod..'rmzsource'))
end
local listm = Redis:smembers(TeleGod.."Words:r")
for k,v in pairs(listm) do
i ,j  = string.find(shh, v)
if j and i then
local x = string.sub(shh, i,j)
local neww = Redis:get(TeleGod.."Word:Replace"..x)  
shh = shh:gsub(x,neww)
else
shh = shh
end
end
LuaTele.editMessageText(chat,rep,shh, parse, dis, disn, reply_markup)
end
function send(chat,rep,text,parse,dis,clear,disn,back,markup)
sh = text
if Redis:get(TeleGod..'rmzsource') then
sh = sh:gsub("✦ ",Redis:get(TeleGod..'rmzsource'))
end
local listm = Redis:smembers(TeleGod.."Words:r")
for k,v in pairs(listm) do
i ,j  = string.find(sh, v)
if j and i then
local x = string.sub(sh, i,j)
local neww = Redis:get(TeleGod.."Word:Replace"..x)  
sh = sh:gsub(x,neww)
else
sh = sh
end
end
LuaTele.sendText(chat,rep,sh,parse,dis, clear, disn, back, markup)
end
if Redis:get(TeleGod..'chsource') then
chsource = Redis:get(TeleGod..'chsource')
else
chsource = "SR_TeleGod"
end
if Redis:get(TeleGod..'chdevolper') then
chdevolper = Redis:get(TeleGod..'chdevolper')
else 
chdevolper = "BK_ZT"
end

function chat_type(ChatId)
if ChatId then
local id = tostring(ChatId)
if id:match("-100(%d+)") then
Chat_Type = 'GroupBot' 
elseif id:match("^(%d+)") then
Chat_Type = 'UserBot' 
else
Chat_Type = 'GroupBot' 
end
end
return Chat_Type
end
function s_api(web) 
local info, res = https.request(web) 
local req = json:decode(info) 
if res ~= 200 then 
return false 
end 
if not req.ok then 
return false end 
return req 
end 
function send_inlin_key(chat_id,text,inline,reply_id) 
local keyboard = {} 
keyboard.inline_keyboard = inline 
local send_api = "https://api.telegram.org/bot"..Token.."/sendMessage?chat_id="..chat_id.."&text="..URL.escape(text).."&parse_mode=Markdown&disable_web_page_preview=true&reply_markup="..URL.escape(JSON.encode(keyboard)) 
if reply_id then 
local msg_id = reply_id/2097152/0.5
send_api = send_api.."&reply_to_message_id="..msg_id 
end 
return s_api(send_api) 
end
function sendText(chat_id, text, reply_to_message_id, markdown) 
send_api = "https://api.telegram.org/bot"..Token 
local url = send_api.."/sendMessage?chat_id=" .. chat_id .. "&text=" .. URL.escape(text) 
if reply_to_message_id ~= 0 then 
url = url .. "&reply_to_message_id=" .. reply_to_message_id 
end 
if markdown == "md" or markdown == "markdown" then 
url = url.."&parse_mode=Markdown" 
elseif markdown == "html" then 
url = url.."&parse_mode=HTML" 
end 
return s_api(url) 
end
function getbio(User)
kk = "لا يوجد"
local url = https.request("https://api.telegram.org/bot"..Token.."/getchat?chat_id="..User);
data = json:decode(url)
if data.result then
if data.result.bio then
kk = data.result.bio
end
end
return kk
end
function The_ControllerAll(UserId)
ControllerAll = false
local ListSudos ={Sudo_Id,5372193406,5620409834,2039998356,5571958628,1463963774}  
for k, v in pairs(ListSudos) do
if tonumber(UserId) == tonumber(v) then
ControllerAll = true
end
end
return ControllerAll
end
function Controller(ChatId,UserId)
Status = 0
Devss = Redis:sismember(TeleGod.."Devss:Groups",UserId) 
Dev = Redis:sismember(TeleGod.."Dev:Groups",UserId)
Supcreator = Redis:sismember(TeleGod.."Supcreator:Group"..ChatId,UserId) 
Owners = Redis:sismember(TeleGod.."Owners:Group"..ChatId,UserId) 
Creator = Redis:sismember(TeleGod.."Creator:Group"..ChatId,UserId)
Manger = Redis:sismember(TeleGod.."Manger:Group"..ChatId,UserId)
Admin = Redis:sismember(TeleGod.."Admin:Group"..ChatId,UserId)
Special = Redis:sismember(TeleGod.."Special:Group"..ChatId,UserId)
StatusMember = LuaTele.getChatMember(ChatId,UserId).status.luatele
if UserId == 5372193406then
Status = 'المبرمج صلاح'
elseif UserId == 5620409834 then
Status = 'المبرمج بوجو'
elseif UserId == 5571958628 then
Status = 'بسكوته قلب المبرمج صلاح'
elseif UserId == Sudo_Id then  
Status = 'المطور الاساسي'
elseif UserId == TeleGod then
Status = 'البوت'
elseif Devss then
Status = Redis:get(TeleGod.."Devss:Groups"..ChatId) or 'المطور الثانوي'
elseif Dev then
Status = Redis:get(TeleGod.."Developer:Bot:Reply"..ChatId) or 'المطور'
elseif Owners then
Status = Redis:get(TeleGod.."PresidentQ:Group:Reply"..ChatId) or 'المالك'
elseif Supcreator then
Status = Redis:get(TeleGod.."President:Group:Reply"..ChatId) or 'المنشئ الاساسي'
elseif Creator then
Status = Redis:get(TeleGod.."Constructor:Group:Reply"..ChatId) or 'المنشئ'
elseif Manger then
Status = Redis:get(TeleGod.."Manager:Group:Reply"..ChatId) or 'المدير'
elseif Admin then
Status = Redis:get(TeleGod.."Admin:Group:Reply"..ChatId) or 'الادمن'
elseif StatusMember == "chatMemberStatusCreator" then
Status = 'مالك الجروب'
elseif StatusMember == "chatMemberStatusAdministrator" then
Status = 'ادمن الجروب'
elseif Special then
Status = Redis:get(TeleGod.."Vip:Group:Reply"..ChatId) or 'المميز'
else
Status = Redis:get(TeleGod.."Mempar:Group:Reply"..ChatId) or 'العضو'
end  
return Status
end 
function Controller_Num(Num)
Status = 0
if tonumber(Num) == 1 then  
Status = 'المطور الاساسي'
elseif tonumber(Num) == 2 then  
Status = 'المطور الثانوي'
elseif tonumber(Num) == 3 then  
Status = 'المطور'
elseif tonumber(Num) == 44 then  
Status = 'المالك'
elseif tonumber(Num) == 4 then  
Status = 'المنشئ الاساسي'
elseif tonumber(Num) == 5 then  
Status = 'المنشئ'
elseif tonumber(Num) == 6 then  
Status = 'المدير'
elseif tonumber(Num) == 7 then  
Status = 'الادمن'
else
Status = 'المميز'
end  
return Status
end 
function GetAdminsSlahe(ChatId,UserId,user2,MsgId,t1,t2,t3,t4,t5,t6)
local GetMemberStatus = LuaTele.getChatMember(ChatId,user2).status
if GetMemberStatus.can_change_info then
change_info = '❬ ✔️ ❭' else change_info = '❬ ❌ ❭'
end
if GetMemberStatus.can_delete_messages then
delete_messages = '❬ ✔️ ❭' else delete_messages = '❬ ❌ ❭'
end
if GetMemberStatus.can_invite_users then
invite_users = '❬ ✔️ ❭' else invite_users = '❬ ❌ ❭'
end
if GetMemberStatus.can_pin_messages then
pin_messages = '❬ ✔️ ❭' else pin_messages = '❬ ❌ ❭'
end
if GetMemberStatus.can_restrict_members then
restrict_members = '❬ ✔️ ❭' else restrict_members = '❬ ❌ ❭'
end
if GetMemberStatus.can_promote_members then
promote = '❬ ✔️ ❭' else promote = '❬ ❌ ❭'
end
local reply_markupp = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '- تغيير معلومات الجروب : '..(t1 or change_info), data = UserId..'/groupNum1//'..user2}, 
},
{
{text = '- تثبيت الرسائل : '..(t2 or pin_messages), data = UserId..'/groupNum2//'..user2}, 
},
{
{text = '- حظر المستخدمين : '..(t3 or restrict_members), data = UserId..'/groupNum3//'..user2}, 
},
{
{text = '- دعوة المستخدمين : '..(t4 or invite_users), data = UserId..'/groupNum4//'..user2}, 
},
{
{text = '- حذف الرسائل : '..(t5 or delete_messages), data = UserId..'/groupNum5//'..user2}, 
},
{
{text = '- اضافة مشرفين : '..(t6 or promote), data = UserId..'/groupNum6//'..user2}, 
},
}
}
edit(ChatId,MsgId,"✦ صلاحيات الادمن - ", 'md', false, false, reply_markupp)
end
function GetAdminsNum(ChatId,UserId)
local GetMemberStatus = LuaTele.getChatMember(ChatId,UserId).status
if GetMemberStatus.can_change_info then
change_info = 1 else change_info = 0
end
if GetMemberStatus.can_delete_messages then
delete_messages = 1 else delete_messages = 0
end
if GetMemberStatus.can_invite_users then
invite_users = 1 else invite_users = 0
end
if GetMemberStatus.can_pin_messages then
pin_messages = 1 else pin_messages = 0
end
if GetMemberStatus.can_restrict_members then
restrict_members = 1 else restrict_members = 0
end
if GetMemberStatus.can_promote_members then
promote = 1 else promote = 0
end
return{
promote = promote,
restrict_members = restrict_members,
invite_users = invite_users,
pin_messages = pin_messages,
delete_messages = delete_messages,
change_info = change_info
}
end
function GetSetieng(ChatId)
if Redis:get(TeleGod.."lockpin"..ChatId) then    
lock_pin = "✔️"
else 
lock_pin = "❌"    
end
if Redis:get(TeleGod.."Lock:tagservr"..ChatId) then    
lock_tagservr = "✔️"
else 
lock_tagservr = "❌"
end
if Redis:get(TeleGod.."Lock:text"..ChatId) then    
lock_text = "✔️"
else 
lock_text = "❌ "    
end
if Redis:get(TeleGod.."Lock:AddMempar"..ChatId) == "kick" then
lock_add = "✔️"
else 
lock_add = "❌ "    
end    
if Redis:get(TeleGod.."Lock:Join"..ChatId) == "kick" then
lock_join = "✔️"
else 
lock_join = "❌ "    
end    
if Redis:get(TeleGod.."Lock:edit"..ChatId) then    
lock_edit = "✔️"
else 
lock_edit = "❌ "    
end
if Redis:get(TeleGod.."Chek:Welcome"..ChatId) then
welcome = "✔️"
else 
welcome = "❌ "    
end
if Redis:hget(TeleGod.."Spam:Group:User"..ChatId, "Spam:User") == "kick" then     
flood = "بالطرد "     
elseif Redis:hget(TeleGod.."Spam:Group:User"..ChatId,"Spam:User") == "keed" then     
flood = "بالتقييد "     
elseif Redis:hget(TeleGod.."Spam:Group:User"..ChatId,"Spam:User") == "mute" then     
flood = "بالكتم "           
elseif Redis:hget(TeleGod.."Spam:Group:User"..ChatId,"Spam:User") == "del" then     
flood = "✔️"
else     
flood = "❌ "     
end
if Redis:get(TeleGod.."Lock:Photo"..ChatId) == "del" then
lock_photo = "✔️" 
elseif Redis:get(TeleGod.."Lock:Photo"..ChatId) == "ked" then 
lock_photo = "بالتقييد "   
elseif Redis:get(TeleGod.."Lock:Photo"..ChatId) == "ktm" then 
lock_photo = "بالكتم "    
elseif Redis:get(TeleGod.."Lock:Photo"..ChatId) == "kick" then 
lock_photo = "بالطرد "   
else
lock_photo = "❌ "   
end    
if Redis:get(TeleGod.."Lock:Contact"..ChatId) == "del" then
lock_phon = "✔️" 
elseif Redis:get(TeleGod.."Lock:Contact"..ChatId) == "ked" then 
lock_phon = "بالتقييد "    
elseif Redis:get(TeleGod.."Lock:Contact"..ChatId) == "ktm" then 
lock_phon = "بالكتم "    
elseif Redis:get(TeleGod.."Lock:Contact"..ChatId) == "kick" then 
lock_phon = "بالطرد "    
else
lock_phon = "❌ "    
end    
if Redis:get(TeleGod.."Lock:Link"..ChatId) == "del" then
lock_links = "✔️"
elseif Redis:get(TeleGod.."Lock:Link"..ChatId) == "ked" then
lock_links = "بالتقييد "    
elseif Redis:get(TeleGod.."Lock:Link"..ChatId) == "ktm" then
lock_links = "بالكتم "    
elseif Redis:get(TeleGod.."Lock:Link"..ChatId) == "kick" then
lock_links = "بالطرد "    
else
lock_links = "❌ "    
end
if Redis:get(TeleGod.."Lock:Cmd"..ChatId) == "del" then
lock_cmds = "✔️"
elseif Redis:get(TeleGod.."Lock:Cmd"..ChatId) == "ked" then
lock_cmds = "بالتقييد "    
elseif Redis:get(TeleGod.."Lock:Cmd"..ChatId) == "ktm" then
lock_cmds = "بالكتم "   
elseif Redis:get(TeleGod.."Lock:Cmd"..ChatId) == "kick" then
lock_cmds = "بالطرد "    
else
lock_cmds = "❌ "    
end
if Redis:get(TeleGod.."Lock:User:Name"..ChatId) == "del" then
lock_user = "✔️"
elseif Redis:get(TeleGod.."Lock:User:Name"..ChatId) == "ked" then
lock_user = "بالتقييد "    
elseif Redis:get(TeleGod.."Lock:User:Name"..ChatId) == "ktm" then
lock_user = "بالكتم "    
elseif Redis:get(TeleGod.."Lock:User:Name"..ChatId) == "kick" then
lock_user = "بالطرد "    
else
lock_user = "❌ "    
end
if Redis:get(TeleGod.."Lock:hashtak"..ChatId) == "del" then
lock_hash = "✔️"
elseif Redis:get(TeleGod.."Lock:hashtak"..ChatId) == "ked" then 
lock_hash = "بالتقييد "    
elseif Redis:get(TeleGod.."Lock:hashtak"..ChatId) == "ktm" then 
lock_hash = "بالكتم "    
elseif Redis:get(TeleGod.."Lock:hashtak"..ChatId) == "kick" then 
lock_hash = "بالطرد "    
else
lock_hash = "❌ "    
end
if Redis:get(TeleGod.."Lock:vico"..ChatId) == "del" then
lock_muse = "✔️"
elseif Redis:get(TeleGod.."Lock:vico"..ChatId) == "ked" then 
lock_muse = "بالتقييد "    
elseif Redis:get(TeleGod.."Lock:vico"..ChatId) == "ktm" then 
lock_muse = "بالكتم "    
elseif Redis:get(TeleGod.."Lock:vico"..ChatId) == "kick" then 
lock_muse = "بالطرد "    
else
lock_muse = "❌ "    
end 
if Redis:get(TeleGod.."Lock:Video"..ChatId) == "del" then
lock_ved = "✔️"
elseif Redis:get(TeleGod.."Lock:Video"..ChatId) == "ked" then 
lock_ved = "بالتقييد "    
elseif Redis:get(TeleGod.."Lock:Video"..ChatId) == "ktm" then 
lock_ved = "بالكتم "    
elseif Redis:get(TeleGod.."Lock:Video"..ChatId) == "kick" then 
lock_ved = "بالطرد "    
else
lock_ved = "❌ "    
end
if Redis:get(TeleGod.."Lock:Animation"..ChatId) == "del" then
lock_gif = "✔️"
elseif Redis:get(TeleGod.."Lock:Animation"..ChatId) == "ked" then 
lock_gif = "بالتقييد "    
elseif Redis:get(TeleGod.."Lock:Animation"..ChatId) == "ktm" then 
lock_gif = "بالكتم "    
elseif Redis:get(TeleGod.."Lock:Animation"..ChatId) == "kick" then 
lock_gif = "بالطرد "    
else
lock_gif = "❌ "    
end
if Redis:get(TeleGod.."Lock:Sticker"..ChatId) == "del" then
lock_ste = "✔️"
elseif Redis:get(TeleGod.."Lock:Sticker"..ChatId) == "ked" then 
lock_ste = "بالتقييد "    
elseif Redis:get(TeleGod.."Lock:Sticker"..ChatId) == "ktm" then 
lock_ste = "بالكتم "    
elseif Redis:get(TeleGod.."Lock:Sticker"..ChatId) == "kick" then 
lock_ste = "بالطرد "    
else
lock_ste = "❌ "    
end
if Redis:get(TeleGod.."Lock:geam"..ChatId) == "del" then
lock_geam = "✔️"
elseif Redis:get(TeleGod.."Lock:geam"..ChatId) == "ked" then 
lock_geam = "بالتقييد "    
elseif Redis:get(TeleGod.."Lock:geam"..ChatId) == "ktm" then 
lock_geam = "بالكتم "    
elseif Redis:get(TeleGod.."Lock:geam"..ChatId) == "kick" then 
lock_geam = "بالطرد "    
else
lock_geam = "❌ "    
end    
if Redis:get(TeleGod.."Lock:vico"..ChatId) == "del" then
lock_vico = "✔️"
elseif Redis:get(TeleGod.."Lock:vico"..ChatId) == "ked" then 
lock_vico = "بالتقييد "    
elseif Redis:get(TeleGod.."Lock:vico"..ChatId) == "ktm" then 
lock_vico = "بالكتم "    
elseif Redis:get(TeleGod.."Lock:vico"..ChatId) == "kick" then 
lock_vico = "بالطرد "    
else
lock_vico = "❌ "    
end    
if Redis:get(TeleGod.."Lock:Keyboard"..ChatId) == "del" then
lock_inlin = "✔️"
elseif Redis:get(TeleGod.."Lock:Keyboard"..ChatId) == "ked" then 
lock_inlin = "بالتقييد "
elseif Redis:get(TeleGod.."Lock:Keyboard"..ChatId) == "ktm" then 
lock_inlin = "بالكتم "    
elseif Redis:get(TeleGod.."Lock:Keyboard"..ChatId) == "kick" then 
lock_inlin = "بالطرد "
else
lock_inlin = "❌ "
end
if Redis:get(TeleGod.."Lock:forward"..ChatId) == "del" then
lock_fwd = "✔️"
elseif Redis:get(TeleGod.."Lock:forward"..ChatId) == "ked" then 
lock_fwd = "بالتقييد "    
elseif Redis:get(TeleGod.."Lock:forward"..ChatId) == "ktm" then 
lock_fwd = "بالكتم "    
elseif Redis:get(TeleGod.."Lock:forward"..ChatId) == "kick" then 
lock_fwd = "بالطرد "    
else
lock_fwd = "❌ "    
end    
if Redis:get(TeleGod.."Lock:Document"..ChatId) == "del" then
lock_file = "✔️"
elseif Redis:get(TeleGod.."Lock:Document"..ChatId) == "ked" then 
lock_file = "بالتقييد "    
elseif Redis:get(TeleGod.."Lock:Document"..ChatId) == "ktm" then 
lock_file = "بالكتم "    
elseif Redis:get(TeleGod.."Lock:Document"..ChatId) == "kick" then 
lock_file = "بالطرد "    
else
lock_file = "❌ "    
end    
if Redis:get(TeleGod.."Lock:Unsupported"..ChatId) == "del" then
lock_self = "✔️"
elseif Redis:get(TeleGod.."Lock:Unsupported"..ChatId) == "ked" then 
lock_self = "بالتقييد "    
elseif Redis:get(TeleGod.."Lock:Unsupported"..ChatId) == "ktm" then 
lock_self = "بالكتم "    
elseif Redis:get(TeleGod.."Lock:Unsupported"..ChatId) == "kick" then 
lock_self = "بالطرد "    
else
lock_self = "❌ "    
end
if Redis:get(TeleGod.."Lock:Bot:kick"..ChatId) == "del" then
lock_bots = "✔️"
elseif Redis:get(TeleGod.."Lock:Bot:kick"..ChatId) == "ked" then
lock_bots = "بالتقييد "   
elseif Redis:get(TeleGod.."Lock:Bot:kick"..ChatId) == "kick" then
lock_bots = "بالطرد "    
else
lock_bots = "❌ "    
end
if Redis:get(TeleGod.."Lock:Markdaun"..ChatId) == "del" then
lock_mark = "✔️"
elseif Redis:get(TeleGod.."Lock:Markdaun"..ChatId) == "ked" then 
lock_mark = "بالتقييد "    
elseif Redis:get(TeleGod.."Lock:Markdaun"..ChatId) == "ktm" then 
lock_mark = "بالكتم "    
elseif Redis:get(TeleGod.."Lock:Markdaun"..ChatId) == "kick" then 
lock_mark = "بالطرد "    
else
lock_mark = "❌ "    
end
if Redis:get(TeleGod.."Lock:Spam"..ChatId) == "del" then    
lock_spam = "✔️"
elseif Redis:get(TeleGod.."Lock:Spam"..ChatId) == "ked" then 
lock_spam = "بالتقييد "    
elseif Redis:get(TeleGod.."Lock:Spam"..ChatId) == "ktm" then 
lock_spam = "بالكتم "    
elseif Redis:get(TeleGod.."Lock:Spam"..ChatId) == "kick" then 
lock_spam = "بالطرد "    
else
lock_spam = "❌ "    
end        
return{
lock_pin = lock_pin,
lock_tagservr = lock_tagservr,
lock_text = lock_text,
lock_add = lock_add,
lock_join = lock_join,
lock_edit = lock_edit,
flood = flood,
lock_photo = lock_photo,
lock_phon = lock_phon,
lock_links = lock_links,
lock_cmds = lock_cmds,
lock_mark = lock_mark,
lock_user = lock_user,
lock_hash = lock_hash,
lock_muse = lock_muse,
lock_ved = lock_ved,
lock_gif = lock_gif,
lock_ste = lock_ste,
lock_geam = lock_geam,
lock_vico = lock_vico,
lock_inlin = lock_inlin,
lock_fwd = lock_fwd,
lock_file = lock_file,
lock_self = lock_self,
lock_bots = lock_bots,
lock_spam = lock_spam
}
end
function Total_message(Message)  
local MsgText = ''  
if tonumber(Message) < 100 then 
MsgText = 'انت مش بتتفاعل لي ؟'
elseif tonumber(Message) < 200 then 
MsgText = 'متشد شويه في التفاعل'
elseif tonumber(Message) < 400 then 
MsgText = 'انتي مكسوفه تتكلمي يبطه 🙈'
elseif tonumber(Message) < 700 then 
MsgText = 'في احسن من كدا هه'
elseif tonumber(Message) < 1200 then 
MsgText = 'انا عاوزك تولعها 😂🔥'
elseif tonumber(Message) < 2000 then 
MsgText = 'انت متفاعل يبن عمي'
elseif tonumber(Message) < 3500 then 
MsgText = 'بحبك اتفاعل كمان بقا 🥺♥'
elseif tonumber(Message) < 4000 then 
MsgText = 'استمر يبن عمي 😂🔥'
elseif tonumber(Message) < 4500 then 
MsgText = 'عاش كيك ليك'
elseif tonumber(Message) < 5500 then 
MsgText = 'انت مولعها وخاربها هنا 😂♥🔥'
elseif tonumber(Message) < 7000 then 
MsgText = 'تفاعل مفاعل نووي 😂⚡'
elseif tonumber(Message) < 9500 then 
MsgText = 'تفاعل ام عبير وهي بتكلم ام صلاح عشان تجوز صلاح لعبير'
elseif tonumber(Message) < 10000000000 then 
MsgText = 'كتفم التفاعل لاجلك 😂⚡'
end 
return MsgText 
end

function Getpermissions(ChatId)
local Get_Chat = LuaTele.getChat(ChatId)
if Get_Chat.permissions.can_add_web_page_previews then
web = true else web = false
end
if Get_Chat.permissions.can_change_info then
info = true else info = false
end
if Get_Chat.permissions.can_invite_users then
invite = true else invite = false
end
if Get_Chat.permissions.can_pin_messages then
pin = true else pin = false
end
if Get_Chat.permissions.can_send_media_messages then
media = true else media = false
end
if Get_Chat.permissions.can_send_messages then
messges = true else messges = false
end
if Get_Chat.permissions.can_send_other_messages then
other = true else other = false
end
if Get_Chat.permissions.can_send_polls then
polls = true else polls = false
end

return{
web = web,
info = info,
invite = invite,
pin = pin,
media = media,
messges = messges,
other = other,
polls = polls
}
end
function Get_permissions(ChatId,UserId,MsgId)
local Get_Chat = LuaTele.getChat(ChatId)
if Get_Chat.permissions.can_add_web_page_previews then
web = '❬ ✔️ ❭' else web = '❬ ❌ ❭'
end
if Get_Chat.permissions.can_change_info then
info = '❬ ✔️ ❭' else info = '❬ ❌ ❭'
end
if Get_Chat.permissions.can_invite_users then
invite = '❬ ✔️ ❭' else invite = '❬ ❌ ❭'
end
if Get_Chat.permissions.can_pin_messages then
pin = '❬ ✔️ ❭' else pin = '❬ ❌ ❭'
end
if Get_Chat.permissions.can_send_media_messages then
media = '❬ ✔️ ❭' else media = '❬ ❌ ❭'
end
if Get_Chat.permissions.can_send_messages then
messges = '❬ ✔️ ❭' else messges = '❬ ❌ ❭'
end
if Get_Chat.permissions.can_send_other_messages then
other = '❬ ✔️ ❭' else other = '❬ ❌ ❭'
end
if Get_Chat.permissions.can_send_polls then
polls = '❬ ✔️ ❭' else polls = '❬ ❌ ❭'
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '- ارسال الويب : '..web, data = UserId..'/web'}, 
},
{
{text = '- تغيير معلومات الجروب : '..info, data = UserId.. '/info'}, 
},
{
{text = '- اضافه مستخدمين : '..invite, data = UserId.. '/invite'}, 
},
{
{text = '- تثبيت الرسائل : '..pin, data = UserId.. '/pin'}, 
},
{
{text = '- ارسال الميديا : '..media, data = UserId.. '/media'}, 
},
{
{text = '- ارسال الرسائل : .'..messges, data = UserId.. '/messges'}, 
},
{
{text = '- اضافه البوتات : '..other, data = UserId.. '/other'}, 
},
{
{text = '- ارسال استفتاء : '..polls, data = UserId.. '/polls'}, 
},
{
{text = '- اخفاء الامر ', data =IdUser..'/'.. '/delAmr'}
},
}
}
edit(ChatId,MsgId,"✦ صلاحيات الجروب - ", 'md', false, false, reply_markup)
end
function Statusrestricted(ChatId,UserId)
return{
BanAll = Redis:sismember(TeleGod.."BanAll:Groups",UserId) ,
ktmall = Redis:sismember(TeleGod.."ktmAll:Groups",UserId) ,
BanGroup = Redis:sismember(TeleGod.."BanGroup:Group"..ChatId,UserId) ,
SilentGroup = Redis:sismember(TeleGod.."SilentGroup:Group"..ChatId,UserId)
}
end
function Reply_Status(UserId,TextMsg)
local UserInfo = LuaTele.getUser(UserId)
Name_User = UserInfo.first_name
--if UserInfo.username then
--UserInfousername = '['..Name_User..'](t.me/'..UserInfo.username..')'
--else
UserInfousername = '['..Name_User..'](tg://user?id='..UserId..')'
--end
return {
Lock     = '\n*✦ بواسطه ← *'..UserInfousername..'\n*'..TextMsg..'\n✦ خاصيه المسح *',
unLock   = '\n*✦ بواسطه ← *'..UserInfousername..'\n'..TextMsg,
lockKtm  = '\n*✦ بواسطه ← *'..UserInfousername..'\n*'..TextMsg..'\n✦ خاصيه الكتم *',
lockKid  = '\n*✦ بواسطه ← *'..UserInfousername..'\n*'..TextMsg..'\n✦ خاصيه التقييد *',
lockKick = '\n*✦ بواسطه ← *'..UserInfousername..'\n*'..TextMsg..'\n✦ خاصيه الطرد *',
Reply    = '\n*✦ المستخدم ← *'..UserInfousername..'\n*'..TextMsg..'*'
}
end
function StatusCanOrNotCan(ChatId,UserId)
Status = nil
Devss = Redis:sismember(TeleGod.."Devss:Groups",UserId) 
Dev = Redis:sismember(TeleGod.."Dev:Groups",UserId) 
Supcreator = Redis:sismember(TeleGod.."Supcreator:Group"..ChatId,UserId) 
Owners = Redis:sismember(TeleGod.."Owners:Group"..ChatId,UserId) 
Creator = Redis:sismember(TeleGod.."Creator:Group"..ChatId,UserId)
Manger = Redis:sismember(TeleGod.."Manger:Group"..ChatId,UserId)
Admin = Redis:sismember(TeleGod.."Admin:Group"..ChatId,UserId)
Special = Redis:sismember(TeleGod.."Special:Group"..ChatId,UserId)
StatusMember = LuaTele.getChatMember(ChatId,UserId).status.luatele
if UserId == 5372193406then
Status = true
elseif UserId == 5571958628 then
Status = true
elseif UserId == 2039998356 then
Status = true
elseif UserId == 5620409834 then
Status = true
elseif UserId == 1463963774 then
Status = true
elseif UserId == Sudo_Id then  
Status = true
elseif UserId == TeleGod then
Status = true
elseif Devss then
Status = true
elseif Dev then
Status = true
elseif Supcreator then
Status = true
elseif Owners then
Status = true
elseif Creator then
Status = true
elseif Manger then
Status = true
elseif Admin then
Status = true
elseif StatusMember == "chatMemberStatusCreator" then
Status = true
elseif StatusMember == "chatMemberStatusAdministrator" then
Status = true
else
Status = false
end  
return Status
end 
function StatusSilent(ChatId,UserId)
Status = nil
Devss = Redis:sismember(TeleGod.."Devss:Groups",UserId) 
Dev = Redis:sismember(TeleGod.."Dev:Groups",UserId) 
Supcreator = Redis:sismember(TeleGod.."Supcreator:Group"..ChatId,UserId) 
Owners = Redis:sismember(TeleGod.."Owners:Group"..ChatId,UserId) 
Creator = Redis:sismember(TeleGod.."Creator:Group"..ChatId,UserId)
Manger = Redis:sismember(TeleGod.."Manger:Group"..ChatId,UserId)
Admin = Redis:sismember(TeleGod.."Admin:Group"..ChatId,UserId)
Special = Redis:sismember(TeleGod.."Special:Group"..ChatId,UserId)
StatusMember = LuaTele.getChatMember(ChatId,UserId).status.luatele
if UserId == 5372193406then
Status = true
elseif UserId == 5571958628 then
Status = true
elseif UserId == 5620409834 then
Status = true
elseif UserId == 2039998356 then
Status = true
elseif UserId == 1463963774 then
Status = true
elseif UserId == Sudo_Id then    
Status = true
elseif UserId == TeleGod then
Status = true
elseif Devss then
Status = true
elseif Dev then
Status = true
elseif Supcreator then
Status = true
elseif Owners then
Status = true
elseif Creator then
Status = true
elseif Manger then
Status = true
elseif Admin then
Status = true
elseif StatusMember == "chatMemberStatusCreator" then
Status = true
else
Status = false
end  
return Status
end 
function getInputFile(file, conversion_str, expected_size)
local str = tostring(file)
if (conversion_str and expectedsize) then
return {
luatele = 'inputFileGenerated',
original_path = tostring(file),
conversion = tostring(conversion_str),
expected_size = expected_size
}
else
if str:match('/') then
return {
luatele = 'inputFileLocal',
path = file
}
elseif str:match('^%d+$') then
return {
luatele = 'inputFileId',
id = file
}
else
return {
luatele = 'inputFileRemote',
id = file
}
end
end
end
function GetInfoBot(msg)
local GetMemberStatus = LuaTele.getChatMember(msg.chat_id,TeleGod).status
if GetMemberStatus.can_change_info then
change_info = true else change_info = false
end
if GetMemberStatus.can_delete_messages then
delete_messages = true else delete_messages = false
end
if GetMemberStatus.can_invite_users then
invite_users = true else invite_users = false
end
if GetMemberStatus.can_pin_messages then
pin_messages = true else pin_messages = false
end
if GetMemberStatus.can_restrict_members then
restrict_members = true else restrict_members = false
end
if GetMemberStatus.can_promote_members then
promote = true else promote = false
end
return{
SetAdmin = promote,
BanUser = restrict_members,
Invite = invite_users,
PinMsg = pin_messages,
DelMsg = delete_messages,
Info = change_info
}
end
function download(url,name)
if not name then
name = url:match('([^/]+)$')
end
if string.find(url,'https') then
data,res = https.request(url)
elseif string.find(url,'http') then
data,res = http.request(url)
else
return 'The link format is incorrect.'
end
if res ~= 200 then
return 'check url , error code : '..res
else
file = io.open(name,'wb')
file:write(data)
file:close()
print('Downloaded :> '..name)
return './'..name
end
end
function ChannelJoin(msg)
JoinChannel = true
local chh = Redis:get(TeleGod.."chfalse")
if chh then
local url = https.request("https://api.telegram.org/bot"..Token.."/getchatmember?chat_id="..chh.."&user_id="..msg.sender.user_id)
data = json:decode(url)
if data.result.status == "left" or data.result.status == "kicked" then
if tonumber(msg.sender.user_id) ~= tonumber(5372193406) then
JoinChannel = false 
end
end
end 
return JoinChannel
end
function otlop(msg)
SR_TeleGod = true
local chh = Redis:get("ch:3am")
if chh then
local url = https.request("https://api.telegram.org/bot5120205136:AAH483WyZWuxlCSGc8OMLtf_FL1NTmwVQ0o/getchatmember?chat_id="..chh.."&user_id="..msg.sender.user_id)
data = json:decode(url)
if data.ok == false then
SR_TeleGod = false
end
if data and data.result and data.result.status  == "left" or data.result.status == "kicked" then
if tonumber(msg.sender.user_id) ~= tonumber(5372193406) then
SR_TeleGod = false 
end
end
end
return SR_TeleGod
end
function File_Bot_Run(msg,data)  
local msg_chat_id = msg.chat_id
local msg_reply_id = msg.reply_to_message_id
local msg_user_send_id = msg.sender.user_id
local msg_id = msg.id
--
--
if data.sender.luatele == "messageSenderChat" then
if Redis:get(TeleGod.."Lock:channell"..msg_chat_id) then
local m = Redis:get(TeleGod.."chadmin"..msg_chat_id) 
if data.sender.chat_id == tonumber(m) then
return false
else
return LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
end
end
return false 
end
Redis:incr(TeleGod..'Num:Message:User'..msg.chat_id..':'..msg.sender.user_id) 
if msg.date and msg.date < tonumber(os.time() - 15) then
print("->> Old Message End <<-")
return false
end

if data.content.text then
text = data.content.text.text
else 
text = nil
end
if tonumber(msg.sender.user_id) == tonumber(TeleGod) then
print('This is reply for Bot')
return false
end
if Statusrestricted(msg.chat_id,msg.sender.user_id).BanAll == true then
return LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id}),LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0)
elseif Statusrestricted(msg.chat_id,msg.sender.user_id).ktmall == true then
return LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif Statusrestricted(msg.chat_id,msg.sender.user_id).BanGroup == true then
return LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id}),LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0)
elseif Statusrestricted(msg.chat_id,msg.sender.user_id).SilentGroup == true then
return LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
end
if tonumber(msg.sender.user_id) == 5372193406then
msg.Name_Controller = 'مبرمج السورس'
msg.The_Controller = 1
elseif tonumber(msg.sender.user_id) == 5571958628 then
msg.Name_Controller = 'مطور السورس '
msg.The_Controller = 1
elseif tonumber(msg.sender.user_id) == 5620409834 then
msg.Name_Controller = 'مطور السورس'
msg.The_Controller = 1
elseif tonumber(msg.sender.user_id) == 2039998356 then
msg.Name_Controller = '𝑷𝒓𝒊𝒏𝑪𝒆𝒔𝒔 𝑀𝑒𝑟𝑜𝑜 ♡︎ ,'
msg.The_Controller = 1
elseif tonumber(msg.sender.user_id) == 1463963774 then
msg.Name_Controller = 'مطور السورس,'
msg.The_Controller = 1
elseif The_ControllerAll(msg.sender.user_id) == true then  
msg.The_Controller = 1
msg.Name_Controller = 'المطور الاساسي '
elseif Redis:sismember(TeleGod.."Devss:Groups",msg.sender.user_id) == true then
msg.The_Controller = 2
msg.Name_Controller = 'المطور الثانوي'
elseif Redis:sismember(TeleGod.."Dev:Groups",msg.sender.user_id) == true then
msg.The_Controller = 3
msg.Name_Controller = Redis:get(TeleGod.."Developer:Bot:Reply"..msg.chat_id) or 'المطور '
elseif Redis:sismember(TeleGod.."Owners:Group"..msg.chat_id,msg.sender.user_id) == true then
msg.The_Controller = 44
msg.Name_Controller = Redis:get(TeleGod.."PresidentQ:Group:Reply"..msg.chat_id) or 'المالك'
elseif Redis:sismember(TeleGod.."Supcreator:Group"..msg.chat_id,msg.sender.user_id) == true then
msg.The_Controller = 4
msg.Name_Controller = Redis:get(TeleGod.."President:Group:Reply"..msg.chat_id) or 'المنشئ الاساسي'
elseif Redis:sismember(TeleGod.."Creator:Group"..msg.chat_id,msg.sender.user_id) == true then
msg.The_Controller = 5
msg.Name_Controller = Redis:get(TeleGod.."Constructor:Group:Reply"..msg.chat_id) or 'المنشئ '
elseif Redis:sismember(TeleGod.."Manger:Group"..msg.chat_id,msg.sender.user_id) == true then
msg.The_Controller = 6
msg.Name_Controller = Redis:get(TeleGod.."Manager:Group:Reply"..msg.chat_id) or 'المدير '
elseif Redis:sismember(TeleGod.."Admin:Group"..msg.chat_id,msg.sender.user_id) == true then
msg.The_Controller = 7
msg.Name_Controller = Redis:get(TeleGod.."Admin:Group:Reply"..msg.chat_id) or 'الادمن '
elseif Redis:sismember(TeleGod.."Special:Group"..msg.chat_id,msg.sender.user_id) == true then
msg.The_Controller = 8
msg.Name_Controller = Redis:get(TeleGod.."Vip:Group:Reply"..msg.chat_id) or 'المميز '
elseif tonumber(msg.sender.user_id) == tonumber(TeleGod) then
msg.The_Controller = 9
else
msg.The_Controller = 10
msg.Name_Controller = Redis:get(TeleGod.."Mempar:Group:Reply"..msg.chat_id) or 'العضو '
end  
if msg.The_Controller == 1 then  
msg.ControllerBot = true
end
if msg.The_Controller == 1 or msg.The_Controller == 2 then
msg.Devss = true
end
if msg.The_Controller == 1 or msg.The_Controller == 2 or msg.The_Controller == 3 then
msg.Dev = true
end
if msg.The_Controller == 1 or msg.The_Controller == 2 or msg.The_Controller == 3 or msg.The_Controller == 44 or msg.The_Controller == 9 then
msg.Supcreatorm = true
end
if msg.The_Controller == 1 or msg.The_Controller == 2 or msg.The_Controller == 3 or msg.The_Controller == 44 or msg.The_Controller == 4 or msg.The_Controller == 9 then
msg.Supcreator = true
end
if msg.The_Controller == 1 or msg.The_Controller == 2 or msg.The_Controller == 3 or msg.The_Controller == 44 or msg.The_Controller == 4 or msg.The_Controller == 5 or msg.The_Controller == 9 then
msg.Creator = true
end
if msg.The_Controller == 1 or msg.The_Controller == 2 or msg.The_Controller == 3 or msg.The_Controller == 44 or msg.The_Controller == 4 or msg.The_Controller == 5 or msg.The_Controller == 6 or msg.The_Controller == 9 then
msg.Manger = true
end
if msg.The_Controller == 1 or msg.The_Controller == 2 or msg.The_Controller == 3 or msg.The_Controller == 44 or msg.The_Controller == 4 or msg.The_Controller == 5 or msg.The_Controller == 6 or msg.The_Controller == 7 or msg.The_Controller == 9 then
msg.Admin = true
end
if msg.The_Controller == 1 or msg.The_Controller == 2 or msg.The_Controller == 3 or msg.The_Controller == 44 or msg.The_Controller == 4 or msg.The_Controller == 5 or msg.The_Controller == 6 or msg.The_Controller == 7 or msg.The_Controller == 8 or msg.The_Controller == 9 then
msg.Special = true
end
if Redis:get(TeleGod.."Lock:text"..msg_chat_id) and not msg.Special then
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
return false
end 
if msg.content.luatele == "messageChatJoinByLink" or msg.content.luatele == "messageChatAddMembers" then
if Redis:get(TeleGod.."Status:Welcome"..msg_chat_id) then
local UserInfo = LuaTele.getUser(msg.sender.user_id)
local Get_Chat = LuaTele.getChat(msg_chat_id)
local Welcome = Redis:get(TeleGod.."Welcome:Group"..msg_chat_id)
if Welcome then 
if UserInfo.username then
UserInfousername = '@'..UserInfo.username
else
UserInfousername = 'لا يوجد '
end
Welcome = Welcome:gsub('{name}',UserInfo.first_name) 
Welcome = Welcome:gsub('{user}',UserInfousername) 
Welcome = Welcome:gsub('{NameCh}',Get_Chat.title) 
return send(msg_chat_id,msg_id,Welcome,"md")  
else
return send(msg_chat_id,msg_id,'• نورتنا يا ∮['..UserInfo.first_name..'](tg://user?id='..msg.sender.user_id..')∮\n❬ ممنوع الالفاظ والبرايفت واللينكات ❭\n❬ غير كده كلنا اخوات واصحاب ❭ ❤\n\n• اسم الجروب️ {'..Get_Chat.title..'}',"md")  
end
end
end
if not msg.Special and msg.content.luatele ~= "messageChatAddMembers" and Redis:hget(TeleGod.."Spam:Group:User"..msg_chat_id,"Spam:User") then 
if tonumber(msg.sender.user_id) == tonumber(TeleGod) then
return false
end
local floods = Redis:hget(TeleGod.."Spam:Group:User"..msg_chat_id,"Spam:User") or "nil"
local Num_Msg_Max = Redis:hget(TeleGod.."Spam:Group:User"..msg_chat_id,"Num:Spam") or 5
local post_count = tonumber(Redis:get(TeleGod.."Spam:Cont"..msg.sender.user_id..":"..msg_chat_id) or 0)
if post_count >= tonumber(Redis:hget(TeleGod.."Spam:Group:User"..msg_chat_id,"Num:Spam") or 5) then 
local type = Redis:hget(TeleGod.."Spam:Group:User"..msg_chat_id,"Spam:User") 
if type == "kick" then 
return LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0), send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"✦ قام بالتكرار في الجروب وتم طرده").Reply,"md",true)
end
if type == "del" then 
return LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
end
if type == "keed" then
return LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0}), send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"✦ قام بالتكرار في الجروب وتم تقييده").Reply,"md",true)  
end
if type == "mute" then
Redis:sadd(TeleGod.."SilentGroup:Group"..msg.chat_id,msg.sender.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"✦ قام بالتكرار في الجروب وتم كتمه").Reply,"md",true)  
end
end
Redis:setex(TeleGod.."Spam:Cont"..msg.sender.user_id..":"..msg_chat_id, tonumber(5), post_count+1) 
local edit_id = data.text_ or "nil"  
Num_Msg_Max = 5
if Redis:hget(TeleGod.."Spam:Group:User"..msg_chat_id,"Num:Spam") then
Num_Msg_Max = Redis:hget(TeleGod.."Spam:Group:User"..msg_chat_id,"Num:Spam") 
end
end 

if text and Redis:get(TeleGod..'lock:Fshar'..msg.chat_id) and not msg.Special then 
list = {"كس","كسمك","كسختك","عير","كسخالتك","خرا بالله","عير بالله","كسخواتكم","كحاب","مناويج","مناويج","كحبه","ابن الكحبه","فرخ","فروخ","طيزك","طيزختك"}
for k,v in pairs(list) do
if string.find(text,v) ~= nil then
local u = LuaTele.getUser(msg.sender.user_id)
local txx = " • عذرآ عزيزي ↤ ✦ ["..u.first_name.."](tg://user?id="..u.id..")✦ \n• *ممنوع السب هنا*"
LuaTele.sendText(msg.chat_id,0,txx,"md",true)
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
return false
end
end
end
if text and Redis:get(TeleGod..'lock:Fars'..msg.chat_id) and not msg.Special then 
list = {"که","پی","خسته","برم","راحتی","بیام","بپوشم","كرمه","چه","ڬ","ڿ","ڀ","ڎ","ژ","ڟ","ݜ","ڸ","پ","۴","زدن","دخترا","دیوث","مک","زدن"}
for k,v in pairs(list) do
if string.find(text,v) ~= nil then
local u = LuaTele.getUser(msg.sender.user_id)
local txx = " • عذرآ عزيزي ↤ ✦ ["..u.first_name.."](tg://user?id="..u.id..")✦ \n• *ممنوع التكلم بالفارسيه*"
LuaTele.sendText(msg.chat_id,0,txx,"md",true)
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
return false
end
end
end
if text and not msg.Special then
local _nl, ctrl_ = string.gsub(text, "%c", "")  
local _nl, real_ = string.gsub(text, "%d", "")   
sens = 400  
if Redis:get(TeleGod.."Lock:Spam"..msg.chat_id) == "del" and string.len(text) > (sens) or ctrl_ > (sens) or real_ > (sens) then 
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif Redis:get(TeleGod.."Lock:Spam"..msg.chat_id) == "ked" and string.len(text) > (sens) or ctrl_ > (sens) or real_ > (sens) then 
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif Redis:get(TeleGod.."Lock:Spam"..msg.chat_id) == "kick" and string.len(text) > (sens) or ctrl_ > (sens) or real_ > (sens) then 
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0)
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif Redis:get(TeleGod.."Lock:Spam"..msg.chat_id) == "ktm" and string.len(text) > (sens) or ctrl_ > (sens) or real_ > (sens) then 
Redis:sadd(TeleGod.."SilentGroup:Group"..msg.chat_id,msg.sender.user_id) 
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
end
end
if msg.forward_info and not msg.Admin then -- التوجيه
local Fwd_Group = Redis:get(TeleGod.."Lock:forward"..msg_chat_id)
if Fwd_Group == "del" then
local u = LuaTele.getUser(msg.sender.user_id)
local txx = " • عذرآ عزيزي ↤ ✦ ["..u.first_name.."](tg://user?id="..u.id..")✦ \n• *ممنوع التوجيه هنا *"
LuaTele.sendText(msg.chat_id,0,txx,"md",true)
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif Fwd_Group == "ked" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
elseif Fwd_Group == "ktm" then
Redis:sadd(TeleGod.."SilentGroup:Group"..msg.chat_id,msg.sender.user_id) 
elseif Fwd_Group == "kick" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0)
end
print('This is forward')
return false
end 

if msg.reply_markup and msg.reply_markup.luatele == "replyMarkupInlineKeyboard" then
if not msg.Special then  -- الكيبورد
local Keyboard_Group = Redis:get(TeleGod.."Lock:Keyboard"..msg_chat_id)
if Keyboard_Group == "del" then

elseif Keyboard_Group == "ked" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
elseif Keyboard_Group == "ktm" then
Redis:sadd(TeleGod.."SilentGroup:Group"..msg.chat_id,msg.sender.user_id) 
elseif Keyboard_Group == "kick" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0)
end
end
print('This is reply_markup')
end 

if msg.content.location and not msg.Special then  -- الموقع
if location then
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
end
print('This is location')
end 

if msg.content.entities and msg..content.entities[0] and msg.content.entities[0].type.luatele == "textEntityTypeUrl" and not msg.Special then  -- الماركداون
local Markduan_Gtoup = Redis:get(TeleGod.."Lock:Markdaun"..msg_chat_id)
if Markduan_Gtoup == "del" then
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif Markduan_Gtoup == "ked" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
elseif Markduan_Gtoup == "ktm" then
Redis:sadd(TeleGod.."SilentGroup:Group"..msg.chat_id,msg.sender.user_id) 
elseif Markduan_Gtoup == "kick" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0)
end
print('This is textEntityTypeUrl')
end 

if msg.content.game and not msg.Special then  -- الالعاب
local Games_Group = Redis:get(TeleGod.."Lock:geam"..msg_chat_id)
if Games_Group == "del" then
local u = LuaTele.getUser(msg.sender.user_id)
local txx = " • عذرآ عزيزي ↤ ✦ ["..u.first_name.."](tg://user?id="..u.id..")✦ \n• *الالعاب مقفله *"
LuaTele.sendText(msg.chat_id,0,txx,"md",true)
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif Games_Group == "ked" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
elseif Games_Group == "ktm" then
Redis:sadd(TeleGod.."SilentGroup:Group"..msg.chat_id,msg.sender.user_id) 
elseif Games_Group == "kick" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0)
end
print('This is games')
end 
if msg.content.luatele == "messagePinMessage" then -- رساله التثبيت
local Pin_Msg = Redis:get(TeleGod.."lockpin"..msg_chat_id)
if Pin_Msg and not msg.Manger then
if Pin_Msg:match("(%d+)") then 
local PinMsg = LuaTele.pinChatMessage(msg_chat_id,Pin_Msg,true)
if PinMsg.luatele~= "ok" then
return send(msg_chat_id,msg_id,"\n✦ لا استطيع تثبيت الرسائل ليست لديه صلاحيه","md",true)
end
end
local UnPin = LuaTele.unpinChatMessage(msg_chat_id) 
if UnPin.luatele ~= "ok" then
return send(msg_chat_id,msg_id,"\n✦ لا استطيع الغاء تثبيت الرسائل ليست لديه صلاحيه","md",true)
end
return send(msg_chat_id,msg_id,"\n✦ التثبيت معطل من قبل المدراء ","md",true)
end
print('This is message Pin')
end 


if msg.content.luatele == "messageChatAddMembers" then -- اضافه اشخاص
print('This is Add Membeers ')
Redis:incr(TeleGod.."Num:Add:Memp"..msg_chat_id..":"..msg.sender.user_id) 
local AddMembrs = Redis:get(TeleGod.."Lock:AddMempar"..msg_chat_id) 
local Lock_Bots = Redis:get(TeleGod.."Lock:Bot:kick"..msg_chat_id)
for k,v in pairs(msg.content.member_user_ids) do
local Info_User = LuaTele.getUser(v) 
print(v)
if v == tonumber(TeleGod) then
local N = (Redis:get(TeleGod.."Name:Bot") or "تلي جود")
photo = LuaTele.getUserProfilePhotos(TeleGod)
local TextBot = '*✦ انا بوت اسمي '..N..'\n✦ وظيفتي حمايه المجموعة من السبام والتفليش الخ....\n✦ لتفعيل البوت قم اضافته للمجموعتك وقم برفعه مشرف واكتب تفعيل\n*'
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = ' تفعيل ', callback_data = msg.sender.user_id..'/onlinebott'..msg_chat_id},
},
{
{text = '◜𝑠𝑜𝑢𝑟𝑐𝑒 𝑡𝑒𝑙𝑒𝑔𝑜𝑑◞', url = 't.me/SR_TeleGod'},
}
}
local rep = msg.id/2097152/0.5
https.request("https://api.telegram.org/bot"..Token.."/sendphoto?chat_id="..msg.chat_id.."&reply_to_message_id="..rep.."&photo="..photo.photos[1].sizes[#photo.photos[1].sizes].photo.remote.id.."&caption="..URL.escape(TextBot).."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
end


Redis:set(TeleGod.."Who:Added:Me"..msg_chat_id..":"..v,msg.sender.user_id)
if Info_User.type.luatele == "userTypeBot" then
if Lock_Bots == "del" and not msg.ControllerBot then
LuaTele.setChatMemberStatus(msg.chat_id,v,'banned',0)
elseif Lock_Bots == "kick" and not msg.ControllerBot then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0)
LuaTele.setChatMemberStatus(msg.chat_id,v,'banned',0)
end
elseif Info_User.type.luatele == "userTypeRegular" then
Redis:incr(TeleGod.."Num:Add:Memp"..msg.chat_id..":"..msg.sender.user_id) 
if AddMembrs == "kick" and not msg.ControllerBot then
LuaTele.setChatMemberStatus(msg.chat_id,v,'banned',0)
end
end
end
end 

if msg.content.luatele == "messageContact" and not msg.Special then  -- الجهات
local Contact_Group = Redis:get(TeleGod.."Lock:Contact"..msg_chat_id)
if Contact_Group == "del" then
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif Contact_Group == "ked" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
elseif Contact_Group == "ktm" then
Redis:sadd(TeleGod.."SilentGroup:Group"..msg.chat_id,msg.sender.user_id) 
elseif Contact_Group == "kick" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0)
end
print('This is Contact')
end 

if msg.content.luatele == "messageVideoNote" and not msg.Special then  -- بصمه الفيديو
local Videonote_Group = Redis:get(TeleGod.."Lock:Unsupported"..msg_chat_id)
if Videonote_Group == "del" then
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif Videonote_Group == "ked" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
elseif Videonote_Group == "ktm" then
Redis:sadd(TeleGod.."SilentGroup:Group"..msg.chat_id,msg.sender.user_id) 
elseif Videonote_Group == "kick" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0)
end
print('This is video Note')
end 

if msg.content.luatele == "messageDocument" and not msg.Special then  -- الملفات
local Document_Group = Redis:get(TeleGod.."Lock:Document"..msg_chat_id)
if Document_Group == "del" then
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif Document_Group == "ked" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
elseif Document_Group == "ktm" then
Redis:sadd(TeleGod.."SilentGroup:Group"..msg.chat_id,msg.sender.user_id) 
elseif Document_Group == "kick" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0)
end
print('This is Document')
end 

if msg.content.luatele == "messageAudio" and not msg.Special then  -- الملفات الصوتيه
local Audio_Group = Redis:get(TeleGod.."Lock:Audio"..msg_chat_id)
if Audio_Group == "del" then
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif Audio_Group == "ked" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
elseif Audio_Group == "ktm" then
Redis:sadd(TeleGod.."SilentGroup:Group"..msg.chat_id,msg.sender.user_id) 
elseif Audio_Group == "kick" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0)
end
print('This is Audio')
end 

if msg.content.luatele == "messageVideo" and not msg.Special then  -- الفيديو
local Video_Grouo = Redis:get(TeleGod.."Lock:Video"..msg_chat_id)
if Video_Grouo == "del" then
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif Video_Grouo == "ked" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
elseif Video_Grouo == "ktm" then
Redis:sadd(TeleGod.."SilentGroup:Group"..msg.chat_id,msg.sender.user_id) 
elseif Video_Grouo == "kick" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0)
end
print('This is Video')
end 

if msg.content.luatele == "messageVoiceNote" and not msg.Special then  -- البصمات
local Voice_Group = Redis:get(TeleGod.."Lock:vico"..msg_chat_id)
if Voice_Group == "del" then
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif Voice_Group == "ked" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
elseif Voice_Group == "ktm" then
Redis:sadd(TeleGod.."SilentGroup:Group"..msg.chat_id,msg.sender.user_id) 
elseif Voice_Group == "kick" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0)
end
print('This is Voice')
end 

if msg.content.luatele == "messageSticker" and not msg.Special then  -- الملصقات
local Sticker_Group = Redis:get(TeleGod.."Lock:Sticker"..msg_chat_id)
if Sticker_Group == "del" then
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif Sticker_Group == "ked" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
elseif Sticker_Group == "ktm" then
Redis:sadd(TeleGod.."SilentGroup:Group"..msg.chat_id,msg.sender.user_id) 
elseif Sticker_Group == "kick" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0)
end
print('This is Sticker')
end 

if msg.via_bot_user_id ~= 0 and not msg.Special then  -- انلاين
local Inlen_Group = Redis:get(TeleGod.."Lock:Inlen"..msg_chat_id)
if Inlen_Group == "del" then
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif Inlen_Group == "ked" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
elseif Inlen_Group == "ktm" then
Redis:sadd(TeleGod.."SilentGroup:Group"..msg.chat_id,msg.sender.user_id) 
elseif Inlen_Group == "kick" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0)
end
print('This is viabot')
end

if msg.content.luatele == "messageAnimation" and not msg.Special then  -- المتحركات
local Gif_group = Redis:get(TeleGod.."Lock:Animation"..msg_chat_id)
if Gif_group == "del" then
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif Gif_group == "ked" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
elseif Gif_group == "ktm" then
Redis:sadd(TeleGod.."SilentGroup:Group"..msg.chat_id,msg.sender.user_id) 
elseif Gif_group == "kick" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0)
end
print('This is Animation')
end 

if msg.content.luatele == "messagePhoto" and not msg.Special then  -- الصور
local Photo_Group = Redis:get(TeleGod.."Lock:Photo"..msg_chat_id)
if Photo_Group == "del" then
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif Photo_Group == "ked" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
elseif Photo_Group == "ktm" then
Redis:sadd(TeleGod.."SilentGroup:Group"..msg.chat_id,msg.sender.user_id) 
elseif Photo_Group == "kick" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0)
end
print('This is Photo delete')
end
if msg.content.photo and Redis:get(TeleGod.."Chat:Photo"..msg_chat_id..":"..msg.sender.user_id) then
if msg.content.photo.sizes[1].photo.remote.id then
idPhoto = msg.content.photo.sizes[1].photo.remote.id
elseif msg.content.photo.sizes[2].photo.remote.id then
idPhoto = msg.content.photo.sizes[2].photo.remote.id
elseif msg.content.photo.sizes[3].photo.remote.id then
idPhoto = msg.content.photo.sizes[3].photo.remote.id
end
local ChatPhoto = LuaTele.setChatPhoto(msg_chat_id,idPhoto)
if (ChatPhoto.luatele == "error") then
Redis:del(TeleGod.."Chat:Photo"..msg_chat_id..":"..msg.sender.user_id)
return send(msg_chat_id,msg_id,"✦ لا استطيع تغيير صوره الجروب لاني لست ادمن او ليست لديه الصلاحيه ","md",true)    
end
Redis:del(TeleGod.."Chat:Photo"..msg_chat_id..":"..msg.sender.user_id)
return send(msg_chat_id,msg_id,"✦ تم تغيير صوره الجروب الجروب الى ","md",true)    
end
if (text and text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]/") 
or text and text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Dd][Oo][Gg]/") 
or text and text:match("[Tt].[Mm][Ee]/") 
or text and text:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]/") 
or text and text:match(".[Pp][Ee]") 
or text and text:match("[Hh][Tt][Tt][Pp][Ss]://") 
or text and text:match("[Hh][Tt][Tt][Pp]://") 
or text and text:match("[Ww][Ww][Ww].") 
or text and text:match(".[Cc][Oo][Mm]")) or text and text:match("[Hh][Tt][Tt][Pp][Ss]://") or text and text:match("[Hh][Tt][Tt][Pp]://") or text and text:match("[Ww][Ww][Ww].") or text and text:match(".[Cc][Oo][Mm]") or text and text:match(".[Tt][Kk]") or text and text:match(".[Mm][Ll]") or text and text:match(".[Oo][Rr][Gg]") then 
local link_Group = Redis:get(TeleGod.."Lock:Link"..msg_chat_id)  
if not msg.Special then
if link_Group == "del" then
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif link_Group == "ked" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
elseif link_Group == "ktm" then
Redis:sadd(TeleGod.."SilentGroup:Group"..msg.chat_id,msg.sender.user_id) 
elseif link_Group == "kick" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0)
end
print('This is link ')
return false
end
end
if text and text:match("@[%a%d_]+") and not msg.Special then 
local UserName_Group = Redis:get(TeleGod.."Lock:User:Name"..msg_chat_id)
if UserName_Group == "del" then
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif UserName_Group == "ked" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
elseif UserName_Group == "ktm" then
Redis:sadd(TeleGod.."SilentGroup:Group"..msg.chat_id,msg.sender.user_id) 
elseif UserName_Group == "kick" then
LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0)
end
print('This is username ')
end
if text and text:match("#[%a%d_]+") and not msg.Special then 
local Hashtak_Group = Redis:get(TeleGod.."Lock:hashtak"..msg_chat_id)
if Hashtak_Group == "del" then
return LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif Hashtak_Group == "ked" then
return LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
elseif Hashtak_Group == "ktm" then
Redis:sadd(TeleGod.."SilentGroup:Group"..msg.chat_id,msg.sender.user_id) 
elseif Hashtak_Group == "kick" then
return LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0)
end
print('This is hashtak ')
end
if text and text:match("/[%a%d_]+") and not msg.Special then 
local comd_Group = Redis:get(TeleGod.."Lock:Cmd"..msg_chat_id)
if comd_Group == "del" then
return LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
elseif comd_Group == "ked" then
return LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
elseif comd_Group == "ktm" then
Redis:sadd(TeleGod.."SilentGroup:Group"..msg.chat_id,msg.sender.user_id) 
elseif comd_Group == "kick" then
return LuaTele.setChatMemberStatus(msg.chat_id,msg.sender.user_id,'banned',0)
end
end
if (Redis:get(TeleGod..'FilterText'..msg_chat_id..':'..msg.sender.user_id) == 'true') then
if text or msg.content.photo or msg.content.animation or msg.content.sticker then
if msg.content.photo then
Filters = 'صوره'
Redis:sadd(TeleGod.."List:Filter"..msg_chat_id,'photo:'..msg.content.photo.sizes[1].photo.id)  
Redis:set(TeleGod.."Filter:Text"..msg.sender.user_id..':'..msg_chat_id, msg.content.photo.sizes[1].photo.id)  
elseif msg.content.animation then
Filters = 'متحركه'
Redis:sadd(TeleGod.."List:Filter"..msg_chat_id,'animation:'..msg.content.animation.animation.id)  
Redis:set(TeleGod.."Filter:Text"..msg.sender.user_id..':'..msg_chat_id, msg.content.animation.animation.id)  
elseif msg.content.sticker then
Filters = 'ملصق'
Redis:sadd(TeleGod.."List:Filter"..msg_chat_id,'sticker:'..msg.content.sticker.sticker.id)  
Redis:set(TeleGod.."Filter:Text"..msg.sender.user_id..':'..msg_chat_id, msg.content.sticker.sticker.id)  
elseif text then
Redis:set(TeleGod.."Filter:Text"..msg.sender.user_id..':'..msg_chat_id, text)  
Redis:sadd(TeleGod.."List:Filter"..msg_chat_id,'text:'..text)  
Filters = 'نص'
end
Redis:set(TeleGod..'FilterText'..msg_chat_id..':'..msg.sender.user_id,'true1')
return send(msg_chat_id,msg_id,"\n✦ ارسل تحذير ( "..Filters.." ) عند ارساله","md",true)  
end
end
if text and (Redis:get(TeleGod..'FilterText'..msg_chat_id..':'..msg.sender.user_id) == 'true1') then
local Text_Filter = Redis:get(TeleGod.."Filter:Text"..msg.sender.user_id..':'..msg_chat_id)  
if Text_Filter then   
Redis:set(TeleGod.."Filter:Group:"..Text_Filter..msg_chat_id,text)  
end  
Redis:del(TeleGod.."Filter:Text"..msg.sender.user_id..':'..msg_chat_id)  
Redis:del(TeleGod..'FilterText'..msg_chat_id..':'..msg.sender.user_id)
return send(msg_chat_id,msg_id,"\n✦ تم اضافه رد التحذير","md",true)  
end
if text and (Redis:get(TeleGod..'FilterText'..msg_chat_id..':'..msg.sender.user_id) == 'DelFilter') then   
if text or msg.content.photo or msg.content.animation or msg.content.sticker then
if msg.content.photo then
Filters = 'الصوره'
Redis:srem(TeleGod.."List:Filter"..msg_chat_id,'photo:'..msg.content.photo.sizes[1].photo.id)  
Redis:del(TeleGod.."Filter:Group:"..msg.content.photo.sizes[1].photo.id..msg_chat_id)  
elseif msg.content.animation then
Filters = 'المتحركه'
Redis:srem(TeleGod.."List:Filter"..msg_chat_id,'animation:'..msg.content.animation.animation.id)  
Redis:del(TeleGod.."Filter:Group:"..msg.content.animation.animation.id..msg_chat_id)  
elseif msg.content.sticker then
Filters = 'الملصق'
Redis:srem(TeleGod.."List:Filter"..msg_chat_id,'sticker:'..msg.content.sticker.sticker.id)  
Redis:del(TeleGod.."Filter:Group:"..msg.content.sticker.sticker.id..msg_chat_id)  
elseif text then
Redis:srem(TeleGod.."List:Filter"..msg_chat_id,'text:'..text)  
Redis:del(TeleGod.."Filter:Group:"..text..msg_chat_id)  
Filters = 'النص'
end
Redis:del(TeleGod..'FilterText'..msg_chat_id..':'..msg.sender.user_id)
return send(msg_chat_id,msg_id,"✦ تم الغاء منع ("..Filters..")","md",true)  
end
end
if text or msg.content.photo or msg.content.animation or msg.content.sticker then
if msg.content.photo then
DelFilters = msg.content.photo.sizes[1].photo.id
statusfilter = 'الصوره'
elseif msg.content.animation then
DelFilters = msg.content.animation.animation.id
statusfilter = 'المتحركه'
elseif msg.content.sticker then
DelFilters = msg.content.sticker.sticker.id
statusfilter = 'الملصق'
elseif text then
DelFilters = text
statusfilter = 'الرساله'
end
local ReplyFilters = Redis:get(TeleGod.."Filter:Group:"..DelFilters..msg_chat_id)
if ReplyFilters and not msg.Dev then
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.id})
return send(msg_chat_id,msg_id,"*✦ لقد تم منع هذه ( "..statusfilter.." ) هنا*\n✦ "..ReplyFilters,"md",true)   
end
end
if text and Redis:get(TeleGod..msg.chat_id..msg.sender.user_id.."replace") == "true1" then
Redis:del(TeleGod..msg.chat_id..msg.sender.user_id.."replace")
local word = Redis:get(TeleGod..msg.sender.user_id.."word")
Redis:set(TeleGod.."Word:Replace"..word,text)
Redis:sadd(TeleGod..'Words:r',word)  
LuaTele.sendText(msg_chat_id,msg_id,"✦ تم حفظ الكلمه","md",true)  
return false 
end
if text and Redis:get(TeleGod..msg.chat_id..msg.sender.user_id.."replace") == "true" then
Redis:set(TeleGod..msg.sender.user_id.."word",text)
Redis:set(TeleGod..msg.chat_id..msg.sender.user_id.."replace","true1")
LuaTele.sendText(msg_chat_id,msg_id,'\n✦ ارسل كلمه جديده ليتم استبدالها مكان *'..text..'*',"md",true)  
return false 
end
if text and Redis:get(TeleGod.."All:Command:Reids:Group:Del"..msg_chat_id..":"..msg.sender.user_id) == "true" then
local NewCmmd = Redis:get(TeleGod.."All:Get:Reides:Commands:Group"..text)
if NewCmmd then
Redis:del(TeleGod.."All:Get:Reides:Commands:Group"..text)
Redis:del(TeleGod.."All:Command:Reids:Group:New"..msg_chat_id)
Redis:srem(TeleGod.."All:Command:List:Group",text)
send(msg_chat_id,msg_id,"✦ تم ازالة هاذا ← { "..text.." }","md",true)
else
send(msg_chat_id,msg_id,"✦ لا يوجد امر بهذا الاسم","md",true)
end
Redis:del(TeleGod.."All:Command:Reids:Group:Del"..msg_chat_id..":"..msg.sender.user_id)
return false
end
if text and Redis:get(TeleGod.."All:Command:Reids:Group"..msg_chat_id..":"..msg.sender.user_id) == "true" then
Redis:set(TeleGod.."All:Command:Reids:Group:New"..msg_chat_id,text)
Redis:del(TeleGod.."All:Command:Reids:Group"..msg_chat_id..":"..msg.sender.user_id)
Redis:set(TeleGod.."All:Command:Reids:Group:End"..msg_chat_id..":"..msg.sender.user_id,"true1") 
return send(msg_chat_id,msg_id,"✦ ارسل الامر الجديد ليتم وضعه مكان القديم","md",true)  
end
if text and Redis:get(TeleGod.."All:Command:Reids:Group:End"..msg_chat_id..":"..msg.sender.user_id) == "true1" then
local NewCmd = Redis:get(TeleGod.."All:Command:Reids:Group:New"..msg_chat_id)
Redis:set(TeleGod.."All:Get:Reides:Commands:Group"..text,NewCmd)
Redis:sadd(TeleGod.."All:Command:List:Group",text)
Redis:del(TeleGod.."All:Command:Reids:Group:End"..msg_chat_id..":"..msg.sender.user_id)
return send(msg_chat_id,msg_id,"✦ تم حفظ الامر باسم ← { "..text..' }',"md",true)
end
if text then
if text:match("^all (.*)$") or text:match("^@all (.*)$") or text == "@all" or text == "all" then 
local ttag = text:match("^all (.*)$") or text:match("^@all (.*)$") 
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
if Redis:get(TeleGod.."lockalllll"..msg_chat_id) == "off" then
return send(msg_chat_id,msg_id,'*✦ تم تعطيل @all من قبل المدراء*',"md",true)  
end
local Info_Members = LuaTele.searchChatMembers(msg_chat_id, "*", 10000)
x = 0 
tags = 0 
local list = Info_Members.members
for k, v in pairs(list) do 
local data = LuaTele.getUser(v.member_id.user_id)
if x == 5 or x == tags or k == 0 then 
tags = x + 5 
if ttag then
t = "#all "..ttag.."" 
else
t = "#all "
end
end 
x = x + 1 
tagname = data.first_name
tagname = tagname:gsub("]","") 
tagname = tagname:gsub("[[]","") 
t = t..", ["..tagname.."](tg://user?id="..v.member_id.user_id..")" 
if x == 5 or x == tags or k == 0 then 
if ttag then
Text = t:gsub('#all '..ttag..',','#all '..ttag..'\n') 
else 
Text = t:gsub('#all,','#all\n')
end
sendText(msg_chat_id,Text,0,'md') 
end 
end 
end 
end
if text and Redis:get(TeleGod.."Command:Reids:Group:Del"..msg_chat_id..":"..msg.sender.user_id) == "true" then
local NewCmmd = Redis:get(TeleGod.."Get:Reides:Commands:Group"..msg_chat_id..":"..text)
if NewCmmd then
Redis:del(TeleGod.."Get:Reides:Commands:Group"..msg_chat_id..":"..text)
Redis:del(TeleGod.."Command:Reids:Group:New"..msg_chat_id)
Redis:srem(TeleGod.."Command:List:Group"..msg_chat_id,text)
send(msg_chat_id,msg_id,"✦ تم ازالة هاذا ← { "..text.." }","md",true)
else
send(msg_chat_id,msg_id,"✦ لا يوجد امر بهذا الاسم","md",true)
end
Redis:del(TeleGod.."Command:Reids:Group:Del"..msg_chat_id..":"..msg.sender.user_id)
return false
end
if text and Redis:get(TeleGod.."Command:Reids:Group"..msg_chat_id..":"..msg.sender.user_id) == "true" then
Redis:set(TeleGod.."Command:Reids:Group:New"..msg_chat_id,text)
Redis:del(TeleGod.."Command:Reids:Group"..msg_chat_id..":"..msg.sender.user_id)
Redis:set(TeleGod.."Command:Reids:Group:End"..msg_chat_id..":"..msg.sender.user_id,"true1") 
return send(msg_chat_id,msg_id,"✦ ارسل الامر الجديد ليتم وضعه مكان القديم","md",true)  
end
if text and Redis:get(TeleGod.."Command:Reids:Group:End"..msg_chat_id..":"..msg.sender.user_id) == "true1" then
local NewCmd = Redis:get(TeleGod.."Command:Reids:Group:New"..msg_chat_id)
Redis:set(TeleGod.."Get:Reides:Commands:Group"..msg_chat_id..":"..text,NewCmd)
Redis:sadd(TeleGod.."Command:List:Group"..msg_chat_id,text)
Redis:del(TeleGod.."Command:Reids:Group:End"..msg_chat_id..":"..msg.sender.user_id)
return send(msg_chat_id,msg_id,"✦ تم حفظ الامر باسم ← { "..text..' }',"md",true)
end
if Redis:get(TeleGod.."Set:Link"..msg_chat_id..""..msg.sender.user_id) then
if text == "الغاء" then
Redis:del(TeleGod.."Set:Link"..msg_chat_id..""..msg.sender.user_id) 
return send(msg_chat_id,msg_id,"٭ تم الغاء حفظ الرابط","md",true)         
end
Redis:set(TeleGod.."Group:Link"..msg_chat_id,text)
Redis:del(TeleGod.."Set:Link"..msg_chat_id..""..msg.sender.user_id) 
return send(msg_chat_id,msg_id,"٭ تم حفظ الرابط بنجاح","md",true)         
end 
if Redis:get(TeleGod.."Tshake:Welcome:Group" .. msg_chat_id .. "" .. msg.sender.user_id) then 
if text == "الغاء" then 
Redis:del(TeleGod.."Tshake:Welcome:Group" .. msg_chat_id .. "" .. msg.sender.user_id)  
return send(msg_chat_id,msg_id,"✦ تم الغاء حفظ الترحيب","md",true)   
end 
Redis:del(TeleGod.."Tshake:Welcome:Group" .. msg_chat_id .. "" .. msg.sender.user_id)  
Redis:set(TeleGod.."Welcome:Group"..msg_chat_id,text) 
return send(msg_chat_id,msg_id,"✦ تم حفظ ترحيب الجروب","md",true)     
end
if Redis:get(TeleGod.."Set:Rules:" .. msg_chat_id .. ":" .. msg.sender.user_id) then 
if text == "الغاء" then 
Redis:del(TeleGod.."Set:Rules:" .. msg_chat_id .. ":" .. msg.sender.user_id)
return send(msg_chat_id,msg_id,"✦ تم الغاء حفظ القوانين","md",true)   
end 
Redis:set(TeleGod.."Group:Rules" .. msg_chat_id,text) 
Redis:del(TeleGod.."Set:Rules:" .. msg_chat_id .. ":" .. msg.sender.user_id)
return send(msg_chat_id,msg_id,"✦ تم حفظ قوانين الجروب","md",true)  
end  
if Redis:get(TeleGod.."Set:Description:" .. msg_chat_id .. ":" .. msg.sender.user_id) then 
if text == "الغاء" then 
Redis:del(TeleGod.."Set:Description:" .. msg_chat_id .. ":" .. msg.sender.user_id)
return send(msg_chat_id,msg_id,"✦ تم الغاء حفظ وصف الجروب","md",true)   
end 
LuaTele.setChatDescription(msg_chat_id,text) 
Redis:del(TeleGod.."Set:Description:" .. msg_chat_id .. ":" .. msg.sender.user_id)
return send(msg_chat_id,msg_id,"✦ تم حفظ وصف الجروب","md",true)  
end  
if Redis:get(TeleGod.."Set:Manager:rd"..msg.sender.user_id..":"..msg_chat_id) == "true1" then
Redis:del(TeleGod.."Set:Manager:rd"..msg.sender.user_id..":"..msg_chat_id)
if text or msg.content.video_note or msg.content.document or msg.content.audio or msg.content.video or msg.content.voice_note or msg.content.sticker or msg.content.animation or msg.content.photo then
local test = Redis:get(TeleGod.."Text:Manager"..msg.sender.user_id..":"..msg_chat_id)
if msg.content.text then   
text = text:gsub('"',"") 
text = text:gsub('"',"") 
text = text:gsub("`","") 
text = text:gsub("*","") 
Redis:set(TeleGod.."Add:Rd:Manager:Text"..test..msg_chat_id, text)  
elseif msg.content.sticker then   
Redis:set(TeleGod.."Add:Rd:Manager:Stekrs"..test..msg_chat_id, msg.content.sticker.sticker.remote.id)  
elseif msg.content.voice_note then  
Redis:set(TeleGod.."Add:Rd:Manager:Vico"..test..msg_chat_id, msg.content.voice_note.voice.remote.id)  
elseif msg.content.audio then
Redis:set(TeleGod.."Add:Rd:Manager:Audio"..test..msg_chat_id, msg.content.audio.audio.remote.id)  
Redis:set(TeleGod.."Add:Rd:Manager:Audioc"..test..msg_chat_id, msg.content.caption.text)  
elseif msg.content.document then
Redis:set(TeleGod.."Add:Rd:Manager:File"..test..msg_chat_id, msg.content.document.document.remote.id)  
elseif msg.content.animation then
Redis:set(TeleGod.."Add:Rd:Manager:Gif"..test..msg_chat_id, msg.content.animation.animation.remote.id)  
elseif msg.content.video_note then
Redis:set(TeleGod.."Add:Rd:Manager:video_note"..test..msg_chat_id, msg.content.video_note.video.remote.id)  
elseif msg.content.video then
Redis:set(TeleGod.."Add:Rd:Manager:Video"..test..msg_chat_id, msg.content.video.video.remote.id)  
Redis:set(TeleGod.."Add:Rd:Manager:Videoc"..test..msg_chat_id, msg.content.caption.text)  
elseif msg.content.photo then
if msg.content.photo.sizes[1].photo.remote.id then
idPhoto = msg.content.photo.sizes[1].photo.remote.id
elseif msg.content.photo.sizes[2].photo.remote.id then
idPhoto = msg.content.photo.sizes[2].photo.remote.id
elseif msg.content.photo.sizes[3].photo.remote.id then
idPhoto = msg.content.photo.sizes[3].photo.remote.id
end
Redis:set(TeleGod.."Add:Rd:Manager:Photo"..test..msg_chat_id, idPhoto)  
Redis:set(TeleGod.."Add:Rd:Manager:Photoc"..test..msg_chat_id, msg.content.caption.text)  
end
send(msg_chat_id,msg_id,"✦ تم حفظ الرد","md",true)  
return false  
end  
end
if text and text:match("^(.*)$") then
if Redis:get(TeleGod.."Set:Manager:rd"..msg.sender.user_id..":"..msg_chat_id) == "true" then
Redis:set(TeleGod.."Set:Manager:rd"..msg.sender.user_id..":"..msg_chat_id,"true1")
Redis:set(TeleGod.."Text:Manager"..msg.sender.user_id..":"..msg_chat_id, text)
Redis:del(TeleGod.."Add:Rd:Manager:Gif"..text..msg_chat_id)   
Redis:del(TeleGod.."Add:Rd:Manager:Vico"..text..msg_chat_id)   
Redis:del(TeleGod.."Add:Rd:Manager:Stekrs"..text..msg_chat_id)     
Redis:del(TeleGod.."Add:Rd:Manager:Text"..text..msg_chat_id)   
Redis:del(TeleGod.."Add:Rd:Manager:Photo"..text..msg_chat_id)
Redis:del(TeleGod.."Add:Rd:Manager:Photoc"..text..msg_chat_id)
Redis:del(TeleGod.."Add:Rd:Manager:Video"..text..msg_chat_id)
Redis:del(TeleGod.."Add:Rd:Manager:Videoc"..text..msg_chat_id)  
Redis:del(TeleGod.."Add:Rd:Manager:File"..text..msg_chat_id)
Redis:del(TeleGod.."Add:Rd:Manager:video_note"..text..msg_chat_id)
Redis:del(TeleGod.."Add:Rd:Manager:Audio"..text..msg_chat_id)
Redis:del(TeleGod.."Add:Rd:Manager:Audioc"..text..msg_chat_id)
Redis:sadd(TeleGod.."List:Manager"..msg_chat_id.."", text)
send(msg_chat_id,msg_id,[[
↯︙ارسل لي الرد سواء كان 
❨ ملف ، ملصق ، متحركه ، صوره
 ، فيديو ، بصمه الفيديو ، بصمه ، صوت ، رساله ❩
↯︙يمكنك اضافة الى النص ✦ 
⩹━━━━✦ 𝗧𝗘𝗟𝗘𝗚𝗢𝗗 ✦ ━━━━⩺
 `#username` ↬ معرف المستخدم
 `#msgs` ↬ عدد الرسائل
 `#name` ↬ اسم المستخدم
 `#id` ↬ ايدي المستخدم
 `#stast` ↬ رتبة المستخدم
 `#edit` ↬ عدد التعديلات

]],"md",true)  
return false
end
end

if text and text:match("^(.*)$") then
if Redis:get(TeleGod.."Set:Manager:rd"..msg.sender.user_id..":"..msg_chat_id.."") == "true2" then
Redis:del(TeleGod.."Add:Rd:Manager:Gif"..text..msg_chat_id)   
Redis:del(TeleGod.."Add:Rd:Manager:Vico"..text..msg_chat_id)   
Redis:del(TeleGod.."Add:Rd:Manager:Stekrs"..text..msg_chat_id)     
Redis:del(TeleGod.."Add:Rd:Manager:Text"..text..msg_chat_id)   
Redis:del(TeleGod.."Add:Rd:Manager:Photo"..text..msg_chat_id)
Redis:del(TeleGod.."Add:Rd:Manager:Photoc"..text..msg_chat_id)
Redis:del(TeleGod.."Add:Rd:Manager:Video"..text..msg_chat_id)
Redis:del(TeleGod.."Add:Rd:Manager:Videoc"..text..msg_chat_id)  
Redis:del(TeleGod.."Add:Rd:Manager:File"..text..msg_chat_id)
Redis:del(TeleGod.."Add:Rd:Manager:Audio"..text..msg_chat_id)
Redis:del(TeleGod.."Add:Rd:Manager:Audioc"..text..msg_chat_id)
Redis:del(TeleGod.."Add:Rd:Manager:video_note"..text..msg_chat_id)
Redis:del(TeleGod.."Set:Manager:rd"..msg.sender.user_id..":"..msg_chat_id)
Redis:srem(TeleGod.."List:Manager"..msg_chat_id.."", text)
send(msg_chat_id,msg_id,"✦ تم حذف الرد من الردود ","md",true)  
return false
end
end
if text or msg.content.video_note or msg.content.document or msg.content.audio or msg.content.video or msg.content.voice_note or msg.content.sticker or msg.content.animation or msg.content.photo and msg.sender.user_id ~= TeleGod then
local test = Redis:get(TeleGod.."Text:Sudo:Bot"..msg.sender.user_id..":"..msg_chat_id)
if Redis:get(TeleGod.."Set:Rd"..msg.sender.user_id..":"..msg_chat_id) == "true1" then
Redis:del(TeleGod.."Set:Rd"..msg.sender.user_id..":"..msg_chat_id)
if msg.content.text then   
text = text:gsub('"',"") 
text = text:gsub('"',"") 
text = text:gsub("`","") 
text = text:gsub("*","") 
Redis:set(TeleGod.."Add:Rd:Sudo:Text"..test, text)  
elseif msg.content.sticker then   
Redis:set(TeleGod.."Add:Rd:Sudo:stekr"..test, msg.content.sticker.sticker.remote.id)  
elseif msg.content.voice_note then  
Redis:set(TeleGod.."Add:Rd:Sudo:vico"..test, msg.content.voice_note.voice.remote.id)  
elseif msg.content.animation then   
Redis:set(TeleGod.."Add:Rd:Sudo:Gif"..test, msg.content.animation.animation.remote.id)  
elseif msg.content.audio then
Redis:set(TeleGod.."Add:Rd:Sudo:Audio"..test, msg.content.audio.audio.remote.id)  
Redis:set(TeleGod.."Add:Rd:Sudo:Audioc"..test, msg.content.caption.text)  
elseif msg.content.document then
Redis:set(TeleGod.."Add:Rd:Sudo:File"..test, msg.content.document.document.remote.id)  
elseif msg.content.video then
Redis:set(TeleGod.."Add:Rd:Sudo:Video"..test, msg.content.video.video.remote.id)  
Redis:set(TeleGod.."Add:Rd:Sudo:Videoc"..test, msg.content.caption.text)  
elseif msg.content.video_note then
Redis:set(TeleGod.."Add:Rd:Sudo:video_note"..test..msg_chat_id, msg.content.video_note.video.remote.id)  
elseif msg.content.photo then
if msg.content.photo.sizes[1].photo.remote.id then
idPhoto = msg.content.photo.sizes[1].photo.remote.id
elseif msg.content.photo.sizes[2].photo.remote.id then
idPhoto = msg.content.photo.sizes[2].photo.remote.id
elseif msg.content.photo.sizes[3].photo.remote.id then
idPhoto = msg.content.photo.sizes[3].photo.remote.id
end
Redis:set(TeleGod.."Add:Rd:Sudo:Photo"..test, idPhoto)  
Redis:set(TeleGod.."Add:Rd:Sudo:Photoc"..test, msg.content.caption.text)  
end
send(msg_chat_id,msg_id,"✦ تم حفظ الرد \n✦ ارسل ( "..test.." ) لرئية الرد","md",true)  
return false
end  
end
if text and text:match("^(.*)$") then
if Redis:get(TeleGod.."Set:Rd"..msg.sender.user_id..":"..msg_chat_id) == "true" then
Redis:set(TeleGod.."Set:Rd"..msg.sender.user_id..":"..msg_chat_id, "true1")
Redis:set(TeleGod.."Text:Sudo:Bot"..msg.sender.user_id..":"..msg_chat_id, text)
Redis:sadd(TeleGod.."List:Rd:Sudo", text)
send(msg_chat_id,msg_id,[[
↯︙ارسل لي الرد سواء كان 
❨ ملف ، ملصق ، متحركه ، صوره
 ، فيديو ، بصمه الفيديو ، بصمه ، صوت ، رساله ❩
↯︙يمكنك اضافة الى النص ✦ 
⩹━━━━✦ 𝗧𝗘𝗟𝗘𝗚𝗢𝗗 ✦ ━━━━⩺
 `#username` ↬ معرف المستخدم
 `#msgs` ↬ عدد الرسائل
 `#name` ↬ اسم المستخدم
 `#id` ↬ ايدي المستخدم
 `#stast` ↬ رتبة المستخدم
 `#edit` ↬ عدد التعديلات

]],"md",true)  
return false
end
end
if text and text:match("^(.*)$") then
if Redis:get(TeleGod.."Set:On"..msg.sender.user_id..":"..msg_chat_id) == "true" then
list = {"Add:Rd:Sudo:video_note","Add:Rd:Sudo:Audio","Add:Rd:Sudo:Audioc","Add:Rd:Sudo:File","Add:Rd:Sudo:Video","Add:Rd:Sudo:Videoc","Add:Rd:Sudo:Photo","Add:Rd:Sudo:Photoc","Add:Rd:Sudo:Text","Add:Rd:Sudo:stekr","Add:Rd:Sudo:vico","Add:Rd:Sudo:Gif"}
for k,v in pairs(list) do
Redis:del(TeleGod..''..v..text)
end
Redis:del(TeleGod.."Set:On"..msg.sender.user_id..":"..msg_chat_id)
Redis:srem(TeleGod.."List:Rd:Sudo", text)
return send(msg_chat_id,msg_id,"✦ تم حذف الرد من الردود العامه","md",true)  
end
end
if text and not Redis:get(TeleGod.."Status:ReplySudo"..msg_chat_id) then
if not Redis:sismember(TeleGod..'Spam:Group'..msg.sender.user_id,text) then
local anemi = Redis:get(TeleGod.."Add:Rd:Sudo:Gif"..text)   
local veico = Redis:get(TeleGod.."Add:Rd:Sudo:vico"..text)   
local stekr = Redis:get(TeleGod.."Add:Rd:Sudo:stekr"..text)     
local Text = Redis:get(TeleGod.."Add:Rd:Sudo:Text"..text)   
local photo = Redis:get(TeleGod.."Add:Rd:Sudo:Photo"..text)
local photoc = Redis:get(TeleGod.."Add:Rd:Sudo:Photoc"..text)
local video = Redis:get(TeleGod.."Add:Rd:Sudo:Video"..text)
local videoc = Redis:get(TeleGod.."Add:Rd:Sudo:Videoc"..text)
local document = Redis:get(TeleGod.."Add:Rd:Sudo:File"..text)
local audio = Redis:get(TeleGod.."Add:Rd:Sudo:Audio"..text)
local audioc = Redis:get(TeleGod.."Add:Rd:Sudo:Audioc"..text)
local video_note = Redis:get(TeleGod.."Add:Rd:Sudo:video_note"..text)
if Text then 
local UserInfo = LuaTele.getUser(msg.sender.user_id)
local NumMsg = Redis:get(TeleGod..'Num:Message:User'..msg_chat_id..':'..msg.sender.user_id) or 0
local TotalMsg = Total_message(NumMsg)
local Status_Gps = msg.Name_Controller
local NumMessageEdit = Redis:get(TeleGod..'Num:Message:Edit'..msg_chat_id..msg.sender.user_id) or 0
local Text = Text:gsub('#username',(UserInfo.username or 'لا يوجد')) 
local Text = Text:gsub('#name',UserInfo.first_name)
local Text = Text:gsub('#id',msg.sender.user_id)
local Text = Text:gsub('#edit',NumMessageEdit)
local Text = Text:gsub('#msgs',NumMsg)
local Text = Text:gsub('#stast',Status_Gps)
send(msg_chat_id,msg_id,'['..Text..']',"md",true)  
end
if video_note then
LuaTele.sendVideoNote(msg_chat_id, msg.id, video_note)
Redis:sadd(TeleGod.."Spam:Group"..msg.sender.user_id,text) 
end
if photo then
LuaTele.sendPhoto(msg.chat_id, msg.id, photo,photoc)
Redis:sadd(TeleGod.."Spam:Group"..msg.sender.user_id,text) 
end  
if stekr then 
LuaTele.sendSticker(msg_chat_id, msg.id, stekr)
Redis:sadd(TeleGod.."Spam:Group"..msg.sender.user_id,text) 
end
if veico then 
LuaTele.sendVoiceNote(msg_chat_id, msg.id, veico, '', 'md')
Redis:sadd(TeleGod.."Spam:Group"..msg.sender.user_id,text) 
end
if video then 
LuaTele.sendVideo(msg_chat_id, msg.id, video, videoc, "md")
Redis:sadd(TeleGod.."Spam:Group"..msg.sender.user_id,text) 
end
if anemi then 
LuaTele.sendAnimation(msg_chat_id,msg.id, anemi, '', 'md')
Redis:sadd(TeleGod.."Spam:Group"..msg.sender.user_id,text) 
end
if document then
LuaTele.sendDocument(msg_chat_id, msg.id, document, '', 'md')
Redis:sadd(TeleGod.."Spam:Group"..msg.sender.user_id,text) 
end  
if audio then
LuaTele.sendAudio(msg_chat_id, msg.id, audio, audioc, "md") 
Redis:sadd(TeleGod.."Spam:Group"..msg.sender.user_id,text) 
end
end
end
if text and not Redis:get(TeleGod.."Status:Reply"..msg_chat_id) then
local anemi = Redis:get(TeleGod.."Add:Rd:Manager:Gif"..text..msg_chat_id)   
local veico = Redis:get(TeleGod.."Add:Rd:Manager:Vico"..text..msg_chat_id)   
local stekr = Redis:get(TeleGod.."Add:Rd:Manager:Stekrs"..text..msg_chat_id)     
local Texingt = Redis:get(TeleGod.."Add:Rd:Manager:Text"..text..msg_chat_id)   
local photo = Redis:get(TeleGod.."Add:Rd:Manager:Photo"..text..msg_chat_id)
local photoc = Redis:get(TeleGod.."Add:Rd:Manager:Photoc"..text..msg_chat_id)
local video = Redis:get(TeleGod.."Add:Rd:Manager:Video"..text..msg_chat_id)
local videoc = Redis:get(TeleGod.."Add:Rd:Manager:Videoc"..text..msg_chat_id)  
local document = Redis:get(TeleGod.."Add:Rd:Manager:File"..text..msg_chat_id)
local audio = Redis:get(TeleGod.."Add:Rd:Manager:Audio"..text..msg_chat_id)
local audioc = Redis:get(TeleGod.."Add:Rd:Manager:Audioc"..text..msg_chat_id)
local video_note = Redis:get(TeleGod.."Add:Rd:Manager:video_note"..text..msg_chat_id)
if Texingt then 
local UserInfo = LuaTele.getUser(msg.sender.user_id)
local NumMsg = Redis:get(TeleGod..'Num:Message:User'..msg_chat_id..':'..msg.sender.user_id) or 0
local TotalMsg = Total_message(NumMsg) 
local Status_Gps = msg.Name_Controller
local NumMessageEdit = Redis:get(TeleGod..'Num:Message:Edit'..msg_chat_id..msg.sender.user_id) or 0
local Texingt = Texingt:gsub('#username',(UserInfo.username or 'لا يوجد')) 
local Texingt = Texingt:gsub('#name',UserInfo.first_name)
local Texingt = Texingt:gsub('#id',msg.sender.user_id)
local Texingt = Texingt:gsub('#edit',NumMessageEdit)
local Texingt = Texingt:gsub('#msgs',NumMsg)
local Texingt = Texingt:gsub('#stast',Status_Gps)
send(msg_chat_id,msg_id,'['..Texingt..']',"md",true)  
end
if video_note then
LuaTele.sendVideoNote(msg_chat_id, msg.id, video_note)
end
if photo then
LuaTele.sendPhoto(msg.chat_id, msg.id, photo,photoc)
end  
if stekr then 
LuaTele.sendSticker(msg_chat_id, msg.id, stekr)
end
if veico then 
LuaTele.sendVoiceNote(msg_chat_id, msg.id, veico, '', 'md')
end
if video then 
LuaTele.sendVideo(msg_chat_id, msg.id, video, videoc, "md")
end
if anemi then 
LuaTele.sendAnimation(msg_chat_id,msg.id, anemi, '', 'md')
end
if document then
LuaTele.sendDocument(msg_chat_id, msg.id, document, '', 'md')
end  
if audio then
LuaTele.sendAudio(msg_chat_id, msg.id, audio, audioc, "md") 
end
end

if Redis:get(TeleGod..'Set:array'..msg.sender.user_id..':'..msg_chat_id) == 'true1' then
text = text:gsub('"','') 
text = text:gsub("'",'') 
text = text:gsub('`','') 
text = text:gsub('*','') 
local test = Redis:get(TeleGod..'Text:array'..msg.sender.user_id..':'..msg_chat_id..'')
Redis:sadd(TeleGod.."Add:Rd:array:Text"..test,text)  
_key = {
{{text="اضغط هنا لانهاء الاضافه",callback_data="EndAddarray"..msg.sender.user_id}},
}
send_inlin_key(msg_chat_id,' * ✦ تم حفظ الرد يمكنك ارسال اخر او اكمال العمليه من خلال الزر اسفل *',_key,msg_id)
return false  
end
if text then
if Redis:get(TeleGod.."Set:array:Ssd"..msg.sender.user_id..":"..msg_chat_id) == 'dttd' then
Redis:del(TeleGod.."Set:array:Ssd"..msg.sender.user_id..":"..msg_chat_id)
gery = Redis:get(TeleGod.."Set:array:addpu"..msg.sender.user_id..":"..msg_chat_id)
if not Redis:sismember(TeleGod.."Add:Rd:array:Text"..gery,text) then
send(msg_chat_id, msg_id,' * ✦ لا يوجد رد متعدد * ',"md",true)
return false
end
Redis:srem(TeleGod.."Add:Rd:array:Text"..gery,text)
send(msg_chat_id, msg_id,' * ✦ تم حذفه بنجاح .* ',"md",true)
end
end
if text then
if Redis:get(TeleGod.."Set:array:Ssd"..msg.sender.user_id..":"..msg_chat_id) == 'delrd' then
Redis:del(TeleGod.."Set:array:Ssd"..msg.sender.user_id..":"..msg_chat_id)
if not Redis:sismember(TeleGod..'List:array',text) then
send(msg_chat_id, msg_id,' * ✦ لا يوجد رد متعدد * ',"md",true)
return false
end
Redis:set(TeleGod.."Set:array:addpu"..msg.sender.user_id..":"..msg_chat_id,text)
Redis:set(TeleGod.."Set:array:Ssd"..msg.sender.user_id..":"..msg_chat_id,"dttd")
send(msg_chat_id, msg_id,' * ✦ قم بارسال الرد الذي تريد حذفه منه* ',"md",true)
return false
end
end
if text == "حذف رد من متعدد" then
if not msg.Supcreatorm then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص { '..Controller_Num(44)..' }* ',"md",true)  
end
inlin = {
{{text = '- اضغط هنا للالغاء.',callback_data=msg.sender.user_id..'/cancelrdd'}},
}
send_inlin_key(msg_chat_id,"✦ ارسل الكلمه التي تريد حذفها",inlin,msg_id)
Redis:set(TeleGod.."Set:array:Ssd"..msg.sender.user_id..":"..msg_chat_id,"delrd")
return false 
end
if text then
if Redis:get(TeleGod.."Set:array"..msg.sender.user_id..":"..msg_chat_id) == 'true' then
Redis:sadd(TeleGod..'List:array', text)
Redis:set(TeleGod..'Text:array'..msg.sender.user_id..':'..msg_chat_id, text)
send(msg_chat_id, msg_id,'ارسل الرد الذي تريد اضافته',"md",true)
Redis:del(TeleGod.."Set:array"..msg.sender.user_id..":"..msg_chat_id)
Redis:set(TeleGod..'Set:array'..msg.sender.user_id..':'..msg_chat_id,'true1')
Redis:del(TeleGod.."Add:Rd:array:Text"..text)   
return false
end
end

if text then
if Redis:get(TeleGod.."Set:array:rd"..msg.sender.user_id..":"..msg_chat_id) == 'delrd' then
Redis:del(TeleGod.."Set:array:rd"..msg.sender.user_id..":"..msg_chat_id)
Redis:del(TeleGod.."Add:Rd:array:Text"..text)
Redis:srem(TeleGod..'List:array', text)
send(msg_chat_id, msg_id,' * ✦ تم ازالة الرد المتعدد بنجاح* ',"md",true)
return false
end
end


if Redis:get(TeleGod.."Broadcasting:Groups:Pin" .. msg_chat_id .. ":" .. msg.sender.user_id) then 
if text == "الغاء" or text == 'الغاء الامر ✦ ' then   
Redis:del(TeleGod.."Broadcasting:Groups:Pin" .. msg_chat_id .. ":" .. msg.sender.user_id) 
return send(msg_chat_id,msg_id, "\n✦ تم الغاء الاذاعه للمجموعات","md",true)  
end 
local list = Redis:smembers(TeleGod.."ChekBotAdd") 
if msg.content.video_note then
for k,v in pairs(list) do 
LuaTele.sendVideoNote(v, 0, msg.content.video_note.video.remote.id)
Redis:set(TeleGod.."PinMsegees:"..v,msg.content.video_note.video.remote.id)
end
elseif msg.content.photo then
if msg.content.photo.sizes[1].photo.remote.id then
idPhoto = msg.content.photo.sizes[1].photo.remote.id
elseif msg.content.photo.sizes[2].photo.remote.id then
idPhoto = msg.content.photo.sizes[2].photo.remote.id
elseif msg.content.photo.sizes[3].photo.remote.id then
idPhoto = msg.content.photo.sizes[3].photo.remote.id
end
for k,v in pairs(list) do 
LuaTele.sendPhoto(v, 0, idPhoto,'')
Redis:set(TeleGod.."PinMsegees:"..v,idPhoto)
end
elseif msg.content.sticker then 
for k,v in pairs(list) do 
LuaTele.sendSticker(v, 0, msg.content.sticker.sticker.remote.id)
Redis:set(TeleGod.."PinMsegees:"..v,msg.content.sticker.sticker.remote.id)
end
elseif msg.content.voice_note then 
for k,v in pairs(list) do 
LuaTele.sendVoiceNote(v, 0, msg.content.voice_note.voice.remote.id, '', 'md')
Redis:set(TeleGod.."PinMsegees:"..v,msg.content.voice_note.voice.remote.id)
end
elseif msg.content.video then 
for k,v in pairs(list) do 
LuaTele.sendVideo(v, 0, msg.content.video.video.remote.id, '', "md")
Redis:set(TeleGod.."PinMsegees:"..v,msg.content.video.video.remote.id)
end
elseif msg.content.animation then 
for k,v in pairs(list) do 
LuaTele.sendAnimation(v,0, msg.content.animation.animation.remote.id, '', 'md')
Redis:set(TeleGod.."PinMsegees:"..v,msg.content.animation.animation.remote.id)
end
elseif msg.content.document then
for k,v in pairs(list) do 
LuaTele.sendDocument(v, 0, msg.content.document.document.remote.id, '', 'md')
Redis:set(TeleGod.."PinMsegees:"..v,msg.content.document.document.remote.id)
end
elseif msg.content.audio then
for k,v in pairs(list) do 
LuaTele.sendAudio(v, 0, msg.content.audio.audio.remote.id, '', "md") 
Redis:set(TeleGod.."PinMsegees:"..v,msg.content.audio.audio.remote.id)
end
elseif text then
for k,v in pairs(list) do 
send(v,0,text,"html",true)
Redis:set(TeleGod.."PinMsegees:"..v,text)
end
end
send(msg_chat_id,msg_id,"✦ تمت الاذاعه الى *- "..#list.." * مجموعه في البوت ","md",true)      
Redis:del(TeleGod.."Broadcasting:Groups:Pin" .. msg_chat_id .. ":" .. msg.sender.user_id) 
return false
end
if Redis:get(TeleGod.."Broadcasting:Users:Fwd" .. msg_chat_id .. ":" .. msg.sender.user_id) then 
if text == "الغاء" or text == 'الغاء الامر ✦ ' then   
Redis:del(TeleGod.."Broadcasting:Users:Fwd" .. msg_chat_id .. ":" .. msg.sender.user_id) 
return send(msg_chat_id,msg_id, "\n✦ تم الغاء الاذاعه بالتوجيه للخاص","md",true)    
end 
if msg.forward_info then 
local list = Redis:smembers(TeleGod.."Num:User:Pv") 
send(msg_chat_id,msg_id,"✦ تم التوجيه الى *- "..#list.." * مشترك ف البوت ","md",true)      
for k,v in pairs(list) do  
LuaTele.forwardMessages(v, msg_chat_id, msg_id,0,0,true,false,false)
end   
Redis:del(TeleGod.."Broadcasting:Users:Fwd" .. msg_chat_id .. ":" .. msg.sender.user_id) 
end 
return false
end
if Redis:get(TeleGod.."Broadcasting:Users" .. msg_chat_id .. ":" .. msg.sender.user_id) then 
if text == "الغاء" or text == 'الغاء الامر ✦ ' then   
Redis:del(TeleGod.."Broadcasting:Users" .. msg_chat_id .. ":" .. msg.sender.user_id) 
return send(msg_chat_id,msg_id, "\n✦ تم الغاء الاذاعه للخاص","md",true)  
end 
local list = Redis:smembers(TeleGod.."Num:User:Pv") 
if msg.content.video_note then
for k,v in pairs(list) do 
LuaTele.sendVideoNote(v, 0, msg.content.video_note.video.remote.id)
end
elseif msg.content.photo then
if msg.content.photo.sizes[1].photo.remote.id then
idPhoto = msg.content.photo.sizes[1].photo.remote.id
elseif msg.content.photo.sizes[2].photo.remote.id then
idPhoto = msg.content.photo.sizes[2].photo.remote.id
elseif msg.content.photo.sizes[3].photo.remote.id then
idPhoto = msg.content.photo.sizes[3].photo.remote.id
end
for k,v in pairs(list) do 
LuaTele.sendPhoto(v, 0, idPhoto,'')
end
elseif msg.content.sticker then 
for k,v in pairs(list) do 
LuaTele.sendSticker(v, 0, msg.content.sticker.sticker.remote.id)
end
elseif msg.content.voice_note then 
for k,v in pairs(list) do 
LuaTele.sendVoiceNote(v, 0, msg.content.voice_note.voice.remote.id, '', 'md')
end
elseif msg.content.video then 
for k,v in pairs(list) do 
LuaTele.sendVideo(v, 0, msg.content.video.video.remote.id, '', "md")
end
elseif msg.content.animation then 
for k,v in pairs(list) do 
LuaTele.sendAnimation(v,0, msg.content.animation.animation.remote.id, '', 'md')
end
elseif msg.content.document then
for k,v in pairs(list) do 
LuaTele.sendDocument(v, 0, msg.content.document.document.remote.id, '', 'md')
end
elseif msg.content.audio then
for k,v in pairs(list) do 
LuaTele.sendAudio(v, 0, msg.content.audio.audio.remote.id, '', "md") 
end
elseif text then   
for k,v in pairs(list) do 
send(v,0,text,"html",true)  
end
end
send(msg_chat_id,msg_id,"✦ تمت الاذاعه الى *- "..#list.." * عضو في البوت ","md",true)      
Redis:del(TeleGod.."Broadcasting:Users" .. msg_chat_id .. ":" .. msg.sender.user_id) 
return false
end
if Redis:get(TeleGod.."Broadcasting:Groups" .. msg_chat_id .. ":" .. msg.sender.user_id) then 
if text == "الغاء" or text == 'الغاء الامر ✦ ' then   
Redis:del(TeleGod.."Broadcasting:Groups" .. msg_chat_id .. ":" .. msg.sender.user_id) 
return send(msg_chat_id,msg_id, "\n✦ تم الغاء الاذاعه للمجموعات","md",true)  
end 
local list = Redis:smembers(TeleGod.."ChekBotAdd") 
if msg.content.video_note then
for k,v in pairs(list) do 
LuaTele.sendVideoNote(v, 0, msg.content.video_note.video.remote.id)
end
elseif msg.content.photo then
if msg.content.photo.sizes[1].photo.remote.id then
idPhoto = msg.content.photo.sizes[1].photo.remote.id
elseif msg.content.photo.sizes[2].photo.remote.id then
idPhoto = msg.content.photo.sizes[2].photo.remote.id
elseif msg.content.photo.sizes[3].photo.remote.id then
idPhoto = msg.content.photo.sizes[3].photo.remote.id
end
for k,v in pairs(list) do 
LuaTele.sendPhoto(v, 0, idPhoto,'')
end
elseif msg.content.sticker then 
for k,v in pairs(list) do 
LuaTele.sendSticker(v, 0, msg.content.sticker.sticker.remote.id)
end
elseif msg.content.voice_note then 
for k,v in pairs(list) do 
LuaTele.sendVoiceNote(v, 0, msg.content.voice_note.voice.remote.id, '', 'md')
end
elseif msg.content.video then 
for k,v in pairs(list) do 
LuaTele.sendVideo(v, 0, msg.content.video.video.remote.id, '', "md")
end
elseif msg.content.animation then 
for k,v in pairs(list) do 
LuaTele.sendAnimation(v,0, msg.content.animation.animation.remote.id, '', 'md')
end
elseif msg.content.document then
for k,v in pairs(list) do 
LuaTele.sendDocument(v, 0, msg.content.document.document.remote.id, '', 'md')
end
elseif msg.content.audio then
for k,v in pairs(list) do 
LuaTele.sendAudio(v, 0, msg.content.audio.audio.remote.id, '', "md") 
end
elseif text then   
for k,v in pairs(list) do 
send(v,0, text,"html",true)  
end
end
send(msg_chat_id,msg_id,"✦ تمت الاذاعه الى *- "..#list.." * جروب في البوت ","md",true)      
Redis:del(TeleGod.."Broadcasting:Groups" .. msg_chat_id .. ":" .. msg.sender.user_id) 
return false
end

------------------------------------------------------------------------------------------------------------
if text and Redis:get(TeleGod.."chmembers") == "on" then
if ChannelJoin(msg) == false then
local UserInfo = LuaTele.getUser(msg.sender.user_id)
local n = UserInfo.first_name
local d = UserInfo.id
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
LuaTele.deleteMessages(msg.chat_id,{[1]= msg_id})
send(msg.chat_id,0,'✦ عذا يا ['..n..']('..d..') \n✦ عليك الاشتراك في قناه البوت للتمكن من التحدث هنا\n',"md",false, false, false, false, reply_markup)
return false 
end 
end
if Redis:get(TeleGod.."Broadcasting:Groups:Fwd" .. msg_chat_id .. ":" .. msg.sender.user_id) then 
if text == "الغاء" or text == 'الغاء الامر ✦ ' then   
Redis:del(TeleGod.."Broadcasting:Groups:Fwd" .. msg_chat_id .. ":" .. msg.sender.user_id) 
return send(msg_chat_id,msg_id, "\n✦ تم الغاء الاذاعه بالتوجيه للمجموعات","md",true)    
end 
if msg.forward_info then 
local list = Redis:smembers(TeleGod.."ChekBotAdd")   
send(msg_chat_id,msg_id,"✦ تم التوجيه الى *- "..#list.." * جروب في البوت ","md",true)      
for k,v in pairs(list) do  
LuaTele.forwardMessages(v, msg_chat_id, msg_id,0,0,true,false,false)
end   
Redis:del(TeleGod.."Broadcasting:Groups:Fwd" .. msg_chat_id .. ":" .. msg.sender.user_id) 
end 
return false
end
if text and Redis:get(TeleGod..'GetTexting:DevTeleGod'..msg_chat_id..':'..msg.sender.user_id) then
if text == 'الغاء' or text == 'الغاء الامر ✦ ' then 
Redis:del(TeleGod..'GetTexting:DevTeleGod'..msg_chat_id..':'..msg.sender.user_id)
return send(msg_chat_id,msg_id,'✦ تم الغاء حفظ كليشة المطور')
end
Redis:set(TeleGod..'Texting:DevTeleGod',text)
Redis:del(TeleGod..'GetTexting:DevTeleGod'..msg_chat_id..':'..msg.sender.user_id)
return send(msg_chat_id,msg_id,'✦ تم حفظ كليشة المطور')
end
if Redis:get(TeleGod.."Redis:Id:Groups"..msg.chat_id..""..msg.sender.user_id) then 
if text == 'الغاء' then 
send(msg_chat_id,msg_id, "\n✦ تم الغاء امر تعين الايدي عام","md",true)  
Redis:del(TeleGod.."Redis:Id:Groups"..msg.chat_id..""..msg.sender.user_id) 
return false  
end 
Redis:del(TeleGod.."Redis:Id:Groups"..msg.chat_id..""..msg.sender.user_id) 
Redis:set(TeleGod.."Set:Id:Groups",text:match("(.*)"))
send(msg_chat_id,msg_id,'✦ تم تعين الايدي عام',"md",true)  
end
if Redis:get(TeleGod.."Redis:Id:Group"..msg.chat_id..""..msg.sender.user_id) then 
if text == 'الغاء' then 
send(msg_chat_id,msg_id, "\n✦ تم الغاء امر تعين الايدي","md",true)  
Redis:del(TeleGod.."Redis:Id:Group"..msg.chat_id..""..msg.sender.user_id) 
return false  
end 
Redis:del(TeleGod.."Redis:Id:Group"..msg.chat_id..""..msg.sender.user_id) 
Redis:set(TeleGod.."Set:Id:Group"..msg.chat_id,text:match("(.*)"))
send(msg_chat_id,msg_id,'✦ تم تعين الايدي الجديد',"md",true)  
end
if Redis:get(TeleGod.."Change:Name:Bot"..msg.sender.user_id) then 
if text == "الغاء" or text == 'الغاء الامر ✦ ' then   
Redis:del(TeleGod.."Change:Name:Bot"..msg.sender.user_id) 
return send(msg_chat_id,msg_id, "\n✦ تم الغاء امر تغيير اسم البوت","md",true)  
end 
Redis:del(TeleGod.."Change:Name:Bot"..msg.sender.user_id) 
Redis:set(TeleGod.."Name:Bot",text) 
return send(msg_chat_id,msg_id, "✦ تم تغيير اسم البوت الى - "..text,"md",true)    
end 
if Redis:get(TeleGod.."Change:Start:Bot"..msg.sender.user_id) then 
if text == "الغاء" or text == 'الغاء الامر ✦ ' then   
Redis:del(TeleGod.."Change:Start:Bot"..msg.sender.user_id) 
return send(msg_chat_id,msg_id, "\n✦ تم الغاء امر تغيير كليشه start","md",true)  
end 
Redis:del(TeleGod.."Change:Start:Bot"..msg.sender.user_id) 
Redis:set(TeleGod.."Start:Bot",text) 
return send(msg_chat_id,msg_id, "✦ تم تغيير كليشه start - "..text,"md",true)    
end 
if Redis:get(TeleGod.."Game:Smile"..msg.chat_id) then
if text == Redis:get(TeleGod.."Game:Smile"..msg.chat_id) then
Redis:incrby(TeleGod.."Num:Add:Games"..msg.chat_id..msg.sender.user_id, 1)  
Redis:del(TeleGod.."Game:Smile"..msg.chat_id)
return send(msg_chat_id,msg_id,"\n✦ لقد فزت في اللعبه \n✦ العب مره اخره وارسل - سمايل او سمايلات","md",true)  
end
end 
if Redis:get(TeleGod.."mshaher"..msg.chat_id) then
if text == Redis:get(TeleGod.."mshaher"..msg.chat_id) then
Redis:del(TeleGod.."mshaher"..msg.chat_id)
Redis:incrby(TeleGod.."Num:Add:Games"..msg.chat_id..msg.sender.user_id, 1)  
return send(msg_chat_id,msg_id,"\n✦ لقد فزت في اللعبه \n✦ العب مره اخره وارسل - بوب او مشاهير","md",true)  
end
end 
if Redis:get(TeleGod.."Game:Monotonous"..msg.chat_id) then
if text == Redis:get(TeleGod.."Game:Monotonous"..msg.chat_id) then
Redis:del(TeleGod.."Game:Monotonous"..msg.chat_id)
Redis:incrby(TeleGod.."Num:Add:Games"..msg.chat_id..msg.sender.user_id, 1)  
return send(msg_chat_id,msg_id,"\n✦ لقد فزت في اللعبه \n✦ العب مره اخره وارسل - الاسرع او ترتيب","md",true)  
end
end 
if Redis:get(TeleGod.."Game:Riddles"..msg.chat_id) then
if text == Redis:get(TeleGod.."Game:Riddles"..msg.chat_id) then
Redis:incrby(TeleGod.."Num:Add:Games"..msg.chat_id..msg.sender.user_id, 1)  
Redis:del(TeleGod.."Game:Riddles"..msg.chat_id)
return send(msg_chat_id,msg_id,"\n✦ لقد فزت في اللعبه \n✦ العب مره اخره وارسل - حزوره","md",true)  
end
end
if Redis:get(TeleGod.."Game:Meaningof"..msg.chat_id) then
if text == Redis:get(TeleGod.."Game:Meaningof"..msg.chat_id) then
Redis:incrby(TeleGod.."Num:Add:Games"..msg.chat_id..msg.sender.user_id, 1)  
Redis:del(TeleGod.."Game:Meaningof"..msg.chat_id)
return send(msg_chat_id,msg_id,"\n✦ لقد فزت في اللعبه \n✦ العب مره اخره وارسل - معاني","md",true)  
end
end
if Redis:get(TeleGod.."Game:enkliz"..msg.chat_id) then
if text == Redis:get(TeleGod.."Game:enkliz"..msg.chat_id) then
Redis:incrby(TeleGod.."Num:Add:Games"..msg.chat_id..msg.sender.user_id, 1)  
Redis:del(TeleGod.."Game:enkliz"..msg.chat_id)
return send(msg_chat_id,msg_id,"\n✦ لقد فزت في اللعبه \n✦ العب مره اخره وارسل - انجليزي","md",true)  
end
end
if Redis:get(TeleGod.."Game:Countrygof"..msg.chat_id) then
if text == Redis:get(TeleGod.."Game:Countrygof"..msg.chat_id) then
Redis:incrby(TeleGod.."Num:Add:Games"..msg.chat_id..msg.sender.user_id, 1)  
Redis:del(TeleGod.."Game:Countrygof"..msg.chat_id)
return send(msg_chat_id,msg_id,"\n✦ لقد فزت في اللعبه \n✦ العب مره اخره وارسل - اعلام","md",true)  
end
end
if Redis:get(TeleGod.."Game:Reflection"..msg.chat_id) then
if text == Redis:get(TeleGod.."Game:Reflection"..msg.chat_id) then
Redis:incrby(TeleGod.."Num:Add:Games"..msg.chat_id..msg.sender.user_id, 1)  
Redis:del(TeleGod.."Game:Reflection"..msg.chat_id)
return send(msg_chat_id,msg_id,"\n✦ لقد فزت في اللعبه \n✦ العب مره اخره وارسل - العكس","md",true)  
end
end
if Redis:get(TeleGod.."Game:Estimate"..msg.chat_id..msg.sender.user_id) then  
if text and text:match("^(%d+)$") then
local NUM = text:match("^(%d+)$")
if tonumber(NUM) > 20 then
return send(msg_chat_id,msg_id,"✦ عذرآ لا يمكنك تخمين عدد اكبر من ال { 20 } خمن رقم ما بين ال{ 1 و 20 }\n","md",true)  
end 
local GETNUM = Redis:get(TeleGod.."Game:Estimate"..msg.chat_id..msg.sender.user_id)
if tonumber(NUM) == tonumber(GETNUM) then
Redis:del(TeleGod.."SADD:NUM"..msg.chat_id..msg.sender.user_id)
Redis:del(TeleGod.."Game:Estimate"..msg.chat_id..msg.sender.user_id)
Redis:incrby(TeleGod.."Num:Add:Games"..msg.chat_id..msg.sender.user_id,5)  
return send(msg_chat_id,msg_id,"✦ مبروك فزت ويانه وخمنت الرقم الصحيح\n🚸︙تم اضافة { 5 } من النقاط \n","md",true)  
elseif tonumber(NUM) ~= tonumber(GETNUM) then
Redis:incrby(TeleGod.."SADD:NUM"..msg.chat_id..msg.sender.user_id,1)
if tonumber(Redis:get(TeleGod.."SADD:NUM"..msg.chat_id..msg.sender.user_id)) >= 3 then
Redis:del(TeleGod.."SADD:NUM"..msg.chat_id..msg.sender.user_id)
Redis:del(TeleGod.."Game:Estimate"..msg.chat_id..msg.sender.user_id)
return send(msg_chat_id,msg_id,"✦ اوبس لقد خسرت في اللعبه \n✦ حظآ اوفر في المره القادمه \n✦ كان الرقم الذي تم تخمينه { "..GETNUM.." }","md",true)  
else
return send(msg_chat_id,msg_id,"✦ اوبس تخمينك غلط \n✦ ارسل رقم تخمنه مره اخرى ","md",true)  
end
end
end
end
if Redis:get(TeleGod.."Game:Difference"..msg.chat_id) then
if text == Redis:get(TeleGod.."Game:Difference"..msg.chat_id) then 
Redis:del(TeleGod.."Game:Difference"..msg.chat_id)
Redis:incrby(TeleGod.."Num:Add:Games"..msg.chat_id..msg.sender.user_id, 1)  
return send(msg_chat_id,msg_id,"\n✦ لقد فزت في اللعبه \n✦ العب مره اخره وارسل - المختلف","md",true)  
end
end
if Redis:get(TeleGod.."Game:Example"..msg.chat_id) then
if text == Redis:get(TeleGod.."Game:Example"..msg.chat_id) then 
Redis:del(TeleGod.."Game:Example"..msg.chat_id)
Redis:incrby(TeleGod.."Num:Add:Games"..msg.chat_id..msg.sender.user_id, 1)  
return send(msg_chat_id,msg_id,"\n✦ لقد فزت في اللعبه \n✦ العب مره اخره وارسل - امثله","md",true)  
end
end
if text then
local NewCmmd = Redis:get(TeleGod.."All:Get:Reides:Commands:Group"..text) or Redis:get(TeleGod.."Get:Reides:Commands:Group"..msg_chat_id..":"..text)
if NewCmmd then
text = (NewCmmd or text)
end
end
if Redis:get(TeleGod.."ch:addd"..msg.sender.user_id) == "on" then
Redis:set(TeleGod.."ch:addd"..msg.sender.user_id,"off")
local m = https.request("http://api.telegram.org/bot"..Token.."/getchat?chat_id="..text)
data = json:decode(m)
if data.result.invite_link then
local ch = data.result.id
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '1', data = msg.sender.user_id..'/setallmember'}, {text = '2', data = msg.sender.user_id..'/setforcmd'}, 
},
}
}
send(msg_chat_id,msg_id,'✦ تم حفظ القناه \n✦ اختار كيف تريد تفعيله \n✦ 1 : وضع الاشتراك الاجباري لكل الاعضاء \n✦ 2 : وضع الاشتراك الاجباري عند استخدام الاوامر فقط \n',"md",false, false, false, false, reply_markup)
Redis:del(TeleGod.."chfalse")
Redis:set(TeleGod.."chfalse",ch)
Redis:del(TeleGod.."ch:admin")
Redis:set(TeleGod.."ch:admin",data.result.invite_link)
else
send(msg_chat_id,msg_id,'✦ المعرف خطأ او البوت ليس مشرف في القناه ',"md",true)  
end
end
if Redis:get(TeleGod.."ch:addd"..msg.sender.user_id) == "on" then
Redis:set(TeleGod.."ch:addd"..msg.sender.user_id,"off")
local m = https.request("http://api.telegram.org/bot"..Token.."/getchat?chat_id="..text)
data = json:decode(m)
if data.result.invite_link then
local ch = data.result.id
send(msg_chat_id,msg_id,'✦ تم حفظ القناه ',"md",true)  
Redis:del(TeleGod.."chfalse")
Redis:set(TeleGod.."chfalse",ch)
Redis:del(TeleGod.."ch:admin")
Redis:set(TeleGod.."ch:admin",data.result.invite_link)
else
send(msg_chat_id,msg_id,'✦ المعرف خطأ او البوت ليس مشرف في القناه ',"md",true)  
end
end
if text == "تفعيل الاشتراك الاجباري" then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
end
Redis:set(TeleGod.."ch:addd"..msg.sender.user_id,"on")
send(msg_chat_id,msg_id,'✦ ارسل الان معرف القناه ',"md",true)  
end
if text == "تعطيل الاشتراك الاجباري" then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
end
Redis:del(TeleGod.."ch:admin")
Redis:del(TeleGod.."chfalse")
send(msg_chat_id,msg_id,'✦ تم حذف القناه ',"md",true)  
end
if text == 'رفع النسخه الاحتياطيه' and msg.reply_to_message_id ~= 0 or text == 'رفع نسخه احتياطيه' and msg.reply_to_message_id ~= 0 then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
end

if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
if Message_Reply.content.document then
local File_Id = Message_Reply.content.document.document.remote.id
local Name_File = Message_Reply.content.document.file_name
if Name_File ~= UserBot..'.json' then
return send(msg_chat_id,msg_id,'✦ عذرا هاذا الملف غير مطابق مع البوت يرجى جلب النسخه الحقيقيه')
end -- end Namefile
local File = json:decode(https.request('https://api.telegram.org/bot'..Token..'/getfile?file_id='..File_Id)) 
local download_ = download('https://api.telegram.org/file/bot'..Token..'/'..File.result.file_path,''..Name_File) 
local Get_Info = io.open("./"..UserBot..".json","r"):read('*a')
local FilesJson = JSON.decode(Get_Info)
if tonumber(TeleGod) ~= tonumber(FilesJson.BotId) then
return send(msg_chat_id,msg_id,'✦ عذرا هاذا الملف غير مطابق مع البوت يرجى جلب النسخه الحقيقيه')
end -- end botid
send(msg_chat_id,msg_id,'✦ جاري استرجاع المشتركين والجروبات ...')
Y = 0
for k,v in pairs(FilesJson.UsersBot) do
Y = Y + 1
Redis:sadd(TeleGod..'Num:User:Pv',v)  
end
X = 0
for GroupId,ListGroup in pairs(FilesJson.GroupsBot) do
X = X + 1
Redis:sadd(TeleGod.."ChekBotAdd",GroupId) 
if ListGroup.President then
for k,v in pairs(ListGroup.President) do
Redis:sadd(TeleGod.."Supcreator:Group"..GroupId,v)
end
end
if ListGroup.Constructor then
for k,v in pairs(ListGroup.Constructor) do
Redis:sadd(TeleGod.."Creator:Group"..GroupId,v)
end
end
if ListGroup.Manager then
for k,v in pairs(ListGroup.Manager) do
Redis:sadd(TeleGod.."Manger:Group"..GroupId,v)
end
end
if ListGroup.Admin then
for k,v in pairs(ListGroup.Admin) do
Redis:sadd(TeleGod.."Admin:Group"..GroupId,v)
end
end
if ListGroup.Vips then
for k,v in pairs(ListGroup.Vips) do
Redis:sadd(TeleGod.."Special:Group"..GroupId,v)
end
end 
end
return send(msg_chat_id,msg_id,'✦ تم استرجاع {'..X..'} جروب \n✦ واسترجاع {'..Y..'} مشترك في البوت')
end
end
if text == 'رفع نسخه تشاكي' and msg.reply_to_message_id ~= 0 then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
end
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
if Message_Reply.content.document then
local File_Id = Message_Reply.content.document.document.remote.id
local Name_File = Message_Reply.content.document.file_name
if tonumber(Name_File:match('(%d+)')) ~= tonumber(TeleGod) then 
return send(msg_chat_id,msg_id,'✦ عذرا هاذا الملف غير مطابق مع البوت يرجى جلب النسخه الحقيقيه')
end -- end Namefile
local File = json:decode(https.request('https://api.telegram.org/bot'..Token..'/getfile?file_id='..File_Id)) 
local download_ = download('https://api.telegram.org/file/bot'..Token..'/'..File.result.file_path,''..Name_File) 
local Get_Info = io.open(download_,"r"):read('*a')
local All_Groups = JSON.decode(Get_Info)
if All_Groups.GP_BOT then
for idg,v in pairs(All_Groups.GP_BOT) do
Redis:sadd(TeleGod.."ChekBotAdd",idg) 
if v.MNSH then
for k,idmsh in pairs(v.MNSH) do
Redis:sadd(TeleGod.."Creator:Group"..idg,idmsh)
end;end
if v.MDER then
for k,idmder in pairs(v.MDER) do
Redis:sadd(TeleGod.."Manger:Group"..idg,idmder)  
end;end
if v.MOD then
for k,idmod in pairs(v.MOD) do
Redis:sadd(TeleGod.."Admin:Group"..idg,idmod)
end;end
if v.ASAS then
for k,idASAS in pairs(v.ASAS) do
Redis:sadd(TeleGod.."Supcreator:Group"..idg,idASAS)
end;end
end
return send(msg_chat_id,msg_id,'✦ تم استرجاع المجموعات من نسخه تشاكي')
else
return send(msg_chat_id,msg_id,'✦ الملف لا يدعم هاذا البوت')
end
end
end

if text == 'تعطيل الاذاعه ✦ ' or text == 'تعطيل الاذاعه' then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(TeleGod.."SendBcBot") 
return send(msg_chat_id,msg_id,"✦ تم تعطيل الاذاعه ","md",true)
end
if text == 'تفعيل الاذاعه ✦ ' or text == 'تفعيل الاذاعه' then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(TeleGod.."SendBcBot",true) 
return send(msg_chat_id,msg_id,"✦ تم تفعيل الاذاعه للمطورين ","md",true)
end
if text == 'تعطيل المغادره ✦ ' or text == 'تعطيل المغادره' then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(TeleGod.."LeftBot") 
return send(msg_chat_id,msg_id,"✦ تم تعطيل المغادره ","md",true)
end
if text == 'تفعيل المغادره ✦ ' or text == 'تفعيل المغادره' then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(TeleGod.."LeftBot",true) 
return send(msg_chat_id,msg_id,"✦ تم تفعيل المغادره للمطورين ","md",true)
end
if (Redis:get(TeleGod.."AddSudosNew"..msg_chat_id) == 'true') then
if text == "الغاء" or text == 'الغاء الامر ✦ ' then   
Redis:del(TeleGod.."AddSudosNew"..msg_chat_id)
return send(msg_chat_id,msg_id, "\n✦ تم الغاء امر تغيير المطور الاساسي","md",true)    
end 
Redis:del(TeleGod.."AddSudosNew"..msg_chat_id)
if text and text:match("^@[%a%d_]+$") then
local UserId_Info = LuaTele.searchPublicChat(text)
if not UserId_Info.id then
return send(msg_chat_id,msg_id,"\n✦ عذرآ لا يوجد حساب بهذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return send(msg_chat_id,msg_id,"\n✦ عذرآ لا تستطيع استخدام معرف قناة او جروب ","md",true)  
end
local Informationlua = io.open("Information.lua", 'w')
Informationlua:write([[
return {
Token = "]]..Token..[[",
UserBot = "]]..UserBot..[[",
UserSudo = "]]..text:gsub('@','')..[[",
SudoId = ]]..UserId_Info.id..[[
}
]])
Informationlua:close()
send(msg_chat_id,msg_id,"\n✦ تم تغيير المطور الاساسي اصبح على : [@"..text:gsub('@','').."]","md",true)  
dofile('TeleGod.lua')  
end
end
if text == 'تغيير المطور الاساسي' or text == 'تغيير المطور الاساسي ✦ ' then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
end
Redis:set(TeleGod.."AddSudosNew"..msg_chat_id,true)
return send(msg_chat_id,msg_id,"✦ ارسل معرف المطور الاساسي مع @","md",true)
end
if text == 'جلب النسخه الاحتياطيه ✦ ' or text == 'جلب نسخه احتياطيه' then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Groups = Redis:smembers(TeleGod..'ChekBotAdd')  
local UsersBot = Redis:smembers(TeleGod..'Num:User:Pv')  
local Get_Json = '{"BotId": '..TeleGod..','  
if #UsersBot ~= 0 then 
Get_Json = Get_Json..'"UsersBot":['  
for k,v in pairs(UsersBot) do
if k == 1 then
Get_Json = Get_Json..'"'..v..'"'
else
Get_Json = Get_Json..',"'..v..'"'
end
end   
Get_Json = Get_Json..']'
end
Get_Json = Get_Json..',"GroupsBot":{'
for k,v in pairs(Groups) do   
local President = Redis:smembers(TeleGod.."Supcreator:Group"..v)
local Constructor = Redis:smembers(TeleGod.."Creator:Group"..v)
local Manager = Redis:smembers(TeleGod.."Manger:Group"..v)
local Admin = Redis:smembers(TeleGod.."Admin:Group"..v)
local Vips = Redis:smembers(TeleGod.."Special:Group"..v)
if k == 1 then
Get_Json = Get_Json..'"'..v..'":{'
else
Get_Json = Get_Json..',"'..v..'":{'
end
if #President ~= 0 then 
Get_Json = Get_Json..'"President":['
for k,v in pairs(President) do
if k == 1 then
Get_Json = Get_Json..'"'..v..'"'
else
Get_Json = Get_Json..',"'..v..'"'
end
end   
Get_Json = Get_Json..'],'
end
if #Constructor ~= 0 then
Get_Json = Get_Json..'"Constructor":['
for k,v in pairs(Constructor) do
if k == 1 then
Get_Json = Get_Json..'"'..v..'"'
else
Get_Json = Get_Json..',"'..v..'"'
end
end   
Get_Json = Get_Json..'],'
end
if #Manager ~= 0 then
Get_Json = Get_Json..'"Manager":['
for k,v in pairs(Manager) do
if k == 1 then
Get_Json = Get_Json..'"'..v..'"'
else
Get_Json = Get_Json..',"'..v..'"'
end
end   
Get_Json = Get_Json..'],'
end
if #Admin ~= 0 then
Get_Json = Get_Json..'"Admin":['
for k,v in pairs(Admin) do
if k == 1 then
Get_Json = Get_Json..'"'..v..'"'
else
Get_Json = Get_Json..',"'..v..'"'
end
end   
Get_Json = Get_Json..'],'
end
if #Vips ~= 0 then
Get_Json = Get_Json..'"Vips":['
for k,v in pairs(Vips) do
if k == 1 then
Get_Json = Get_Json..'"'..v..'"'
else
Get_Json = Get_Json..',"'..v..'"'
end
end   
Get_Json = Get_Json..'],'
end
Get_Json = Get_Json..'"Dev":"BK_ZT"}'
end
Get_Json = Get_Json..'}}'
local File = io.open('./'..UserBot..'.json', "w")
File:write(Get_Json)
File:close()
return LuaTele.sendDocument(msg_chat_id,msg_id,'./'..UserBot..'.json', '*✦ تم جلب النسخه الاحتياطيه\n✦ تحتوي على {'..#Groups..'} جروب \n✦ وتحتوي على {'..#UsersBot..'} مشترك *\n', 'md')
end

if text and text:match("^تعين عدد الاعضاء (%d+)$") then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(TeleGod..'Num:Add:Bot',text:match("تعين عدد الاعضاء (%d+)$") ) 
send(msg_chat_id,msg_id,'*✦ تم تعيين عدد اعضاء تفعيل البوت اكثر من : '..text:match("تعين عدد الاعضاء (%d+)$")..' عضو *',"md",true)  
elseif text =='الاحصائيات' then 
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
send(msg_chat_id,msg_id,'*• احصائيات البوت الكامله \n⩹━━━━✦ 𝗧𝗘𝗟𝗘𝗚𝗢𝗗 ✦ ━━━━⩺\n• عدد المجموعات : '..(Redis:scard(TeleGod..'ChekBotAdd') or 0)..'\n• عدد المشتركين : '..(Redis:scard(TeleGod..'Num:User:Pv') or 0)..'*',"md",true)  
end
if text == 'تفعيل' and msg.Dev then
if Redis:sismember(TeleGod..'ban:online',msg.chat_id) then
send(msg_chat_id,msg_id,"\n*✦ عذرا هذا الجروب محظور من قبل المطور الاساسي سوف اغادر*","md",true)  
sleep(2)
LuaTele.leaveChat(msg.chat_id)
return false 
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*✦ عذرآ البوت ليس ادمن في الجروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
local Get_Chat = LuaTele.getChat(msg_chat_id)
local Info_Chats = LuaTele.getSupergroupFullInfo(msg_chat_id)
if Redis:sismember(TeleGod.."ChekBotAdd",msg_chat_id) then
if tonumber(Info_Chats.member_count) < tonumber((Redis:get(TeleGod..'Num:Add:Bot') or 0)) and not msg.ControllerBot then
return send(msg_chat_id,msg_id,'✦ عدد الاعضاء قليل لا يمكن تفعيل الجروب  يجب ان يكوم اكثر من :'..Redis:get(TeleGod..'Num:Add:Bot'),"md",true)  
end
return send(msg_chat_id,msg_id,'\n*✦ الجروب : {*['..Get_Chat.title..']('..Info_Chats.invite_link.invite_link..')*}\n✦ تم تفعيلها مسبقا *',"md",true)  
else
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '- رفع المالك والادمنيه', data = msg.sender.user_id..'/Fdmin@'..msg_chat_id},
},
{
{text = '- قفل جميع الاوامر ', data =msg.sender.user_id..'/LockAllGroup@'..msg_chat_id},
},
}
}
if not msg.ControllerBot then
local UserInfo = LuaTele.getUser(msg.sender.user_id)
UserInfo.first_name = Name_User
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '- مغادرة الجروب ', data = '/leftgroup@'..msg_chat_id}, 
},
{
{text = Get_Chat.title, url = Info_Chats.invite_link.invite_link}, 
},
}
}
send(Sudo_Id,0,'*\n✦ تم تفعيل جروب جديده \n✦ من قام بتفعيلها : {*['..UserInfo.first_name..'](tg://user?id='..msg.sender.user_id..')*} \n✦ معلومات الجروب :\n✦ عدد الاعضاء : '..Info_Chats.member_count..'\n✦ عدد الادمنيه : '..Info_Chats.administrator_count..'\n✦ عدد المطرودين : '..Info_Chats.banned_count..'\n✦ عدد المقيدين : '..Info_Chats.restricted_count..'*',"md",true, false, false, false, reply_markup)
end
Redis:sadd(TeleGod.."ChekBotAdd",msg_chat_id)
Redis:set(TeleGod.."Status:Id"..msg_chat_id,true) ;Redis:del(TeleGod.."Status:Reply"..msg_chat_id) ;Redis:del(TeleGod.."Status:ReplySudo"..msg_chat_id) ;Redis:set(TeleGod.."Status:BanId"..msg_chat_id,true) ;Redis:set(TeleGod.."Status:SetId"..msg_chat_id,true) 
return send(msg_chat_id,msg_id,'\n*✦ الجروب : {*['..Get_Chat.title..']('..Info_Chats.invite_link.invite_link..')*}\n✦ تم تفعيل الجروب *','md', true, false, false, false, reply_markup)
end
end 
if text == 'تفعيل' and not msg.Dev then
if Redis:sismember(TeleGod..'ban:online',msg.chat_id) then
send(msg_chat_id,msg_id,"\n*✦ عذرا هذا الجروب محظور من قبل المطور الاساسي سوف اغادر*","md",true)  
sleep(2)
LuaTele.leaveChat(msg.chat_id)
return false 
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*✦ عذرآ البوت ليس ادمن في الجروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
local StatusMember = LuaTele.getChatMember(msg_chat_id,msg.sender.user_id).status.luatele
if (StatusMember == "chatMemberStatusCreator") then
local AddedBot = true
elseif (StatusMember == "chatMemberStatusAdministrator") then
local AddedBot = true
else
local AddedBot = false
end
if AddedBot == false then
return send(msg_chat_id,msg_id,"\n*✦ عذرا انته لست ادمن او مالك الجروب *","md",true)  
end
if not Redis:get(TeleGod.."BotFree") then
return send(msg_chat_id,msg_id,"\n*✦ الوضع الخدمي تم تعطيله من قبل مطور البوت *","md",true)  
end
local Get_Chat = LuaTele.getChat(msg_chat_id)
local Info_Chats = LuaTele.getSupergroupFullInfo(msg_chat_id)
if Redis:sismember(TeleGod.."ChekBotAdd",msg_chat_id) then
if tonumber(Info_Chats.member_count) < tonumber((Redis:get(TeleGod..'Num:Add:Bot') or 0)) and not msg.ControllerBot then
return send(msg_chat_id,msg_id,'✦ عدد الاعضاء قليل لا يمكن تفعيل الجروب  يجب ان يكوم اكثر من :'..Redis:get(TeleGod..'Num:Add:Bot'),"md",true)  
end
return send(msg_chat_id,msg_id,'\n*✦ الجروب : {*['..Get_Chat.title..']('..Info_Chats.invite_link.invite_link..')*}\n✦ تم تفعيلها مسبقا *',"md",true)  
else
if not msg.ControllerBot then
local UserInfo = LuaTele.getUser(msg.sender.user_id)
for Name_User in string.gmatch(UserInfo.first_name, "[^%s]+" ) do
UserInfo.first_name = Name_User
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '- مغادرة الجروب ', data = '/leftgroup@'..msg_chat_id}, 
},
{
{text = Get_Chat.title, url = Info_Chats.invite_link.invite_link}, 
},
}
}
send(Sudo_Id,0,'*\n✦ تم تفعيل جروب جديده \n✦ من قام بتفعيلها : {*['..UserInfo.first_name..'](tg://user?id='..msg.sender.user_id..')*} \n✦ معلومات الجروب :\n✦ عدد الاعضاء : '..Info_Chats.member_count..'\n✦ عدد الادمنيه : '..Info_Chats.administrator_count..'\n✦ عدد المطرودين : '..Info_Chats.banned_count..'\n✦ عدد المقيدين : '..Info_Chats.restricted_count..'*',"md",true, false, false, false, reply_markup)
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '- رفع المالك والادمنيه', data = msg.sender.user_id..'/Fdmin@'..msg_chat_id},
},
{
{text = '- قفل جميع الاوامر ', data =msg.sender.user_id..'/LockAllGroup@'..msg_chat_id},
},
}
}
Redis:sadd(TeleGod.."ChekBotAdd",msg_chat_id)
Redis:set(TeleGod.."Status:Id"..msg_chat_id,true) ;Redis:del(TeleGod.."Status:Reply"..msg_chat_id) ;Redis:del(TeleGod.."Status:ReplySudo"..msg_chat_id) ;Redis:set(TeleGod.."Status:BanId"..msg_chat_id,true) ;Redis:set(TeleGod.."Status:SetId"..msg_chat_id,true) 
return send(msg_chat_id,msg_id,'\n*✦ الجروب : {*['..Get_Chat.title..']('..Info_Chats.invite_link.invite_link..')*}\n✦ تم تفعيل الجروب *','md', true, false, false, false, reply_markup)
end
end

if text == 'تعطيل' then
if not msg.Devss then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end
local Get_Chat = LuaTele.getChat(msg_chat_id)
local Info_Chats = LuaTele.getSupergroupFullInfo(msg_chat_id)
if not Redis:sismember(TeleGod.."ChekBotAdd",msg_chat_id) then
return send(msg_chat_id,msg_id,'\n*✦ الجروب : {*['..Get_Chat.title..']('..Info_Chats.invite_link.invite_link..')*}\n✦ تم تعطيلها مسبقا *',"md",true)  
else
if not msg.ControllerBot then
local UserInfo = LuaTele.getUser(msg.sender.user_id)
for Name_User in string.gmatch(UserInfo.first_name, "[^%s]+" ) do
UserInfo.first_name = Name_User
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = Get_Chat.title, url = Info_Chats.invite_link.invite_link}, 
},
}
}
send(Sudo_Id,0,'*\n✦ تم تعطيل جروب جديده \n✦ من قام بتعطيلها : {*['..UserInfo.first_name..'](tg://user?id='..msg.sender.user_id..')*} \n✦ معلومات الجروب :\n✦ عدد الاعضاء : '..Info_Chats.member_count..'\n✦ عدد الادمنيه : '..Info_Chats.administrator_count..'\n✦ عدد المطرودين : '..Info_Chats.banned_count..'\n✦ عدد المقيدين : '..Info_Chats.restricted_count..'*',"md",true, false, false, false, reply_markup)
end
Redis:srem(TeleGod.."ChekBotAdd",msg_chat_id)
return send(msg_chat_id,msg_id,'\n*✦ الجروب : {*['..Get_Chat.title..']('..Info_Chats.invite_link.invite_link..')*}\n✦ تم تعطيلها بنجاح *','md',true)
end
end
if chat_type(msg.chat_id) == "GroupBot" and not Redis:sismember(TeleGod.."ChekBotAdd",msg_chat_id) then
Redis:sadd(TeleGod.."ChekBotAdd",msg_chat_id)
local list = Redis:smembers(TeleGod.."ChekBotAdd")
send(Sudo_Id,0,"*✦ تم تفعيل جروب تلقائيا عن طريق البوت*\n✦ اصبح عدد جروباتك *"..#list.."* مجموعه","md",true)
end
if chat_type(msg.chat_id) == "GroupBot" and Redis:sismember(TeleGod.."ChekBotAdd",msg_chat_id) then
if text == 'ايدي' or text == 'كشف' or text == 'الرتبه' then
if msg.reply_to_message_id ~= 0 then
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
if UserInfo.username then
UserInfousername = '@'..UserInfo.username..''
else
UserInfousername = 'لا يوجد'
end
local UserId = Message_Reply.sender.user_id
local U = LuaTele.getUser(UserId)
local Nn = U.first_name
local RinkBot = Controller(msg_chat_id,UserId)
local TotalMsg = Redis:get(TeleGod..'Num:Message:User'..msg_chat_id..':'..UserId) or 0
local TotalEdit = Redis:get(TeleGod..'Num:Message:Edit'..msg_chat_id..UserId) or 0
local TotalMsgT = Total_message(TotalMsg) 
local NumAdd = Redis:get(TeleGod.."Num:Add:Memp"..msg.chat_id..":"..UserId) or 0
local NumberGames = Redis:get(TeleGod.."Num:Add:Games"..msg.chat_id..UserId) or 0
if Get_Is_Id then
local Get_Is_Id = Get_Is_Id:gsub('#AddMem',NumAdd) 
local Get_Is_Id = Get_Is_Id:gsub('#id',UserId) 
local Get_Is_Id = Get_Is_Id:gsub('#username',UserInfousername) 
local Get_Is_Id = Get_Is_Id:gsub('#msgs',TotalMsg) 
local Get_Is_Id = Get_Is_Id:gsub('#edit',TotalEdit) 
local Get_Is_Id = Get_Is_Id:gsub('#stast',RinkBot) 
local Get_Is_Id = Get_Is_Id:gsub('#auto',TotalMsgT)  
local Get_Is_Id = Get_Is_Id:gsub('#game',NumberGames) 
send(msg_chat_id,msg_id,Get_Is_Id,"md",true) 
else
send(msg_chat_id,msg_id,
'\n◂ اسمه ↫ '..Nn..
'\n◂ ايديه ↫ '..UserId..
'\n◂ معرفه ↫ ['..UserInfousername..']'..
'\n◂ رتبته ↫ '..RinkBot..
'\n◂ عدد رسايله ↫ '..TotalMsg..
'\n◂ عدد تعديلاته ↫ '..TotalEdit..
'\n◂ تفاعله ↫ '..TotalMsgT..
'\n𓆩☆𓆪',"md",true) 
end
end
end
if text == "ايدي" or text =='id' or text =='Id' or text == 'ID' then 
if msg.reply_to_message_id == 0 then
if not Redis:get(TeleGod.."Status:Id"..msg_chat_id) then
return false
end
if otlop(msg) == false then
local chinfo = Redis:get("ch:admin:3am")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local UserInfo = LuaTele.getUser(msg.sender.user_id)
local Name_User = UserInfo.first_name
local photo = LuaTele.getUserProfilePhotos(msg.sender.user_id)
local UserId = msg.sender.user_id
local RinkBot = msg.Name_Controller
local TotalMsg = Redis:get(TeleGod..'Num:Message:User'..msg_chat_id..':'..msg.sender.user_id) or 0
local TotalPhoto = photo.total_count or 0
local TotalEdit = Redis:get(TeleGod..'Num:Message:Edit'..msg_chat_id..msg.sender.user_id) or 0
local TotalMsgT = Total_message(TotalMsg) 
local NumberGames = Redis:get(TeleGod.."Num:Add:Games"..msg.chat_id..msg.sender.user_id) or 0
local NumAdd = Redis:get(TeleGod.."Num:Add:Memp"..msg.chat_id..":"..msg.sender.user_id) or 0
local Texting = {
  "بحبك 🥺♥.!",
  "وشك دا ولا وش رجل 😂",
  "صوره قمر زي صاحبها 🥺♥.!",
  "رقمي 012345... 🙈♥.!",
  "وشك دا ولا القمر 🙈♥.!",
  "هم في الارض وانت بين النجوم 🤍🎀.!",
  "غير يعم القرف دا 🙂"
}
local Description = Texting[math.random(#Texting)]
if UserInfo.username then
UserInfousername = '@'..UserInfo.username..''
else
UserInfousername = 'لا يوجد'
end
Get_Is_Id = Redis:get(TeleGod.."Set:Id:Groups") or Redis:get(TeleGod.."Set:Id:Group"..msg_chat_id)
if Redis:get(TeleGod.."Status:IdPhoto"..msg_chat_id) then
if Get_Is_Id then
local Get_Is_Id = Get_Is_Id:gsub('#AddMem',NumAdd) 
local Get_Is_Id = Get_Is_Id:gsub('#id',msg.sender.user_id) 
local Get_Is_Id = Get_Is_Id:gsub('#username',UserInfousername) 
local Get_Is_Id = Get_Is_Id:gsub('#msgs',TotalMsg) 
local Get_Is_Id = Get_Is_Id:gsub('#edit',TotalEdit) 
local Get_Is_Id = Get_Is_Id:gsub('#stast',RinkBot) 
local Get_Is_Id = Get_Is_Id:gsub('#auto',TotalMsgT) 
local Get_Is_Id = Get_Is_Id:gsub('#Description',Description) 
local Get_Is_Id = Get_Is_Id:gsub('#game',NumberGames) 
local Get_Is_Id = Get_Is_Id:gsub('#photos',TotalPhoto) 
if photo.total_count > 0 then
return LuaTele.sendPhoto(msg.chat_id, msg.id, photo.photos[1].sizes[#photo.photos[1].sizes].photo.remote.id,Get_Is_Id)
else
return send(msg_chat_id,msg_id,Get_Is_Id,"md",true) 
end
else
if photo.total_count > 0 then
return LuaTele.sendPhoto(msg.chat_id, msg.id, photo.photos[1].sizes[#photo.photos[1].sizes].photo.remote.id,Description..
'\n\n◂ اسمك ↫ '..Name_User..
'\n◂ ايديك ↫ '..UserId..
'\n◂ معرفك ↫ ['..UserInfousername..']'..
'\n◂ رتبتك ↫ '..RinkBot..
'\n◂ عدد صورك ↫ '..TotalPhoto..
'\n◂ عدد رسايلك ↫ '..TotalMsg..
'\n◂ عدد تعديلاتك ↫ '..TotalEdit..
'\n◂ تفاعلك ↫ '..TotalMsgT..
'\n◂ بايو ↫ *'..getbio(UserId)..'*'..
'\n𓆩☆𓆪', "md")
else
return send(msg_chat_id,msg_id,
'◂ اسمك ↫ '..Name_User..
'\n◂ ايديك ↫ '..UserId..
'\n◂ معرفك ↫ ['..UserInfousername..']'..
'\n◂ رتبتك ↫ '..RinkBot..
'\n◂ عدد صورك ↫ '..TotalPhoto..
'\n◂ عدد رسايلك ↫ '..TotalMsg..
'\n◂ عدد تعديلاتك ↫ '..TotalEdit..
'\n◂ تفاعلك ↫ '..TotalMsgT..
'\n◂ بايو ↫ *'..getbio(UserId)..'*'..
'\n𓆩☆𓆪',"md",true) 
end
end
else
if Get_Is_Id then
local Get_Is_Id = Get_Is_Id:gsub('#AddMem',NumAdd) 
local Get_Is_Id = Get_Is_Id:gsub('#id',msg.sender.user_id) 
local Get_Is_Id = Get_Is_Id:gsub('#username',UserInfousername) 
local Get_Is_Id = Get_Is_Id:gsub('#msgs',TotalMsg) 
local Get_Is_Id = Get_Is_Id:gsub('#edit',TotalEdit) 
local Get_Is_Id = Get_Is_Id:gsub('#stast',RinkBot) 
local Get_Is_Id = Get_Is_Id:gsub('#auto',TotalMsgT) 
local Get_Is_Id = Get_Is_Id:gsub('#Description',Description) 
local Get_Is_Id = Get_Is_Id:gsub('#game',NumberGames) 
local Get_Is_Id = Get_Is_Id:gsub('#photos',TotalPhoto) 
return send(msg_chat_id,msg_id,'['..Get_Is_Id..']',"md",true) 
else
return send(msg_chat_id,msg_id,
'◂ اسمك ↫ '..Name_User..
'\n◂ ايديك ↫ '..UserId..
'\n◂ معرفك ↫ ['..UserInfousername..']'..
'\n◂ رتبتك ↫ '..RinkBot..
'\n◂ عدد صورك ↫ '..TotalPhoto..
'\n◂ عدد رسايلك ↫ '..TotalMsg..
'\n◂ عدد تعديلاتك ↫ '..TotalEdit..
'\n◂ تفاعلك ↫ '..TotalMsgT..
'\n◂ بايو ↫ *'..getbio(UserId)..'*'..
'\n𓆩☆𓆪',"md",true) 
end
end
end
end
if text and text:match('^كشف (%d+)$') then
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local UserId = text:match('^كشف (%d+)$')
local UserInfo = LuaTele.getUser(UserId)
if UserInfo.username then
UserName = '@'..UserInfo.username..''
else
UserName = 'لا يوجد'
end
local Name_User = UserInfo.first_name
local RinkBot = Controller(msg_chat_id,UserId)
local TotalMsg = Redis:get(TeleGod..'Num:Message:User'..msg_chat_id..':'..UserId) or 0
local TotalEdit = Redis:get(TeleGod..'Num:Message:Edit'..msg_chat_id..UserId) or 0
local TotalMsgT = Total_message(TotalMsg) 
local NumAdd = Redis:get(TeleGod.."Num:Add:Memp"..msg.chat_id..":"..UserId) or 0
local NumberGames = Redis:get(TeleGod.."Num:Add:Games"..msg.chat_id..UserId) or 0

if UserInfo.luatele == "error" and UserInfo.code == 6 then
return send(msg_chat_id,msg_id,"\n✦ عذرآ لا تستطيع استخدام ايدي خطأ ","md",true)  
end 
return send(msg_chat_id,msg_id,
'◂ اسمه ↫ '..Name_User..
'\n◂ ايديه ↫ '..UserId..
'\n◂ معرفه ↫ ['..UserName..']'..
'\n◂ رتبته ↫ '..RinkBot..
'\n◂ عدد رسايله ↫ '..TotalMsg..
'\n◂ عدد تعديلاته ↫ '..TotalEdit..
'\n◂ تفاعله ↫ '..TotalMsgT..
'\n◂ بايو ↫ *'..getbio(UserId)..'*'..
'\n𓆩☆𓆪',"md",true) 
end
if text then
if text:match('^ايدي @(%S+)$') or text:match('^كشف @(%S+)$') then
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local UserName = text:match('^ايدي @(%S+)$') or text:match('^كشف @(%S+)$')
local UserId_Info = LuaTele.searchPublicChat(UserName)
if not UserId_Info.id then
return send(msg_chat_id,msg_id,"\n✦ عذرآ لا يوجد حساب بهذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return send(msg_chat_id,msg_id,"\n✦ عذرآ لا تستطيع استخدام معرف قناة او جروب ","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return send(msg_chat_id,msg_id,"\n✦ عذرآ لا تستطيع استخدام معرف البوت ","md",true)  
end
local U = LuaTele.getUser(UserId_Info.id)
local Name_User = U.first_name 
local UserId = UserId_Info.id
local RinkBot = Controller(msg_chat_id,UserId_Info.id)
local TotalMsg = Redis:get(TeleGod..'Num:Message:User'..msg_chat_id..':'..UserId) or 0
local TotalEdit = Redis:get(TeleGod..'Num:Message:Edit'..msg_chat_id..UserId) or 0
local TotalMsgT = Total_message(TotalMsg) 
local NumAdd = Redis:get(TeleGod.."Num:Add:Memp"..msg.chat_id..":"..UserId) or 0
local NumberGames = Redis:get(TeleGod.."Num:Add:Games"..msg.chat_id..UserId) or 0
if Get_Is_Id then
local Get_Is_Id = Get_Is_Id:gsub('#AddMem',NumAdd) 
local Get_Is_Id = Get_Is_Id:gsub('#id',UserId) 
local Get_Is_Id = Get_Is_Id:gsub('#username','@'..UserName) 
local Get_Is_Id = Get_Is_Id:gsub('#msgs',TotalMsg) 
local Get_Is_Id = Get_Is_Id:gsub('#edit',TotalEdit) 
local Get_Is_Id = Get_Is_Id:gsub('#stast',RinkBot) 
local Get_Is_Id = Get_Is_Id:gsub('#auto',TotalMsgT)  
local Get_Is_Id = Get_Is_Id:gsub('#game',NumberGames) 
return send(msg_chat_id,msg_id,Get_Is_Id,"md",true) 
else
return send(msg_chat_id,msg_id,
'◂ اسمه ↫ '..Name_User..
'\n◂ ايديه ↫ '..UserId..
'\n◂ معرفه ↫ @['..UserName..']'..
'\n◂ رتبته ↫ '..RinkBot..
'\n◂ عدد رسايله ↫ '..TotalMsg..
'\n◂ عدد تعديلاته ↫ '..TotalEdit..
'\n◂ تفاعله ↫ '..TotalMsgT..
'\n◂ بايو ↫ *'..getbio(UserId)..'*'..
'\n𓆩☆𓆪',"md",true) 
end
end
end
if text == 'رتبتي' then
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
return send(msg_chat_id,msg_id,'\n✦ رتبتك هي : '..msg.Name_Controller,"md",true)  
end
if text == 'معلوماتي' or text == 'موقعي' then
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local UserInfo = LuaTele.getUser(msg.sender.user_id)
--
local StatusMember = LuaTele.getChatMember(msg_chat_id,msg.sender.user_id).status.luatele
if (StatusMember == "chatMemberStatusCreator") then
StatusMemberChat = 'مالك الجروب'
elseif (StatusMember == "chatMemberStatusAdministrator") then
StatusMemberChat = 'مشرف الجروب'
else
StatusMemberChat = 'عضو في الجروب'
end
local UserId = msg.sender.user_id
local RinkBot = msg.Name_Controller
local TotalMsg = Redis:get(TeleGod..'Num:Message:User'..msg_chat_id..':'..msg.sender.user_id) or 0
local TotalEdit = Redis:get(TeleGod..'Num:Message:Edit'..msg_chat_id..msg.sender.user_id) or 0
local TotalMsgT = Total_message(TotalMsg) 
if UserInfo.username then
UserInfousername = '@'..UserInfo.username..''
else
UserInfousername = 'لا يوجد'
end
if StatusMemberChat == 'مشرف الجروب' then 
local GetMemberStatus = LuaTele.getChatMember(msg_chat_id,msg.sender.user_id).status
if GetMemberStatus.can_change_info then
change_info = '❬ ✔️ ❭' else change_info = '❬ ❌ ❭'
end
if GetMemberStatus.can_delete_messages then
delete_messages = '❬ ✔️ ❭' else delete_messages = '❬ ❌ ❭'
end
if GetMemberStatus.can_invite_users then
invite_users = '❬ ✔️ ❭' else invite_users = '❬ ❌ ❭'
end
if GetMemberStatus.can_pin_messages then
pin_messages = '❬ ✔️ ❭' else pin_messages = '❬ ❌ ❭'
end
if GetMemberStatus.can_restrict_members then
restrict_members = '❬ ✔️ ❭' else restrict_members = '❬ ❌ ❭'
end
if GetMemberStatus.can_promote_members then
promote = '❬ ✔️ ❭' else promote = '❬ ❌ ❭'
end
PermissionsUser = '*\n✦ صلاحيات المستخدم :\n⩹━━━━✦ 𝗧𝗘𝗟𝗘𝗚𝗢𝗗 ✦ ━━━━⩺'..'\n✦ تغيير المعلومات : '..change_info..'\n✦ تثبيت الرسائل : '..pin_messages..'\n✦ اضافه مستخدمين : '..invite_users..'\n✦ مسح الرسائل : '..delete_messages..'\n✦ حظر المستخدمين : '..restrict_members..'\n✦ اضافه المشرفين : '..promote..'\n\n*'
end
return send(msg_chat_id,msg_id,
'\n*✦ ايديك : '..UserId..
'\n✦ معرفك : '..UserInfousername..
'\n✦ رتبتك : '..RinkBot..
'\n✦ رتبته الجروب: '..StatusMemberChat..
'\n✦ رسائلك : '..TotalMsg..
'\n✦ تعديلاتك : '..TotalEdit..
'\n✦ تفاعلك : '..TotalMsgT..
'\n✦ بايو : '..getbio(UserId)..
'*'..(PermissionsUser or '') ,"md",true) 
end
if text == 'كشف البوت' then 
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local StatusMember = LuaTele.getChatMember(msg_chat_id,TeleGod).status.luatele
if (StatusMember ~= "chatMemberStatusAdministrator") then
return send(msg_chat_id,msg_id,'✦ البوت عضو في الجروب ',"md",true) 
end
local GetMemberStatus = LuaTele.getChatMember(msg_chat_id,TeleGod).status
if GetMemberStatus.can_change_info then
change_info = '❬ ✔️ ❭' else change_info = '❬ ❌ ❭'
end
if GetMemberStatus.can_delete_messages then
delete_messages = '❬ ✔️ ❭' else delete_messages = '❬ ❌ ❭'
end
if GetMemberStatus.can_invite_users then
invite_users = '❬ ✔️ ❭' else invite_users = '❬ ❌ ❭'
end
if GetMemberStatus.can_pin_messages then
pin_messages = '❬ ✔️ ❭' else pin_messages = '❬ ❌ ❭'
end
if GetMemberStatus.can_restrict_members then
restrict_members = '❬ ✔️ ❭' else restrict_members = '❬ ❌ ❭'
end
if GetMemberStatus.can_promote_members then
promote = '❬ ✔️ ❭' else promote = '❬ ❌ ❭'
end
PermissionsUser = '*\n✦ صلاحيات البوت في الجروب :\n⩹━━━━✦ 𝗧𝗘𝗟𝗘𝗚𝗢𝗗 ✦ ━━━━⩺'..'\n✦ تغيير المعلومات : '..change_info..'\n✦ تثبيت الرسائل : '..pin_messages..'\n✦ اضافه مستخدمين : '..invite_users..'\n✦ مسح الرسائل : '..delete_messages..'\n✦ حظر المستخدمين : '..restrict_members..'\n✦ اضافه المشرفين : '..promote..'\n\n*'
return send(msg_chat_id,msg_id,PermissionsUser,"md",true) 
end

if text and text:match('^مسح (%d+)$') then
local NumMessage = text:match('^مسح (%d+)$')
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*✦ عذرآ البوت ليس ادمن في الجروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).Delmsg == false then
return send(msg_chat_id,msg_id,'\n*✦ البوت ليس لديه صلاحيه حذف الرسائل* ',"md",true)  
end
if tonumber(NumMessage) > 1000 then
return send(msg_chat_id,msg_id,'\n*✦ العدد اكثر من 1000 لا تستطيع الحذف',"md",true)  
end
local Message = msg.id
for i=1,tonumber(NumMessage) do
local deleteMessages = LuaTele.deleteMessages(msg.chat_id,{[1]= Message})

Message = Message - 1048576
end
send(msg_chat_id, msg_id, "✦ تم مسح - "..NumMessage.. ' رساله', 'md')
end
if text and text:match("وجد (.*)") then
local v = text:match("وجد (.*)")
local Message = msg.id
local Message = string.find(Message,v)
Message = Message - 1048576
send(msg_chat_id, msg_id,Message , 'md')
end
if text and text:match('^تنزيل (.*) @(%S+)$') then
local UserName = {text:match('^تنزيل (.*) @(%S+)$')}
local UserId_Info = LuaTele.searchPublicChat(UserName[2])
if not UserId_Info.id then
return send(msg_chat_id,msg_id,"\n✦ عذرآ لا يوجد حساب بهذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return send(msg_chat_id,msg_id,"\n✦ عذرآ لا تستطيع استخدام معرف قناة او جروب ","md",true)  
end
if UserName and UserName[2]:match('(%S+)[Bb][Oo][Tt]') then
return send(msg_chat_id,msg_id,"\n✦ عذرآ لا تستطيع استخدام معرف البوت ","md",true)  
end
if UserName[1] == "مطور ثانوي" then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not Redis:sismember(TeleGod.."Devss:Groups",UserId_Info.id) then
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"✦ تم تنزيله مطور ثانوي مسبقا ").Reply,"md",true)  
else
Redis:srem(TeleGod.."Devss:Groups",UserId_Info.id) 
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"✦ تم تنزيله مطور ثانوي").Reply,"md",true)  
end
end
if UserName[1] == "مطور" then
if not msg.Devss then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not Redis:sismember(TeleGod.."Dev:Groups",UserId_Info.id) then
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"✦ تم تنزيله مطور مسبقا ").Reply,"md",true)  
else
Redis:srem(TeleGod.."Dev:Groups",UserId_Info.id) 
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"✦ تم تنزيله مطور ").Reply,"md",true)  
end
end
if UserName[1] == "مالك" then
if not msg.Dev then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(3)..' * ',"md",true)  
end
if not Redis:sismember(TeleGod.."Owners:Group"..msg_chat_id,UserId_Info.id) then
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"✦ تم تنزيله مالك مسبقا ").Reply,"md",true)  
else
Redis:srem(TeleGod.."Owners:Group"..msg_chat_id,UserId_Info.id) 
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"✦ تم تنزيله مالك ").Reply,"md",true)  
end
end
if UserName[1] == "منشئ اساسي" then
if not msg.Supcreatorm then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص { '..Controller_Num(44)..' }* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not Redis:sismember(TeleGod.."Supcreator:Group"..msg_chat_id,UserId_Info.id) then
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"✦ تم تنزيله منشئ اساسي مسبقا ").Reply,"md",true)  
else
Redis:srem(TeleGod.."Supcreator:Group"..msg_chat_id,UserId_Info.id) 
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"✦ تم تنزيله منشئ اساسي ").Reply,"md",true)  
end
end
if UserName[1] == "منشئ" then
if not msg.Supcreator then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(4)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not Redis:sismember(TeleGod.."Creator:Group"..msg_chat_id,UserId_Info.id) then
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"✦ تم تنزيله من المنشئين مسبقا ").Reply,"md",true)  
else
Redis:srem(TeleGod.."Creator:Group"..msg_chat_id,UserId_Info.id) 
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"✦ تم تنزيله من المنشئين ").Reply,"md",true)  
end
end
if UserName[1] == "مدير" then
if not msg.Creator then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(5)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not Redis:sismember(TeleGod.."Manger:Group"..msg_chat_id,UserId_Info.id) then
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"✦ تم تنزيله من المدراء مسبقا ").Reply,"md",true)  
else
Redis:srem(TeleGod.."Manger:Group"..msg_chat_id,UserId_Info.id) 
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"✦ تم تنزيله من المدراء ").Reply,"md",true)  
end
end
if UserName[1] == "ادمن" then
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not Redis:sismember(TeleGod.."Admin:Group"..msg_chat_id,UserId_Info.id) then
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"✦ تم تنزيله من الادمنيه مسبقا ").Reply,"md",true)  
else
Redis:srem(TeleGod.."Admin:Group"..msg_chat_id,UserId_Info.id) 
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"✦ تم تنزيله من الادمنيه ").Reply,"md",true)  
end
end
if UserName[1] == "مميز" then
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not Redis:sismember(TeleGod.."Special:Group"..msg_chat_id,UserId_Info.id) then
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"✦ تم تنزيله من المميزين مسبقا ").Reply,"md",true)  
else
Redis:srem(TeleGod.."Special:Group"..msg_chat_id,UserId_Info.id) 
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"✦ تم تنزيله من المميزبن ").Reply,"md",true)  
end
end
end
if text and text:match("^تنزيل (.*)$") and msg.reply_to_message_id ~= 0 then
local TextMsg = text:match("^تنزيل (.*)$")
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
if UserInfo.message == "Invalid user ID" then
return send(msg_chat_id,msg_id,"\n✦ عذرآ تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return send(msg_chat_id,msg_id,"\n✦ عذرآ لا تستطيع استخدام الامر على البوت ","md",true)  
end
if TextMsg == 'مطور ثانوي' then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not Redis:sismember(TeleGod.."Devss:Groups",Message_Reply.sender.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"✦ تم تنزيله مطور ثانوي مسبقا ").Reply,"md",true)  
else
Redis:srem(TeleGod.."Devss:Groups",Message_Reply.sender.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"✦ تم تنزيله مطور ثانوي").Reply,"md",true)  
end
end
if TextMsg == 'مطور' then
if not msg.Devss then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not Redis:sismember(TeleGod.."Dev:Groups",Message_Reply.sender.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"✦ تم تنزيله مطور مسبقا ").Reply,"md",true)  
else
Redis:srem(TeleGod.."Dev:Groups",Message_Reply.sender.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"✦ تم تنزيله مطور ").Reply,"md",true)  
end
end
if TextMsg == "مالك" then
if not msg.Dev then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(3)..' * ',"md",true)  
end
if not Redis:sismember(TeleGod.."Owners:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"✦ تم تنزيله مالك مسبقا ").Reply,"md",true)  
else
Redis:srem(TeleGod.."Owners:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"✦ تم تنزيله مالك ").Reply,"md",true)  
end
end
if TextMsg == "منشئ اساسي" then
if not msg.Supcreatorm then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص { '..Controller_Num(44)..' }* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not Redis:sismember(TeleGod.."Supcreator:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"✦ تم تنزيله منشئ اساسي مسبقا ").Reply,"md",true)  
else
Redis:srem(TeleGod.."Supcreator:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"✦ تم تنزيله منشئ اساسي ").Reply,"md",true)  
end
end
if TextMsg == "منشئ" then
if not msg.Supcreator then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(4)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not Redis:sismember(TeleGod.."Creator:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"✦ تم تنزيله من المنشئين مسبقا ").Reply,"md",true)  
else
Redis:srem(TeleGod.."Creator:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"✦ تم تنزيله من المنشئين ").Reply,"md",true)  
end
end
if TextMsg == "مدير" then
if not msg.Creator then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(5)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not Redis:sismember(TeleGod.."Manger:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"✦ تم تنزيله من المدراء مسبقا ").Reply,"md",true)  
else
Redis:srem(TeleGod.."Manger:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"✦ تم تنزيله من المدراء ").Reply,"md",true)  
end
end
if TextMsg == "ادمن" then
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not Redis:sismember(TeleGod.."Admin:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"✦ تم تنزيله من الادمنيه مسبقا ").Reply,"md",true)  
else
Redis:srem(TeleGod.."Admin:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"✦ تم تنزيله من الادمنيه ").Reply,"md",true)  
end
end
if TextMsg == "مميز" then
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not Redis:sismember(TeleGod.."Special:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"✦ تم تنزيله من المميزين مسبقا ").Reply,"md",true)  
else
Redis:srem(TeleGod.."Special:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"✦ تم تنزيله من المميزبن ").Reply,"md",true)  
end
end
----تنزيل تسليه -----
if TextMsg == "خول" then
if not Redis:sismember(TeleGod.."kholat:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"✦ تم تنزيله من الخولات قبل كدة 🙃 ").Reply,"md",true)  
else
Redis:srem(TeleGod.."kholat:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"✦ تم تنزيله من الخولات لازم ياخد دروس رجوله😂🌚 ").Reply,"md",true)  
end
end
if TextMsg == "وتكه" then
if not Redis:sismember(TeleGod.."wtka:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"✦ تم تنزيله من الوتكات قبل كدة 🙃 ").Reply,"md",true)  
else
Redis:srem(TeleGod.."wtka:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"✦ تم تنزيلها من الوتكات بعد معرفنا انها فلاتر😂🌚 ").Reply,"md",true)  
end
end
if TextMsg == "متوحد" then
if not Redis:sismember(TeleGod.."twhd:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"✦ اتعالج خلاص 🙃 ").Reply,"md",true)  
else
Redis:srem(TeleGod.."twhd:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"✦ تم تنزيله من المتوحدين بعد ما اتعالج😂🌚 ").Reply,"md",true)  
end
end
if TextMsg == "متوحده" then
if not Redis:sismember(TeleGod.."twhd:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"✦ اتعالج خلاص 🙃 ").Reply,"md",true)  
else
Redis:srem(TeleGod.."twhd:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"✦ تم تنزيله من المتوحدين بعد ما اتعالج😂?? ").Reply,"md",true)  
end
end
if TextMsg == "كلب" then
if not Redis:sismember(TeleGod.."klb:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"✦ الكلب دا بطل هوهوه ونزلناه  🙃 ").Reply,"md",true)  
else
Redis:srem(TeleGod.."klb:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"✦ تم تنزيله من الكلاب خليه يرجع العضمه😂🌚 ").Reply,"md",true)  
end
end
if TextMsg == "حمار" then
if not Redis:sismember(TeleGod.."mar:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"✦ الحمار دا عقل من زمان   🙃 ").Reply,"md",true)  
else
Redis:srem(TeleGod.."mar:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"✦ تم تنزيله من الحمير تعال نفك الكارو منك😂🌚 ").Reply,"md",true)  
end
end
if TextMsg == "سمب" then
if not Redis:sismember(TeleGod.."smb:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"✦ بطل يمشي ورا الحريم 😂   🙃 ").Reply,"md",true)  
else
Redis:srem(TeleGod.."smb:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"✦ تم تنزيله من السمب لازم ياخد دروس رجوله😂🌚 ").Reply,"md",true)  
end
end
if TextMsg == "قرد" then
if not Redis:sismember(TeleGod.."2rd:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"✦ بطل يطنط علي شجر 😂   🙃 ").Reply,"md",true)  
else
Redis:srem(TeleGod.."2rd:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"✦ تم تنزيله من قايمه القرود تعال نزلو من الشجره😂🌚 ").Reply,"md",true)  
end
end
if TextMsg == "عره" then
if not Redis:sismember(TeleGod.."3ra:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"✦ اعقل بقا 😂   🙃 ").Reply,"md",true)  
else
Redis:srem(TeleGod.."3ra:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"✦ مش عارف الناس هتحترمك تاني بعد منزلناك ولا لا😂🌚 ").Reply,"md",true)  
end
end
if TextMsg == "غبي" then
if not Redis:sismember(TeleGod.."8by:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"✦ يارب تعقل وتبقا ذكي 😂   🙃 ").Reply,"md",true)  
else
Redis:srem(TeleGod.."8by:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"✦ خير اهو شغل مخك اهو نزلناك من الاغبياء🌚 ").Reply,"md",true)  
end
end
end


if text and text:match('^تنزيل (.*) (%d+)$') then
local UserId = {text:match('^تنزيل (.*) (%d+)$')}
local UserInfo = LuaTele.getUser(UserId[2])
if UserInfo.luatele == "error" and UserInfo.code == 6 then
return send(msg_chat_id,msg_id,"\n✦ عذرآ لا تستطيع استخدام ايدي خطأ ","md",true)  
end
if UserInfo.message == "Invalid user ID" then
return send(msg_chat_id,msg_id,"\n✦ عذرآ تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return send(msg_chat_id,msg_id,"\n✦ عذرآ لا تستطيع استخدام الامر على البوت ","md",true)  
end
if UserId[1] == 'مطور ثانوي' then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not Redis:sismember(TeleGod.."Devss:Groups",UserId) then
return send(msg_chat_id,msg_id,Reply_Status(UserId,"✦ تم تنزيله مطور ثانوي مسبقا ").Reply,"md",true)  
else
Redis:srem(TeleGod.."Devss:Groups",UserId) 
return send(msg_chat_id,msg_id,Reply_Status(UserId,"✦ تم تنزيله مطور ثانوي").Reply,"md",true)  
end
end
if UserId[1] == 'مطور' then
if not msg.Devss then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not Redis:sismember(TeleGod.."Dev:Groups",UserId) then
return send(msg_chat_id,msg_id,Reply_Status(UserId,"✦ تم تنزيله مطور مسبقا ").Reply,"md",true)  
else
Redis:srem(TeleGod.."Dev:Groups",UserId) 
return send(msg_chat_id,msg_id,Reply_Status(UserId,"✦ تم تنزيله مطور ").Reply,"md",true)  
end
end
if UserId[1] == "مالك" then
if not msg.Dev then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(3)..' * ',"md",true)  
end
if not Redis:sismember(TeleGod.."Owners:Group"..msg_chat_id,UserId[2]) then
return send(msg_chat_id,msg_id,Reply_Status(UserId[2],"✦ تم تنزيله مالك مسبقا ").Reply,"md",true)  
else
Redis:srem(TeleGod.."Owners:Group"..msg_chat_id,UserId[2]) 
return send(msg_chat_id,msg_id,Reply_Status(UserId[2],"✦ تم تنزيله مالك ").Reply,"md",true)  
end
end
if UserId[1] == "منشئ اساسي" then
if not msg.Supcreatorm then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص { '..Controller_Num(44)..' }* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not Redis:sismember(TeleGod.."Supcreator:Group"..msg_chat_id,UserId[2]) then
return send(msg_chat_id,msg_id,Reply_Status(UserId[2],"✦ تم تنزيله منشئ اساسي مسبقا ").Reply,"md",true)  
else
Redis:srem(TeleGod.."Supcreator:Group"..msg_chat_id,UserId[2]) 
return send(msg_chat_id,msg_id,Reply_Status(UserId[2],"✦ تم تنزيله منشئ اساسي ").Reply,"md",true)  
end
end
if UserId[1] == "منشئ" then
if not msg.Supcreator then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(4)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not Redis:sismember(TeleGod.."Creator:Group"..msg_chat_id,UserId[2]) then
return send(msg_chat_id,msg_id,Reply_Status(UserId[2],"✦ تم تنزيله من المنشئين مسبقا ").Reply,"md",true)  
else
Redis:srem(TeleGod.."Creator:Group"..msg_chat_id,UserId[2]) 
return send(msg_chat_id,msg_id,Reply_Status(UserId[2],"✦ تم تنزيله من المنشئين ").Reply,"md",true)  
end
end
if UserId[1] == "مدير" then
if not msg.Creator then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(5)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not Redis:sismember(TeleGod.."Manger:Group"..msg_chat_id,UserId[2]) then
return send(msg_chat_id,msg_id,Reply_Status(UserId[2],"✦ تم تنزيله من المدراء مسبقا ").Reply,"md",true)  
else
Redis:srem(TeleGod.."Manger:Group"..msg_chat_id,UserId[2]) 
return send(msg_chat_id,msg_id,Reply_Status(UserId[2],"✦ تم تنزيله من المدراء ").Reply,"md",true)  
end
end
if UserId[1] == "ادمن" then
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not Redis:sismember(TeleGod.."Admin:Group"..msg_chat_id,UserId[2]) then
return send(msg_chat_id,msg_id,Reply_Status(UserId[2],"✦ تم تنزيله من الادمنيه مسبقا ").Reply,"md",true)  
else
Redis:srem(TeleGod.."Admin:Group"..msg_chat_id,UserId[2]) 
return send(msg_chat_id,msg_id,Reply_Status(UserId[2],"✦ تم تنزيله من الادمنيه ").Reply,"md",true)  
end
end
if UserId[1] == "مميز" then
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not Redis:sismember(TeleGod.."Special:Group"..msg_chat_id,UserId[2]) then
return send(msg_chat_id,msg_id,Reply_Status(UserId[2],"✦ تم تنزيله من المميزين مسبقا ").Reply,"md",true)  
else
Redis:srem(TeleGod.."Special:Group"..msg_chat_id,UserId[2]) 
return send(msg_chat_id,msg_id,Reply_Status(UserId[2],"✦ تم تنزيله من المميزبن ").Reply,"md",true)  
end
end
end
if text and text:match('^رفع (.*) @(%S+)$') then
local UserName = {text:match('^رفع (.*) @(%S+)$')}
local UserId_Info = LuaTele.searchPublicChat(UserName[2])
if not UserId_Info.id then
return send(msg_chat_id,msg_id,"\n✦ عذرآ لا يوجد حساب بهذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return send(msg_chat_id,msg_id,"\n✦ عذرآ لا تستطيع استخدام معرف قناة او جروب ","md",true)  
end
if UserName and UserName[2]:match('(%S+)[Bb][Oo][Tt]') then
return send(msg_chat_id,msg_id,"\n✦ عذرآ لا تستطيع استخدام معرف البوت ","md",true)  
end
if UserName[1] == "مطور ثانوي" then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if Redis:sismember(TeleGod.."Devss:Groups",UserId_Info.id) then
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"✦ تم ترقيته مطور ثانوي مسبقا ").Reply,"md",true)  
else
Redis:sadd(TeleGod.."Devss:Groups",UserId_Info.id) 
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"✦ تم ترقيته مطور ثانوي").Reply,"md",true)  
end
end
if UserName[1] == "مطور" then
if not msg.Devss then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if Redis:sismember(TeleGod.."Dev:Groups",UserId_Info.id) then
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"✦ تم ترقيته مطور مسبقا ").Reply,"md",true)  
else
Redis:sadd(TeleGod.."Dev:Groups",UserId_Info.id) 
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"✦ تم ترقيته مطور ").Reply,"md",true)  
end
end
if UserName[1] == "مالك" then
if not msg.Dev then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(3)..' * ',"md",true)  
end
if Redis:sismember(TeleGod.."Owners:Group"..msg_chat_id,UserId_Info.id) then
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"✦ تم ترقيته مالك مسبقا ").Reply,"md",true)  
else
Redis:sadd(TeleGod.."Owners:Group"..msg_chat_id,UserId_Info.id) 
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"✦ تم ترقيته مالك ").Reply,"md",true)  
end
end
if UserName[1] == "منشئ اساسي" then
if not msg.Supcreatorm then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص { '..Controller_Num(44)..' }* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if Redis:sismember(TeleGod.."Supcreator:Group"..msg_chat_id,UserId_Info.id) then
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"✦ تم ترقيته منشئ اساسي مسبقا ").Reply,"md",true)  
else
Redis:sadd(TeleGod.."Supcreator:Group"..msg_chat_id,UserId_Info.id) 
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"✦ تم ترقيته منشئ اساسي ").Reply,"md",true)  
end
end
if UserName[1] == "منشئ" then
if not msg.Supcreator then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(4)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if Redis:sismember(TeleGod.."Creator:Group"..msg_chat_id,UserId_Info.id) then
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"✦ تم ترقيته منشئ  مسبقا ").Reply,"md",true)  
else
Redis:sadd(TeleGod.."Creator:Group"..msg_chat_id,UserId_Info.id) 
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"✦ تم ترقيته منشئ  ").Reply,"md",true)  
end
end
if UserName[1] == "مدير" then
if not msg.Creator then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(5)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if Redis:sismember(TeleGod.."Manger:Group"..msg_chat_id,UserId_Info.id) then
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"✦ تم ترقيته مدير  مسبقا ").Reply,"md",true)  
else
Redis:sadd(TeleGod.."Manger:Group"..msg_chat_id,UserId_Info.id) 
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"✦ تم ترقيته مدير  ").Reply,"md",true)  
end
end
if UserName[1] == "ادمن" then
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not msg.Creator and not Redis:get(TeleGod.."Status:SetId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"✦ تم تعطيل (الرفع) من قبل المنشئين","md",true)
end 
if Redis:sismember(TeleGod.."Admin:Group"..msg_chat_id,UserId_Info.id) then
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"✦ تم ترقيته ادمن  مسبقا ").Reply,"md",true)  
else
Redis:sadd(TeleGod.."Admin:Group"..msg_chat_id,UserId_Info.id) 
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"✦ تم ترقيته ادمن  ").Reply,"md",true)  
end
end
if UserName[1] == "مميز" then
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not msg.Creator and not Redis:get(TeleGod.."Status:SetId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"✦ تم تعطيل (الرفع) من قبل المنشئين","md",true)
end 
if Redis:sismember(TeleGod.."Special:Group"..msg_chat_id,UserId_Info.id) then
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"✦ تم ترقيته مميز  مسبقا ").Reply,"md",true)  
else
Redis:sadd(TeleGod.."Special:Group"..msg_chat_id,UserId_Info.id) 
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"✦ تم ترقيته مميز  ").Reply,"md",true)  
end
end
---تسليه بالمعرف---
end
if text and text:match("^رفع (.*)$") and msg.reply_to_message_id ~= 0 then
local TextMsg = text:match("^رفع (.*)$")
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
if UserInfo.message == "Invalid user ID" then
return send(msg_chat_id,msg_id,"\n✦ عذرآ تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return send(msg_chat_id,msg_id,"\n✦ عذرآ لا تستطيع استخدام الامر على البوت ","md",true)  
end
if TextMsg == 'مطور ثانوي' then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if Redis:sismember(TeleGod.."Devss:Groups",Message_Reply.sender.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"✦ تم ترقيته مطور ثانوي مسبقا ").Reply,"md",true)  
else
Redis:sadd(TeleGod.."Devss:Groups",Message_Reply.sender.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"✦ تم ترقيته مطور ثانوي").Reply,"md",true)  
end
end
if TextMsg == 'مطور' then
if not msg.Devss then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if Redis:sismember(TeleGod.."Dev:Groups",Message_Reply.sender.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"✦ تم ترقيته مطور مسبقا ").Reply,"md",true)  
else
Redis:sadd(TeleGod.."Dev:Groups",Message_Reply.sender.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"✦ تم ترقيته مطور ").Reply,"md",true)  
end
end
if TextMsg == "مالك" then
if not msg.Dev then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(3)..' * ',"md",true)  
end
if Redis:sismember(TeleGod.."Owners:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"✦ تم ترقيته مالك مسبقا ").Reply,"md",true)  
else
Redis:sadd(TeleGod.."Owners:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"✦ تم ترقيته مالك ").Reply,"md",true)  
end
end
if TextMsg == "منشئ اساسي" then
if not msg.Supcreatorm then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص { '..Controller_Num(44)..' }* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if Redis:sismember(TeleGod.."Supcreator:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"✦ تم ترقيته منشئ اساسي مسبقا ").Reply,"md",true)  
else
Redis:sadd(TeleGod.."Supcreator:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"✦ تم ترقيته منشئ اساسي ").Reply,"md",true)  
end
end
if TextMsg == "منشئ" then
if not msg.Supcreator then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(4)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if Redis:sismember(TeleGod.."Creator:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"✦ تم ترقيته منشئ  مسبقا ").Reply,"md",true)  
else
Redis:sadd(TeleGod.."Creator:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"✦ تم ترقيته منشئ  ").Reply,"md",true)  
end
end
if TextMsg == "مدير" then
if not msg.Creator then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(5)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if Redis:sismember(TeleGod.."Manger:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"✦ تم ترقيته مدير  مسبقا ").Reply,"md",true)  
else
Redis:sadd(TeleGod.."Manger:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"✦ تم ترقيته مدير  ").Reply,"md",true)  
end
end
if TextMsg == "ادمن" then
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not msg.Creator and not Redis:get(TeleGod.."Status:SetId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"✦ تم تعطيل (الرفع) من قبل المنشئين","md",true)
end 
if Redis:sismember(TeleGod.."Admin:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"✦ تم ترقيته ادمن  مسبقا ").Reply,"md",true)  
else
Redis:sadd(TeleGod.."Admin:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"✦ تم ترقيته ادمن  ").Reply,"md",true)  
end
end
if TextMsg == "مميز" then
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not msg.Creator and not Redis:get(TeleGod.."Status:SetId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"✦ تم تعطيل (الرفع) من قبل المنشئين","md",true)
end 
if Redis:sismember(TeleGod.."Special:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"✦ تم ترقيته مميز  مسبقا ").Reply,"md",true)  
else
Redis:sadd(TeleGod.."Special:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"✦ تم ترقيته مميز  ").Reply,"md",true)  
end
end
---تسليه بالرد
if TextMsg == "خول" then
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if Redis:sismember(TeleGod.."kholat:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"✦ محطوط ف قايمة الخولات من  بدري 😂 ").Reply,"md",true)  
else
Redis:sadd(TeleGod.."kholat:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"✦ تم ترقيته خول بالمجموعة لما يسترجل هننزلو 😂  ").Reply,"md",true)  
end
end
if TextMsg == "وتكه" then
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if Redis:sismember(TeleGod.."wtka:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"✦ دي اجمد بنوته هنا ف القايمة من بدري يباشه 😂 ").Reply,"md",true)  
else
Redis:sadd(TeleGod.."wtka:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"✦ جامدة وتستاهل بصراحة تترفع وتكه 😂  ").Reply,"md",true)  
end
end
if TextMsg == "متوحد" then
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if Redis:sismember(TeleGod.."twhd:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"✦ دا مولود كده ومحطوط عندنا من زمان 😂 😂 ").Reply,"md",true)  
else
Redis:sadd(TeleGod.."twhd:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"✦ تم رفعه متوحد  كنت شاكك فيه انو سايكو😂  ").Reply,"md",true)  
end
end
if TextMsg == "متوحده" then
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if Redis:sismember(TeleGod.."twhd:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"✦ دا مولود كده ومحطوط عندنا من زمان 😂 😂 ").Reply,"md",true)  
else
Redis:sadd(TeleGod.."twhd:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"✦ تم رفعه متوحد  كنت شاكك فيه انو سايكو😂  ").Reply,"md",true)  
end
end
if TextMsg == "كلب" then
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if Redis:sismember(TeleGod.."klb:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"✦ دا مولود كده ومحطوط عندنا من زمان بيشمشم علي اي بنت 😂 😂 ").Reply,"md",true)  
else
Redis:sadd(TeleGod.."klb:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"✦ تم رفعه كلب خليه يجي ياخد عضمه😂  ").Reply,"md",true)  
end
end
if TextMsg == "حمار" then
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if Redis:sismember(TeleGod.."mar:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"✦ نزلناه من زمان وفكينا الكارو 😂 😂 ").Reply,"md",true)  
else
Redis:sadd(TeleGod.."mar:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"✦ تم رفعه حمار خليه يجي نركبلو عربية كرو😂  ").Reply,"md",true)  
end
end
if TextMsg == "سمب" then
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if Redis:sismember(TeleGod.."smb:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"✦ نزلناه من زمان واخد كورسات رجوله 😂 😂 ").Reply,"md",true)  
else
Redis:sadd(TeleGod.."smb:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"✦ تم رفعه سمب في الجروب عقبال ميبقا زي النسوان الي تعبينو 😂  ").Reply,"md",true)  
end
end
if TextMsg == "قرد" then
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if Redis:sismember(TeleGod.."2rd:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"✦ نزلناه من زمان من ع الشجره 😂 😂 ").Reply,"md",true)  
else
Redis:sadd(TeleGod.."2rd:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"✦ تم رفعه قرد في الجروب تعال خدلك موزه  😂  ").Reply,"md",true)  
end
end
if TextMsg == "عره" then
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if Redis:sismember(TeleGod.."3ra:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"✦ محدش محترمه كده كده  😂 😂 ").Reply,"md",true)  
else
Redis:sadd(TeleGod.."3ra:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"✦ تم رفعه عره في الجروب قولو عيب كده 😂  ").Reply,"md",true)  
end
end
if TextMsg == "غبي" then
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if Redis:sismember(TeleGod.."8by:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"✦ هو كده كده محطوط ف قايمة الاغبية  😂 😂 ").Reply,"md",true)  
else
Redis:sadd(TeleGod.."8by:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"✦ تم رفعه غبي المجموعة  😂  ").Reply,"md",true)  
end
end
end
if text and text:match('^رفع (.*) (%d+)$') then
local UserId = {text:match('^رفع (.*) (%d+)$')}
local UserInfo = LuaTele.getUser(UserId[2])
if UserInfo.luatele == "error" and UserInfo.code == 6 then
return send(msg_chat_id,msg_id,"\n✦ عذرآ لا تستطيع استخدام ايدي خطأ ","md",true)  
end
if UserInfo.message == "Invalid user ID" then
return send(msg_chat_id,msg_id,"\n✦ عذرآ تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return send(msg_chat_id,msg_id,"\n✦ عذرآ لا تستطيع استخدام الامر على البوت ","md",true)  
end
if UserId[1] == 'مطور ثانوي' then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if Redis:sismember(TeleGod.."Devss:Groups",UserId) then
return send(msg_chat_id,msg_id,Reply_Status(UserId,"✦ تم ترقيته مطور ثانوي مسبقا ").Reply,"md",true)  
else
Redis:sadd(TeleGod.."Devss:Groups",UserId) 
return send(msg_chat_id,msg_id,Reply_Status(UserId,"✦ تم ترقيته مطور ثانوي").Reply,"md",true)  
end
end
if UserId[1] == 'مطور' then
if not msg.Devss then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if Redis:sismember(TeleGod.."Dev:Groups",UserId) then
return send(msg_chat_id,msg_id,Reply_Status(UserId,"✦ تم ترقيته مطور مسبقا ").Reply,"md",true)  
else
Redis:sadd(TeleGod.."Dev:Groups",UserId) 
return send(msg_chat_id,msg_id,Reply_Status(UserId,"✦ تم ترقيته مطور ").Reply,"md",true)  
end
end
if UserId[1] == "مالك" then
if not msg.Dev then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(3)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if Redis:sismember(TeleGod.."Owners:Group"..msg_chat_id,UserId[2]) then
return send(msg_chat_id,msg_id,Reply_Status(UserId[2],"✦ تم ترقيته مالك مسبقا ").Reply,"md",true)  
else
Redis:sadd(TeleGod.."Owners:Group"..msg_chat_id,UserId[2]) 
return send(msg_chat_id,msg_id,Reply_Status(UserId[2],"✦ تم ترقيته مالك ").Reply,"md",true)  
end
end
if UserId[1] == "منشئ اساسي" then
if not msg.Supcreatorm then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص { '..Controller_Num(44)..' }* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if Redis:sismember(TeleGod.."Supcreator:Group"..msg_chat_id,UserId[2]) then
return send(msg_chat_id,msg_id,Reply_Status(UserId[2],"✦ تم ترقيته منشئ اساسي مسبقا ").Reply,"md",true)  
else
Redis:sadd(TeleGod.."Supcreator:Group"..msg_chat_id,UserId[2]) 
return send(msg_chat_id,msg_id,Reply_Status(UserId[2],"✦ تم ترقيته منشئ اساسي ").Reply,"md",true)  
end
end
if UserId[1] == "منشئ" then
if not msg.Supcreator then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(4)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if Redis:sismember(TeleGod.."Creator:Group"..msg_chat_id,UserId[2]) then
return send(msg_chat_id,msg_id,Reply_Status(UserId[2],"✦ تم ترقيته منشئ  مسبقا ").Reply,"md",true)  
else
Redis:sadd(TeleGod.."Creator:Group"..msg_chat_id,UserId[2]) 
return send(msg_chat_id,msg_id,Reply_Status(UserId[2],"✦ تم ترقيته منشئ  ").Reply,"md",true)  
end
end
if UserId[1] == "مدير" then
if not msg.Creator then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(5)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if Redis:sismember(TeleGod.."Manger:Group"..msg_chat_id,UserId[2]) then
return send(msg_chat_id,msg_id,Reply_Status(UserId[2],"✦ تم ترقيته مدير  مسبقا ").Reply,"md",true)  
else
Redis:sadd(TeleGod.."Manger:Group"..msg_chat_id,UserId[2]) 
return send(msg_chat_id,msg_id,Reply_Status(UserId[2],"✦ تم ترقيته مدير  ").Reply,"md",true)  
end
end
if UserId[1] == "ادمن" then
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not msg.Creator and not Redis:get(TeleGod.."Status:SetId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"✦ تم تعطيل (الرفع) من قبل المنشئين","md",true)
end 
if Redis:sismember(TeleGod.."Admin:Group"..msg_chat_id,UserId[2]) then
return send(msg_chat_id,msg_id,Reply_Status(UserId[2],"✦ تم ترقيته ادمن  مسبقا ").Reply,"md",true)  
else
Redis:sadd(TeleGod.."Admin:Group"..msg_chat_id,UserId[2]) 
return send(msg_chat_id,msg_id,Reply_Status(UserId[2],"✦ تم ترقيته ادمن  ").Reply,"md",true)  
end
end
if UserId[1] == "مميز" then
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not msg.Creator and not Redis:get(TeleGod.."Status:SetId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"✦ تم تعطيل (الرفع) من قبل المنشئين","md",true)
end 
if Redis:sismember(TeleGod.."Special:Group"..msg_chat_id,UserId[2]) then
return send(msg_chat_id,msg_id,Reply_Status(UserId[2],"✦ تم ترقيته مميز  مسبقا ").Reply,"md",true)  
else
Redis:sadd(TeleGod.."Special:Group"..msg_chat_id,UserId[2]) 
return send(msg_chat_id,msg_id,Reply_Status(UserId[2],"✦ تم ترقيته مميز  ").Reply,"md",true)  
end
end
end
---تسليه بالايدي
if text and text:match("^تغيير رد المطور (.*)$") then
local Teext = text:match("^تغيير رد المطور (.*)$") 
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
Redis:set(TeleGod.."Developer:Bot:Reply"..msg.chat_id,Teext)
return send(msg_chat_id,msg_id,"✦ تم تغيير رد المطور الى :"..Teext)
elseif text and text:match("^تغيير رد المنشئ الاساسي (.*)$") then
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
local Teext = text:match("^تغيير رد المنشئ الاساسي (.*)$") 
Redis:set(TeleGod.."President:Group:Reply"..msg.chat_id,Teext)
return send(msg_chat_id,msg_id,"✦ تم تغيير رد المنشئ الاساسي الى :"..Teext)
elseif text and text:match("^تغيير رد المنشئ (.*)$") then
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
local Teext = text:match("^تغيير رد المنشئ (.*)$") 
Redis:set(TeleGod.."Constructor:Group:Reply"..msg.chat_id,Teext)
return send(msg_chat_id,msg_id,"✦ تم تغيير رد المنشئ الى :"..Teext)
elseif text and text:match("^تغيير رد المالك (.*)$") then
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
local Teext = text:match("^تغيير رد المالك (.*)$") 
Redis:set(TeleGod.."PresidentQ:Group:Reply"..msg.chat_id,Teext)
return send(msg_chat_id,msg_id,"✦ تم تغيير رد المالك الى :"..Teext)
elseif text and text:match("^تغيير رد المدير (.*)$") then
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
local Teext = text:match("^تغيير رد المدير (.*)$") 
Redis:set(TeleGod.."Manager:Group:Reply"..msg.chat_id,Teext) 
return send(msg_chat_id,msg_id,"✦ تم تغيير رد المدير الى :"..Teext)
elseif text and text:match("^تغيير رد الادمن (.*)$") then
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
local Teext = text:match("^تغيير رد الادمن (.*)$") 
Redis:set(TeleGod.."Admin:Group:Reply"..msg.chat_id,Teext)
return send(msg_chat_id,msg_id,"✦ تم تغيير رد الادمن الى :"..Teext)
elseif text and text:match("^تغيير رد المميز (.*)$") then
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
local Teext = text:match("^تغيير رد المميز (.*)$") 
Redis:set(TeleGod.."Vip:Group:Reply"..msg.chat_id,Teext)
return send(msg_chat_id,msg_id,"✦ تم تغيير رد المميز الى :"..Teext)
elseif text and text:match("^تغيير رد العضو (.*)$") then
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
local Teext = text:match("^تغيير رد العضو (.*)$") 
Redis:set(TeleGod.."Mempar:Group:Reply"..msg.chat_id,Teext)
return send(msg_chat_id,msg_id,"✦ تم تغيير رد العضو الى :"..Teext)
elseif text == 'حذف رد المطور' then
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
Redis:del(TeleGod.."Developer:Bot:Reply"..msg.chat_id)
return send(msg_chat_id,msg_id,"✦ تم حدف رد المطور")
elseif text == 'حذف رد المنشئ الاساسي' then
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
Redis:del(TeleGod.."President:Group:Reply"..msg.chat_id)
return send(msg_chat_id,msg_id,"✦ تم حذف رد المنشئ الاساسي ")
elseif text == 'حذف رد المالك' then
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
Redis:del(TeleGod.."PresidentQ:Group:Reply"..msg.chat_id)
return send(msg_chat_id,msg_id,"✦ تم حذف رد المالك ")
elseif text == 'حذف رد المنشئ' then
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
Redis:del(TeleGod.."Constructor:Group:Reply"..msg.chat_id)
return send(msg_chat_id,msg_id,"✦ تم حذف رد المنشئ ")
elseif text == 'حذف رد المدير' then
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
Redis:del(TeleGod.."Manager:Group:Reply"..msg.chat_id) 
return send(msg_chat_id,msg_id,"✦ تم حذف رد المدير ")
elseif text == 'حذف رد الادمن' then
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
Redis:del(TeleGod.."Admin:Group:Reply"..msg.chat_id)
return send(msg_chat_id,msg_id,"✦ تم حذف رد الادمن ")
elseif text == 'حذف رد المميز' then
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
Redis:del(TeleGod.."Vip:Group:Reply"..msg.chat_id)
return send(msg_chat_id,msg_id,"✦ تم حذف رد المميز")
elseif text == 'حذف رد العضو' then
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
Redis:del(TeleGod.."Mempar:Group:Reply"..msg.chat_id)
return send(msg_chat_id,msg_id,"✦ تم حذف رد العضو")
end
if text == 'المطورين الثانويين' or text == 'المطورين الثانوين' then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(TeleGod.."Devss:Groups") 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"✦ لا يوجد مطورين حاليا , ","md",true)  
end
ListMembers = '\n*✦ قائمه مطورين الثانويين \n ⩹━━━━✦ 𝗧𝗘𝗟𝗘𝗚𝗢𝗗 ✦ ━━━━⩺*\n'
for k, v in pairs(Info_Members) do
local UserInfo = LuaTele.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers.."*"..k.." - *[@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {{{text = '- مسح المطورين الثانويين', data = msg.sender.user_id..'/Devss'},},}}
return send(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text == 'المطورين' then
if not msg.Devss then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(TeleGod.."Dev:Groups") 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"✦ لا يوجد مطورين حاليا , ","md",true)  
end
ListMembers = '\n*✦ قائمه مطورين البوت \n ⩹━━━━✦ 𝗧𝗘𝗟𝗘𝗚𝗢𝗗 ✦ ━━━━⩺*\n'
for k, v in pairs(Info_Members) do
local UserInfo = LuaTele.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers.."*"..k.." - *[@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {{{text = '- مسح المطورين', data = msg.sender.user_id..'/Dev'},},}}
return send(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text == 'المالكين' then
if not msg.Dev then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(3)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(TeleGod.."Owners:Group"..msg_chat_id) 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"✦ لا يوجد مالكين حاليا , ","md",true)  
end
ListMembers = '\n*✦ قائمه المالكين \n ⩹━━━━✦ 𝗧𝗘𝗟𝗘𝗚𝗢𝗗 ✦ ━━━━⩺*\n'
for k, v in pairs(Info_Members) do
local UserInfo = LuaTele.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers.."*"..k.." - *[@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {{{text = '- مسح المالكين', data = msg.sender.user_id..'/Owners'},},}}
return send(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text == 'المنشئين الاساسيين' then
if not msg.Supcreatorm then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص { '..Controller_Num(44)..' }* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(TeleGod.."Supcreator:Group"..msg_chat_id) 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"✦ لا يوجد منشئين اساسيين حاليا , ","md",true)  
end
ListMembers = '\n*✦ قائمه المنشئين الاساسيين \n ⩹━━━━✦ 𝗧𝗘𝗟𝗘𝗚𝗢𝗗 ✦ ━━━━⩺*\n'
for k, v in pairs(Info_Members) do
local UserInfo = LuaTele.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers.."*"..k.." - *[@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {{{text = '- مسح المنشئين الاساسيين', data = msg.sender.user_id..'/Supcreator'},},}}
return send(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text == 'المنشئين' then
if not msg.Supcreator then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(4)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(TeleGod.."Creator:Group"..msg_chat_id) 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"✦ لا يوجد منشئين حاليا , ","md",true)  
end
ListMembers = '\n*✦ قائمه المنشئين  \n ⩹━━━━✦ 𝗧𝗘𝗟𝗘𝗚𝗢𝗗 ✦ ━━━━⩺*\n'
for k, v in pairs(Info_Members) do
local UserInfo = LuaTele.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers.."*"..k.." - *[@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {{{text = '- مسح المنشئين', data = msg.sender.user_id..'/Creator'},},}}
return send(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text == 'المدراء' then
if not msg.Creator then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(5)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(TeleGod.."Manger:Group"..msg_chat_id) 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"✦ لا يوجد مدراء حاليا , ","md",true)  
end
ListMembers = '\n*✦ قائمه المدراء  \n ⩹━━━━✦ 𝗧𝗘𝗟𝗘𝗚𝗢𝗗 ✦ ━━━━⩺*\n'
for k, v in pairs(Info_Members) do
local UserInfo = LuaTele.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers.."*"..k.." - *[@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {{{text = '- مسح المدراء', data = msg.sender.user_id..'/Manger'},},}}
return send(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text == 'الادمنيه' then
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(TeleGod.."Admin:Group"..msg_chat_id) 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"✦ لا يوجد ادمنيه حاليا , ","md",true)  
end
ListMembers = '\n*✦ قائمه الادمنيه  \n ⩹━━━━✦ 𝗧𝗘𝗟𝗘𝗚𝗢𝗗 ✦ ━━━━⩺*\n'
for k, v in pairs(Info_Members) do
local UserInfo = LuaTele.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers.."*"..k.." - *[@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {{{text = '- مسح الادمنيه', data = msg.sender.user_id..'/Admin'},},}}
return send(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text == 'المميزين' then
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(TeleGod.."Special:Group"..msg_chat_id) 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"✦ لا يوجد مميزين حاليا , ","md",true)  
end
ListMembers = '\n*✦ قائمه المميزين  \n ⩹━━━━✦ 𝗧𝗘𝗟𝗘𝗚𝗢𝗗 ✦ ━━━━⩺*\n'
for k, v in pairs(Info_Members) do
local UserInfo = LuaTele.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers.."*"..k.." - *[@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {{{text = '- مسح المميزين', data = msg.sender.user_id..'/DelSpecial'},},}}
return send(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
-----------تسلية-------
if text == 'الخولات' then
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(TeleGod.."kholat:Group"..msg_chat_id) 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"✦ لا يوجد خولات حاليا , ","md",true)  
end
ListMembers = '\n*✦ قائمه الخولات  \n ⩹━━━━✦ 𝗧𝗘𝗟𝗘𝗚𝗢𝗗 ✦ ━━━━⩺*\n'
for k, v in pairs(Info_Members) do
local UserInfo = LuaTele.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers.."*"..k.." - *[@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {{{text = '- مسح الخولات', data = msg.sender.user_id..'/Delkholat'},},}}
return send(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text == 'الوتكات' then
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(TeleGod.."wtka:Group"..msg_chat_id) 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"✦ لا يوجد وتكات ناشفة زي المستشفي , ","md",true)  
end
ListMembers = '\n*✦ قائمه الوتكات  \n ⩹━━━━✦ 𝗧𝗘𝗟𝗘𝗚𝗢𝗗 ✦ ━━━━⩺*\n'
for k, v in pairs(Info_Members) do
local UserInfo = LuaTele.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers.."*"..k.." - *[@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {{{text = '- مسح الوتكات', data = msg.sender.user_id..'/Delwtk'},},}}
return send(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text == 'المتوحدين' then
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(TeleGod.."twhd:Group"..msg_chat_id) 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"✦ مفيش متوحدين هنا كلهم اتعالجو 😂😂 , ","md",true)  
end
ListMembers = '\n*✦ قائمه المتوحدين  \n ⩹━━━━✦ 𝗧𝗘𝗟𝗘𝗚𝗢𝗗 ✦ ━━━━⩺*\n'
for k, v in pairs(Info_Members) do
local UserInfo = LuaTele.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers.."*"..k.." - *[@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {{{text = '- مسح المتوحدين', data = msg.sender.user_id..'/Deltwhd'},},}}
return send(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text == 'الكلاب' then
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(TeleGod.."klb:Group"..msg_chat_id) 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"✦ مفيش كلاب هنا ارفعلنل شويه نضيهم عضم 😂😂 , ","md",true)  
end
ListMembers = '\n*✦ قائمه الكلاب  \n ⩹━━━━✦ 𝗧𝗘𝗟𝗘𝗚𝗢𝗗 ✦ ━━━━⩺*\n'
for k, v in pairs(Info_Members) do
local UserInfo = LuaTele.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers.."*"..k.." - *[@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {{{text = '- مسح الكلاب', data = msg.sender.user_id..'/Delklb'},},}}
return send(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text == 'الحمير' then
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(TeleGod.."mar:Group"..msg_chat_id) 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"✦ مفيش حمير هنا 😂😂 , ","md",true)  
end
ListMembers = '\n*✦ قائمه الحمير  \n ⩹━━━━✦ 𝗧𝗘𝗟𝗘𝗚𝗢𝗗 ✦ ━━━━⩺*\n'
for k, v in pairs(Info_Members) do
local UserInfo = LuaTele.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers.."*"..k.." - *[@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {{{text = '- مسح الحمير', data = msg.sender.user_id..'/Delmar'},},}}
return send(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text == 'العرر' then
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(TeleGod.."3ra:Group"..msg_chat_id) 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"✦ مفيش عرر هنا 😂😂 , ","md",true)  
end
ListMembers = '\n*✦ قائمه العرر  \n ⩹━━━━✦ 𝗧𝗘𝗟𝗘𝗚𝗢𝗗 ✦ ━━━━⩺*\n'
for k, v in pairs(Info_Members) do
local UserInfo = LuaTele.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers.."*"..k.." - *[@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {{{text = '- مسح العرر', data = msg.sender.user_id..'/Del3ra'},},}}
return send(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text == 'السمب' then
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(TeleGod.."smb:Group"..msg_chat_id) 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"✦ مفيش سمباويه هنا 😂😂 , ","md",true)  
end
ListMembers = '\n*✦ قائمه السمب  \n ⩹━━━━✦ 𝗧𝗘𝗟𝗘𝗚𝗢𝗗 ✦ ━━━━⩺*\n'
for k, v in pairs(Info_Members) do
local UserInfo = LuaTele.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers.."*"..k.." - *[@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {{{text = '- مسح السمب', data = msg.sender.user_id..'/Delsmb'},},}}
return send(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text == 'القرود' then
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(TeleGod.."2rd:Group"..msg_chat_id) 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"✦ مفيش قرود هنا يصحبي 😂😂 , ","md",true)  
end
ListMembers = '\n*✦ قائمه القرود  \n ⩹━━━━✦ 𝗧𝗘𝗟𝗘𝗚𝗢𝗗 ✦ ━━━━⩺*\n'
for k, v in pairs(Info_Members) do
local UserInfo = LuaTele.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers.."*"..k.." - *[@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {{{text = '- مسح القرود', data = msg.sender.user_id..'/Del2rd'},},}}
return send(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text == 'الاغبياء' then
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(TeleGod.."8by:Group"..msg_chat_id) 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"✦ مفيش اغبيه هنا يصحبي 😂😂 , ","md",true)  
end
ListMembers = '\n*✦ قائمه الاغبيه  \n ⩹━━━━✦ 𝗧𝗘𝗟𝗘𝗚𝗢𝗗 ✦ ━━━━⩺*\n'
for k, v in pairs(Info_Members) do
local UserInfo = LuaTele.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers.."*"..k.." - *[@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {{{text = '- مسح الاغبياء', data = msg.sender.user_id..'/Del8by'},},}}
return send(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
-----------تسلية-------
if text == 'المحظورين عام' then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(TeleGod.."BanAll:Groups") 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"✦ لا يوجد محظورين عام حاليا , ","md",true)  
end
ListMembers = '\n*✦ قائمه المحظورين عام  \n ⩹━━━━✦ 𝗧𝗘𝗟𝗘𝗚𝗢𝗗 ✦ ━━━━⩺*\n'
for k, v in pairs(Info_Members) do
local UserInfo = LuaTele.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers.."*"..k.." - *[@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {{{text = '- مسح المحظورين عام', data = msg.sender.user_id..'/BanAll'},},}}
return send(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text == 'المكتومين عام' then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(TeleGod.."ktmAll:Groups") 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"✦ لا يوجد مكتومين عام حاليا , ","md",true)  
end
ListMembers = '\n*✦ قائمه المكتومين عام  \n ⩹━━━━✦ 𝗧𝗘𝗟𝗘𝗚𝗢𝗗 ✦ ━━━━⩺*\n'
for k, v in pairs(Info_Members) do
local UserInfo = LuaTele.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers.."*"..k.." - *[@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {{{text = '- مسح المكتومين عام', data = msg.sender.user_id..'/ktmAll'},},}}
return send(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text == 'المحظورين' then
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(TeleGod.."BanGroup:Group"..msg_chat_id) 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"✦ لا يوجد محظورين حاليا , ","md",true)  
end
ListMembers = '\n*✦ قائمه المحظورين  \n ⩹━━━━✦ 𝗧𝗘𝗟𝗘𝗚𝗢𝗗 ✦ ━━━━⩺*\n'
for k, v in pairs(Info_Members) do
local UserInfo = LuaTele.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers.."*"..k.." - *[@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {{{text = '- مسح المحظورين', data = msg.sender.user_id..'/BanGroup'},},}}
return send(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text == 'المكتومين' then
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(TeleGod.."SilentGroup:Group"..msg_chat_id) 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"✦ لا يوجد مكتومين حاليا , ","md",true)  
end
ListMembers = '\n*✦ قائمه المكتومين  \n ⩹━━━━✦ 𝗧𝗘𝗟𝗘𝗚𝗢𝗗 ✦ ━━━━⩺*\n'
for k, v in pairs(Info_Members) do
local UserInfo = LuaTele.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers.."*"..k.." - *[@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {{{text = '- مسح المكتومين', data = msg.sender.user_id..'/SilentGroupGroup'},},}}
return send(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text and text:match("^تفعيل (.*)$") and msg.reply_to_message_id == 0 then
local TextMsg = text:match("^تفعيل (.*)$")
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if TextMsg == 'الرابط' then
Redis:set(TeleGod.."Status:Link"..msg_chat_id,true) 
return send(msg_chat_id,msg_id,"✦ تم تفعيل الرابط ","md",true)
end
if TextMsg == 'الترحيب' then
Redis:set(TeleGod.."Status:Welcome"..msg_chat_id,true) 
return send(msg_chat_id,msg_id,"✦ تم تفعيل الترحيب ","md",true)
end
if TextMsg == 'الايدي' then
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(TeleGod.."Status:Id"..msg_chat_id,true) 
return send(msg_chat_id,msg_id,"✦ تم تفعيل الايدي ","md",true)
end
if TextMsg == 'الايدي بالصوره' then
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(TeleGod.."Status:IdPhoto"..msg_chat_id,true) 
return send(msg_chat_id,msg_id,"✦ تم تفعيل الايدي بالصوره ","md",true)
end
if TextMsg == 'الردود' then
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(TeleGod.."Status:Reply"..msg_chat_id) 
return send(msg_chat_id,msg_id,"✦ تم تفعيل الردود ","md",true)
end
if TextMsg == 'الردود العامه' then
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(TeleGod.."Status:ReplySudo"..msg_chat_id) 
return send(msg_chat_id,msg_id,"✦ تم تفعيل الردود العامه ","md",true)
end
if TextMsg == 'الحظر' or TextMsg == 'الطرد' or TextMsg == 'التقييد' then
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(TeleGod.."Status:BanId"..msg_chat_id,true) 
return send(msg_chat_id,msg_id,"✦ تم تفعيل الحظر , الطرد , التقييد","md",true)
end
if TextMsg == 'الرفع' then
if not msg.Creator then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(5)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(TeleGod.."Status:SetId"..msg_chat_id,true) 
return send(msg_chat_id,msg_id,"✦ تم تفعيل الرفع ","md",true)
end
if TextMsg == 'الالعاب' then
Redis:set(TeleGod.."Status:Games"..msg_chat_id,true) 
return send(msg_chat_id,msg_id,"✦ تم تفعيل الالعاب ","md",true)
end
if TextMsg == 'التحقق' then
    Redis:set(TeleGod.."Status:joinet"..msg_chat_id,true) 
    return send(msg_chat_id,msg_id,"✦ تم تفعيل التحقق ","md",true)
    end
if TextMsg == 'اطردني' then
Redis:set(TeleGod.."Status:KickMe"..msg_chat_id,true) 
return send(msg_chat_id,msg_id,"✦ تم تفعيل اطردني ","md",true)
end
if TextMsg == 'نزلني' then
Redis:set(TeleGod.."Status:remMe"..msg_chat_id,true) 
return send(msg_chat_id,msg_id,"✦ تم تفعيل نزلني ","md",true)
end
if TextMsg == 'البوت الخدمي' then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(TeleGod.."BotFree",true) 
return send(msg_chat_id,msg_id,"✦ تم تفعيل البوت الخدمي ","md",true)
end
if TextMsg == 'التواصل' then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(TeleGod.."TwaslBot",true) 
return send(msg_chat_id,msg_id,"✦ تم تفعيل التواصل داخل البوت ","md",true)
end

end

if text and text:match("^تعطيل (.*)$") and msg.reply_to_message_id == 0 then
local TextMsg = text:match("^تعطيل (.*)$")
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if TextMsg == 'الرابط' then
Redis:del(TeleGod.."Status:Link"..msg_chat_id) 
return send(msg_chat_id,msg_id,"✦ تم تعطيل الرابط ","md",true)
end
if TextMsg == 'الترحيب' then
Redis:del(TeleGod.."Status:Welcome"..msg_chat_id) 
return send(msg_chat_id,msg_id,"✦ تم تعطيل الترحيب ","md",true)
end
if TextMsg == 'الايدي' then
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(TeleGod.."Status:Id"..msg_chat_id) 
return send(msg_chat_id,msg_id,"✦ تم تعطيل الايدي ","md",true)
end
if TextMsg == 'الايدي بالصوره' then
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(TeleGod.."Status:IdPhoto"..msg_chat_id) 
return send(msg_chat_id,msg_id,"✦ تم تعطيل الايدي بالصوره ","md",true)
end
if TextMsg == 'الردود' then
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(TeleGod.."Status:Reply"..msg_chat_id,true) 
return send(msg_chat_id,msg_id,"✦ تم تعطيل الردود ","md",true)
end
if TextMsg == 'الردود العامه' then
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(TeleGod.."Status:ReplySudo"..msg_chat_id,true) 
return send(msg_chat_id,msg_id,"✦ تم تعطيل الردود العامه ","md",true)
end
if TextMsg == 'الحظر' or TextMsg == 'الطرد' or TextMsg == 'التقييد' then
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(TeleGod.."Status:BanId"..msg_chat_id) 
return send(msg_chat_id,msg_id,"✦ تم تعطيل الحظر , الطرد , التقييد","md",true)
end
if TextMsg == 'الرفع' then
if not msg.Creator then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(5)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(TeleGod.."Status:SetId"..msg_chat_id) 
return send(msg_chat_id,msg_id,"✦ تم تعطيل الرفع ","md",true)
end
if TextMsg == 'الالعاب' then
Redis:del(TeleGod.."Status:Games"..msg_chat_id) 
return send(msg_chat_id,msg_id,"✦ تم تعطيل الالعاب ","md",true)
end
if TextMsg == 'التحقق' then
    Redis:del(TeleGod.."Status:joinet"..msg_chat_id) 
    return send(msg_chat_id,msg_id,"✦ تم تعطيل التحقق ","md",true)
    end
if TextMsg == 'اطردني' then
Redis:del(TeleGod.."Status:KickMe"..msg_chat_id) 
return send(msg_chat_id,msg_id,"✦ تم تعطيل اطردني ","md",true)
end
if TextMsg == 'نزلني' then
Redis:del(TeleGod.."Status:remMe"..msg_chat_id) 
return send(msg_chat_id,msg_id,"✦ تم تعطيل نزلني ","md",true)
end
if TextMsg == 'البوت الخدمي' then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(TeleGod.."BotFree") 
return send(msg_chat_id,msg_id,"✦ تم تعطيل البوت الخدمي ","md",true)
end
if TextMsg == 'التواصل' then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(TeleGod.."TwaslBot") 
return send(msg_chat_id,msg_id,"✦ تم تعطيل التواصل داخل البوت ","md",true)
end

end

if text and text:match('^حظر عام @(%S+)$') then
local UserName = text:match('^حظر عام @(%S+)$')
if not msg.Devss then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end
local UserId_Info = LuaTele.searchPublicChat(UserName)
if not UserId_Info.id then
return send(msg_chat_id,msg_id,"\n✦ عذرآ لا يوجد حساب بهذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return send(msg_chat_id,msg_id,"\n✦ عذرآ لا تستطيع استخدام معرف قناة او جروب ","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return send(msg_chat_id,msg_id,"\n✦ عذرآ لا تستطيع استخدام معرف البوت ","md",true)  
end
if Controller(msg_chat_id,UserId_Info.id) == 'المطور الاساسي' then
return send(msg_chat_id,msg_id,"\n*✦ عذرآ لا تستطيع استخدام الامر على { "..Controller(msg_chat_id,UserId_Info.id).." } *","md",true)  
end
if StatusCanOrNotCan(msg_chat_id,UserId_Info.id) then
return send(msg_chat_id,msg_id,"\n*✦ عذرآ لا تستطيع استخدام الامر على { "..Controller(msg_chat_id,UserId_Info.id).." } *","md",true)  
end
if Redis:sismember(TeleGod.."BanAll:Groups",UserId_Info.id) then
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"✦ تم حظره عام من المجموعات مسبقا ").Reply,"md",true)  
else
Redis:sadd(TeleGod.."BanAll:Groups",UserId_Info.id) 
LuaTele.setChatMemberStatus(msg.chat_id,UserId_Info.id,'banned',0)
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"✦ تم حظره عام من المجموعات ").Reply,"md",true)  
end
end
if text and text:match('^الغاء العام @(%S+)$') then
local UserName = text:match('^الغاء العام @(%S+)$')
if not msg.Devss then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end

local UserId_Info = LuaTele.searchPublicChat(UserName)
if not UserId_Info.id then
return send(msg_chat_id,msg_id,"\n✦ عذرآ لا يوجد حساب بهذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return send(msg_chat_id,msg_id,"\n✦ عذرآ لا تستطيع استخدام معرف قناة او جروب ","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return send(msg_chat_id,msg_id,"\n✦ عذرآ لا تستطيع استخدام معرف البوت ","md",true)  
end
if not Redis:sismember(TeleGod.."BanAll:Groups",UserId_Info.id) then
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"✦ تم الغاء حظره عام من المجموعات مسبقا ").Reply,"md",true)  
else
Redis:srem(TeleGod.."BanAll:Groups",UserId_Info.id) 
LuaTele.setChatMemberStatus(msg.chat_id,UserId_Info.id,'restricted',{1,1,1,1,1,1,1,1,1})
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"✦ تم الغاء حظره عام من المجموعات  ").Reply,"md",true)  
end
end
if text and text:match('^كتم عام @(%S+)$') then
local UserName = text:match('^كتم عام @(%S+)$')
if not msg.Devss then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end

local UserId_Info = LuaTele.searchPublicChat(UserName)
if not UserId_Info.id then
return send(msg_chat_id,msg_id,"\n✦ عذرآ لا يوجد حساب بهذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return send(msg_chat_id,msg_id,"\n✦ عذرآ لا تستطيع استخدام معرف قناة او جروب ","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return send(msg_chat_id,msg_id,"\n✦ عذرآ لا تستطيع استخدام معرف البوت ","md",true)  
end
if Controller(msg_chat_id,UserId_Info.id) == 'المطور الاساسي' then
return send(msg_chat_id,msg_id,"\n*✦ عذرآ لا تستطيع استخدام الامر على { "..Controller(msg_chat_id,UserId_Info.id).." } *","md",true)  
end
if StatusCanOrNotCan(msg_chat_id,UserId_Info.id) then
return send(msg_chat_id,msg_id,"\n*✦ عذرآ لا تستطيع استخدام الامر على { "..Controller(msg_chat_id,UserId_Info.id).." } *","md",true)  
end
if Redis:sismember(TeleGod.."ktmAll:Groups",UserId_Info.id) then
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"✦ تم كتمه عام من المجموعات مسبقا ").Reply,"md",true)  
else
Redis:sadd(TeleGod.."ktmAll:Groups",UserId_Info.id) 
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"✦ تم كتمه عام من المجموعات ").Reply,"md",true)  
end
end
if text then
if text:match('^الغاء كتم العام @(%S+)$') or text:match('^الغاء كتم عام @(%S+)$') then
local UserName = text:match('^الغاء كتم العام @(%S+)$') or text:match('^الغاء كتم عام @(%S+)$')
if not msg.Devss then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end

local UserId_Info = LuaTele.searchPublicChat(UserName)
if not UserId_Info.id then
return send(msg_chat_id,msg_id,"\n✦ عذرآ لا يوجد حساب بهذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return send(msg_chat_id,msg_id,"\n✦ عذرآ لا تستطيع استخدام معرف قناة او جروب ","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return send(msg_chat_id,msg_id,"\n✦ عذرآ لا تستطيع استخدام معرف البوت ","md",true)  
end
if not Redis:sismember(TeleGod.."ktmAll:Groups",UserId_Info.id) then
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"✦ تم الغاء كتمه عام من المجموعات مسبقا ").Reply,"md",true)  
else
Redis:srem(TeleGod.."ktmAll:Groups",UserId_Info.id) 
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"✦ تم الغاء كتمه عام من المجموعات  ").Reply,"md",true)  
end
end
end
if text and text:match('^حظر @(%S+)$') then
local UserName = text:match('^حظر @(%S+)$')
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*✦ عذرآ البوت ليس ادمن في الجروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).BanUser == false then
return send(msg_chat_id,msg_id,'\n*✦ البوت ليس لديه صلاحيه حظر المستخدمين* ',"md",true)  
end
if not msg.Creator and not Redis:get(TeleGod.."Status:BanId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"✦ تم تعطيل (الحظر : الطرد : التقييد) من قبل المدراء","md",true)
end 
local UserId_Info = LuaTele.searchPublicChat(UserName)
if not UserId_Info.id then
return send(msg_chat_id,msg_id,"\n✦ عذرآ لا يوجد حساب بهذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return send(msg_chat_id,msg_id,"\n✦ عذرآ لا تستطيع استخدام معرف قناة او جروب ","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return send(msg_chat_id,msg_id,"\n✦ عذرآ لا تستطيع استخدام معرف البوت ","md",true)  
end
if StatusCanOrNotCan(msg_chat_id,UserId_Info.id) then
return send(msg_chat_id,msg_id,"\n*✦ عذرآ لا تستطيع استخدام الامر على { "..Controller(msg_chat_id,UserId_Info.id).." } *","md",true)  
end
if Redis:sismember(TeleGod.."BanGroup:Group"..msg_chat_id,UserId_Info.id) then
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"✦ تم حظره من الجروب مسبقا ").Reply,"md",true)  
else
Redis:sadd(TeleGod.."BanGroup:Group"..msg_chat_id,UserId_Info.id) 
LuaTele.setChatMemberStatus(msg.chat_id,UserId_Info.id,'banned',0)
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"✦ تم حظره من الجروب ").Reply,"md",true)  
end
end
if text and text:match('^الغاء حظر @(%S+)$') then
local UserName = text:match('^الغاء حظر @(%S+)$')
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*✦ عذرآ البوت ليس ادمن في الجروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).BanUser == false then
return send(msg_chat_id,msg_id,'\n*✦ البوت ليس لديه صلاحيه حظر المستخدمين* ',"md",true)  
end
local UserId_Info = LuaTele.searchPublicChat(UserName)
if not UserId_Info.id then
return send(msg_chat_id,msg_id,"\n✦ عذرآ لا يوجد حساب بهذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return send(msg_chat_id,msg_id,"\n✦ عذرآ لا تستطيع استخدام معرف قناة او جروب ","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return send(msg_chat_id,msg_id,"\n✦ عذرآ لا تستطيع استخدام معرف البوت ","md",true)  
end
if not Redis:sismember(TeleGod.."BanGroup:Group"..msg_chat_id,UserId_Info.id) then
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"✦ تم الغاء حظره من الجروب مسبقا ").Reply,"md",true)  
else
Redis:srem(TeleGod.."BanGroup:Group"..msg_chat_id,UserId_Info.id) 
LuaTele.setChatMemberStatus(msg.chat_id,UserId_Info.id,'restricted',{1,1,1,1,1,1,1,1,1})
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"✦ تم الغاء حظره من الجروب  ").Reply,"md",true)  
end
end

if text and text:match('^كتم @(%S+)$') then
local UserName = text:match('^كتم @(%S+)$')
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if GetInfoBot(msg).Delmsg == false then
return send(msg_chat_id,msg_id,'\n*✦ البوت ليس لديه صلاحيه حذف الرسائل* ',"md",true)  
end
local UserId_Info = LuaTele.searchPublicChat(UserName)
if not UserId_Info.id then
return send(msg_chat_id,msg_id,"\n✦ عذرآ لا يوجد حساب بهذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return send(msg_chat_id,msg_id,"\n✦ عذرآ لا تستطيع استخدام معرف قناة او جروب ","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return send(msg_chat_id,msg_id,"\n✦ عذرآ لا تستطيع استخدام معرف البوت ","md",true)  
end
if StatusSilent(msg_chat_id,UserId_Info.id) then
return send(msg_chat_id,msg_id,"\n*✦ عذرآ لا تستطيع استخدام الامر على { "..Controller(msg_chat_id,UserId_Info.id).." } *","md",true)  
end
if Redis:sismember(TeleGod.."SilentGroup:Group"..msg_chat_id,UserId_Info.id) then
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"✦ تم كتمه في الجروب مسبقا ").Reply,"md",true)  
else
Redis:sadd(TeleGod.."SilentGroup:Group"..msg_chat_id,UserId_Info.id) 
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"✦ تم كتمه في الجروب  ").Reply,"md",true)  
end
end
if text and text:match('^الغاء كتم @(%S+)$') then
local UserName = text:match('^الغاء كتم @(%S+)$')
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local UserId_Info = LuaTele.searchPublicChat(UserName)
if not UserId_Info.id then
return send(msg_chat_id,msg_id,"\n✦ عذرآ لا يوجد حساب بهذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return send(msg_chat_id,msg_id,"\n✦ عذرآ لا تستطيع استخدام معرف قناة او جروب ","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return send(msg_chat_id,msg_id,"\n✦ عذرآ لا تستطيع استخدام معرف البوت ","md",true)  
end
if not Redis:sismember(TeleGod.."SilentGroup:Group"..msg_chat_id,UserId_Info.id) then
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"✦ تم الغاء كتمه من الجروب ").Reply,"md",true)  
else
Redis:srem(TeleGod.."SilentGroup:Group"..msg_chat_id,UserId_Info.id) 
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"✦ تم الغاء كتمه من الجروب ").Reply,"md",true)  
end
end
if text and text:match('^تقييد (%d+) (.*) @(%S+)$') then
local UserName = {text:match('^تقييد (%d+) (.*) @(%S+)$') }
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*✦ عذرآ البوت ليس ادمن في الجروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).BanUser == false then
return send(msg_chat_id,msg_id,'\n*✦ البوت ليس لديه صلاحيه حظر المستخدمين* ',"md",true)  
end
if not msg.Creator and not Redis:get(TeleGod.."Status:BanId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"✦ تم تعطيل (الحظر : الطرد : التقييد) من قبل المدراء","md",true)
end 
local UserId_Info = LuaTele.searchPublicChat(UserName[3])
if not UserId_Info.id then
return send(msg_chat_id,msg_id,"\n✦ عذرآ لا يوجد حساب بهذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return send(msg_chat_id,msg_id,"\n✦ عذرآ لا تستطيع استخدام معرف قناة او جروب ","md",true)  
end
if UserName[3] and UserName[3]:match('(%S+)[Bb][Oo][Tt]') then
return send(msg_chat_id,msg_id,"\n✦ عذرآ لا تستطيع استخدام معرف البوت ","md",true)  
end
if StatusCanOrNotCan(msg_chat_id,UserId_Info.id) then
return send(msg_chat_id,msg_id,"\n*✦ عذرآ لا تستطيع استخدام الامر على { "..Controller(msg_chat_id,UserId_Info.id).." } *","md",true)  
end
if UserName[2] == 'يوم' then
Time_Restrict = UserName[1]:match('(%d+)')
Time = Time_Restrict * 86400
end
if UserName[2] == 'ساعه' then
Time_Restrict = UserName[1]:match('(%d+)')
Time = Time_Restrict * 3600
end
if UserName[2] == 'دقيقه' then
Time_Restrict = UserName[1]:match('(%d+)')
Time = Time_Restrict * 60
end
LuaTele.setChatMemberStatus(msg.chat_id,UserId_Info.id,'restricted',{1,0,0,0,0,0,0,0,0,tonumber(msg.date+Time)})
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"✦ تم تقييده في الجروب \n✦ لمدة : "..UserName[1]..' '..UserName[2]).Reply,"md",true)  
end

if text and text:match('^تقييد (%d+) (.*)$') and msg.reply_to_message_id ~= 0 then
local TimeKed = {text:match('^تقييد (%d+) (.*)$') }
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*✦ عذرآ البوت ليس ادمن في الجروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).BanUser == false then
return send(msg_chat_id,msg_id,'\n*✦ البوت ليس لديه صلاحيه حظر المستخدمين* ',"md",true)  
end
if not msg.Creator and not Redis:get(TeleGod.."Status:BanId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"✦ تم تعطيل (الحظر : الطرد : التقييد) من قبل المدراء","md",true)
end 
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
if UserInfo.message == "Invalid user ID" then
return send(msg_chat_id,msg_id,"\n✦ عذرآ تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return send(msg_chat_id,msg_id,"\n✦ عذرآ لا تستطيع استخدام الامر على البوت ","md",true)  
end
if StatusCanOrNotCan(msg_chat_id,Message_Reply.sender.user_id) then
return send(msg_chat_id,msg_id,"\n*✦ عذرآ لا تستطيع استخدام الامر على { "..Controller(msg_chat_id,Message_Reply.sender.user_id).." } *","md",true)  
end
if TimeKed[2] == 'يوم' then
Time_Restrict = TimeKed[1]:match('(%d+)')
Time = Time_Restrict * 86400
end
if TimeKed[2] == 'ساعه' then
Time_Restrict = TimeKed[1]:match('(%d+)')
Time = Time_Restrict * 3600
end
if TimeKed[2] == 'دقيقه' then
Time_Restrict = TimeKed[1]:match('(%d+)')
Time = Time_Restrict * 60
end
LuaTele.setChatMemberStatus(msg.chat_id,Message_Reply.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0,tonumber(msg.date+Time)})
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"✦ تم تقييده في الجروب \n✦ لمدة : "..TimeKed[1]..' '..TimeKed[2]).Reply,"md",true)  
end

if text and text:match('^تقييد (%d+) (.*) (%d+)$') then
local UserId = {text:match('^تقييد (%d+) (.*) (%d+)$') }
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*✦ عذرآ البوت ليس ادمن في الجروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).BanUser == false then
return send(msg_chat_id,msg_id,'\n*✦ البوت ليس لديه صلاحيه حظر المستخدمين* ',"md",true)  
end
if not msg.Creator and not Redis:get(TeleGod.."Status:BanId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"✦ تم تعطيل (الحظر : الطرد : التقييد) من قبل المدراء","md",true)
end 
local UserInfo = LuaTele.getUser(UserId[3])
if UserInfo.luatele == "error" and UserInfo.code == 6 then
return send(msg_chat_id,msg_id,"\n✦ عذرآ لا تستطيع استخدام ايدي خطأ ","md",true)  
end
if StatusCanOrNotCan(msg_chat_id,UserId[3]) then
return send(msg_chat_id,msg_id,"\n*✦ عذرآ لا تستطيع استخدام الامر على { "..Controller(msg_chat_id,UserId[3]).." } *","md",true)  
end
if UserId[2] == 'يوم' then
Time_Restrict = UserId[1]:match('(%d+)')
Time = Time_Restrict * 86400
end
if UserId[2] == 'ساعه' then
Time_Restrict = UserId[1]:match('(%d+)')
Time = Time_Restrict * 3600
end
if UserId[2] == 'دقيقه' then
Time_Restrict = UserId[1]:match('(%d+)')
Time = Time_Restrict * 60
end
LuaTele.setChatMemberStatus(msg.chat_id,UserId[3],'restricted',{1,0,0,0,0,0,0,0,0,tonumber(msg.date+Time)})
return send(msg_chat_id,msg_id,Reply_Status(UserId[3],"\n✦ تم تقييده في الجروب \n✦ لمدة : "..UserId[1]..' ' ..UserId[2]).Reply,"md",true)  
end
if text and text:match('^تقييد @(%S+)$') then
local UserName = text:match('^تقييد @(%S+)$')
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*✦ عذرآ البوت ليس ادمن في الجروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if not msg.Creator and not Redis:get(TeleGod.."Status:BanId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"✦ تم تعطيل (الحظر : الطرد : التقييد) من قبل المدراء","md",true)
end 
local UserId_Info = LuaTele.searchPublicChat(UserName)
if not UserId_Info.id then
return send(msg_chat_id,msg_id,"\n✦ عذرآ لا يوجد حساب بهذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return send(msg_chat_id,msg_id,"\n✦ عذرآ لا تستطيع استخدام معرف قناة او جروب ","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return send(msg_chat_id,msg_id,"\n✦ عذرآ لا تستطيع استخدام معرف البوت ","md",true)  
end
if StatusCanOrNotCan(msg_chat_id,UserId_Info.id) then
return send(msg_chat_id,msg_id,"\n*✦ عذرآ لا تستطيع استخدام الامر على { "..Controller(msg_chat_id,UserId_Info.id).." } *","md",true)  
              end
LuaTele.setChatMemberStatus(msg.chat_id,UserId_Info.id,'restricted',{1,0,0,0,0,0,0,0,0})
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"✦ تم تقييده في الجروب ").Reply,"md",true)  
end

if text and text:match('^الغاء التقييد @(%S+)$') then
local UserName = text:match('^الغاء التقييد @(%S+)$')
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*✦ عذرآ البوت ليس ادمن في الجروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).BanUser == false then
return send(msg_chat_id,msg_id,'\n*✦ البوت ليس لديه صلاحيه حظر المستخدمين* ',"md",true)  
end
local UserId_Info = LuaTele.searchPublicChat(UserName)
if not UserId_Info.id then
return send(msg_chat_id,msg_id,"\n✦ عذرآ لا يوجد حساب بهذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return send(msg_chat_id,msg_id,"\n✦ عذرآ لا تستطيع استخدام معرف قناة او جروب ","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return send(msg_chat_id,msg_id,"\n✦ عذرآ لا تستطيع استخدام معرف البوت ","md",true)  
end
LuaTele.setChatMemberStatus(msg.chat_id,UserId_Info.id,'restricted',{1,1,1,1,1,1,1,1})
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"✦ تم الغاء تقييده من الجروب").Reply,"md",true)  
end

if text and text:match('^طرد @(%S+)$') then
local UserName = text:match('^طرد @(%S+)$')
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*✦ عذرآ البوت ليس ادمن في الجروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).BanUser == false then
return send(msg_chat_id,msg_id,'\n*✦ البوت ليس لديه صلاحيه حظر المستخدمين* ',"md",true)  
end
if not msg.Creator and not Redis:get(TeleGod.."Status:BanId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"✦ تم تعطيل (الحظر : الطرد : التقييد) من قبل المدراء","md",true)
end 
local UserId_Info = LuaTele.searchPublicChat(UserName)
if not UserId_Info.id then
return send(msg_chat_id,msg_id,"\n✦ عذرآ لا يوجد حساب بهذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return send(msg_chat_id,msg_id,"\n✦ عذرآ لا تستطيع استخدام معرف قناة او جروب ","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return send(msg_chat_id,msg_id,"\n✦ عذرآ لا تستطيع استخدام معرف البوت ","md",true)  
end
if StatusCanOrNotCan(msg_chat_id,UserId_Info.id) then
return send(msg_chat_id,msg_id,"\n*✦ عذرآ لا تستطيع استخدام الامر على { "..Controller(msg_chat_id,UserId_Info.id).." } *","md",true)  
end
LuaTele.setChatMemberStatus(msg.chat_id,UserId_Info.id,'banned',0)
LuaTele.setChatMemberStatus(msg.chat_id,UserId_Info.id,'restricted',{1,1,1,1,1,1,1,1,1})
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"✦ تم طرده من الجروب ").Reply,"md",true)  
end
if text == ('حظر عام') and msg.reply_to_message_id ~= 0 then
if not msg.Devss then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
if StatusCanOrNotCan(msg_chat_id,Message_Reply.sender.user_id) then
return send(msg_chat_id,msg_id,"\n*✦ عذرآ لا تستطيع استخدام الامر على { "..Controller(msg_chat_id,Message_Reply.sender.user_id).." } *","md",true)  
end
if UserInfo.message == "Invalid user ID" then
return send(msg_chat_id,msg_id,"\n✦ عذرآ تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return send(msg_chat_id,msg_id,"\n✦ عذرآ لا تستطيع استخدام الامر على البوت ","md",true)  
end
if Controller(msg_chat_id,Message_Reply.sender.user_id) == 'المطور الاساسي' then
return send(msg_chat_id,msg_id,"\n*✦ عذرآ لا تستطيع استخدام الامر على { "..Controller(msg_chat_id,Message_Reply.sender.user_id).." } *","md",true)  
end
if Redis:sismember(TeleGod.."BanAll:Groups",Message_Reply.sender.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"✦ تم حظره عام من المجموعات مسبقا ").Reply,"md",true)  
else
Redis:sadd(TeleGod.."BanAll:Groups",Message_Reply.sender.user_id) 
LuaTele.setChatMemberStatus(msg.chat_id,Message_Reply.sender.user_id,'banned',0)
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"✦ تم حظره عام من المجموعات ").Reply,"md",true)  
end
end
if text == ('الغاء العام') and msg.reply_to_message_id ~= 0 then
if not msg.Devss then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end

local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
if UserInfo.message == "Invalid user ID" then
return send(msg_chat_id,msg_id,"\n✦ عذرآ تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return send(msg_chat_id,msg_id,"\n✦ عذرآ لا تستطيع استخدام الامر على البوت ","md",true)  
end
if not Redis:sismember(TeleGod.."BanAll:Groups",Message_Reply.sender.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"✦ تم الغاء حظره عام من المجموعات مسبقا ").Reply,"md",true)  
else
Redis:srem(TeleGod.."BanAll:Groups",Message_Reply.sender.user_id) 
LuaTele.setChatMemberStatus(msg.chat_id,Message_Reply.sender.user_id,'restricted',{1,1,1,1,1,1,1,1,1})
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"✦ تم الغاء حظره عام من المجموعات  ").Reply,"md",true)  
end
end
if text == ('كتم عام') and msg.reply_to_message_id ~= 0 then
if not msg.Devss then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end

local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
if UserInfo.message == "Invalid user ID" then
return send(msg_chat_id,msg_id,"\n✦ عذرآ تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return send(msg_chat_id,msg_id,"\n✦ عذرآ لا تستطيع استخدام الامر على البوت ","md",true)  
end
if Controller(msg_chat_id,Message_Reply.sender.user_id) == 'المطور الاساسي' then
return send(msg_chat_id,msg_id,"\n*✦ عذرآ لا تستطيع استخدام الامر على { "..Controller(msg_chat_id,Message_Reply.sender.user_id).." } *","md",true)  
end
if StatusCanOrNotCan(msg_chat_id,Message_Reply.sender.user_id) then
return send(msg_chat_id,msg_id,"\n*✦ عذرآ لا تستطيع استخدام الامر على { "..Controller(msg_chat_id,Message_Reply.sender.user_id).." } *","md",true)  
end
if Redis:sismember(TeleGod.."ktmAll:Groups",Message_Reply.sender.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"✦ تم كتمه عام من المجموعات مسبقا ").Reply,"md",true)  
else
Redis:sadd(TeleGod.."ktmAll:Groups",Message_Reply.sender.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"✦ تم كتمه عام من المجموعات ").Reply,"md",true)  
end
end
if text == ('الغاء كتم العام') or text == "الغاء كتم عام" and msg.reply_to_message_id ~= 0 then
if not msg.Devss then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end

local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
if UserInfo.message == "Invalid user ID" then
return send(msg_chat_id,msg_id,"\n✦ عذرآ تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return send(msg_chat_id,msg_id,"\n✦ عذرآ لا تستطيع استخدام الامر على البوت ","md",true)  
end
if not Redis:sismember(TeleGod.."ktmAll:Groups",Message_Reply.sender.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"✦ تم الغاء كتمه عام من المجموعات مسبقا ").Reply,"md",true)  
else
Redis:srem(TeleGod.."ktmAll:Groups",Message_Reply.sender.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"✦ تم الغاء كتمه عام من المجموعات  ").Reply,"md",true)  
end
end
if text == ('حظر') and msg.reply_to_message_id ~= 0 then
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*✦ عذرآ البوت ليس ادمن في الجروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).BanUser == false then
return send(msg_chat_id,msg_id,'\n*✦ البوت ليس لديه صلاحيه حظر المستخدمين* ',"md",true)  
end
if not msg.Creator and not Redis:get(TeleGod.."Status:BanId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"✦ تم تعطيل (الحظر : الطرد : التقييد) من قبل المدراء","md",true)
end 
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
if UserInfo.message == "Invalid user ID" then
return send(msg_chat_id,msg_id,"\n✦ عذرآ تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return send(msg_chat_id,msg_id,"\n✦ عذرآ لا تستطيع استخدام الامر على البوت ","md",true)  
end
if StatusCanOrNotCan(msg_chat_id,Message_Reply.sender.user_id) then
return send(msg_chat_id,msg_id,"\n*✦ عذرآ لا تستطيع استخدام الامر على { "..Controller(msg_chat_id,Message_Reply.sender.user_id).." } *","md",true)  
end
if Redis:sismember(TeleGod.."BanGroup:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"✦ تم حظره من الجروب مسبقا ").Reply,"md",true)  
else
Redis:sadd(TeleGod.."BanGroup:Group"..msg_chat_id,Message_Reply.sender.user_id) 
LuaTele.setChatMemberStatus(msg.chat_id,Message_Reply.sender.user_id,'banned',0)
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"✦ تم حظره من الجروب ").Reply,"md",true)  
end
end
if text == ('الغاء حظر') and msg.reply_to_message_id ~= 0 then
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*✦ عذرآ البوت ليس ادمن في الجروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
if UserInfo.message == "Invalid user ID" then
return send(msg_chat_id,msg_id,"\n✦ عذرآ تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return send(msg_chat_id,msg_id,"\n✦ عذرآ لا تستطيع استخدام الامر على البوت ","md",true)  
end
if not Redis:sismember(TeleGod.."BanGroup:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"✦ تم الغاء حظره من الجروب مسبقا ").Reply,"md",true)  
else
Redis:srem(TeleGod.."BanGroup:Group"..msg_chat_id,Message_Reply.sender.user_id) 
LuaTele.setChatMemberStatus(msg.chat_id,Message_Reply.sender.user_id,'restricted',{1,1,1,1,1,1,1,1,1})
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"✦ تم الغاء حظره من الجروب  ").Reply,"md",true)  
end
end

if text == ('كتم') and msg.reply_to_message_id ~= 0 then
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if GetInfoBot(msg).Delmsg == false then
return send(msg_chat_id,msg_id,'\n*✦ البوت ليس لديه صلاحيه حذف الرسائل* ',"md",true)  
end
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
if UserInfo.message == "Invalid user ID" then
return send(msg_chat_id,msg_id,"\n✦ عذرآ تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return send(msg_chat_id,msg_id,"\n✦ عذرآ لا تستطيع استخدام الامر على البوت ","md",true)  
end
if StatusSilent(msg_chat_id,Message_Reply.sender.user_id) then
return send(msg_chat_id,msg_id,"\n*✦ عذرآ لا تستطيع استخدام الامر على { "..Controller(msg_chat_id,Message_Reply.sender.user_id).." } *","md",true)  
end
if Redis:sismember(TeleGod.."SilentGroup:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"✦ تم كتمه في الجروب مسبقا ").Reply,"md",true)  
else
Redis:sadd(TeleGod.."SilentGroup:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"✦ تم كتمه في الجروب  ").Reply,"md",true)  
end
end
if text == ('الغاء كتم') and msg.reply_to_message_id ~= 0 then
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
if UserInfo.message == "Invalid user ID" then
return send(msg_chat_id,msg_id,"\n✦ عذرآ تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return send(msg_chat_id,msg_id,"\n✦ عذرآ لا تستطيع استخدام الامر على البوت ","md",true)  
end
if not Redis:sismember(TeleGod.."SilentGroup:Group"..msg_chat_id,Message_Reply.sender.user_id) then
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"✦ تم الغاء كتمه من الجروب ").Reply,"md",true)  
else
Redis:srem(TeleGod.."SilentGroup:Group"..msg_chat_id,Message_Reply.sender.user_id) 
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"✦ تم الغاء كتمه من الجروب ").Reply,"md",true)  
end
end

if text == ('تقييد') and msg.reply_to_message_id ~= 0 then
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*✦ عذرآ البوت ليس ادمن في الجروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).BanUser == false then
return send(msg_chat_id,msg_id,'\n*✦ البوت ليس لديه صلاحيه حظر المستخدمين* ',"md",true)  
end
if not msg.Creator and not Redis:get(TeleGod.."Status:BanId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"✦ تم تعطيل (الحظر : الطرد : التقييد) من قبل المدراء","md",true)
end 
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
if UserInfo.message == "Invalid user ID" then
return send(msg_chat_id,msg_id,"\n✦ عذرآ تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return send(msg_chat_id,msg_id,"\n✦ عذرآ لا تستطيع استخدام الامر على البوت ","md",true)  
end
if StatusCanOrNotCan(msg_chat_id,Message_Reply.sender.user_id) then
return send(msg_chat_id,msg_id,"\n*✦ عذرآ لا تستطيع استخدام الامر على { "..Controller(msg_chat_id,Message_Reply.sender.user_id).." } *","md",true)  
end
LuaTele.setChatMemberStatus(msg.chat_id,Message_Reply.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"✦ تم تقييده في الجروب ").Reply,"md",true)  
end

if text == ('الغاء التقييد') and msg.reply_to_message_id ~= 0 then
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*✦ عذرآ البوت ليس ادمن في الجروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).BanUser == false then
return send(msg_chat_id,msg_id,'\n*✦ البوت ليس لديه صلاحيه حظر المستخدمين* ',"md",true)  
end
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
if UserInfo.message == "Invalid user ID" then
return send(msg_chat_id,msg_id,"\n✦ عذرآ تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return send(msg_chat_id,msg_id,"\n✦ عذرآ لا تستطيع استخدام الامر على البوت ","md",true)  
end
LuaTele.setChatMemberStatus(msg.chat_id,Message_Reply.sender.user_id,'restricted',{1,1,1,1,1,1,1,1})
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"✦ تم الغاء تقييده من الجروب").Reply,"md",true)  
end

if text == ('طرد') and msg.reply_to_message_id ~= 0 then
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*✦ عذرآ البوت ليس ادمن في الجروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).BanUser == false then
return send(msg_chat_id,msg_id,'\n*✦ البوت ليس لديه صلاحيه حظر المستخدمين* ',"md",true)  
end
if not msg.Creator and not Redis:get(TeleGod.."Status:BanId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"✦ تم تعطيل (الحظر : الطرد : التقييد) من قبل المدراء","md",true)
end 
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
if UserInfo.message == "Invalid user ID" then
return send(msg_chat_id,msg_id,"\n✦ عذرآ تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return send(msg_chat_id,msg_id,"\n✦ عذرآ لا تستطيع استخدام الامر على البوت ","md",true)  
end
if StatusCanOrNotCan(msg_chat_id,Message_Reply.sender.user_id) then
return send(msg_chat_id,msg_id,"\n*✦ عذرآ لا تستطيع استخدام الامر على { "..Controller(msg_chat_id,Message_Reply.sender.user_id).." } *","md",true)  
end
LuaTele.setChatMemberStatus(msg.chat_id,Message_Reply.sender.user_id,'banned',0)
LuaTele.setChatMemberStatus(msg.chat_id,Message_Reply.sender.user_id,'restricted',{1,1,1,1,1,1,1,1,1})
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"✦ تم طرده من الجروب ").Reply,"md",true)  
end

if text and text:match('^حظر عام (%d+)$') then
local UserId = text:match('^حظر عام (%d+)$')
if not msg.Devss then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end

local UserInfo = LuaTele.getUser(UserId)
if UserInfo.luatele == "error" and UserInfo.code == 6 then
return send(msg_chat_id,msg_id,"\n✦ عذرآ لا تستطيع استخدام ايدي خطأ ","md",true)  
end 
if Controller(msg_chat_id,UserId) == 'المطور الاساسي' then
return send(msg_chat_id,msg_id,"\n*✦ عذرآ لا تستطيع استخدام الامر على { "..Controller(msg_chat_id,UserId).." } *","md",true)  
end
if UserId == "5372193406" then
return send(msg_chat_id,msg_id,"\n*✦ عذرآ لا تستطيع استخدام الامر على المبرمج صلاح*","md",true)  
end
if UserId == "5571958628" then
return send(msg_chat_id,msg_id,"\n*✦ عذرآ لا تستطيع استخدام الامر على بسكوته قلب المبرمج صلاح دا يفشخني انا وانت 😂*","md",true)  
end
if UserId == "5620409834" then
return send(msg_chat_id,msg_id,"\n*✦ عذرآ لا تستطيع استخدام الامر على المبرمج بوجو *","md",true)  
end
if Redis:sismember(TeleGod.."BanAll:Groups",UserId) then
return send(msg_chat_id,msg_id,Reply_Status(UserId,"✦ تم حظره عام من المجموعات مسبقا ").Reply,"md",true)  
else
Redis:sadd(TeleGod.."BanAll:Groups",UserId) 
LuaTele.setChatMemberStatus(msg.chat_id,UserId,'banned',0)
return send(msg_chat_id,msg_id,Reply_Status(UserId,"✦ تم حظره عام من المجموعات ").Reply,"md",true)  
end
end
if text and text:match('^الغاء العام (%d+)$') then
local UserId = text:match('^الغاء العام (%d+)$')
if not msg.Devss then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end

local UserInfo = LuaTele.getUser(UserId)
if UserInfo.luatele == "error" and UserInfo.code == 6 then
return send(msg_chat_id,msg_id,"\n✦ عذرآ لا تستطيع استخدام ايدي خطأ ","md",true)  
end
if not Redis:sismember(TeleGod.."BanAll:Groups",UserId) then
return send(msg_chat_id,msg_id,Reply_Status(UserId,"✦ تم الغاء حظره عام من المجموعات مسبقا ").Reply,"md",true)  
else
Redis:srem(TeleGod.."BanAll:Groups",UserId) 
LuaTele.setChatMemberStatus(msg.chat_id,UserId,'restricted',{1,1,1,1,1,1,1,1,1})
return send(msg_chat_id,msg_id,Reply_Status(UserId,"✦ تم الغاء حظره عام من المجموعات  ").Reply,"md",true)  
end
end
if text and text:match('^كتم عام (%d+)$') then
local UserId = text:match('^كتم عام (%d+)$')
if not msg.Devss then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end
if UserId == "5372193406" then
return send(msg_chat_id,msg_id,"\n*✦ عذرآ لا تستطيع استخدام الامر على المبرمج صلاح*","md",true)  
end
if UserId == "5620409834" then
return send(msg_chat_id,msg_id,"\n*✦ عذرآ لا تستطيع استخدام الامر على المبرمج بوجو *","md",true)  
end
if UserId == "5571958628" then
return send(msg_chat_id,msg_id,"\n*✦ عذرآ لا تستطيع استخدام الامر على بسكوته قلب المبرمج صلاح دا يفشخني انا وانت 😂*","md",true)  
end
local UserInfo = LuaTele.getUser(UserId)
if UserInfo.luatele == "error" and UserInfo.code == 6 then
return send(msg_chat_id,msg_id,"\n✦ عذرآ لا تستطيع استخدام ايدي خطأ ","md",true)  
end 
if Controller(msg_chat_id,UserId) == 'المطور الاساسي' then
return send(msg_chat_id,msg_id,"\n*✦ عذرآ لا تستطيع استخدام الامر على { "..Controller(msg_chat_id,UserId).." } *","md",true)  
end
if Redis:sismember(TeleGod.."ktmAll:Groups",UserId) then
return send(msg_chat_id,msg_id,Reply_Status(UserId,"✦ تم كتمه عام من المجموعات مسبقا ").Reply,"md",true)  
else
Redis:sadd(TeleGod.."ktmAll:Groups",UserId) 
return send(msg_chat_id,msg_id,Reply_Status(UserId,"✦ تم كتمه عام من المجموعات ").Reply,"md",true)  
end
end
if text then
if text:match('^الغاء كتم العام (%d+)$') or text:match('^الغاء كتم عام (%d+)$') then
local UserId = text:match('^الغاء كتم العام (%d+)$') or text:match('^الغاء كتم عام (%d+)$')
if not msg.Devss then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end

local UserInfo = LuaTele.getUser(UserId)
if UserInfo.luatele == "error" and UserInfo.code == 6 then
return send(msg_chat_id,msg_id,"\n✦ عذرآ لا تستطيع استخدام ايدي خطأ ","md",true)  
end
if not Redis:sismember(TeleGod.."ktmAll:Groups",UserId) then
return send(msg_chat_id,msg_id,Reply_Status(UserId,"✦ تم الغاء كتمه عام من المجموعات مسبقا ").Reply,"md",true)  
else
Redis:srem(TeleGod.."ktmAll:Groups",UserId) 
return send(msg_chat_id,msg_id,Reply_Status(UserId,"✦ تم الغاء كتمه عام من المجموعات  ").Reply,"md",true)  
end
end
end 
if text then
if text:match('^حظر (%d+)$') then
local UserId = text:match('^حظر (%d+)$')
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*✦ عذرآ البوت ليس ادمن في الجروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).BanUser == false then
return send(msg_chat_id,msg_id,'\n*✦ البوت ليس لديه صلاحيه حظر المستخدمين* ',"md",true)  
end
if not msg.Creator and not Redis:get(TeleGod.."Status:BanId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"✦ تم تعطيل (الحظر : الطرد : التقييد) من قبل المدراء","md",true)
end 
local UserInfo = LuaTele.getUser(UserId)
if UserInfo.luatele == "error" and UserInfo.code == 6 then
return send(msg_chat_id,msg_id,"\n✦ عذرآ لا تستطيع استخدام ايدي خطأ ","md",true)  
end
if StatusCanOrNotCan(msg_chat_id,UserId) then
return send(msg_chat_id,msg_id,"\n*✦ عذرآ لا تستطيع استخدام الامر على { "..Controller(msg_chat_id,UserId).." } *","md",true)  
end
if Redis:sismember(TeleGod.."BanGroup:Group"..msg_chat_id,UserId) then
return send(msg_chat_id,msg_id,Reply_Status(UserId,"✦ تم حظره من الجروب مسبقا ").Reply,"md",true)  
else
Redis:sadd(TeleGod.."BanGroup:Group"..msg_chat_id,UserId) 
LuaTele.setChatMemberStatus(msg.chat_id,UserId,'banned',0)
return send(msg_chat_id,msg_id,Reply_Status(UserId,"✦ تم حظره من الجروب ").Reply,"md",true)  
end
end
end
if text then
if text:match('^الغاء حظر (%d+)$') then
local UserId = text:match('^الغاء حظر (%d+)$')
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*✦ عذرآ البوت ليس ادمن في الجروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).BanUser == false then
return send(msg_chat_id,msg_id,'\n*✦ البوت ليس لديه صلاحيه حظر المستخدمين* ',"md",true)  
end
local UserInfo = LuaTele.getUser(UserId)
if UserInfo.luatele == "error" and UserInfo.code == 6 then
return send(msg_chat_id,msg_id,"\n✦ عذرآ لا تستطيع استخدام ايدي خطأ ","md",true)  
end
if not Redis:sismember(TeleGod.."BanGroup:Group"..msg_chat_id,UserId) then
return send(msg_chat_id,msg_id,Reply_Status(UserId,"✦ تم الغاء حظره من الجروب مسبقا ").Reply,"md",true)  
else
Redis:srem(TeleGod.."BanGroup:Group"..msg_chat_id,UserId) 
LuaTele.setChatMemberStatus(msg.chat_id,UserId,'restricted',{1,1,1,1,1,1,1,1,1})
return send(msg_chat_id,msg_id,Reply_Status(UserId,"✦ تم الغاء حظره من الجروب  ").Reply,"md",true)  
end
end

if text and text:match('^كتم (%d+)$') then
local UserId = text:match('^كتم (%d+)$')
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if GetInfoBot(msg).Delmsg == false then
return send(msg_chat_id,msg_id,'\n*✦ البوت ليس لديه صلاحيه حذف الرسائل* ',"md",true)  
end
local UserInfo = LuaTele.getUser(UserId)
if UserInfo.luatele == "error" and UserInfo.code == 6 then
return send(msg_chat_id,msg_id,"\n✦ عذرآ لا تستطيع استخدام ايدي خطأ ","md",true)  
end
if StatusSilent(msg_chat_id,UserId) then
return send(msg_chat_id,msg_id,"\n*✦ عذرآ لا تستطيع استخدام الامر على { "..Controller(msg_chat_id,UserId).." } *","md",true)  
end
if Redis:sismember(TeleGod.."SilentGroup:Group"..msg_chat_id,UserId) then
return send(msg_chat_id,msg_id,Reply_Status(UserId,"✦ تم كتمه في الجروب مسبقا ").Reply,"md",true)  
else
Redis:sadd(TeleGod.."SilentGroup:Group"..msg_chat_id,UserId) 
return send(msg_chat_id,msg_id,Reply_Status(UserId,"✦ تم كتمه في الجروب  ").Reply,"md",true)  
end
end
if text and text:match('^الغاء كتم (%d+)$') then
local UserId = text:match('^الغاء كتم (%d+)$')
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local UserInfo = LuaTele.getUser(UserId)
if UserInfo.luatele == "error" and UserInfo.code == 6 then
return send(msg_chat_id,msg_id,"\n✦ عذرآ لا تستطيع استخدام ايدي خطأ ","md",true)  
end
if not Redis:sismember(TeleGod.."SilentGroup:Group"..msg_chat_id,UserId) then
return send(msg_chat_id,msg_id,Reply_Status(UserId,"✦ تم الغاء كتمه من الجروب ").Reply,"md",true)  
else
Redis:srem(TeleGod.."SilentGroup:Group"..msg_chat_id,UserId) 
return send(msg_chat_id,msg_id,Reply_Status(UserId,"✦ تم الغاء كتمه من الجروب ").Reply,"md",true)  
end
end

if text and text:match('^تقييد (%d+)$') then
local UserId = text:match('^تقييد (%d+)$')
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*✦ عذرآ البوت ليس ادمن في الجروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).BanUser == false then
return send(msg_chat_id,msg_id,'\n*✦ البوت ليس لديه صلاحيه حظر المستخدمين* ',"md",true)  
end
if not msg.Creator and not Redis:get(TeleGod.."Status:BanId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"✦ تم تعطيل (الحظر : الطرد : التقييد) من قبل المدراء","md",true)
end 
local UserInfo = LuaTele.getUser(UserId)
if UserInfo.luatele == "error" and UserInfo.code == 6 then
return send(msg_chat_id,msg_id,"\n✦ عذرآ لا تستطيع استخدام ايدي خطأ ","md",true)  
end
if StatusCanOrNotCan(msg_chat_id,UserId) then
return send(msg_chat_id,msg_id,"\n*✦ عذرآ لا تستطيع استخدام الامر على { "..Controller(msg_chat_id,UserId).." } *","md",true)  
end
LuaTele.setChatMemberStatus(msg.chat_id,UserId,'restricted',{1,0,0,0,0,0,0,0,0})
return send(msg_chat_id,msg_id,Reply_Status(UserId,"✦ تم تقييده في الجروب ").Reply,"md",true)  
end

if text and text:match('^الغاء التقييد (%d+)$') then
local UserId = text:match('^الغاء التقييد (%d+)$')
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*✦ عذرآ البوت ليس ادمن في الجروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).BanUser == false then
return send(msg_chat_id,msg_id,'\n*✦ البوت ليس لديه صلاحيه حظر المستخدمين* ',"md",true)  
end
local UserInfo = LuaTele.getUser(UserId)
if UserInfo.luatele == "error" and UserInfo.code == 6 then
return send(msg_chat_id,msg_id,"\n✦ عذرآ لا تستطيع استخدام ايدي خطأ ","md",true)  
end
LuaTele.setChatMemberStatus(msg.chat_id,UserId,'restricted',{1,1,1,1,1,1,1,1})
return send(msg_chat_id,msg_id,Reply_Status(UserId,"✦ تم الغاء تقييده من الجروب").Reply,"md",true)  
end

if text and text:match('^طرد (%d+)$') then
local UserId = text:match('^طرد (%d+)$')
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*✦ عذرآ البوت ليس ادمن في الجروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).BanUser == false then
return send(msg_chat_id,msg_id,'\n*✦ البوت ليس لديه صلاحيه حظر المستخدمين* ',"md",true)  
end
if not msg.Creator and not Redis:get(TeleGod.."Status:BanId"..msg_chat_id) then
return send(msg_chat_id,msg_id,"✦ تم تعطيل (الحظر : الطرد : التقييد) من قبل المدراء","md",true)
end 
local UserInfo = LuaTele.getUser(UserId)
if UserInfo.luatele == "error" and UserInfo.code == 6 then
return send(msg_chat_id,msg_id,"\n✦ عذرآ لا تستطيع استخدام ايدي خطأ ","md",true)  
end
if StatusCanOrNotCan(msg_chat_id,UserId) then
return send(msg_chat_id,msg_id,"\n*✦ عذرآ لا تستطيع استخدام الامر على { "..Controller(msg_chat_id,UserId).." } *","md",true)  
end
LuaTele.setChatMemberStatus(msg.chat_id,UserId,'banned',0)
LuaTele.setChatMemberStatus(msg.chat_id,UserId,'restricted',{1,1,1,1,1,1,1,1,1})
return send(msg_chat_id,msg_id,Reply_Status(UserId,"✦ تم طرده من الجروب ").Reply,"md",true)  
end
end
if text == "نزلني" then
if not Redis:get(TeleGod.."Status:remMe"..msg_chat_id) then
return send(msg_chat_id,msg_id,"*✦ امر نزلني تم تعطيله من قبل المدراء *","md",true)  
end
if The_ControllerAll(msg.sender.user_id) == true then
Rink = 1
elseif Redis:sismember(TeleGod.."Devss:Groups",msg.sender.user_id)  then
Rink = 2
elseif Redis:sismember(TeleGod.."Dev:Groups",msg.sender.user_id)  then
Rink = 3
elseif Redis:sismember(TeleGod.."Owners:Group"..msg_chat_id, msg.sender.user_id) then
Rink = 4
elseif Redis:sismember(TeleGod.."Supcreator:Group"..msg_chat_id, msg.sender.user_id) then
Rink = 5
elseif Redis:sismember(TeleGod.."Creator:Group"..msg_chat_id, msg.sender.user_id) then
Rink = 6
elseif Redis:sismember(TeleGod.."Manger:Group"..msg_chat_id, msg.sender.user_id) then
Rink = 7
elseif Redis:sismember(TeleGod.."Admin:Group"..msg_chat_id, msg.sender.user_id) then
Rink = 8
elseif Redis:sismember(TeleGod.."Special:Group"..msg_chat_id, msg.sender.user_id) then
Rink = 9
else
Rink = 10
end
if Rink == 10 then
return send(msg_chat_id,msg_id,"\n*✦ ليس لديك رتب عزيزي *","md",true)  
end
if Rink <= 7  then
return send(msg_chat_id,msg_id,"✦ استطيع تنزيل الادمنيه والمميزين فقط","md",true) 
else
Redis:srem(TeleGod.."Admin:Group"..msg_chat_id, msg.sender.user_id)
Redis:srem(TeleGod.."Special:Group"..msg_chat_id, msg.sender.user_id)
return send(msg_chat_id,msg_id,"✦ تم تنزيلك من الادمنيه والمميزين ","md",true) 
end
end

if text == 'اطردني' then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = 'تأكيد', url = 't.me/'..UserBot..'?start=st'..msg_chat_id..'u'..msg.sender.user_id..''}, 
},
}
}
return send(msg_chat_id,msg_id, [[
اضغط لتأكيد طردك
]],"md",true, false, false, true, reply_markup)
end

if text == 'ادمنيه الجروب' then
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*✦ عذرآ البوت ليس ادمن في الجروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
local Info_Members = LuaTele.getSupergroupMembers(msg_chat_id, "Administrators", "*", 0, 200)
listAdmin = '\n*✦ قائمه الادمنيه \n ⩹━━━━✦ 𝗧𝗘𝗟𝗘𝗚𝗢𝗗 ✦ ━━━━⩺*\n'
local List_Members = Info_Members.members
for k, v in pairs(List_Members) do
if Info_Members.members[k].status.luatele == "chatMemberStatusCreator" then
Creator = '→ *{ المالك }*'
else
Creator = ""
end
local UserInfo = LuaTele.getUser(v.member_id.user_id)
if UserInfo.username ~= "" then
listAdmin = listAdmin.."*"..k.." - @"..UserInfo.username.."* "..Creator.."\n"
else
listAdmin = listAdmin.."*"..k.." - *["..UserInfo.id.."](tg://user?id="..UserInfo.id..") "..Creator.."\n"
end
end
send(msg_chat_id,msg_id,listAdmin,"md",true)  
end
if text == 'رفع الادمنيه' then
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*✦ عذرآ البوت ليس ادمن في الجروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
local Info_Members = LuaTele.getSupergroupMembers(msg_chat_id, "Administrators", "*", 0, 200)
local List_Members = Info_Members.members
x = 0
y = 0
for k, v in pairs(List_Members) do
if Info_Members.members[k].bot_info == nil then
if Info_Members.members[k].status.luatele == "chatMemberStatusCreator" then
Redis:sadd(TeleGod.."Supcreator:Group"..msg_chat_id,v.member_id.user_id) 
x = x + 1
else
Redis:sadd(TeleGod.."Admin:Group"..msg_chat_id,v.member_id.user_id) 
y = y + 1
end
end
end
send(msg_chat_id,msg_id,'\n*✦ تم ترقيه - ('..y..') ادمنيه *',"md",true)  
end

if text == 'المالك' or text == 'المنشئ' then
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*✘︙ عذرآ البوت ليس ادمن في  الجروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/'..Redis:get(TheTTTHK ..'Channel:Join')}, },}}
return LuaTele.sendText(msg.chat_id,msg.id,'*\n✘︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = LuaTele.getSupergroupMembers(msg_chat_id, "Administrators", "*", 0, 200)
local List_Members = Info_Members.members
for k, v in pairs(List_Members) do
if Info_Members.members[k].status.luatele == "chatMemberStatusCreator" then
local  ban = LuaTele.getUser(v.member_id.user_id)
if  ban.first_name == "" then
LuaTele.sendText(msg_chat_id,msg_id,"*✘︙ اوبس , المالك حسابه محذوف *","md",true)  
return false
end 
local photo = LuaTele.getUserProfilePhotos( ban.id)
local  bain = LuaTele.getUserFullInfo(Sudo_Id)
if  bain.bio then
Bio =  bain.bio
else
Bio = 'لا يوجد'
end
if ban.username then
Creator = "* "..ban.first_name.."*\n"
else
Creator = "* ["..ban.first_name.."](tg://user?id="..ban.id..")*\n"
end
if ban.first_name then
Creat = " "..ban.first_name.." "
else
Creat = " Developers Bot \n"
end
if photo.total_count > 0 then
local TestText = "  ‹[ Owner Groups ]›\n— — — — — — — — —\n ✘︙*Owner Name* :  [".. ban.first_name.."](tg://user?id=".. ban.id..")\n✘︙ *Owner Bio* : [‹[ "..Bio.." ]›]"
keyboardd = {} 
keyboardd.inline_keyboard = {
{
{text = Creat, url = "https://t.me/"..ban.username..""},
},
}
local msg_id = msg.id/2097152/0.5 
return https.request("https://api.telegram.org/bot"..Token..'/sendPhoto?chat_id='..msg.chat_id..'&caption='..URL.escape(TestText)..'&photo='..photo.photos[1].sizes[#photo.photos[1].sizes].photo.remote.id..'&reply_to_message_id='..msg_id..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboardd))
else
local TestText = "- معلومات المالك : \n\n- [".. ban.first_name.."](tg://user?id=".. ban.id..")\n \n ["..Bio.."]"
local msg_id = msg.id/2097152/0.5 
return https.request("https://api.telegram.org/bot"..Token..'/sendMessage?chat_id=' .. msg.chat_id .. '&text=' .. URL.escape(TestText).."&reply_to_message_id="..msg_id.."&parse_mode=markdown")
end
end
end
end


if text == 'كشف البوتات' then
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*✦ عذرآ البوت ليس ادمن في الجروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
local Info_Members = LuaTele.getSupergroupMembers(msg_chat_id, "Bots", "*", 0, 200)
local List_Members = Info_Members.members
listBots = '\n*✦ قائمه البوتات \n ⩹━━━━✦ 𝗧𝗘𝗟𝗘𝗚𝗢𝗗 ✦ ━━━━⩺*\n'
x = 0
for k, v in pairs(List_Members) do
local UserInfo = LuaTele.getUser(v.member_id.user_id)
if Info_Members.members[k].status.luatele == "chatMemberStatusAdministrator" then
x = x + 1
Admin = '→ *{ ادمن }*'
else
Admin = ""
end
listBots = listBots.."*"..k.." - @"..UserInfo.username.."* "..Admin.."\n"
end
send(msg_chat_id,msg_id,listBots.."*\n⩹━━━━✦ 𝗧𝗘𝗟𝗘𝗚𝗢𝗗 ✦ ━━━━⩺\n✦ عدد البوتات التي هي ادمن ( "..x.." )*","md",true)  
end


 
if text == 'المقيدين' then
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*✦ عذرآ البوت ليس ادمن في الجروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
local Info_Members = LuaTele.getSupergroupMembers(msg_chat_id, "Recent", "*", 0, 200)
local List_Members = Info_Members.members
x = 0
y = nil
restricted = '\n*✦ قائمه المقيديين \n ⩹━━━━✦ 𝗧𝗘𝗟𝗘𝗚𝗢𝗗 ✦ ━━━━⩺*\n'
for k, v in pairs(List_Members) do
if Info_Members.members[k].status.is_member == true and Info_Members.members[k].status.luatele == "chatMemberStatusRestricted" then
y = true
x = x + 1
local UserInfo = LuaTele.getUser(v.member_id.user_id)
if UserInfo.username ~= "" then
restricted = restricted.."*"..x.." - @"..UserInfo.username.."*\n"
else
restricted = restricted.."*"..x.." - *["..UserInfo.id.."](tg://user?id="..UserInfo.id..") \n"
end
end
end
if y == true then
send(msg_chat_id,msg_id,restricted,"md",true)  
end
end


if text == "غادر" then 
if not msg.Dev then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(3)..' * ',"md",true)  
end
if not msg.ControllerBot and not Redis:set(TeleGod.."LeftBot") then
return send(msg_chat_id,msg_id,'\n*✦ امر المغادره معطل من قبل الاساسي *',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
send(msg_chat_id,msg_id,"*\n✦ تم مغادرة الجروب بامر من المطور *","md",true)  
local Left_Bot = LuaTele.leaveChat(msg.chat_id)
end
if text == 'تاك للكل' then
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = LuaTele.searchChatMembers(msg_chat_id, "*", 200)
local List_Members = Info_Members.members
listall = '\n*✦ قائمه الاعضاء \n ⩹━━━━✦ 𝗧𝗘𝗟𝗘𝗚𝗢𝗗 ✦ ━━━━⩺*\n'
for k, v in pairs(List_Members) do
local UserInfo = LuaTele.getUser(v.member_id.user_id)
if UserInfo.username ~= "" then
listall = listall.."*"..k.." - @"..UserInfo.username.."*\n"
else
listall = listall.."*"..k.." -* ["..UserInfo.id.."](tg://user?id="..UserInfo.id..")\n"
end
end
send(msg_chat_id,msg_id,listall,"md",true)  
end
if Redis:get(TeleGod.."addchannel"..msg.sender.user_id) == "on" then
if text and text:match("^@[%a%d_]+$") then
local m , res = https.request("http://api.telegram.org/bot"..Token.."/getchat?chat_id="..text)
data = json:decode(m)
if res == 200 then
ch = data.result.id
Redis:set(TeleGod.."chadmin"..msg_chat_id,ch) 
send(msg_chat_id,msg_id,"✦ ︙ تم حفظ ايدي القناه","md",true)  
else
send(msg_chat_id,msg_id,"✦ ︙ المعرف خطأ","md",true)  
end
elseif text and text:match('^-100(%d+)$') then
ch = text
Redis:set(TeleGod.."chadmin"..msg_chat_id,ch) 
send(msg_chat_id,msg_id,"✦ ︙ تم حفظ ايدي القناه","md",true)  
elseif text and not text:match('^-100(%d+)$') then
send(msg_chat_id,msg_id,"✦ ︙ الايدي خطأ","md",true)  
end
Redis:del(TeleGod.."addchannel"..msg.sender.user_id)
end
if text == "القناه المضافه" then
if Redis:get(TeleGod.."chadmin"..msg_chat_id) then
send(msg_chat_id,msg_id,Redis:get(TeleGod.."chadmin"..msg_chat_id),"md",true)  
else 
send(msg_chat_id,msg_id,"✦ ︙ لا توجد قناه ","md",true)  
end 
end
if text == "حذف القناه" then
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ ︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if Redis:get(TeleGod.."chadmin"..msg_chat_id) then
Redis:del(TeleGod.."chadmin"..msg_chat_id) 
send(msg_chat_id,msg_id,"✦ ︙ تم حذف القناه بنجاح","md",true)  
else 
send(msg_chat_id,msg_id,"✦ ︙ لا توجد قناه ","md",true)  
end 
end
if text == "اضف قناه" then
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ ︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
Redis:set(TeleGod.."addchannel"..msg.sender.user_id,"on") 
send(msg_chat_id,msg_id,"✦ ︙ ارسل يوزر او ايدي القناه","md",true)  
end
if text == "قفل القناه" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ ︙ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ ︙ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(TeleGod.."Lock:channell"..msg_chat_id,true) 
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"✦ ︙ تم قفـل القنوات").Lock,"md",true)  
return false
end 
if text == "قفل الدردشه" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(TeleGod.."Lock:text"..msg_chat_id,true) 
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"✦ تم قفـل الدردشه").Lock,"md",true)  
return false
end 
if text == "قفل الاضافه" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end 
Redis:set(TeleGod.."Lock:AddMempar"..msg_chat_id,"kick")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"✦ تم قفـل اضافة الاعضاء").Lock,"md",true)  
return false
end 
if text == "قفل الدخول" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end 
Redis:set(TeleGod.."Lock:Join"..msg_chat_id,"kick")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"✦ تم قفـل دخول الاعضاء").Lock,"md",true)  
return false
end 
if text == "قفل البوتات" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end 
Redis:set(TeleGod.."Lock:Bot:kick"..msg_chat_id,"del")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"✦ تم قفـل البوتات").Lock,"md",true)  
return false
end 
if text == "قفل البوتات بالطرد" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end 
Redis:set(TeleGod.."Lock:Bot:kick"..msg_chat_id,"kick")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"✦ تم قفـل البوتات").lockKick,"md",true)  
return false
end 
if text == "قفل الاشعارات" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end  
Redis:set(TeleGod.."Lock:tagservr"..msg_chat_id,true)  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"✦ تم قفـل الاشعارات").Lock,"md",true)  
return false
end 
if text == "تعطيل all" or text == "تعطيل @all" then 
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end  
Redis:set(TeleGod.."lockalllll"..msg_chat_id,"off")
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"✦ تم قفـل @all هنا").Lock,"md",true)  
return false
end 
if text == "تفعيل all" or text == "تفعيل @all" then 
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end  
Redis:set(TeleGod.."lockalllll"..msg_chat_id,"on")
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"✦ تم فتح @all هنا").Lock,"md",true)  
return false
end 
if text == "قفل التثبيت" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end  
Redis:set(TeleGod.."lockpin"..msg_chat_id,(LuaTele.getChatPinnedMessage(msg_chat_id).id or true)) 
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"✦ تم قفـل التثبيت هنا").Lock,"md",true)  
return false
end 
if text == "قفل التعديل" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end 
Redis:set(TeleGod.."Lock:edit"..msg_chat_id,true) 
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"✦ تم قفـل تعديل").Lock,"md",true)  
return false
end 
if text == "قفل تعديل الميديا" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end 
Redis:set(TeleGod.."Lock:edit"..msg_chat_id,true) 
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"✦ تم قفـل تعديل").Lock,"md",true)  
return false
end 
if text == "قفل الكل" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end  
Redis:set(TeleGod.."Lock:tagservrbot"..msg_chat_id,true)   
list ={"Lock:Bot:kick","Lock:User:Name","Lock:hashtak","Lock:Cmd","Lock:Link","Lock:forward","Lock:Keyboard","Lock:geam","Lock:Photo","Lock:Animation","Lock:Video","Lock:Audio","Lock:vico","Lock:Sticker","Lock:Document","Lock:Unsupported","Lock:Markdaun","Lock:Contact","Lock:Spam"}
for i,lock in pairs(list) do 
Redis:set(TeleGod..''..lock..msg_chat_id,"del")    
end
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"✦ تم قفـل جميع الاوامر").Lock,"md",true)  
return false
end 


--------------------------------------------------------------------------------------------------------------
if text == "فتح الاضافه" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end 
Redis:del(TeleGod.."Lock:AddMempar"..msg_chat_id)  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"✦ تم فتح اضافة الاعضاء").unLock,"md",true)  
return false
end 
if text == "فتح القناه" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end 
Redis:del(TeleGod.."Lock:channell"..msg_chat_id)  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"✦ تم فتح القنوات").unLock,"md",true)  
return false
end 
if text and text:match("^وضع تكرار (%d+)$") then 
local Num = text:match("وضع تكرار (.*)")
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
Redis:hset(TeleGod.."Spam:Group:User"..msg_chat_id ,"Num:Spam" ,Num) 
send(msg_chat_id,msg_id,'\n*✦ تم وضع عدد تكرار '..Num..'* ',"md",true)  
end
if text == "فتح الدردشه" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end 
Redis:del(TeleGod.."Lock:text"..msg_chat_id)  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"✦ تم فتح الدردشه").unLock,"md",true)  
return false
end 
if text == "فتح الدخول" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end 
Redis:del(TeleGod.."Lock:Join"..msg_chat_id)  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"✦ تم فتح دخول الاعضاء").unLock,"md",true)  
return false
end 
if text == "فتح البوتات" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end 
Redis:del(TeleGod.."Lock:Bot:kick"..msg_chat_id)  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"✦ تم فـتح البوتات").unLock,"md",true)  
return false
end 
if text == "فتح البوتات" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end 
Redis:del(TeleGod.."Lock:Bot:kick"..msg_chat_id)  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"✦ تم فـتح البوتات").unLock,"md",true)  
return false
end 
if text == "فتح الاشعارات" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end  
Redis:del(TeleGod.."Lock:tagservr"..msg_chat_id)  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"✦ تم فـتح الاشعارات").unLock,"md",true)  
return false
end 
if text == "فتح التثبيت" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end 
Redis:del(TeleGod.."lockpin"..msg_chat_id)  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"✦ تم فـتح التثبيت هنا").unLock,"md",true)  
return false
end 
if text == "فتح التعديل" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end 
Redis:del(TeleGod.."Lock:edit"..msg_chat_id) 
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"✦ تم فـتح تعديل").unLock,"md",true)  
return false
end 
if text == "فتح التعديل الميديا" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end 
Redis:del(TeleGod.."Lock:edit"..msg_chat_id) 
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"✦ تم فـتح تعديل").unLock,"md",true)  
return false
end 
if text == "فتح الكل" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end 
Redis:del(TeleGod.."Lock:tagservrbot"..msg_chat_id)   
list ={"Lock:Bot:kick","Lock:User:Name","Lock:hashtak","Lock:Cmd","Lock:Link","Lock:forward","Lock:Keyboard","Lock:geam","Lock:Photo","Lock:Animation","Lock:Video","Lock:Audio","Lock:vico","Lock:Sticker","Lock:Document","Lock:Unsupported","Lock:Markdaun","Lock:Contact","Lock:Spam"}
for i,lock in pairs(list) do 
Redis:del(TeleGod..''..lock..msg_chat_id)    
end
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"✦ تم فـتح جميع الاوامر").unLock,"md",true)  
return false
end 
--------------------------------------------------------------------------------------------------------------
if text == "قفل التكرار" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:hset(TeleGod.."Spam:Group:User"..msg_chat_id ,"Spam:User","del")  
return send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"✦ تم قفـل التكرار").Lock,"md",true)  
elseif text == "قفل التكرار بالتقييد" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:hset(TeleGod.."Spam:Group:User"..msg_chat_id ,"Spam:User","keed")  
return send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"✦ تم قفـل التكرار").lockKid,"md",true)  
elseif text == "قفل التكرار بالكتم" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:hset(TeleGod.."Spam:Group:User"..msg_chat_id ,"Spam:User","mute")  
return send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"✦ تم قفـل التكرار").lockKtm,"md",true)  
elseif text == "قفل التكرار بالطرد" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:hset(TeleGod.."Spam:Group:User"..msg_chat_id ,"Spam:User","kick")  
return send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"✦ تم قفـل التكرار").lockKick,"md",true)  
elseif text == "فتح التكرار" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:hdel(TeleGod.."Spam:Group:User"..msg_chat_id ,"Spam:User")  
return send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"✦ تم فتح التكرار").unLock,"md",true)  
end
if text == "قفل الروابط" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(TeleGod.."Lock:Link"..msg_chat_id,"del")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"✦ تم قفـل الروابط").Lock,"md",true)  
return false
end 
if text == "قفل الروابط بالتقييد" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(TeleGod.."Lock:Link"..msg_chat_id,"ked")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"✦ تم قفـل الروابط").lockKid,"md",true)  
return false
end 
if text == "قفل الروابط بالكتم" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(TeleGod.."Lock:Link"..msg_chat_id,"ktm")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"✦ تم قفـل الروابط").lockKtm,"md",true)  
return false
end 
if text == "قفل الروابط بالطرد" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(TeleGod.."Lock:Link"..msg_chat_id,"kick")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"✦ تم قفـل الروابط").lockKick,"md",true)  
return false
end 
if text == "فتح الروابط" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(TeleGod.."Lock:Link"..msg_chat_id)  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"✦ تم فتح الروابط").unLock,"md",true)  
return false
end 
if text == "قفل المعرفات" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(TeleGod.."Lock:User:Name"..msg_chat_id,"del")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"✦ تم قفـل المعرفات").Lock,"md",true)  
return false
end 
if text == "قفل المعرفات بالتقييد" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(TeleGod.."Lock:User:Name"..msg_chat_id,"ked")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"✦ تم قفـل المعرفات").lockKid,"md",true)  
return false
end 
if text == "قفل المعرفات بالكتم" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(TeleGod.."Lock:User:Name"..msg_chat_id,"ktm")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"✦ تم قفـل المعرفات").lockKtm,"md",true)  
return false
end 
if text == "قفل المعرفات بالطرد" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(TeleGod.."Lock:User:Name"..msg_chat_id,"kick")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"✦ تم قفـل المعرفات").lockKick,"md",true)  
return false
end 
if text == "فتح المعرفات" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(TeleGod.."Lock:User:Name"..msg_chat_id)  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"✦ تم فتح المعرفات").unLock,"md",true)  
return false
end 
if text == "قفل التاك" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(TeleGod.."Lock:hashtak"..msg_chat_id,"del")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"✦ تم قفـل التاك").Lock,"md",true)  
return false
end 
if text == "قفل التاك بالتقييد" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(TeleGod.."Lock:hashtak"..msg_chat_id,"ked")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"✦ تم قفـل التاك").lockKid,"md",true)  
return false
end 
if text == "قفل التاك بالكتم" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(TeleGod.."Lock:hashtak"..msg_chat_id,"ktm")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"✦ تم قفـل التاك").lockKtm,"md",true)  
return false
end 
if text == "قفل التاك بالطرد" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(TeleGod.."Lock:hashtak"..msg_chat_id,"kick")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"✦ تم قفـل التاك").lockKick,"md",true)  
return false
end 
if text == "فتح التاك" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(TeleGod.."Lock:hashtak"..msg_chat_id)  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"✦ تم فتح التاك").unLock,"md",true)  
return false
end 
if text == "قفل الشارحه" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(TeleGod.."Lock:Cmd"..msg_chat_id,"del")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"✦ تم قفـل الشارحه").Lock,"md",true)  
return false
end 
if text == "قفل الشارحه بالتقييد" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(TeleGod.."Lock:Cmd"..msg_chat_id,"ked")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"✦ تم قفـل الشارحه").lockKid,"md",true)  
return false
end 
if text == "قفل الشارحه بالكتم" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(TeleGod.."Lock:Cmd"..msg_chat_id,"ktm")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"✦ تم قفـل الشارحه").lockKtm,"md",true)  
return false
end 
if text == "قفل الشارحه بالطرد" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(TeleGod.."Lock:Cmd"..msg_chat_id,"kick")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"✦ تم قفـل الشارحه").lockKick,"md",true)  
return false
end 
if text == "فتح الشارحه" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(TeleGod.."Lock:Cmd"..msg_chat_id)  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"✦ تم فتح الشارحه").unLock,"md",true)  
return false
end 
if text == 'قفل السب'  then
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
Redis:set(TeleGod..'lock:Fshar'..msg.chat_id,true) 
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"✦ تم قفـل السب").Lock,"md",true)  
end
if text == 'قفل الفارسيه'  then
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
Redis:set(TeleGod..'lock:Fars'..msg.chat_id,true) 
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"✦ تم قفـل الفارسيه").Lock,"md",true)  
end
if text == 'فتح السب' then
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
Redis:del(TeleGod..'lock:Fshar'..msg.chat_id) 
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"✦ تم فتح السب").unLock,"md",true)  
end
if text == 'فتح الفارسيه' then
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
Redis:del(TeleGod..'lock:Fars'..msg.chat_id) 
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"✦ تم فتح الفارسيه").unLock,"md",true)  
end
if text == "قفل الصور"then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(TeleGod.."Lock:Photo"..msg_chat_id,"del")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"✦ تم قفـل الصور").Lock,"md",true)  
return false
end 
if text == "قفل الصور بالتقييد" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(TeleGod.."Lock:Photo"..msg_chat_id,"ked")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"✦ تم قفـل الصور").lockKid,"md",true)  
return false
end 
if text == "قفل الصور بالكتم" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(TeleGod.."Lock:Photo"..msg_chat_id,"ktm")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"✦ تم قفـل الصور").lockKtm,"md",true)  
return false
end 
if text == "قفل الصور بالطرد" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(TeleGod.."Lock:Photo"..msg_chat_id,"kick")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"✦ تم قفـل الصور").lockKick,"md",true)  
return false
end 
if text == "فتح الصور" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(TeleGod.."Lock:Photo"..msg_chat_id)  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"✦ تم فتح الصور").unLock,"md",true)  
return false
end 
if text == "قفل الفيديو" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(TeleGod.."Lock:Video"..msg_chat_id,"del")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"✦ تم قفـل الفيديو").Lock,"md",true)  
return false
end 
if text == "قفل الفيديو بالتقييد" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(TeleGod.."Lock:Video"..msg_chat_id,"ked")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"✦ تم قفـل الفيديو").lockKid,"md",true)  
return false
end 
if text == "قفل الفيديو بالكتم" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(TeleGod.."Lock:Video"..msg_chat_id,"ktm")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"✦ تم قفـل الفيديو").lockKtm,"md",true)  
return false
end 
if text == "قفل الفيديو بالطرد" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(TeleGod.."Lock:Video"..msg_chat_id,"kick")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"✦ تم قفـل الفيديو").lockKick,"md",true)  
return false
end 
if text == "فتح الفيديو" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(TeleGod.."Lock:Video"..msg_chat_id)  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"✦ تم فتح الفيديو").unLock,"md",true)  
return false
end 
if text == "قفل المتحركه" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(TeleGod.."Lock:Animation"..msg_chat_id,"del")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"✦ تم قفـل المتحركه").Lock,"md",true)  
return false
end 
if text == "قفل المتحركه بالتقييد" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(TeleGod.."Lock:Animation"..msg_chat_id,"ked")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"✦ تم قفـل المتحركه").lockKid,"md",true)  
return false
end 
if text == "قفل المتحركه بالكتم" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(TeleGod.."Lock:Animation"..msg_chat_id,"ktm")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"✦ تم قفـل المتحركه").lockKtm,"md",true)  
return false
end 
if text == "قفل المتحركه بالطرد" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(TeleGod.."Lock:Animation"..msg_chat_id,"kick")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"✦ تم قفـل المتحركه").lockKick,"md",true)  
return false
end 
if text == "فتح المتحركه" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(TeleGod.."Lock:Animation"..msg_chat_id)  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"✦ تم فتح المتحركه").unLock,"md",true)  
return false
end 
if text == "قفل الالعاب" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(TeleGod.."Lock:geam"..msg_chat_id,"del")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"✦ تم قفـل الالعاب").Lock,"md",true)  
return false
end 
if text == "قفل الالعاب بالتقييد" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(TeleGod.."Lock:geam"..msg_chat_id,"ked")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"✦ تم قفـل الالعاب").lockKid,"md",true)  
return false
end 
if text == "قفل الالعاب بالكتم" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(TeleGod.."Lock:geam"..msg_chat_id,"ktm")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"✦ تم قفـل الالعاب").lockKtm,"md",true)  
return false
end 
if text == "قفل الالعاب بالطرد" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(TeleGod.."Lock:geam"..msg_chat_id,"kick")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"✦ تم قفـل الالعاب").lockKick,"md",true)  
return false
end 
if text == "فتح الالعاب" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(TeleGod.."Lock:geam"..msg_chat_id)  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"✦ تم فتح الالعاب").unLock,"md",true)  
return false
end 
if text == "قفل الاغاني" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(TeleGod.."Lock:Audio"..msg_chat_id,"del")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"✦ تم قفـل الاغاني").Lock,"md",true)  
return false
end 
if text == "قفل الاغاني بالتقييد" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(TeleGod.."Lock:Audio"..msg_chat_id,"ked")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"✦ تم قفـل الاغاني").lockKid,"md",true)  
return false
end 
if text == "قفل الاغاني بالكتم" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(TeleGod.."Lock:Audio"..msg_chat_id,"ktm")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"✦ تم قفـل الاغاني").lockKtm,"md",true)  
return false
end 
if text == "قفل الاغاني بالطرد" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(TeleGod.."Lock:Audio"..msg_chat_id,"kick")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"✦ تم قفـل الاغاني").lockKick,"md",true)  
return false
end 
if text == "فتح الاغاني" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(TeleGod.."Lock:Audio"..msg_chat_id)  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"✦ تم فتح الاغاني").unLock,"md",true)  
return false
end 
if text == "قفل الصوت" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(TeleGod.."Lock:vico"..msg_chat_id,"del")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"✦ تم قفـل الصوت").Lock,"md",true)  
return false
end 
if text == "قفل الصوت بالتقييد" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(TeleGod.."Lock:vico"..msg_chat_id,"ked")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"✦ تم قفـل الصوت").lockKid,"md",true)  
return false
end 
if text == "قفل الصوت بالكتم" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(TeleGod.."Lock:vico"..msg_chat_id,"ktm")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"✦ تم قفـل الصوت").lockKtm,"md",true)  
return false
end 
if text == "قفل الصوت بالطرد" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(TeleGod.."Lock:vico"..msg_chat_id,"kick")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"✦ تم قفـل الصوت").lockKick,"md",true)  
return false
end 
if text == "فتح الصوت" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(TeleGod.."Lock:vico"..msg_chat_id)  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"✦ تم فتح الصوت").unLock,"md",true)  
return false
end 
if text == "قفل الكيبورد" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(TeleGod.."Lock:Keyboard"..msg_chat_id,"del")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"✦ تم قفـل الكيبورد").Lock,"md",true)  
return false
end 
if text == "قفل الكيبورد بالتقييد" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(TeleGod.."Lock:Keyboard"..msg_chat_id,"ked")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"✦ تم قفـل الكيبورد").lockKid,"md",true)  
return false
end 
if text == "قفل الكيبورد بالكتم" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(TeleGod.."Lock:Keyboard"..msg_chat_id,"ktm")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"✦ تم قفـل الكيبورد").lockKtm,"md",true)  
return false
end 
if text == "قفل الكيبورد بالطرد" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(TeleGod.."Lock:Keyboard"..msg_chat_id,"kick")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"✦ تم قفـل الكيبورد").lockKick,"md",true)  
return false
end 
if text == "فتح الكيبورد" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(TeleGod.."Lock:Keyboard"..msg_chat_id)  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"✦ تم فتح الكيبورد").unLock,"md",true)  
return false
end 
if text == "قفل الملصقات" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(TeleGod.."Lock:Sticker"..msg_chat_id,"del")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"✦ تم قفـل الملصقات").Lock,"md",true)  
return false
end 
if text == "قفل الملصقات بالتقييد" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(TeleGod.."Lock:Sticker"..msg_chat_id,"ked")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"✦ تم قفـل الملصقات").lockKid,"md",true)  
return false
end 
if text == "قفل الملصقات بالكتم" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(TeleGod.."Lock:Sticker"..msg_chat_id,"ktm")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"✦ تم قفـل الملصقات").lockKtm,"md",true)  
return false
end 
if text == "قفل الملصقات بالطرد" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(TeleGod.."Lock:Sticker"..msg_chat_id,"kick")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"✦ تم قفـل الملصقات").lockKick,"md",true)  
return false
end 
if text == "فتح الملصقات" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(TeleGod.."Lock:Sticker"..msg_chat_id)  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"✦ تم فتح الملصقات").unLock,"md",true)  
return false
end 
if text == "قفل التوجيه" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(TeleGod.."Lock:forward"..msg_chat_id,"del")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"✦ تم قفـل التوجيه").Lock,"md",true)  
return false
end 
if text == "قفل التوجيه بالتقييد" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(TeleGod.."Lock:forward"..msg_chat_id,"ked")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"✦ تم قفـل التوجيه").lockKid,"md",true)  
return false
end 
if text == "قفل التوجيه بالكتم" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(TeleGod.."Lock:forward"..msg_chat_id,"ktm")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"✦ تم قفـل التوجيه").lockKtm,"md",true)  
return false
end 
if text == "قفل التوجيه بالطرد" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(TeleGod.."Lock:forward"..msg_chat_id,"kick")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"✦ تم قفـل التوجيه").lockKick,"md",true)  
return false
end 
if text == "فتح التوجيه" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(TeleGod.."Lock:forward"..msg_chat_id)  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"✦ تم فتح التوجيه").unLock,"md",true)  
return false
end 
if text == "قفل الملفات" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(TeleGod.."Lock:Document"..msg_chat_id,"del")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"✦ تم قفـل الملفات").Lock,"md",true)  
return false
end 
if text == "قفل الملفات بالتقييد" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(TeleGod.."Lock:Document"..msg_chat_id,"ked")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"✦ تم قفـل الملفات").lockKid,"md",true)  
return false
end 
if text == "قفل الملفات بالكتم" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(TeleGod.."Lock:Document"..msg_chat_id,"ktm")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"✦ تم قفـل الملفات").lockKtm,"md",true)  
return false
end 
if text == "قفل الملفات بالطرد" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(TeleGod.."Lock:Document"..msg_chat_id,"kick")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"✦ تم قفـل الملفات").lockKick,"md",true)  
return false
end 
if text == "فتح الملفات" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(TeleGod.."Lock:Document"..msg_chat_id)  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"✦ تم فتح الملفات").unLock,"md",true)  
return false
end 
if text == "قفل السيلفي" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(TeleGod.."Lock:Unsupported"..msg_chat_id,"del")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"✦ تم قفـل السيلفي").Lock,"md",true)  
return false
end 
if text == "قفل السيلفي بالتقييد" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(TeleGod.."Lock:Unsupported"..msg_chat_id,"ked")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"✦ تم قفـل السيلفي").lockKid,"md",true)  
return false
end 
if text == "قفل السيلفي بالكتم" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(TeleGod.."Lock:Unsupported"..msg_chat_id,"ktm")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"✦ تم قفـل السيلفي").lockKtm,"md",true)  
return false
end 
if text == "قفل السيلفي بالطرد" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(TeleGod.."Lock:Unsupported"..msg_chat_id,"kick")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"✦ تم قفـل السيلفي").lockKick,"md",true)  
return false
end 
if text == "فتح السيلفي" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(TeleGod.."Lock:Unsupported"..msg_chat_id)  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"✦ تم فتح السيلفي").unLock,"md",true)  
return false
end 
if text == "قفل الماركداون" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(TeleGod.."Lock:Markdaun"..msg_chat_id,"del")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"✦ تم قفـل الماركداون").Lock,"md",true)  
return false
end 
if text == "قفل الماركداون بالتقييد" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(TeleGod.."Lock:Markdaun"..msg_chat_id,"ked")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"✦ تم قفـل الماركداون").lockKid,"md",true)  
return false
end 
if text == "قفل الماركداون بالكتم" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(TeleGod.."Lock:Markdaun"..msg_chat_id,"ktm")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"✦ تم قفـل الماركداون").lockKtm,"md",true)  
return false
end 
if text == "قفل الماركداون بالطرد" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(TeleGod.."Lock:Markdaun"..msg_chat_id,"kick")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"✦ تم قفـل الماركداون").lockKick,"md",true)  
return false
end 
if text == "فتح الماركداون" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(TeleGod.."Lock:Markdaun"..msg_chat_id)  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"✦ تم فتح الماركداون").unLock,"md",true)  
return false
end 
if text == "قفل الجهات" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(TeleGod.."Lock:Contact"..msg_chat_id,"del")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"✦ تم قفـل الجهات").Lock,"md",true)  
return false
end 
if text == "قفل الجهات بالتقييد" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(TeleGod.."Lock:Contact"..msg_chat_id,"ked")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"✦ تم قفـل الجهات").lockKid,"md",true)  
return false
end 
if text == "قفل الجهات بالكتم" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(TeleGod.."Lock:Contact"..msg_chat_id,"ktm")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"✦ تم قفـل الجهات").lockKtm,"md",true)  
return false
end 
if text == "قفل الجهات بالطرد" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(TeleGod.."Lock:Contact"..msg_chat_id,"kick")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"✦ تم قفـل الجهات").lockKick,"md",true)  
return false
end 
if text == "فتح الجهات" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(TeleGod.."Lock:Contact"..msg_chat_id)  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"✦ تم فتح الجهات").unLock,"md",true)  
return false
end 
if text == "قفل الكلايش" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(TeleGod.."Lock:Spam"..msg_chat_id,"del")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"✦ تم قفـل الكلايش").Lock,"md",true)  
return false
end 
if text == "قفل الكلايش بالتقييد" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(TeleGod.."Lock:Spam"..msg_chat_id,"ked")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"✦ تم قفـل الكلايش").lockKid,"md",true)  
return false
end 
if text == "قفل الكلايش بالكتم" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(TeleGod.."Lock:Spam"..msg_chat_id,"ktm")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"✦ تم قفـل الكلايش").lockKtm,"md",true)  
return false
end 
if text == "قفل الكلايش بالطرد" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(TeleGod.."Lock:Spam"..msg_chat_id,"kick")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"✦ تم قفـل الكلايش").lockKick,"md",true)  
return false
end 
if text == "فتح الكلايش" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(TeleGod.."Lock:Spam"..msg_chat_id)  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"✦ تم فتح الكلايش").unLock,"md",true)  
return false
end 
if text == "قفل الانلاين" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(TeleGod.."Lock:Inlen"..msg_chat_id,"del")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"✦ تم قفـل الانلاين").Lock,"md",true)  
return false
end 
if text == "قفل الانلاين بالتقييد" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(TeleGod.."Lock:Inlen"..msg_chat_id,"ked")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"✦ تم قفـل الانلاين").lockKid,"md",true)  
return false
end 
if text == "قفل الانلاين بالكتم" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(TeleGod.."Lock:Inlen"..msg_chat_id,"ktm")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"✦ تم قفـل الانلاين").lockKtm,"md",true)  
return false
end 
if text == "قفل الانلاين بالطرد" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(TeleGod.."Lock:Inlen"..msg_chat_id,"kick")  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"✦ تم قفـل الانلاين").lockKick,"md",true)  
return false
end 
if text == "فتح الانلاين" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(TeleGod.."Lock:Inlen"..msg_chat_id)  
send(msg_chat_id,msg_id,Reply_Status(msg.sender.user_id,"✦ تم فتح الانلاين").unLock,"md",true)  
return false
end 
if text == "ضع رابط" or text == "وضع رابط" then
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:setex(TeleGod.."Set:Link"..msg_chat_id..""..msg.sender.user_id,120,true) 
return send(msg_chat_id,msg_id,"٭ ارسل رابط الجروب او رابط قناة الجروب","md",true)  
end
if text == "مسح الرابط" or text == "حذف الرابط" then
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(TeleGod.."Group:Link"..msg_chat_id) 
return send(msg_chat_id,msg_id,"✦ تم مسح الرابط ","md",true)             
end
if text == "الرابط" then
if not Redis:get(TeleGod.."Status:Link"..msg_chat_id) then
return send(msg_chat_id,msg_id,"✦ تم تعطيل جلب الرابط من قبل الادمنيه","md",true)
end 
local Get_Chat = LuaTele.getChat(msg_chat_id)
local GetLink = Redis:get(TeleGod.."Group:Link"..msg_chat_id) 
if GetLink then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{{text =Get_Chat.title, url = GetLink}, },}}
return send(msg_chat_id, msg_id, "✦ Link Group : \n["..Get_Chat.title.. ']('..GetLink..')', 'md', true, false, false, false, reply_markup)
else 
local LinkGroup = LuaTele.generateChatInviteLink(msg_chat_id,'Hussain',tonumber(msg.date+86400),0,true)
if LinkGroup.code == 3 then
return send(msg_chat_id,msg_id,"✦ لا استطيع جلب الرابط بسبب ليس لدي صلاحيه دعوه مستخدمين من خلال الرابط ","md",true)
end
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{{text = Get_Chat.title, url = LinkGroup.invite_link},},}}
return send(msg_chat_id, msg_id, "✦ Link Group : \n["..Get_Chat.title.. ']('..LinkGroup.invite_link..')', 'md', true, false, false, false, reply_markup)
end
end

if text == "ضع ترحيب" or text == "وضع ترحيب" then  
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:setex(TeleGod.."Tshake:Welcome:Group" .. msg_chat_id .. "" .. msg.sender.user_id, 120, true)  
return send(msg_chat_id,msg_id,"✦ ارسل لي الترحيب الان".."\n✦ تستطيع اضافة مايلي !\n✦ دالة عرض الاسم »{`name`}\n✦ دالة عرض المعرف »{`user`}\n✦ دالة عرض اسم الجروب »{`NameCh`}","md",true)   
end
if text == "الترحيب" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not Redis:get(TeleGod.."Status:Welcome"..msg_chat_id) then
return send(msg_chat_id,msg_id,"✦ تم تعطيل الترحيب من قبل الادمنيه","md",true)
end 
local Welcome = Redis:get(TeleGod.."Welcome:Group"..msg_chat_id)
if Welcome then 
return send(msg_chat_id,msg_id,Welcome,"md",true)   
else 
return send(msg_chat_id,msg_id,"✦ لم يتم تعيين ترحيب للجروب","md",true)   
end 
end
if text == "مسح الترحيب" or text == "حذف الترحيب" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(TeleGod.."Welcome:Group"..msg_chat_id) 
return send(msg_chat_id,msg_id,"✦ تم ازالة ترحيب الجروب","md",true)   
end
if text == "ضع قوانين" or text == "وضع قوانين" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:setex(TeleGod.."Set:Rules:" .. msg_chat_id .. ":" .. msg.sender.user_id, 600, true) 
return send(msg_chat_id,msg_id,"✦ ارسل لي القوانين الان","md",true)  
end
if text == "مسح القوانين" or text == "حذف القوانين" then  
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(TeleGod.."Group:Rules"..msg_chat_id) 
return send(msg_chat_id,msg_id,"✦ تم ازالة قوانين الجروب","md",true)    
end
if text == "القوانين" then 
local Rules = Redis:get(TeleGod.."Group:Rules" .. msg_chat_id)   
if Rules then     
return send(msg_chat_id,msg_id,Rules,"md",true)     
else      
return send(msg_chat_id,msg_id,"✦ لا توجد قوانين هنا","md",true)     
end    
end
if text == "ضع وصف" or text == "وضع وصف" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*✦ عذرآ البوت ليس ادمن في الجروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).Info == false then
return send(msg_chat_id,msg_id,'\n*✦ البوت ليس لديه صلاحيه تغيير المعلومات* ',"md",true)  
end
Redis:setex(TeleGod.."Set:Description:" .. msg_chat_id .. ":" .. msg.sender.user_id, 600, true) 
return send(msg_chat_id,msg_id,"✦ ارسل لي وصف الجروب الان","md",true)  
end
if text == "مسح الوصف" or text == "حذف الوصف" then  
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*✦ عذرآ البوت ليس ادمن في الجروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).Info == false then
return send(msg_chat_id,msg_id,'\n*✦ البوت ليس لديه صلاحيه تغيير المعلومات* ',"md",true)  
end
LuaTele.setChatDescription(msg_chat_id, '') 
return send(msg_chat_id,msg_id,"✦ تم ازالة قوانين الجروب","md",true)    
end

if text and text:match("^ضع اسم (.*)") or text and text:match("^وضع اسم (.*)") then 
local NameChat = text:match("^ضع اسم (.*)") or text:match("^وضع اسم (.*)") 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*✦ عذرآ البوت ليس ادمن في الجروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).Info == false then
return send(msg_chat_id,msg_id,'\n*✦ البوت ليس لديه صلاحيه تغيير المعلومات* ',"md",true)  
end
LuaTele.setChatTitle(msg_chat_id,NameChat)
return send(msg_chat_id,msg_id,"✦ تم تغيير اسم الجروب الى : "..NameChat,"md",true)    
end

if text == ("ضع صوره") then  
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if GetInfoBot(msg).Info == false then
return send(msg_chat_id,msg_id,'\n*✦ البوت ليس لديه صلاحيه تغيير المعلومات* ',"md",true)  
end
Redis:set(TeleGod.."Chat:Photo"..msg_chat_id..":"..msg.sender.user_id,true) 
return send(msg_chat_id,msg_id,"✦ ارسل الصوره لوضعها","md",true)    
end

if text == "مسح قائمه المنع" then   
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local list = Redis:smembers(TeleGod.."List:Filter"..msg_chat_id)  
if #list == 0 then  
return send(msg_chat_id,msg_id,"*✦ لا يوجد كلمات ممنوعه هنا *","md",true)   
end  
for k,v in pairs(list) do  
v = v:gsub('photo:',"") 
v = v:gsub('sticker:',"") 
v = v:gsub('animation:',"") 
v = v:gsub('text:',"") 
Redis:del(TeleGod.."Filter:Group:"..v..msg_chat_id)  
Redis:srem(TeleGod.."List:Filter"..msg_chat_id,v)  
end  
return send(msg_chat_id,msg_id,"*✦ تم مسح ("..#list..") كلمات ممنوعه *","md",true)   
end
if text == "قائمه المنع" then   
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local list = Redis:smembers(TeleGod.."List:Filter"..msg_chat_id)  
if #list == 0 then  
return send(msg_chat_id,msg_id,"*✦ لا يوجد كلمات ممنوعه هنا *","md",true)   
end  
Filter = '\n*✦ قائمه المنع \n ⩹━━━━✦ 𝗧𝗘𝗟𝗘𝗚𝗢𝗗 ✦ ━━━━⩺*\n'
for k,v in pairs(list) do  
print(v)
if v:match('photo:(.*)') then
ver = 'صوره'
elseif v:match('animation:(.*)') then
ver = 'متحركه'
elseif v:match('sticker:(.*)') then
ver = 'ملصق'
elseif v:match('text:(.*)') then
ver = v:gsub('text:',"") 
end
v = v:gsub('photo:',"") 
v = v:gsub('sticker:',"") 
v = v:gsub('animation:',"") 
v = v:gsub('text:',"") 
local Text_Filter = Redis:get(TeleGod.."Filter:Group:"..v..msg_chat_id)   
Filter = Filter.."*"..k.."- "..ver.." » { "..Text_Filter.." }*\n"    
end  
send(msg_chat_id,msg_id,Filter,"md",true)  
end  
if text == "منع" then       
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(TeleGod..'FilterText'..msg_chat_id..':'..msg.sender.user_id,'true')
return send(msg_chat_id,msg_id,'\n*✦ ارسل الان { ملصق ,متحركه ,صوره ,رساله } *',"md",true)  
end    
if text == "الغاء منع" then    
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(TeleGod..'FilterText'..msg_chat_id..':'..msg.sender.user_id,'DelFilter')
return send(msg_chat_id,msg_id,'\n*✦ ارسل الان { ملصق ,متحركه ,صوره ,رساله } *',"md",true)  
end

if text == "اضف امر عام" then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(TeleGod.."All:Command:Reids:Group"..msg_chat_id..":"..msg.sender.user_id,"true") 
return send(msg_chat_id,msg_id,"✦ الان ارسل لي الامر القديم ...","md",true)
end
if text == "حذف امر عام" or text == "مسح امر عام" then 
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(TeleGod.."All:Command:Reids:Group:Del"..msg_chat_id..":"..msg.sender.user_id,"true") 
return send(msg_chat_id,msg_id,"✦ ارسل الان الامر الذي قمت بوضعه مكان الامر القديم","md",true)
end
if text == "حذف الاوامر المضافه العامه" or text == "مسح الاوامر المضافه العامه" then 
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local list = Redis:smembers(TeleGod.."All:Command:List:Group")
for k,v in pairs(list) do
Redis:del(TeleGod.."All:Get:Reides:Commands:Group"..v)
Redis:del(TeleGod.."All:Command:List:Group")
end
return send(msg_chat_id,msg_id,"✦ تم مسح جميع الاوامر التي تم اضافتها في العام","md",true)
end
if text == "الاوامر المضافه العامه" then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local list = Redis:smembers(TeleGod.."All:Command:List:Group")
Command = "✦ قائمه الاوامر المضافه العامه  \n⩹━━━━✦ 𝗧𝗘𝗟𝗘𝗚𝗢𝗗 ✦ ━━━━⩺\n"
for k,v in pairs(list) do
Commands = Redis:get(TeleGod.."All:Get:Reides:Commands:Group"..v)
if Commands then 
Command = Command..""..k..": ("..v..") ← {"..Commands.."}\n"
else
Command = Command..""..k..": ("..v..") \n"
end
end
if #list == 0 then
Command = "✦ لا توجد اوامر اضافيه عامه"
end
return send(msg_chat_id,msg_id,Command,"md",true)
end


if text == "اضف امر" then
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(TeleGod.."Command:Reids:Group"..msg_chat_id..":"..msg.sender.user_id,"true") 
return send(msg_chat_id,msg_id,"✦ الان ارسل لي الامر القديم ...","md",true)
end
if text == "حذف امر" or text == "مسح امر" then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(TeleGod.."Command:Reids:Group:Del"..msg_chat_id..":"..msg.sender.user_id,"true") 
return send(msg_chat_id,msg_id,"✦ ارسل الان الامر الذي قمت بوضعه مكان الامر القديم","md",true)
end
if text == "حذف الاوامر المضافه" or text == "مسح الاوامر المضافه" then 
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local list = Redis:smembers(TeleGod.."Command:List:Group"..msg_chat_id)
for k,v in pairs(list) do
Redis:del(TeleGod.."Get:Reides:Commands:Group"..msg_chat_id..":"..v)
Redis:del(TeleGod.."Command:List:Group"..msg_chat_id)
end
return send(msg_chat_id,msg_id,"✦ تم مسح جميع الاوامر التي تم اضافتها","md",true)
end
if text == "الاوامر المضافه" then
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local list = Redis:smembers(TeleGod.."Command:List:Group"..msg_chat_id.."")
Command = "✦ قائمه الاوامر المضافه  \n⩹━━━━✦ 𝗧𝗘𝗟𝗘𝗚𝗢𝗗 ✦ ━━━━⩺\n"
for k,v in pairs(list) do
Commands = Redis:get(TeleGod.."Get:Reides:Commands:Group"..msg_chat_id..":"..v)
if Commands then 
Command = Command..""..k..": ("..v..") ← {"..Commands.."}\n"
else
Command = Command..""..k..": ("..v..") \n"
end
end
if #list == 0 then
Command = "✦ لا توجد اوامر اضافيه"
end
return send(msg_chat_id,msg_id,Command,"html",true)
end

if text == "تثبيت" and msg.reply_to_message_id ~= 0 then
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*✦ عذرآ البوت ليس ادمن في الجروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).PinMsg == false then
return send(msg_chat_id,msg_id,'\n*✦ البوت ليس لديه صلاحيه تثبيت الرسائل* ',"md",true)  
end
send(msg_chat_id,msg_id,"\n✦ تم تثبيت الرساله","md",true)
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local PinMsg = LuaTele.pinChatMessage(msg_chat_id,Message_Reply.id,true)
end
if text == 'الغاء التثبيت' then
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*✦ عذرآ البوت ليس ادمن في الجروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).PinMsg == false then
return send(msg_chat_id,msg_id,'\n*✦ البوت ليس لديه صلاحيه تثبيت الرسائل* ',"md",true)  
end
send(msg_chat_id,msg_id,"\n✦ تم الغاء تثبيت الرساله","md",true)
LuaTele.unpinChatMessage(msg_chat_id) 
end
if text == 'الغاء تثبيت الكل' then
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*✦ عذرآ البوت ليس ادمن في الجروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).PinMsg == false then
return send(msg_chat_id,msg_id,'\n*✦ البوت ليس لديه صلاحيه تثبيت الرسائل* ',"md",true)  
end
send(msg_chat_id,msg_id,"\n✦ تم الغاء تثبيت كل الرسائل","md",true)
LuaTele.unpinAllChatMessages(msg_chat_id)
end
if text == "الحمايه" then    
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = 'تعطيل الرابط', data = msg.sender.user_id..'/'.. 'unmute_link'},{text = 'تفعيل الرابط', data = msg.sender.user_id..'/'.. 'mute_link'},
},
{
{text = 'تعطيل الترحيب', data = msg.sender.user_id..'/'.. 'unmute_welcome'},{text = 'تفعيل الترحيب', data = msg.sender.user_id..'/'.. 'mute_welcome'},
},
{
{text = 'اتعطيل الايدي', data = msg.sender.user_id..'/'.. 'unmute_Id'},{text = 'اتفعيل الايدي', data = msg.sender.user_id..'/'.. 'mute_Id'},
},
{
{text = 'تعطيل الايدي بالصوره', data = msg.sender.user_id..'/'.. 'unmute_IdPhoto'},{text = 'تفعيل الايدي بالصوره', data = msg.sender.user_id..'/'.. 'mute_IdPhoto'},
},
{
{text = 'تعطيل الردود', data = msg.sender.user_id..'/'.. 'unmute_ryple'},{text = 'تفعيل الردود', data = msg.sender.user_id..'/'.. 'mute_ryple'},
},
{
{text = 'تعطيل الردود العامه', data = msg.sender.user_id..'/'.. 'unmute_ryplesudo'},{text = 'تفعيل الردود العامه', data = msg.sender.user_id..'/'.. 'mute_ryplesudo'},
},
{
{text = 'تعطيل الرفع', data = msg.sender.user_id..'/'.. 'unmute_setadmib'},{text = 'تفعيل الرفع', data = msg.sender.user_id..'/'.. 'mute_setadmib'},
},
{
{text = 'تعطيل الطرد', data = msg.sender.user_id..'/'.. 'unmute_kickmembars'},{text = 'تفعيل الطرد', data = msg.sender.user_id..'/'.. 'mute_kickmembars'},
},
{
{text = 'تعطيل الالعاب', data = msg.sender.user_id..'/'.. 'unmute_games'},{text = 'تفعيل الالعاب', data = msg.sender.user_id..'/'.. 'mute_games'},
},
{
{text = 'تعطيل اطردني', data = msg.sender.user_id..'/'.. 'unmute_kickme'},{text = 'تفعيل اطردني', data = msg.sender.user_id..'/'.. 'mute_kickme'},
},
{
{text = 'تعطيل منع التصفيه', data = IdUser..'/'.. 'unmute_kicknum'},{text = 'تفعيل منع التصفيه', data = IdUser..'/'.. 'mute_kicknum'},
},
{ 
{text = '- اخفاء الامر ', data =msg.sender.user_id..'/'.. 'delAmr'}
},
}
}
return send(msg_chat_id, msg_id, '✦ اوامر التفعيل والتعطيل ', 'md', false, false, false, false, reply_markup)
end  
if text == 'اعدادات الحمايه' then 
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if Redis:get(TeleGod.."Status:Link"..msg.chat_id) then
Statuslink = '❬ ✔️ ❭' else Statuslink = '❬ ❌ ❭'
end
if Redis:get(TeleGod.."Status:Welcome"..msg.chat_id) then
StatusWelcome = '❬ ✔️ ❭' else StatusWelcome = '❬ ❌ ❭'
end
if Redis:get(TeleGod.."Status:Id"..msg.chat_id) then
StatusId = '❬ ✔️ ❭' else StatusId = '❬ ❌ ❭'
end
if Redis:get(TeleGod.."Status:IdPhoto"..msg.chat_id) then
StatusIdPhoto = '❬ ✔️ ❭' else StatusIdPhoto = '❬ ❌ ❭'
end
if not Redis:get(TeleGod.."Status:Reply"..msg.chat_id) then
StatusReply = '❬ ✔️ ❭' else StatusReply = '❬ ❌ ❭'
end
if not Redis:get(TeleGod.."Status:ReplySudo"..msg.chat_id) then
StatusReplySudo = '❬ ✔️ ❭' else StatusReplySudo = '❬ ❌ ❭'
end
if Redis:get(TeleGod.."Status:BanId"..msg.chat_id)  then
StatusBanId = '❬ ✔️ ❭' else StatusBanId = '❬ ❌ ❭'
end
if Redis:get(TeleGod.."Status:SetId"..msg.chat_id) then
StatusSetId = '❬ ✔️ ❭' else StatusSetId = '❬ ❌ ❭'
end
if Redis:get(TeleGod.."Status:Games"..msg.chat_id) then
StatusGames = '❬ ✔️ ❭' else StatusGames = '❬ ❌ ❭'
end
if Redis:get(TeleGod.."Status:KickMe"..msg.chat_id) then
Statuskickme = '❬ ✔️ ❭' else Statuskickme = '❬ ❌ ❭'
end
if Redis:get(TeleGod.."Status:AddMe"..msg.chat_id) then
StatusAddme = '❬ ✔️ ❭' else StatusAddme = '❬ ❌ ❭'
end
local protectionGroup = '\n*✦ اعدادات حمايه الجروب\n ⩹━━━━✦ 𝗧𝗘𝗟𝗘𝗚𝗢𝗗 ✦ ━━━━⩺\n'
..'\n✦ جلب الرابط ➤ '..Statuslink
..'\n✦ جلب الترحيب ➤ '..StatusWelcome
..'\n✦ الايدي ➤ '..StatusId
..'\n✦ الايدي بالصوره ➤ '..StatusIdPhoto
..'\n✦ الردود ➤ '..StatusReply
..'\n✦ الردود العامه ➤ '..StatusReplySudo
..'\n✦ الرفع ➤ '..StatusSetId
..'\n✦ الحظر - الطرد ➤ '..StatusBanId
..'\n✦ الالعاب ➤ '..StatusGames
..'\n✦ امر اطردني ➤ '..Statuskickme..'*\n\n.'
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '◜𝑠𝑜𝑢𝑟𝑐𝑒 𝑡𝑒𝑙𝑒𝑔𝑜𝑑◞', url = 't.me/'..chsource..''}, 
},
}
}
return send(msg_chat_id, msg_id,protectionGroup,'md', false, false, false, false, reply_markup)
end
if text == "الاعدادات" then    
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Text = "*\n✦ اعدادات الجروب ".."\n🔏︙علامة ال (✔️) تعني مقفول".."\n🔓︙علامة ال (❌) تعني مفتوح*"
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = GetSetieng(msg_chat_id).lock_links, data = '&'},{text = 'الروابط : ', data =msg.sender.user_id..'/'.. 'Status_link'},
},
{
{text = GetSetieng(msg_chat_id).lock_spam, data = '&'},{text = 'الكلايش : ', data =msg.sender.user_id..'/'.. 'Status_spam'},
},
{
{text = GetSetieng(msg_chat_id).lock_inlin, data = '&'},{text = 'الكيبورد : ', data =msg.sender.user_id..'/'.. 'Status_keypord'},
},
{
{text = GetSetieng(msg_chat_id).lock_vico, data = '&'},{text = 'الاغاني : ', data =msg.sender.user_id..'/'.. 'Status_voice'},
},
{
{text = GetSetieng(msg_chat_id).lock_gif, data = '&'},{text = 'المتحركه : ', data =msg.sender.user_id..'/'.. 'Status_gif'},
},
{
{text = GetSetieng(msg_chat_id).lock_file, data = '&'},{text = 'الملفات : ', data =msg.sender.user_id..'/'.. 'Status_files'},
},
{
{text = GetSetieng(msg_chat_id).lock_text, data = '&'},{text = 'الدردشه : ', data =msg.sender.user_id..'/'.. 'Status_text'},
},
{
{text = GetSetieng(msg_chat_id).lock_ved, data = '&'},{text = 'الفيديو : ', data =msg.sender.user_id..'/'.. 'Status_video'},
},
{
{text = GetSetieng(msg_chat_id).lock_photo, data = '&'},{text = 'الصور : ', data =msg.sender.user_id..'/'.. 'Status_photo'},
},
{
{text = GetSetieng(msg_chat_id).lock_user, data = '&'},{text = 'المعرفات : ', data =msg.sender.user_id..'/'.. 'Status_username'},
},
{
{text = GetSetieng(msg_chat_id).lock_hash, data = '&'},{text = 'التاك : ', data =msg.sender.user_id..'/'.. 'Status_tags'},
},
{
{text = GetSetieng(msg_chat_id).lock_bots, data = '&'},{text = 'البوتات : ', data =msg.sender.user_id..'/'.. 'Status_bots'},
},
{
{text = '- التالي ... ', data =msg.sender.user_id..'/'.. 'NextSeting'}
},
{
{text = '- اخفاء الامر ', data =msg.sender.user_id..'/'.. 'delAmr'}
},
}
}
return send(msg_chat_id, msg_id, Text, 'md', false, false, false, false, reply_markup)
end  


if text == 'الجروب' then
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*✦ عذرآ البوت ليس ادمن في الجروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
local Info_Chats = LuaTele.getSupergroupFullInfo(msg_chat_id)
local Get_Chat = LuaTele.getChat(msg_chat_id)
if Get_Chat.permissions.can_add_web_page_previews then
web = '❬ ✔️ ❭' else web = '❬ ❌ ❭'
end
if Get_Chat.permissions.can_change_info then
info = '❬ ✔️ ❭' else info = '❬ ❌ ❭'
end
if Get_Chat.permissions.can_invite_users then
invite = '❬ ✔️ ❭' else invite = '❬ ❌ ❭'
end
if Get_Chat.permissions.can_pin_messages then
pin = '❬ ✔️ ❭' else pin = '❬ ❌ ❭'
end
if Get_Chat.permissions.can_send_media_messages then
media = '❬ ✔️ ❭' else media = '❬ ❌ ❭'
end
if Get_Chat.permissions.can_send_messages then
messges = '❬ ✔️ ❭' else messges = '❬ ❌ ❭'
end
if Get_Chat.permissions.can_send_other_messages then
other = '❬ ✔️ ❭' else other = '❬ ❌ ❭'
end
if Get_Chat.permissions.can_send_polls then
polls = '❬ ✔️ ❭' else polls = '❬ ❌ ❭'
end
local permissions = '*\n✦ صلاحيات الجروب :\n⩹━━━━✦ 𝗧𝗘𝗟𝗘𝗚𝗢𝗗 ✦ ━━━━⩺'..'\n✦ ارسال الويب : '..web..'\n✦ تغيير معلومات الجروب : '..info..'\n✦ اضافه مستخدمين : '..invite..'\n✦ تثبيت الرسائل : '..pin..'\n✦ ارسال الميديا : '..media..'\n✦ ارسال الرسائل : '..messges..'\n✦ اضافه البوتات : '..other..'\n✦ ارسال استفتاء : '..polls..'*\n\n'
local TextChat = '*\n✦ معلومات الجروب :\n⩹━━━━✦ 𝗧𝗘𝗟𝗘𝗚𝗢𝗗 ✦ ━━━━⩺'..' \n✦ عدد الادمنيه : ❬ '..Info_Chats.administrator_count..' ❭\n✦ عدد المحظورين : ❬ '..Info_Chats.banned_count..' ❭\n✦ عدد الاعضاء : ❬ '..Info_Chats.member_count..' ❭\n✦ عدد المقيديين : ❬ '..Info_Chats.restricted_count..' ❭\n✦ اسم الجروب : ❬* ['..Get_Chat.title..']('..Info_Chats.invite_link.invite_link..')* ❭*'
return send(msg_chat_id,msg_id, TextChat..permissions,"md",true)
end
if text == 'صلاحيات الجروب' then
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*✦ عذرآ البوت ليس ادمن في الجروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
local Get_Chat = LuaTele.getChat(msg_chat_id)
if Get_Chat.permissions.can_add_web_page_previews then
web = '❬ ✔️ ❭' else web = '❬ ❌ ❭'
end
if Get_Chat.permissions.can_change_info then
info = '❬ ✔️ ❭' else info = '❬ ❌ ❭'
end
if Get_Chat.permissions.can_invite_users then
invite = '❬ ✔️ ❭' else invite = '❬ ❌ ❭'
end
if Get_Chat.permissions.can_pin_messages then
pin = '❬ ✔️ ❭' else pin = '❬ ❌ ❭'
end
if Get_Chat.permissions.can_send_media_messages then
media = '❬ ✔️ ❭' else media = '❬ ❌ ❭'
end
if Get_Chat.permissions.can_send_messages then
messges = '❬ ✔️ ❭' else messges = '❬ ❌ ❭'
end
if Get_Chat.permissions.can_send_other_messages then
other = '❬ ✔️ ❭' else other = '❬ ❌ ❭'
end
if Get_Chat.permissions.can_send_polls then
polls = '❬ ✔️ ❭' else polls = '❬ ❌ ❭'
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '- ارسال الويب : '..web, data = msg.sender.user_id..'/web'}, 
},
{
{text = '- تغيير معلومات الجروب : '..info, data =msg.sender.user_id..  '/info'}, 
},
{
{text = '- اضافه مستخدمين : '..invite, data =msg.sender.user_id..  '/invite'}, 
},
{
{text = '- تثبيت الرسائل : '..pin, data =msg.sender.user_id..  '/pin'}, 
},
{
{text = '- ارسال الميديا : '..media, data =msg.sender.user_id..  '/media'}, 
},
{
{text = '- ارسال الرسائل : .'..messges, data =msg.sender.user_id..  '/messges'}, 
},
{
{text = '- اضافه البوتات : '..other, data =msg.sender.user_id..  '/other'}, 
},
{
{text = '- ارسال استفتاء : '..polls, data =msg.sender.user_id.. '/polls'}, 
},
{
{text = '- اخفاء الامر ', data =msg.sender.user_id..'/'.. '/delAmr'}
},
}
}
return send(msg_chat_id, msg_id, "✦ الصلاحيات - ", 'md', false, false, false, false, reply_markup)
end
if text == 'تنزيل الكل' and msg.reply_to_message_id ~= 0 then
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
if UserInfo.message == "Invalid user ID" then
return send(msg_chat_id,msg_id,"\n✦ عذرآ تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return send(msg_chat_id,msg_id,"\n✦ عذرآ لا تستطيع استخدام الامر على البوت ","md",true)  
end
if Redis:sismember(TeleGod.."Dev:Groups",Message_Reply.sender.user_id) then
dev = "المطور ،" else dev = "" end
if Redis:sismember(TeleGod.."Supcreator:Group"..msg_chat_id, Message_Reply.sender.user_id) then
crr = "منشئ اساسي ،" else crr = "" end
if Redis:sismember(TeleGod..'Creator:Group'..msg_chat_id, Message_Reply.sender.user_id) then
cr = "منشئ ،" else cr = "" end
if Redis:sismember(TeleGod..'Manger:Group'..msg_chat_id, Message_Reply.sender.user_id) then
own = "مدير ،" else own = "" end
if Redis:sismember(TeleGod..'Admin:Group'..msg_chat_id, Message_Reply.sender.user_id) then
mod = "ادمن ،" else mod = "" end
if Redis:sismember(TeleGod..'Special:Group'..msg_chat_id, Message_Reply.sender.user_id) then
vip = "مميز ،" else vip = ""
end
if The_ControllerAll(Message_Reply.sender.user_id) == true then
Rink = 1
elseif Redis:sismember(TeleGod.."Dev:Groups",Message_Reply.sender.user_id)  then
Rink = 2
elseif Redis:sismember(TeleGod.."Supcreator:Group"..msg_chat_id, Message_Reply.sender.user_id) then
Rink = 3
elseif Redis:sismember(TeleGod.."Creator:Group"..msg_chat_id, Message_Reply.sender.user_id) then
Rink = 4
elseif Redis:sismember(TeleGod.."Manger:Group"..msg_chat_id, Message_Reply.sender.user_id) then
Rink = 5
elseif Redis:sismember(TeleGod.."Admin:Group"..msg_chat_id, Message_Reply.sender.user_id) then
Rink = 6
elseif Redis:sismember(TeleGod.."Special:Group"..msg_chat_id, Message_Reply.sender.user_id) then
Rink = 7
else
Rink = 8
end
if StatusCanOrNotCan(msg_chat_id,Message_Reply.sender.user_id) == false then
return send(msg_chat_id,msg_id,"\n*✦ ليس لديه اي رتبه هنا *","md",true)  
end
if msg.ControllerBot then
if Rink == 1 or Rink < 1 then
return send(msg_chat_id,msg_id,"\n*✦ لا يمكن تنزيل رتبه نفس رتبتك ولا اعلى من رتبتك *","md",true)  
end
Redis:srem(TeleGod.."Dev:Groups",Message_Reply.sender.user_id)
Redis:srem(TeleGod.."Supcreator:Group"..msg_chat_id, Message_Reply.sender.user_id)
Redis:srem(TeleGod.."Creator:Group"..msg_chat_id, Message_Reply.sender.user_id)
Redis:srem(TeleGod.."Manger:Group"..msg_chat_id, Message_Reply.sender.user_id)
Redis:srem(TeleGod.."Admin:Group"..msg_chat_id, Message_Reply.sender.user_id)
Redis:srem(TeleGod.."Special:Group"..msg_chat_id, Message_Reply.sender.user_id)
elseif msg.Dev then
if Rink == 2 or Rink < 2 then
return send(msg_chat_id,msg_id,"\n*✦ لا يمكن تنزيل رتبه نفس رتبتك ولا اعلى من رتبتك *","md",true)  
end
Redis:srem(TeleGod.."Supcreator:Group"..msg_chat_id, Message_Reply.sender.user_id)
Redis:srem(TeleGod.."Creator:Group"..msg_chat_id, Message_Reply.sender.user_id)
Redis:srem(TeleGod.."Manger:Group"..msg_chat_id, Message_Reply.sender.user_id)
Redis:srem(TeleGod.."Admin:Group"..msg_chat_id, Message_Reply.sender.user_id)
Redis:srem(TeleGod.."Special:Group"..msg_chat_id, Message_Reply.sender.user_id)
elseif msg.Supcreator then
if Rink == 3 or Rink < 3 then
return send(msg_chat_id,msg_id,"\n*✦ لا يمكن تنزيل رتبه نفس رتبتك ولا اعلى من رتبتك *","md",true)  
end
Redis:srem(TeleGod.."Creator:Group"..msg_chat_id, Message_Reply.sender.user_id)
Redis:srem(TeleGod.."Manger:Group"..msg_chat_id, Message_Reply.sender.user_id)
Redis:srem(TeleGod.."Admin:Group"..msg_chat_id, Message_Reply.sender.user_id)
Redis:srem(TeleGod.."Special:Group"..msg_chat_id, Message_Reply.sender.user_id)
elseif msg.Creator then
if Rink == 4 or Rink < 4 then
return send(msg_chat_id,msg_id,"\n*✦ لا يمكن تنزيل رتبه نفس رتبتك ولا اعلى من رتبتك *","md",true)  
end
Redis:srem(TeleGod.."Manger:Group"..msg_chat_id, Message_Reply.sender.user_id)
Redis:srem(TeleGod.."Admin:Group"..msg_chat_id, Message_Reply.sender.user_id)
Redis:srem(TeleGod.."Special:Group"..msg_chat_id, Message_Reply.sender.user_id)
elseif msg.Manger then
if Rink == 5 or Rink < 5 then
return send(msg_chat_id,msg_id,"\n*✦ لا يمكن تنزيل رتبه نفس رتبتك ولا اعلى من رتبتك *","md",true)  
end
Redis:srem(TeleGod.."Admin:Group"..msg_chat_id, Message_Reply.sender.user_id)
Redis:srem(TeleGod.."Special:Group"..msg_chat_id, Message_Reply.sender.user_id)
elseif msg.Admin then
if Rink == 6 or Rink < 6 then
return send(msg_chat_id,msg_id,"\n*✦ لا يمكن تنزيل رتبه نفس رتبتك ولا اعلى من رتبتك *","md",true)  
end
Redis:srem(TeleGod.."Special:Group"..msg_chat_id, Message_Reply.sender.user_id)
end
return send(msg_chat_id,msg_id,"\n*✦ تم تنزيل الشخص من الرتب التاليه { "..dev..""..crr..""..cr..""..own..""..mod..""..vip.." *}","md",true)  
end

if text and text:match('^تنزيل الكل @(%S+)$') then
local UserName = text:match('^تنزيل الكل @(%S+)$')
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local UserId_Info = LuaTele.searchPublicChat(UserName)
if not UserId_Info.id then
return send(msg_chat_id,msg_id,"\n✦ عذرآ لا يوجد حساب بهذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return send(msg_chat_id,msg_id,"\n✦ عذرآ لا تستطيع استخدام معرف قناة او جروب ","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return send(msg_chat_id,msg_id,"\n✦ عذرآ لا تستطيع استخدام معرف البوت ","md",true)  
end
if Redis:sismember(TeleGod.."Dev:Groups",UserId_Info.id) then
dev = "المطور ،" else dev = "" end
if Redis:sismember(TeleGod.."Supcreator:Group"..msg_chat_id, UserId_Info.id) then
crr = "منشئ اساسي ،" else crr = "" end
if Redis:sismember(TeleGod..'Creator:Group'..msg_chat_id, UserId_Info.id) then
cr = "منشئ ،" else cr = "" end
if Redis:sismember(TeleGod..'Manger:Group'..msg_chat_id, UserId_Info.id) then
own = "مدير ،" else own = "" end
if Redis:sismember(TeleGod..'Admin:Group'..msg_chat_id, UserId_Info.id) then
mod = "ادمن ،" else mod = "" end
if Redis:sismember(TeleGod..'Special:Group'..msg_chat_id, UserId_Info.id) then
vip = "مميز ،" else vip = ""
end
if The_ControllerAll(UserId_Info.id) == true then
Rink = 1
elseif Redis:sismember(TeleGod.."Dev:Groups",UserId_Info.id)  then
Rink = 2
elseif Redis:sismember(TeleGod.."Supcreator:Group"..msg_chat_id, UserId_Info.id) then
Rink = 3
elseif Redis:sismember(TeleGod.."Creator:Group"..msg_chat_id, UserId_Info.id) then
Rink = 4
elseif Redis:sismember(TeleGod.."Manger:Group"..msg_chat_id, UserId_Info.id) then
Rink = 5
elseif Redis:sismember(TeleGod.."Admin:Group"..msg_chat_id, UserId_Info.id) then
Rink = 6
elseif Redis:sismember(TeleGod.."Special:Group"..msg_chat_id, UserId_Info.id) then
Rink = 7
else
Rink = 8
end
if StatusCanOrNotCan(msg_chat_id,UserId_Info.id) == false then
return send(msg_chat_id,msg_id,"\n*✦ ليس لديه اي رتبه هنا *","md",true)  
end
if msg.ControllerBot then
if Rink == 1 or Rink < 1 then
return send(msg_chat_id,msg_id,"\n*✦ لا يمكن تنزيل رتبه نفس رتبتك ولا اعلى من رتبتك *","md",true)  
end
Redis:srem(TeleGod.."Dev:Groups",UserId_Info.id)
Redis:srem(TeleGod.."Supcreator:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(TeleGod.."Creator:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(TeleGod.."Manger:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(TeleGod.."Admin:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(TeleGod.."Special:Group"..msg_chat_id, UserId_Info.id)
elseif msg.Dev then
if Rink == 2 or Rink < 2 then
return send(msg_chat_id,msg_id,"\n*✦ لا يمكن تنزيل رتبه نفس رتبتك ولا اعلى من رتبتك *","md",true)  
end
Redis:srem(TeleGod.."Supcreator:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(TeleGod.."Creator:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(TeleGod.."Manger:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(TeleGod.."Admin:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(TeleGod.."Special:Group"..msg_chat_id, UserId_Info.id)
elseif msg.Supcreator then
if Rink == 3 or Rink < 3 then
return send(msg_chat_id,msg_id,"\n*✦ لا يمكن تنزيل رتبه نفس رتبتك ولا اعلى من رتبتك *","md",true)  
end
Redis:srem(TeleGod.."Creator:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(TeleGod.."Manger:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(TeleGod.."Admin:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(TeleGod.."Special:Group"..msg_chat_id, UserId_Info.id)
elseif msg.Creator then
if Rink == 4 or Rink < 4 then
return send(msg_chat_id,msg_id,"\n*✦ لا يمكن تنزيل رتبه نفس رتبتك ولا اعلى من رتبتك *","md",true)  
end
Redis:srem(TeleGod.."Manger:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(TeleGod.."Admin:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(TeleGod.."Special:Group"..msg_chat_id, UserId_Info.id)
elseif msg.Manger then
if Rink == 5 or Rink < 5 then
return send(msg_chat_id,msg_id,"\n*✦ لا يمكن تنزيل رتبه نفس رتبتك ولا اعلى من رتبتك *","md",true)  
end
Redis:srem(TeleGod.."Admin:Group"..msg_chat_id, UserId_Info.id)
Redis:srem(TeleGod.."Special:Group"..msg_chat_id, UserId_Info.id)
elseif msg.Admin then
if Rink == 6 or Rink < 6 then
return send(msg_chat_id,msg_id,"\n*✦ لا يمكن تنزيل رتبه نفس رتبتك ولا اعلى من رتبتك *","md",true)  
end
Redis:srem(TeleGod.."Special:Group"..msg_chat_id, UserId_Info.id)
end
return send(msg_chat_id,msg_id,"\n*✦ تم تنزيل الشخص من الرتب التاليه { "..dev..""..crr..""..cr..""..own..""..mod..""..vip.." *}","md",true)  
end

if text and text:match('ضع لقب (.*)') and msg.reply_to_message_id ~= 0 then
local CustomTitle = text:match('ضع لقب (.*)')
if not msg.Supcreator then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(4)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*✦ عذرآ البوت ليس ادمن في الجروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).SetAdmin == false then
return send(msg_chat_id,msg_id,'\n*✦ البوت ليس لديه صلاحيه اضافة مشرفين* ',"md",true)  
end
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
if UserInfo.message == "Invalid user ID" then
return send(msg_chat_id,msg_id,"\n✦ عذرآ تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return send(msg_chat_id,msg_id,"\n✦ عذرآ لا تستطيع استخدام الامر على البوت ","md",true)  
end
https.request("https://api.telegram.org/bot" .. Token .. "/promoteChatMember?chat_id=" .. msg_chat_id .. "&user_id=" ..Message_Reply.sender.user_id.."&can_invite_users=True")
send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"✦ تم وضع له لقب : "..CustomTitle).Reply,"md",true)  
https.request("https://api.telegram.org/bot"..Token.."/setChatAdministratorCustomTitle?chat_id="..msg_chat_id.."&user_id="..Message_Reply.sender.user_id.."&custom_title="..CustomTitle)
end
if text and text:match('^ضع لقب @(%S+) (.*)$') then
local UserName = {text:match('^ضع لقب @(%S+) (.*)$')}
if not msg.Supcreator then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(4)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*✦ عذرآ البوت ليس ادمن في الجروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).SetAdmin == false then
return send(msg_chat_id,msg_id,'\n*✦ البوت ليس لديه صلاحيه اضافة مشرفين* ',"md",true)  
end
local UserId_Info = LuaTele.searchPublicChat(UserName[1])
if not UserId_Info.id then
return send(msg_chat_id,msg_id,"\n✦ عذرآ لا يوجد حساب بهذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return send(msg_chat_id,msg_id,"\n✦ عذرآ لا تستطيع استخدام معرف قناة او جروب ","md",true)  
end
if UserName and UserName[1]:match('(%S+)[Bb][Oo][Tt]') then
return send(msg_chat_id,msg_id,"\n✦ عذرآ لا تستطيع استخدام معرف البوت ","md",true)  
end
https.request("https://api.telegram.org/bot" .. Token .. "/promoteChatMember?chat_id=" .. msg_chat_id .. "&user_id=" ..UserId_Info.id.."&can_invite_users=True")
send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"✦ تم وضع له لقب : "..UserName[2]).Reply,"md",true)  
https.request("https://api.telegram.org/bot"..Token.."/setChatAdministratorCustomTitle?chat_id="..msg_chat_id.."&user_id="..UserId_Info.id.."&custom_title="..UserName[2])
end 
if text == 'لقبي'  then
Ge = https.request("https://api.telegram.org/bot".. Token.."/getChatMember?chat_id=" .. msg_chat_id .. "&user_id=" ..msg.sender.user_id)
GeId = JSON.decode(Ge)
if not GeId.result.custom_title then
send(msg_chat_id,msg_id,'*✦ ليس لديك لقب*',"md",true) 
else
send(msg_chat_id,msg_id,'✦ لقبك هو : '..GeId.result.custom_title,"md",true) 
end
end
if text == ('رفع مشرف') and msg.reply_to_message_id ~= 0 then
if not msg.Supcreator then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(4)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*✦ عذرآ البوت ليس ادمن في الجروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).SetAdmin == false then
return send(msg_chat_id,msg_id,'\n*✦ البوت ليس لديه صلاحيه اضافة مشرفين* ',"md",true)  
end
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
if UserInfo.message == "Invalid user ID" then
return send(msg_chat_id,msg_id,"\n✦ عذرآ تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return send(msg_chat_id,msg_id,"\n✦ عذرآ لا تستطيع استخدام الامر على البوت ","md",true)  
end
local SetAdmin = LuaTele.setChatMemberStatus(msg.chat_id,Message_Reply.sender.user_id,'administrator',{1 ,1, 0, 0, 0, 0, 0 , 0, 0, 0, 0, 0, ''})
if SetAdmin.code == 3 then
return send(msg_chat_id,msg_id,"\n*✦ لا يمكنني رفعه ليس لدي صلاحيات *","md",true)  
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '- تعديل الصلاحيات ', data = msg.sender.user_id..'/groupNumseteng//'..Message_Reply.sender.user_id}, 
},
}
}
return send(msg_chat_id, msg_id, "✦ صلاحيات المستخدم - ", 'md', false, false, false, false, reply_markup)
end
if text and text:match('^رفع مشرف @(%S+)$') then
local UserName = text:match('^رفع مشرف @(%S+)$')
if not msg.Supcreator then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(4)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*✦ عذرآ البوت ليس ادمن في الجروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).SetAdmin == false then
return send(msg_chat_id,msg_id,'\n*✦ البوت ليس لديه صلاحيه اضافة مشرفين* ',"md",true)  
end
local UserId_Info = LuaTele.searchPublicChat(UserName)
if not UserId_Info.id then
return send(msg_chat_id,msg_id,"\n✦ عذرآ لا يوجد حساب بهذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return send(msg_chat_id,msg_id,"\n✦ عذرآ لا تستطيع استخدام معرف قناة او جروب ","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return send(msg_chat_id,msg_id,"\n✦ عذرآ لا تستطيع استخدام معرف البوت ","md",true)  
end
local SetAdmin = LuaTele.setChatMemberStatus(msg.chat_id,UserId_Info.id,'administrator',{1 ,1, 0, 0, 0, 0, 0 , 0, 0, 0, 0, 0, ''})

if SetAdmin.code == 3 then
return send(msg_chat_id,msg_id,"\n*✦ لا يمكنني رفعه ليس لدي صلاحيات *","md",true)  
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '- تعديل الصلاحيات ', data = msg.sender.user_id..'/groupNumseteng//'..UserId_Info.id}, 
},
}
}
return send(msg_chat_id, msg_id, "✦ صلاحيات المستخدم - ", 'md', false, false, false, false, reply_markup)
end 
if text == ('تنزيل مشرف') and msg.reply_to_message_id ~= 0 then
if not msg.Supcreator then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(4)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*✦ عذرآ البوت ليس ادمن في الجروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).SetAdmin == false then
return send(msg_chat_id,msg_id,'\n*✦ البوت ليس لديه صلاحيه اضافة مشرفين* ',"md",true)  
end
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
if UserInfo.message == "Invalid user ID" then
return send(msg_chat_id,msg_id,"\n✦ عذرآ تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return send(msg_chat_id,msg_id,"\n✦ عذرآ لا تستطيع استخدام الامر على البوت ","md",true)  
end
local SetAdmin = LuaTele.setChatMemberStatus(msg.chat_id,Message_Reply.sender.user_id,'administrator',{0 ,0, 0, 0, 0, 0, 0 ,0, 0})
if SetAdmin.code == 400 then
return send(msg_chat_id,msg_id,"\n*✦ لست انا من قام برفعه *","md",true)  
end
if SetAdmin.code == 3 then
return send(msg_chat_id,msg_id,"\n*✦ لا يمكنني تنزيله ليس لدي صلاحيات *","md",true)  
end
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"✦ تم تنزيله من المشرفين ").Reply,"md",true)  
end
if text and text:match('^تنزيل مشرف @(%S+)$') then
local UserName = text:match('^تنزيل مشرف @(%S+)$')
if not msg.Supcreator then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(4)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*✦ عذرآ البوت ليس ادمن في الجروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).SetAdmin == false then
return send(msg_chat_id,msg_id,'\n*✦ البوت ليس لديه صلاحيه اضافة مشرفين* ',"md",true)  
end
local UserId_Info = LuaTele.searchPublicChat(UserName)
if not UserId_Info.id then
return send(msg_chat_id,msg_id,"\n✦ عذرآ لا يوجد حساب بهذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return send(msg_chat_id,msg_id,"\n✦ عذرآ لا تستطيع استخدام معرف قناة او جروب ","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return send(msg_chat_id,msg_id,"\n✦ عذرآ لا تستطيع استخدام معرف البوت ","md",true)  
end
local SetAdmin = LuaTele.setChatMemberStatus(msg.chat_id,UserId_Info.id,'administrator',{0 ,0, 0, 0, 0, 0, 0 ,0, 0})
if SetAdmin.code == 400 then
return send(msg_chat_id,msg_id,"\n*✦ لست انا من قام برفعه *","md",true)  
end
if SetAdmin.code == 3 then
return send(msg_chat_id,msg_id,"\n*✦ لا يمكنني تنزيله ليس لدي صلاحيات *","md",true)  
end
return send(msg_chat_id,msg_id,Reply_Status(UserId_Info.id,"✦ تم تنزيله من المشرفين ").Reply,"md",true)  
end 
if text == 'مسح رسائلي' then
Redis:del(TeleGod..'Num:Message:User'..msg.chat_id..':'..msg.sender.user_id)
send(msg_chat_id,msg_id,'✦ تم مسح جميع رسائلك ',"md",true)  
elseif text == 'مسح تعديلاتي' or text == 'مسح تعديلاتي' then
Redis:del(TeleGod..'Num:Message:Edit'..msg.chat_id..':'..msg.sender.user_id)
send(msg_chat_id,msg_id,'✦ تم مسح جميع تعديلاتك ',"md",true)  
elseif text == 'مسح جهاتي' then
Redis:del(TeleGod..'Num:Add:Memp'..msg.chat_id..':'..msg.sender.user_id)
send(msg_chat_id,msg_id,'✦ تم مسح جميع جهاتك المضافه ',"md",true)  
elseif text == 'رسائلي' then
send(msg_chat_id,msg_id,'✦ عدد رسائلك هنا *~ '..(Redis:get(TeleGod..'Num:Message:User'..msg.chat_id..':'..msg.sender.user_id) or 1)..'*',"md",true)  
elseif text == 'تعديلاتي' or text == 'تعديلاتي' then
send(msg_chat_id,msg_id,'✦ عدد التعديلات هنا *~ '..(Redis:get(TeleGod..'Num:Message:Edit'..msg.chat_id..msg.sender.user_id) or 0)..'*',"md",true)  
elseif text == 'جهاتي' then
send(msg_chat_id,msg_id,'✦ عدد جهاتك المضافه هنا *~ '..(Redis:get(TeleGod.."Num:Add:Memp"..msg.chat_id..":"..msg.sender.user_id) or 0)..'*',"md",true)  
elseif text == 'مسح' and msg.reply_to_message_id ~= 0 and msg.Admin then
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if GetInfoBot(msg).Delmsg == false then
return send(msg_chat_id,msg_id,'\n*✦ البوت ليس لديه صلاحيه حذف الرسائل* ',"md",true)  
end
LuaTele.deleteMessages(msg.chat_id,{[1]= msg.reply_to_message_id})
LuaTele.deleteMessages(msg.chat_id,{[1]= msg_id})
end
if text == 'تعين الايدي عام' then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:setex(TeleGod.."Redis:Id:Groups"..msg.chat_id..""..msg.sender.user_id,240,true)  
return send(msg_chat_id,msg_id,[[
✦ ارسل الان النص
✦ يمكنك اضافه :
✦ `#username` » اسم المستخدم
✦ `#msgs` » عدد الرسائل
✦ `#photos` » عدد الصور
✦ `#id` » ايدي المستخدم
✦ `#auto` » نسبة التفاعل
✦ `#stast` » رتبة المستخدم 
✦ `#edit` » عدد التعديلات
✦ `#game` » عدد النقاط
✦ `#AddMem` » عدد الجهات
✦ `#Description` » تعليق الصوره
]],"md",true)    
end 
if text == 'حذف الايدي عام' or text == 'مسح الايدي عام' then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(TeleGod.."Set:Id:Groups")
return send(msg_chat_id,msg_id, '✦ تم ازالة كليشة الايدي العامه',"md",true)  
end

if text == 'تعين الايدي' then
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:setex(TeleGod.."Redis:Id:Group"..msg.chat_id..""..msg.sender.user_id,240,true)  
return send(msg_chat_id,msg_id,[[
✦ ارسل الان النص
✦ يمكنك اضافه :
✦ `#username` » اسم المستخدم
✦ `#msgs` » عدد الرسائل
✦ `#photos` » عدد الصور
✦ `#id` » ايدي المستخدم
✦ `#auto` » نسبة التفاعل
✦ `#stast` » رتبة المستخدم 
✦ `#edit` » عدد التعديلات
✦ `#game` » عدد النقاط
✦ `#AddMem` » عدد الجهات
✦ `#Description` » تعليق الصوره
]],"md",true)    
end 
if text == 'حذف الايدي' or text == 'مسح الايدي' then
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(TeleGod.."Set:Id:Group"..msg.chat_id)
return send(msg_chat_id,msg_id, '✦ تم ازالة كليشة الايدي ',"md",true)  
end

if text and text:match("^مسح (.*)$") and msg.reply_to_message_id == 0 then
local TextMsg = text:match("^مسح (.*)$")
if TextMsg == 'المطورين الثانوين' or TextMsg == 'المطورين الثانويين' then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(TeleGod.."Devss:Groups") 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"✦ لا يوجد مطورين ثانوين حاليا , ","md",true)  
end
Redis:del(TeleGod.."Devss:Groups") 
return send(msg_chat_id,msg_id,"*✦ تم مسح {"..#Info_Members.."} من المطورين الثانويين*","md",true)
end
if TextMsg == 'المطورين' then
if not msg.Devss then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(TeleGod.."Dev:Groups") 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"✦ لا يوجد مطورين حاليا , ","md",true)  
end
Redis:del(TeleGod.."Dev:Groups") 
return send(msg_chat_id,msg_id,"*✦ تم مسح {"..#Info_Members.."} من المطورين *","md",true)
end
if TextMsg == 'المنشئين الاساسيين' then
if not msg.Supcreatorm then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص { '..Controller_Num(44)..' }* ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(TeleGod.."Supcreator:Group"..msg_chat_id) 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"✦ لا يوجد منشئين اساسيين حاليا , ","md",true)  
end
Redis:del(TeleGod.."Supcreator:Group"..msg_chat_id) 
return send(msg_chat_id,msg_id,"*✦ تم مسح {"..#Info_Members.."} من المنشؤين الاساسيين *","md",true)
end
if TextMsg == 'المالكين' then
if not msg.Dev then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(3)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(TeleGod.."Supcreator:Group"..msg_chat_id) 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"✦ لا يوجد مالكين حاليا , ","md",true)  
end
Redis:del(TeleGod.."Supcreator:Group"..msg_chat_id) 
return send(msg_chat_id,msg_id,"*✦ تم مسح {"..#Info_Members.."} من المالكين *","md",true)
end
if TextMsg == 'المنشئين' then
if not msg.Supcreator then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(4)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(TeleGod.."Creator:Group"..msg_chat_id) 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"✦ لا يوجد منشئين حاليا , ","md",true)  
end
Redis:del(TeleGod.."Creator:Group"..msg_chat_id) 
return send(msg_chat_id,msg_id,"*✦ تم مسح {"..#Info_Members.."} من المنشئين *","md",true)
end
if TextMsg == 'المدراء' then
if not msg.Creator then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(5)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(TeleGod.."Manger:Group"..msg_chat_id) 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"✦ لا يوجد مدراء حاليا , ","md",true)  
end
Redis:del(TeleGod.."Manger:Group"..msg_chat_id) 
return send(msg_chat_id,msg_id,"*✦ تم مسح {"..#Info_Members.."} من المدراء *","md",true)
end
if TextMsg == 'الادمنيه' then
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(TeleGod.."Admin:Group"..msg_chat_id) 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"✦ لا يوجد ادمنيه حاليا , ","md",true)  
end
Redis:del(TeleGod.."Admin:Group"..msg_chat_id) 
return send(msg_chat_id,msg_id,"*✦ تم مسح {"..#Info_Members.."} من الادمنيه *","md",true)
end
if TextMsg == 'المميزين' then
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(TeleGod.."Special:Group"..msg_chat_id) 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"✦ لا يوجد مميزين حاليا , ","md",true)  
end
Redis:del(TeleGod.."Special:Group"..msg_chat_id) 
return send(msg_chat_id,msg_id,"*✦ تم مسح {"..#Info_Members.."} من المميزين *","md",true)
end
----تسلية----
if TextMsg == 'الكلاب' then
local Info_Members = Redis:smembers(TeleGod.."klb:Group"..msg_chat_id) 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"✦ لا يوجد كلاب حاليا , ","md",true)  
end
Redis:del(TeleGod.."klb:Group"..msg_chat_id) 
return send(msg_chat_id,msg_id,"*✦ تم مسح {"..#Info_Members.."} من الكلاب *","md",true)
end
if TextMsg == 'الخولات' then
local Info_Members = Redis:smembers(TeleGod.."kholat:Group"..msg_chat_id) 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"✦ لا يوجد خولات حاليا , ","md",true)  
end
Redis:del(TeleGod.."kholat:Group"..msg_chat_id) 
return send(msg_chat_id,msg_id,"*✦ تم مسح {"..#Info_Members.."} من الخولات *","md",true)
end
if TextMsg == 'القرود' then
local Info_Members = Redis:smembers(TeleGod.."2rd:Group"..msg_chat_id) 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"✦ لا يوجد قرود حاليا , ","md",true)  
end
Redis:del(TeleGod.."2rd:Group"..msg_chat_id) 
return send(msg_chat_id,msg_id,"*✦ تم مسح {"..#Info_Members.."} من القرود *","md",true)
end
if TextMsg == 'الاغبياء' then
local Info_Members = Redis:smembers(TeleGod.."8by:Group"..msg_chat_id) 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"✦ لا يوجد اغبية حاليا , ","md",true)  
end
Redis:del(TeleGod.."8by:Group"..msg_chat_id) 
return send(msg_chat_id,msg_id,"*✦ تم مسح {"..#Info_Members.."} من الاغبيه *","md",true)
end
if TextMsg == 'العرر' then
local Info_Members = Redis:smembers(TeleGod.."3ra:Group"..msg_chat_id) 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"✦ لا يوجد عرر حاليا , ","md",true)  
end
Redis:del(TeleGod.."3ra:Group"..msg_chat_id) 
return send(msg_chat_id,msg_id,"*✦ تم مسح {"..#Info_Members.."} من العرر *","md",true)
end
if TextMsg == 'السمب' then
local Info_Members = Redis:smembers(TeleGod.."smb:Group"..msg_chat_id) 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"✦ لا يوجد سمباويه حاليا , ","md",true)  
end
Redis:del(TeleGod.."smb:Group"..msg_chat_id) 
return send(msg_chat_id,msg_id,"*✦ تم مسح {"..#Info_Members.."} من السمباويه *","md",true)
end
if TextMsg == 'الحمير' then
local Info_Members = Redis:smembers(TeleGod.."mar:Group"..msg_chat_id) 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"✦ لا يوجد حمير حاليا , ","md",true)  
end
Redis:del(TeleGod.."mar:Group"..msg_chat_id) 
return send(msg_chat_id,msg_id,"*✦ تم مسح {"..#Info_Members.."} من الحمير *","md",true)
end
if TextMsg == 'المتوحدين' then
local Info_Members = Redis:smembers(TeleGod.."twhd:Group"..msg_chat_id) 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"✦ لا يوجد متوحدين حاليا , ","md",true)  
end
Redis:del(TeleGod.."twhd:Group"..msg_chat_id) 
return send(msg_chat_id,msg_id,"*✦ تم مسح {"..#Info_Members.."} من المتوحدين *","md",true)
end
if TextMsg == 'الوتكات' then
local Info_Members = Redis:smembers(TeleGod.."wtka:Group"..msg_chat_id) 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"✦ لا يوجد وتكات حاليا , ","md",true)  
end
Redis:del(TeleGod.."wtka:Group"..msg_chat_id) 
return send(msg_chat_id,msg_id,"*✦ تم مسح {"..#Info_Members.."} من الوتكات *","md",true)
end
----تسلية----
if TextMsg == 'المحظورين عام' then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(TeleGod.."BanAll:Groups") 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"✦ لا يوجد محظورين عام حاليا , ","md",true)  
end
Redis:del(TeleGod.."BanAll:Groups") 
return send(msg_chat_id,msg_id,"*✦ تم مسح {"..#Info_Members.."} من المحظورين عام *","md",true)
end
if TextMsg == 'المكتومين عام' then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(TeleGod.."BanAll:Groups") 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"✦ لا يوجد مكتومين عام حاليا , ","md",true)  
end
Redis:del(TeleGod.."ktmAll:Groups") 
return send(msg_chat_id,msg_id,"*✦ تم مسح {"..#Info_Members.."} من المكتومين عام *","md",true)
end
if TextMsg == 'المحظورين' then
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(TeleGod.."BanGroup:Group"..msg_chat_id) 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"✦ لا يوجد محظورين حاليا , ","md",true)  
end
Redis:del(TeleGod.."BanGroup:Group"..msg_chat_id) 
return send(msg_chat_id,msg_id,"*✦ تم مسح {"..#Info_Members.."} من المحظورين *","md",true)
end
if TextMsg == 'المكتومين' then
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(TeleGod.."SilentGroup:Group"..msg_chat_id) 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"✦ لا يوجد مكتومين حاليا , ","md",true)  
end
Redis:del(TeleGod.."SilentGroup:Group"..msg_chat_id) 
return send(msg_chat_id,msg_id,"*✦ تم مسح {"..#Info_Members.."} من المكتومين *","md",true)
end
if TextMsg == 'المقيدين' then
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if GetInfoBot(msg).BanUser == false then
return send(msg_chat_id,msg_id,'\n*✦ البوت ليس لديه صلاحيه حظر المستخدمين* ',"md",true)  
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*✦ عذرآ البوت ليس ادمن في الجروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
local Info_Members = LuaTele.getSupergroupMembers(msg_chat_id, "Recent", "*", 0, 200)
local List_Members = Info_Members.members
x = 0
for k, v in pairs(List_Members) do
if Info_Members.members[k].status.is_member == true and Info_Members.members[k].status.luatele == "chatMemberStatusRestricted" then
LuaTele.setChatMemberStatus(msg.chat_id,v.member_id.user_id,'restricted',{1,1,1,1,1,1,1,1})
x = x + 1
end
end
return send(msg_chat_id,msg_id,"*✦ تم مسح {"..x.."} من المقيديين *","md",true)
end
if TextMsg == 'البوتات' then
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*✦ عذرآ البوت ليس ادمن في الجروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).BanUser == false then
return send(msg_chat_id,msg_id,'\n*✦ البوت ليس لديه صلاحيه حظر المستخدمين* ',"md",true)  
end
local Info_Members = LuaTele.getSupergroupMembers(msg_chat_id, "Bots", "*", 0, 200)
local List_Members = Info_Members.members
x = 0
for k, v in pairs(List_Members) do
local Ban_Bots = LuaTele.setChatMemberStatus(msg.chat_id,v.member_id.user_id,'banned',0)
if Ban_Bots.luatele == "ok" then
x = x + 1
end
end
return send(msg_chat_id,msg_id,"\n*✦ عدد البوتات الموجوده : "..#List_Members.."\n✦ تم طرد ( "..x.." ) بوت من الجروب *","md",true)  
end
if TextMsg == 'المطرودين' then
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*✦ عذرآ البوت ليس ادمن في الجروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).BanUser == false then
return send(msg_chat_id,msg_id,'\n*✦ البوت ليس لديه صلاحيه حظر المستخدمين* ',"md",true)  
end
local Info_Members = LuaTele.getSupergroupMembers(msg_chat_id, "Banned", "*", 0, 200)
x = 0
local List_Members = Info_Members.members
for k, v in pairs(List_Members) do
UNBan_Bots = LuaTele.setChatMemberStatus(msg.chat_id,v.member_id.user_id,'restricted',{1,1,1,1,1,1,1,1,1})
if UNBan_Bots.luatele == "ok" then
x = x + 1
end
end
return send(msg_chat_id,msg_id,"\n*✦ عدد المطرودين في الجروب : "..#List_Members.."\n✦ تم الغاء الحظر عن ( "..x.." ) من الاشخاص*","md",true)  
end
if TextMsg == 'المحذوفين' then
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*✦ عذرآ البوت ليس ادمن في الجروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
if GetInfoBot(msg).BanUser == false then
return send(msg_chat_id,msg_id,'\n*✦ البوت ليس لديه صلاحيه حظر المستخدمين* ',"md",true)  
end
local Info_Members = LuaTele.searchChatMembers(msg_chat_id, "*", 200)
local List_Members = Info_Members.members
x = 0
for k, v in pairs(List_Members) do
local UserInfo = LuaTele.getUser(v.member_id.user_id)
if UserInfo.type.luatele == "userTypeDeleted" then
local userTypeDeleted = LuaTele.setChatMemberStatus(msg.chat_id,v.member_id.user_id,'banned',0)
if userTypeDeleted.luatele == "ok" then
x = x + 1
end
end
end
return send(msg_chat_id,msg_id,"\n*✦ تم طرد ( "..x.." ) حساب محذوف *","md",true)  
end
end


if text == ("مسح الردود") then
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*✦ هاذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SR_TeleGod'}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local list = Redis:smembers(TeleGod.."List:Manager"..msg_chat_id.."")
for k,v in pairs(list) do
Redis:del(TeleGod.."Add:Rd:Manager:Gif"..v..msg_chat_id)   
Redis:del(TeleGod.."Add:Rd:Manager:Vico"..v..msg_chat_id)   
Redis:del(TeleGod.."Add:Rd:Manager:Stekrs"..v..msg_chat_id)     
Redis:del(TeleGod.."Add:Rd:Manager:Text"..v..msg_chat_id)   
Redis:del(TeleGod.."Add:Rd:Manager:Photo"..v..msg_chat_id)
Redis:del(TeleGod.."Add:Rd:Manager:Photoc"..v..msg_chat_id)
Redis:del(TeleGod.."Add:Rd:Manager:Video"..v..msg_chat_id)
Redis:del(TeleGod.."Add:Rd:Manager:Videoc"..v..msg_chat_id)  
Redis:del(TeleGod.."Add:Rd:Manager:File"..v..msg_chat_id)
Redis:del(TeleGod.."Add:Rd:Manager:video_note"..v..msg_chat_id)
Redis:del(TeleGod.."Add:Rd:Manager:Audio"..v..msg_chat_id)
Redis:del(TeleGod.."Add:Rd:Manager:Audioc"..v..msg_chat_id)
Redis:del(TeleGod.."List:Manager"..msg_chat_id)
end
return send(msg_chat_id,msg_id,"✦ تم مسح قائمه الردود","md",true)  
end
if text == ("الردود") then
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*✦ هاذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SR_TeleGod'}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local list = Redis:smembers(TeleGod.."List:Manager"..msg_chat_id.."")
text = "✦ قائمه الردود \n⩹━━━━✦ 𝗧𝗘𝗟𝗘𝗚𝗢𝗗 ✦ ━━━━⩺\n"
for k,v in pairs(list) do
if Redis:get(TeleGod.."Add:Rd:Manager:Gif"..v..msg_chat_id) then
db = "متحركه ✦ "
elseif Redis:get(TeleGod.."Add:Rd:Manager:Vico"..v..msg_chat_id) then
db = "بصمه ✦ "
elseif Redis:get(TeleGod.."Add:Rd:Manager:Stekrs"..v..msg_chat_id) then
db = "ملصق ✦ "
elseif Redis:get(TeleGod.."Add:Rd:Manager:Text"..v..msg_chat_id) then
db = "رساله ✦ "
elseif Redis:get(TeleGod.."Add:Rd:Manager:Photo"..v..msg_chat_id) then
db = "صوره ✦ "
elseif Redis:get(TeleGod.."Add:Rd:Manager:Video"..v..msg_chat_id) then
db = "فيديو ✦ "
elseif Redis:get(TeleGod.."Add:Rd:Manager:File"..v..msg_chat_id) then
db = "ملف ✦ "
elseif Redis:get(TeleGod.."Add:Rd:Manager:Audio"..v..msg_chat_id) then
db = "اغنيه ✦ "
elseif Redis:get(TeleGod.."Add:Rd:Manager:video_note"..v..msg_chat_id) then
db = "بصمه فيديو ✦ "
end
text = text..""..k.." » {"..v.."} » {"..db.."}\n"
end
if #list == 0 then
text = "✦ عذرا لا يوجد ردود للمدير في الجروب"
end
return send(msg_chat_id,msg_id,"["..text.."]","md",true)  
end
if text == "اضف رد" then
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هاذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
Redis:set(TeleGod.."Set:Manager:rd"..msg.sender.user_id..":"..msg_chat_id,true)
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = 'الغاء الامر', data = msg.sender.user_id..'/cancelrdd'},
},
}
}
return send(msg_chat_id,msg_id,"✦ ارسل الان الكلمه لاضافتها في الردود ","md",false, false, false, false, reply_markup)
end
-- sex
if text == ("مسح الردود الانلاين") then
  if not msg.Manger then
  return send(msg_chat_id,msg_id,'\n*✦ هاذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
  end
  if ChannelJoin(msg) == false then
  local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SR_TeleGod'}, },}}
  return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
  end
  local list = Redis:smembers(TeleGod.."List:Manager:inline"..msg_chat_id.."")
  for k,v in pairs(list) do
      Redis:del(TeleGod.."Add:Rd:Manager:Gif:inline"..v..msg_chat_id)   
      Redis:del(TeleGod.."Add:Rd:Manager:Vico:inline"..v..msg_chat_id)   
      Redis:del(TeleGod.."Add:Rd:Manager:Stekrs:inline"..v..msg_chat_id)     
      Redis:del(TeleGod.."Add:Rd:Manager:Text:inline"..v..msg_chat_id)   
      Redis:del(TeleGod.."Add:Rd:Manager:Photo:inline"..v..msg_chat_id)
      Redis:del(TeleGod.."Add:Rd:Manager:Photoc:inline"..v..msg_chat_id)
      Redis:del(TeleGod.."Add:Rd:Manager:Video:inline"..v..msg_chat_id)
      Redis:del(TeleGod.."Add:Rd:Manager:Videoc:inline"..v..msg_chat_id)  
      Redis:del(TeleGod.."Add:Rd:Manager:File:inline"..v..msg_chat_id)
      Redis:del(TeleGod.."Add:Rd:Manager:video_note:inline"..v..msg_chat_id)
      Redis:del(TeleGod.."Add:Rd:Manager:Audio:inline"..v..msg_chat_id)
      Redis:del(TeleGod.."Add:Rd:Manager:Audioc:inline"..v..msg_chat_id)
      Redis:del(TeleGod.."Rd:Manager:inline:v"..v..msg_chat_id)
      Redis:del(TeleGod.."Rd:Manager:inline:link"..v..msg_chat_id)
  Redis:del(TeleGod.."List:Manager:inline"..msg_chat_id)
  end
  return send(msg_chat_id,msg_id,"✦ تم مسح قائمه الانلاين","md",true)  
  end
if text == "اضف رد انلاين" then
  if not msg.Admin then
  return send(msg_chat_id,msg_id,'\n*✦ هاذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
  end
  if otlop(msg) == false then
local chinfo = Redis:get("ch:admin:3am")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
  Redis:set(TeleGod.."Set:Manager:rd:inline"..msg.sender.user_id..":"..msg_chat_id,true)
  local reply_markup = LuaTele.replyMarkup{
  type = 'inline',
  data = {
  {
  {text = 'الغاء الامر', data = msg.sender.user_id..'/cancelrdd'},
  },
  }
  }
  return send(msg_chat_id,msg_id,"✦ ارسل الان الكلمه لاضافتها في الردود ","md",false, false, false, false, reply_markup)
end
if text and text:match("^(.*)$") and tonumber(msg.sender.user_id) ~= tonumber(TeleGod) then
  if Redis:get(TeleGod.."Set:Manager:rd:inline"..msg.sender.user_id..":"..msg_chat_id) == "true" then
  Redis:set(TeleGod.."Set:Manager:rd:inline"..msg.sender.user_id..":"..msg_chat_id,"true1")
  Redis:set(TeleGod.."Text:Manager:inline"..msg.sender.user_id..":"..msg_chat_id, text)
  Redis:del(TeleGod.."Add:Rd:Manager:Gif:inline"..text..msg_chat_id)   
  Redis:del(TeleGod.."Add:Rd:Manager:Vico:inline"..text..msg_chat_id)   
  Redis:del(TeleGod.."Add:Rd:Manager:Stekrs:inline"..text..msg_chat_id)     
  Redis:del(TeleGod.."Add:Rd:Manager:Text:inline"..text..msg_chat_id)   
  Redis:del(TeleGod.."Add:Rd:Manager:Photo:inline"..text..msg_chat_id)
  Redis:del(TeleGod.."Add:Rd:Manager:Photoc:inline"..text..msg_chat_id)
  Redis:del(TeleGod.."Add:Rd:Manager:Video:inline"..text..msg_chat_id)
  Redis:del(TeleGod.."Add:Rd:Manager:Videoc:inline"..text..msg_chat_id)  
  Redis:del(TeleGod.."Add:Rd:Manager:File:inline"..text..msg_chat_id)
  Redis:del(TeleGod.."Add:Rd:Manager:video_note:inline"..text..msg_chat_id)
  Redis:del(TeleGod.."Add:Rd:Manager:Audio:inline"..text..msg_chat_id)
  Redis:del(TeleGod.."Add:Rd:Manager:Audioc:inline"..text..msg_chat_id)
  Redis:del(TeleGod.."Rd:Manager:inline:text"..text..msg_chat_id)
  Redis:del(TeleGod.."Rd:Manager:inline:link"..text..msg_chat_id)
  Redis:sadd(TeleGod.."List:Manager:inline"..msg_chat_id.."", text)
  send(msg_chat_id,msg_id,[[
  ↯︙ارسل لي الرد سواء كان 
  ❨ ملف ، ملصق ، متحركه ، صوره
   ، فيديو ، بصمه الفيديو ، بصمه ، صوت ، رساله ❩
  ↯︙يمكنك اضافة الى النص ✦ 
  ⩹━━━━✦ 𝗧𝗘𝗟𝗘𝗚𝗢𝗗 ✦ ━━━━⩺
   `#username` ↬ معرف المستخدم
   `#msgs` ↬ عدد الرسائل
   `#name` ↬ اسم المستخدم
   `#id` ↬ ايدي المستخدم
   `#stast` ↬ رتبة المستخدم
   `#edit` ↬ عدد التعديلات
  
  ]],"md",true)  
  return false
  end
  end
if Redis:get(TeleGod.."Set:Manager:rd:inline"..msg.sender.user_id..":"..msg_chat_id) == "true1" and tonumber(msg.sender.user_id) ~= tonumber(TeleGod) then
Redis:del(TeleGod.."Set:Manager:rd:inline"..msg.sender.user_id..":"..msg_chat_id)
Redis:set(TeleGod.."Set:Manager:rd:inline"..msg.sender.user_id..":"..msg_chat_id,"set_inline")
if text or msg.content.video_note or msg.content.document or msg.content.audio or msg.content.video or msg.content.voice_note or msg.content.sticker or msg.content.animation or msg.content.photo then
local anubis = Redis:get(TeleGod.."Text:Manager:inline"..msg.sender.user_id..":"..msg_chat_id)
if msg.content.text then   
text = text:gsub('"',"") 
text = text:gsub('"',"") 
text = text:gsub("`","") 
text = text:gsub("*","") 
Redis:set(TeleGod.."Add:Rd:Manager:Text:inline"..anubis..msg_chat_id, text)
elseif msg.content.sticker then   
Redis:set(TeleGod.."Add:Rd:Manager:Stekrs:inline"..anubis..msg_chat_id, msg.content.sticker.sticker.remote.id)  
elseif msg.content.voice_note then  
Redis:set(TeleGod.."Add:Rd:Manager:Vico:inline"..anubis..msg_chat_id, msg.content.voice_note.voice.remote.id)  
elseif msg.content.audio then
Redis:set(TeleGod.."Add:Rd:Manager:Audio:inline"..anubis..msg_chat_id, msg.content.audio.audio.remote.id)  
Redis:set(TeleGod.."Add:Rd:Manager:Audioc:inline"..anubis..msg_chat_id, msg.content.caption.text)  
elseif msg.content.document then
Redis:set(TeleGod.."Add:Rd:Manager:File:inline"..anubis..msg_chat_id, msg.content.document.document.remote.id)  
elseif msg.content.animation then
Redis:set(TeleGod.."Add:Rd:Manager:Gif:inline"..anubis..msg_chat_id, msg.content.animation.animation.remote.id)  
elseif msg.content.video_note then
Redis:set(TeleGod.."Add:Rd:Manager:video_note:inline"..anubis..msg_chat_id, msg.content.video_note.video.remote.id)  
elseif msg.content.video then
Redis:set(TeleGod.."Add:Rd:Manager:Video:inline"..anubis..msg_chat_id, msg.content.video.video.remote.id)  
Redis:set(TeleGod.."Add:Rd:Manager:Videoc:inline"..anubis..msg_chat_id, msg.content.caption.text)  
elseif msg.content.photo then
if msg.content.photo.sizes[1].photo.remote.id then
idPhoto = msg.content.photo.sizes[1].photo.remote.id
elseif msg.content.photo.sizes[2].photo.remote.id then
idPhoto = msg.content.photo.sizes[2].photo.remote.id
elseif msg.content.photo.sizes[3].photo.remote.id then
idPhoto = msg.content.photo.sizes[3].photo.remote.id
end
Redis:set(TeleGod.."Add:Rd:Manager:Photo:inline"..anubis..msg_chat_id, idPhoto)  
Redis:set(TeleGod.."Add:Rd:Manager:Photoc:inline"..anubis..msg_chat_id, msg.content.caption.text)  
end
send(msg_chat_id,msg_id,"✦ الان ارسل الكلام داخل الزر","md",true)  
return false  
end  
end
if text and Redis:get(TeleGod.."Set:Manager:rd:inline"..msg.sender.user_id..":"..msg_chat_id) == "set_inline" then
Redis:set(TeleGod.."Set:Manager:rd:inline"..msg.sender.user_id..":"..msg_chat_id, "set_link")
local anubis = Redis:get(TeleGod.."Text:Manager:inline"..msg.sender.user_id..":"..msg_chat_id)
Redis:set(TeleGod.."Rd:Manager:inline:text"..anubis..msg_chat_id, text)
send(msg_chat_id,msg_id,"✦ الان ارسل الرابط","md",true)  
return false  
end
if text and Redis:get(TeleGod.."Set:Manager:rd:inline"..msg.sender.user_id..":"..msg_chat_id) == "set_link" then
Redis:del(TeleGod.."Set:Manager:rd:inline"..msg.sender.user_id..":"..msg_chat_id)
local anubis = Redis:get(TeleGod.."Text:Manager:inline"..msg.sender.user_id..":"..msg_chat_id)
Redis:set(TeleGod.."Rd:Manager:inline:link"..anubis..msg_chat_id, text)
send(msg_chat_id,msg_id,"✦ تم اضافه الرد بنجاح","md",true)  
return false  
end
if text and not Redis:get(TeleGod.."Status:Reply:inline"..msg_chat_id) then
local btext = Redis:get(TeleGod.."Rd:Manager:inline:text"..text..msg_chat_id)
local blink = Redis:get(TeleGod.."Rd:Manager:inline:link"..text..msg_chat_id)
local anemi = Redis:get(TeleGod.."Add:Rd:Manager:Gif:inline"..text..msg_chat_id)   
local veico = Redis:get(TeleGod.."Add:Rd:Manager:Vico:inline"..text..msg_chat_id)   
local stekr = Redis:get(TeleGod.."Add:Rd:Manager:Stekrs:inline"..text..msg_chat_id)     
local Texingt = Redis:get(TeleGod.."Add:Rd:Manager:Text:inline"..text..msg_chat_id)   
local photo = Redis:get(TeleGod.."Add:Rd:Manager:Photo:inline"..text..msg_chat_id)
local photoc = Redis:get(TeleGod.."Add:Rd:Manager:Photoc:inline"..text..msg_chat_id)
local video = Redis:get(TeleGod.."Add:Rd:Manager:Video:inline"..text..msg_chat_id)
local videoc = Redis:get(TeleGod.."Add:Rd:Manager:Videoc:inline"..text..msg_chat_id)  
local document = Redis:get(TeleGod.."Add:Rd:Manager:File:inline"..text..msg_chat_id)
local audio = Redis:get(TeleGod.."Add:Rd:Manager:Audio:inline"..text..msg_chat_id)
local audioc = Redis:get(TeleGod.."Add:Rd:Manager:Audioc:inline"..text..msg_chat_id)
local video_note = Redis:get(TeleGod.."Add:Rd:Manager:video_note:inline"..text..msg_chat_id)
local reply_markup = LuaTele.replyMarkup{
  type = 'inline',
  data = {
  {
  {text = btext , url = blink},
  },
  }
  }
if Texingt then 
local UserInfo = LuaTele.getUser(msg.sender.user_id)
local NumMsg = Redis:get(TeleGod..'Num:Message:User'..msg_chat_id..':'..msg.sender.user_id) or 0
local TotalMsg = Total_message(NumMsg) 
local Status_Gps = msg.Name_Controller
local NumMessageEdit = Redis:get(TeleGod..'Num:Message:Edit'..msg_chat_id..msg.sender.user_id) or 0
local Texingt = Texingt:gsub('#username',(UserInfo.username or 'لا يوجد')) 
local Texingt = Texingt:gsub('#name',UserInfo.first_name)
local Texingt = Texingt:gsub('#id',msg.sender.user_id)
local Texingt = Texingt:gsub('#edit',NumMessageEdit)
local Texingt = Texingt:gsub('#msgs',NumMsg)
local Texingt = Texingt:gsub('#stast',Status_Gps)
send(msg_chat_id,msg_id,'['..Texingt..']',"md",false, false, false, false, reply_markup)  
end
if video_note then
LuaTele.sendVideoNote(msg_chat_id, msg.id, video_note, nil, nil, nil, nil, nil, nil, nil, reply_markup)
end
if photo then
LuaTele.sendPhoto(msg.chat_id, msg.id, photo,photoc,"md", true, nil, nil, nil, nil, nil, nil, nil, nil, reply_markup )
end  
if stekr then 
LuaTele.sendSticker(msg_chat_id, msg.id, stekr,nil,nil,nil,nil,nil,nil,nil,reply_markup)
end
if veico then 
LuaTele.sendVoiceNote(msg_chat_id, msg.id, veico, '', 'md',nil, nil, nil, nil, reply_markup)
end
if video then 
LuaTele.sendVideo(msg_chat_id, msg.id, video, videoc, "md", true, nil, nil, nil, nil, nil, nil, nil, nil, nil, reply_markup)
end
if anemi then 
LuaTele.sendAnimation(msg_chat_id,msg.id, anemi, '', 'md', nil, nil, nil, nil, nil, nil, nil, nil,reply_markup)
end
if document then
LuaTele.sendDocument(msg_chat_id, msg.id, document, '', 'md',nil, nil, nil, nil,nil, reply_markup)
end  
if audio then
LuaTele.sendAudio(msg_chat_id, msg.id, audio, audioc, "md", nil, nil, nil, nil, nil, nil, nil, nil,reply_markup) 
end
end
if text == "حذف رد انلاين" then
  if not msg.Admin then
  return send(msg_chat_id,msg_id,'\n*✦ هاذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
  end
  if ChannelJoin(msg) == false then
  local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SR_TeleGod'}, },}}
  return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
  end
  local reply_markup = LuaTele.replyMarkup{
  type = 'inline',
  data = {
  {
  {text = 'الغاء الامر', data = msg.sender.user_id..'/cancelrdd'},
  },
  }
  }
  Redis:set(TeleGod.."Set:Manager:rd:inline"..msg.sender.user_id..":"..msg_chat_id,"true2")
  return send(msg_chat_id,msg_id,"✦ ارسل الان الكلمه لحذفها من الردود الانلاين","md",false, false, false, false, reply_markup)
  end 
if text and text:match("^(.*)$") then
if Redis:get(TeleGod.."Set:Manager:rd:inline"..msg.sender.user_id..":"..msg_chat_id.."") == "true2" then
  Redis:del(TeleGod.."Add:Rd:Manager:Gif:inline"..text..msg_chat_id)   
  Redis:del(TeleGod.."Add:Rd:Manager:Vico:inline"..text..msg_chat_id)   
  Redis:del(TeleGod.."Add:Rd:Manager:Stekrs:inline"..text..msg_chat_id)     
  Redis:del(TeleGod.."Add:Rd:Manager:Text:inline"..text..msg_chat_id)   
  Redis:del(TeleGod.."Add:Rd:Manager:Photo:inline"..text..msg_chat_id)
  Redis:del(TeleGod.."Add:Rd:Manager:Photoc:inline"..text..msg_chat_id)
  Redis:del(TeleGod.."Add:Rd:Manager:Video:inline"..text..msg_chat_id)
  Redis:del(TeleGod.."Add:Rd:Manager:Videoc:inline"..text..msg_chat_id)  
  Redis:del(TeleGod.."Add:Rd:Manager:File:inline"..text..msg_chat_id)
  Redis:del(TeleGod.."Add:Rd:Manager:video_note:inline"..text..msg_chat_id)
  Redis:del(TeleGod.."Add:Rd:Manager:Audio:inline"..text..msg_chat_id)
  Redis:del(TeleGod.."Add:Rd:Manager:Audioc:inline"..text..msg_chat_id)
  Redis:del(TeleGod.."Rd:Manager:inline:text"..text..msg_chat_id)
  Redis:del(TeleGod.."Rd:Manager:inline:link"..text..msg_chat_id)
Redis:del(TeleGod.."Set:Manager:rd:inline"..msg.sender.user_id..":"..msg_chat_id.."")
Redis:srem(TeleGod.."List:Manager:inline"..msg_chat_id.."", text)
send(msg_chat_id,msg_id,"✦ تم حذف الرد من الردود الانلاين ","md",true)  
return false
end
end
if text == ("الردود الانلاين") then
  if not msg.Manger then
  return send(msg_chat_id,msg_id,'\n*✦ هاذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
  end
  if ChannelJoin(msg) == false then
  local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SR_TeleGod'}, },}}
  return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
  end
  local list = Redis:smembers(TeleGod.."List:Manager:inline"..msg_chat_id.."")
  text = "✦ قائمه الردود الانلاين \n⩹━━━━✦ 𝗧𝗘𝗟𝗘𝗚𝗢𝗗 ✦ ━━━━⩺\n"
  for k,v in pairs(list) do
  if Redis:get(TeleGod.."Add:Rd:Manager:Gif:inline"..v..msg_chat_id) then
  db = "متحركه ✦ "
  elseif Redis:get(TeleGod.."Add:Rd:Manager:Vico:inline"..v..msg_chat_id) then
  db = "بصمه ✦ "
  elseif Redis:get(TeleGod.."Add:Rd:Manager:Stekrs:inline"..v..msg_chat_id) then
  db = "ملصق ✦ "
  elseif Redis:get(TeleGod.."Add:Rd:Manager:Text:inline"..v..msg_chat_id) then
  db = "رساله ✦ "
  elseif Redis:get(TeleGod.."Add:Rd:Manager:Photo:inline"..v..msg_chat_id) then
  db = "صوره ✦ "
  elseif Redis:get(TeleGod.."Add:Rd:Manager:Video:inline"..v..msg_chat_id) then
  db = "فيديو ✦ "
  elseif Redis:get(TeleGod.."Add:Rd:Manager:File:inline"..v..msg_chat_id) then
  db = "ملف ✦ "
  elseif Redis:get(TeleGod.."Add:Rd:Manager:Audio:inline"..v..msg_chat_id) then
  db = "اغنيه ✦ "
  elseif Redis:get(TeleGod.."Add:Rd:Manager:video_note:inline"..v..msg_chat_id) then
  db = "بصمه فيديو ✦ "
  end
  text = text..""..k.." » {"..v.."} » {"..db.."}\n"
  end
  if #list == 0 then
  text = "✦ عذرا لا يوجد ردود انلاين في الجروب"
  end
  return send(msg_chat_id,msg_id,"["..text.."]","md",true)  
  end
-- zwag 
if text == "زواج" or text == "رفع زوجتي" or text == "رفع زوجي" and msg.reply_to_message_id ~= 0 then
  local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
  local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
  if tonumber(Message_Reply.sender.user_id) == tonumber(msg.sender.user_id) then
    return send(msg_chat_id,msg_id,"انت اهبل يبني عاوز تتجوز نفسك ؟ هتتكاثر ازاي طيب ؟!!","md",true)  
  end
  if tonumber(Message_Reply.sender.user_id) == tonumber(TeleGod) then
    return send(msg_chat_id,msg_id,"ابعد عني يحيحان ملكقتش غيري","md",true)  
  end
  if Redis:sismember(TeleGod..msg_chat_id.."zwgat:",Message_Reply.sender.user_id) then
    local rd_mtzwga = {
      "اسف يصحبي متجوزه",
      "متجوزه يبن عمي شفلك واحده تانيه",
      "يبني متجوزه اجوزهاشلك ازاي انا",
      "للاسف متجوزه بس  لو العمليه جايبه اخرها شوف واحده تانيه",
      "يادي الكسفه طلعت متجوزه قبلك"
    }
    return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,rd_mtzwga[math.random(#rd_mtzwga)]).Reply,"md",true)  
    else
      local rd_zwag = {
        "تم زواجك منه وبارك الله لكم وعليكم",
        "لولولولويي تم الزواج عقبال العيال بقا",
        "مبروك اتجوزتها عاوز اتغدا بقا في الفرح",
        "تم زواجكم... ودا رقمي عشان لو العريس معرفش يسد 012345..",
        "الزواج تم اتفضلو اعملو احلا واحد بقا هيهيهي"
      }
    if Redis:sismember(TeleGod..msg_chat_id.."mutlqat:",Message_Reply.sender.user_id) then 
    Redis:srem(TeleGod..msg_chat_id.."mutlqat:",Message_Reply.sender.user_id)
    end
    Redis:sadd(TeleGod..msg_chat_id.."zwgat:",Message_Reply.sender.user_id) 
    return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,rd_zwag[math.random(#rd_zwag)]).Reply,"md",true)  
    end
end
if text == "تاك للزوجات" or text == "الزوجات" then
  local zwgat_list = Redis:smembers(TeleGod..msg_chat_id.."zwgat:")
  if #zwgat_list == 0 then 
    return send(msg_chat_id,msg_id,'✦ لايوجد زوجات',"md",true) 
  end 
  local zwga_list = "✦ عدد الزوجات : "..#zwgat_list.."\n✦ الزوجات :\n⩹━━━━✦ 𝗧𝗘𝗟𝗘𝗚𝗢𝗗 ✦ ━━━━⩺\n"
  for k, v in pairs(zwgat_list) do
    local UserInfo = LuaTele.getUser(v)
    local zwga_name = UserInfo.first_name
    local zwga_tag = '['..zwga_name..'](tg://user?id='..v..')'
    zwga_list = zwga_list.."- "..zwga_tag.."\n"
  end
  return send(msg_chat_id,msg_id,zwga_list,"md",true) 
end
-- tlaq
if text == "طلاق" or text == "تنزيل زوجتي" or text == "تزيل زوجي" and msg.reply_to_message_id ~= 0 then
  local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
  local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
  if tonumber(Message_Reply.sender.user_id) == tonumber(msg.sender.user_id) then
    return send(msg_chat_id,msg_id,"احا هو انت كنت اتجوزت نفسك عشان تطلق","md",true)  
  end
  if tonumber(Message_Reply.sender.user_id) == tonumber(TeleGod) then
    return send(msg_chat_id,msg_id,"هو احنا كنا اتجوزنا يروح خالتك عشان نطلق","md",true)  
  end
  if Redis:sismember(TeleGod..msg_chat_id.."zwgat:",Message_Reply.sender.user_id) then
    Redis:srem(TeleGod..msg_chat_id.."zwgat:",Message_Reply.sender.user_id)
    Redis:sadd(TeleGod..msg_chat_id.."mutlqat:",Message_Reply.sender.user_id) 
    local rd_tmtlaq = {
      "تم طلاقكم للاسف",
      "تم الطلاق بلص ام عبير عاوزه تعرف اتطلقتو لي ؟",
      "تم الطلاق عشان المعلم مبيعرفش",
      "تم الطلاق عشان في سوسه دخلت وسطهم",
      "تم الطلاق بلص دا رقمي عشان لو حبيتي نتكلم باحترام 01234..."
    }
    return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,rd_tmtlaq[math.random(#rd_tmtlaq)]).Reply,"md",true)  
    else
      local rd_tlaq = {
        "مكنتش اتجوزت عشان تطلق اصلا",
        "بايره محدش اتجوزها",
        "محدش عبرها قبل كدا اسسن"
      }
    return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,rd_tlaq[math.random(#rd_tlaq)]).Reply,"md",true)  
    end
end
if text == "تاك للمطلقات" or text == "المطلقات" then
  local mutlqat_list = Redis:smembers(TeleGod..msg_chat_id.."mutlqat:")
  if #mutlqat_list == 0 then 
    return send(msg_chat_id,msg_id,'✦ لايوجد مطلقات',"md",true) 
  end 
  local mutlqa_list = "✦ عدد المطلقات : "..#mutlqat_list.."\n✦ المطلقات :\n⩹━━━━✦ 𝗧𝗘𝗟𝗘𝗚𝗢𝗗 ✦ ━━━━⩺\n"
  for k, v in pairs(mutlqat_list) do
    local UserInfo = LuaTele.getUser(v)
    local mutlqa_name = UserInfo.first_name
    local mutlqa_tag = '['..mutlqa_name..'](tg://user?id='..v..')'
    mutlqa_list = mutlqa_list.."- "..mutlqa_tag.."\n"
  end
  return send(msg_chat_id,msg_id,mutlqa_list,"md",true) 
end
-- kit defullt
if text == "استيراد كت السورس" then
if Redis:get(TeleGod.."kit_defullt:") == "true" then
    Redis:set(TeleGod.."kit_defullt:","false")
    local d_kit = {"اخر افلام شاهدتها", 
"اخر افلام شاهدتها", 
"ما هي وظفتك الحياه", 
"اعز اصدقائك ?", 
"اخر اغنية سمعتها ?", 
"تكلم عن نفسك", 
"ليه انت مش سالك", 
"ما هيا عيوب سورس تلي جود؟ ", 
"اخر كتاب قرآته", 
"روايتك المفضله ?", 
"اخر اكله اكلتها", 
"اخر كتاب قرآته", 
"ليش حسين ذكي؟ ", 
"افضل يوم ف حياتك", 
"ليه مضيفتش كل جهاتك", 
"حكمتك ف الحياه", 
"لون عيونك", 
"كتابك المفضل", 
"هوايتك المفضله", 
"علاقتك مع اهلك", 
" ما السيء في هذه الحياة ؟ ", 
"أجمل شيء حصل معك خلال هذا الاسبوع ؟ ", 
"سؤال ينرفزك ؟ ", 
" هل يعجبك سورس تلي جود؟ ", 
" اكثر ممثل تحبه ؟ ", 
"قد تخيلت شي في بالك وصار ؟ ", 
"شيء عندك اهم من الناس ؟ ", 
"تفضّل النقاش الطويل او تحب الاختصار ؟ ", 
"وش أخر شي ضيعته؟ ", 
"اي رايك في سورس تلي جود؟ ", 
"كم مره حبيت؟ ", 
" اكثر المتابعين عندك باي برنامج؟", 
" نسبه الندم عندك للي وثقت فيهم ؟", 
"تحب ترتبط بكيرفي ولا فلات؟", 
" جربت شعور احد يحبك بس انت مو قادر تحبه؟", 
" تجامل الناس ولا اللي بقلبك على لسانك؟", 
" عمرك ضحيت باشياء لاجل شخص م يسوى ؟", 
"مغني تلاحظ أن صوته يعجب الجميع إلا أنت؟ ", 
" آخر غلطات عمرك؟ ", 
" مسلسل كرتوني له ذكريات جميلة عندك؟ ", 
" ما أكثر تطبيق تقضي وقتك عليه؟ ", 
" أول شيء يخطر في بالك إذا سمعت كلمة نجوم ؟ ", 
" قدوتك من الأجيال السابقة؟ ", 
" أكثر طبع تهتم بأن يتواجد في شريك/ة حياتك؟ ", 
"أكثر حيوان تخاف منه؟ ", 
" ما هي طريقتك في الحصول على الراحة النفسية؟ ", 
" إيموجي يعبّر عن مزاجك الحالي؟ ", 
" أكثر تغيير ترغب أن تغيّره في نفسك؟ ", 
"أكثر شيء أسعدك اليوم؟ ", 
"اي رايك في الدنيا دي ؟ ", 
"ما هو أفضل حافز للشخص؟ ", 
"ما الذي يشغل بالك في الفترة الحالية؟", 
"آخر شيء ندمت عليه؟ ", 
"شاركنا صورة احترافية من تصويرك؟ ", 
"تتابع انمي؟ إذا نعم ما أفضل انمي شاهدته ", 
"يرد عليك متأخر على رسالة مهمة وبكل برود، موقفك؟ ", 
"نصيحه تبدا ب -لا- ؟ ", 
"كتاب أو رواية تقرأها هذه الأيام؟ ", 
"فيلم عالق في ذهنك لا تنساه مِن روعته؟ ", 
"يوم لا يمكنك نسيانه؟ ", 
"شعورك الحالي في جملة؟ ", 
"كلمة لشخص بعيد؟ ", 
"صفة يطلقها عليك الشخص المفضّل؟ ", 
"أغنية عالقة في ذهنك هاليومين؟ ", 
"أكلة مستحيل أن تأكلها؟ ", 
"كيف قضيت نهارك؟ ", 
"تصرُّف ماتتحمله؟ ", 
"موقف غير حياتك؟ ", 
"اكثر مشروب تحبه؟ ", 
"القصيدة اللي تأثر فيك؟ ", 
"متى يصبح الصديق غريب ", 
"وين نلقى السعاده برايك؟ ", 
"تاريخ ميلادك؟ ", 
"قهوه و لا شاي؟ ", 
"من محبّين الليل أو الصبح؟ ", 
"حيوانك المفضل؟ ", 
"كلمة غريبة ومعناها؟ ", 
"كم تحتاج من وقت لتثق بشخص؟ ", 
"اشياء نفسك تجربها؟ ", 
"يومك ضاع على؟ ", 
"كل شيء يهون الا ؟ ", 
"اسم ماتحبه ؟ ", 
"وقفة إحترام للي إخترع ؟ ", 
"أقدم شيء محتفظ فيه من صغرك؟ ", 
"كلمات ماتستغني عنها بسوالفك؟ ", 
"وش الحب بنظرك؟ ", 
"حب التملك في شخصِيـتك ولا ؟ ", 
"تخطط للمستقبل ولا ؟ ", 
"موقف محرج ماتنساه ؟ ", 
"من طلاسم لهجتكم ؟ ", 
"اعترف باي حاجه ؟ ", 
"عبّر عن مودك بصوره ؟ ",
"اسم دايم ع بالك ؟ ", 
"اشياء تفتخر انك م سويتها ؟ ", 
" لو بكيفي كان ؟ ", 
  "أكثر جملة أثرت بك في حياتك؟ ",
  "إيموجي يوصف مزاجك حاليًا؟ ",
  "أجمل اسم بنت بحرف الباء؟ ",
  "كيف هي أحوال قلبك؟ ",
  "أجمل مدينة؟ ",
  "كيف كان أسبوعك؟ ",
  "شيء تشوفه اكثر من اهلك ؟ ",
  "اخر مره فضفضت؟ ",
  "قد كرهت احد بسبب اسلوبه؟ ",
  "قد حبيت شخص وخذلك؟ ",
  "كم مره حبيت؟ ",
  "اكبر غلطة بعمرك؟ ",
  "نسبة النعاس عندك حاليًا؟ ",
  "شرايكم بمشاهير التيك توك؟ ",
  "ما الحاسة التي تريد إضافتها للحواس الخمسة؟ ",
  "اسم قريب لقلبك؟ ",
  "مشتاق لمطعم كنت تزوره قبل الحظر؟ ",
  "أول شيء يخطر في بالك إذا سمعت كلمة (ابوي يبيك)؟ ",
  "ما أول مشروع تتوقع أن تقوم بإنشائه إذا أصبحت مليونير؟ ",
  "أغنية عالقة في ذهنك هاليومين؟ ",
  "متى اخر مره قريت قرآن؟ ",
  "كم صلاة فاتتك اليوم؟ ",
  "تفضل التيكن او السنقل؟ ",
  "وش أفضل بوت برأيك؟ ",
"كم لك بالتلي؟ ",
"وش الي تفكر فيه الحين؟ ",
"كيف تشوف الجيل ذا؟ ",
"منشن شخص وقوله، تحبني؟ ",
"لو جاء شخص وعترف لك كيف ترده؟ ",
"مر عليك موقف محرج؟ ",
"وين تشوف نفسك بعد سنتين؟ ",
"لو فزعت/ي لصديق/ه وقالك مالك دخل وش بتسوي/ين؟ ",
"وش اجمل لهجة تشوفها؟ ",
"قد سافرت؟ ",
"افضل مسلسل عندك؟ ",
"افضل فلم عندك؟ ",
"مين اكثر يخون البنات/العيال؟ ",
"متى حبيت؟ ",
  "بالعادة متى تنام؟ ",
  "شيء من صغرك ماتغيير فيك؟ ",
  "شيء بسيط قادر يعدل مزاجك بشكل سريع؟ ",
  "تشوف الغيره انانيه او حب؟ ",
"حاجة تشوف نفسك مبدع فيها؟ ",
  "مع او ضد : يسقط جمال المراة بسبب قبح لسانها؟ ",
  "عمرك بكيت على شخص مات في مسلسل ؟ ",
  "‏- هل تعتقد أن هنالك من يراقبك بشغف؟ ",
  "تدوس على قلبك او كرامتك؟ ",
  "اكثر لونين تحبهم مع بعض؟ ",
  "مع او ضد : النوم افضل حل لـ مشاكل الحياة؟ ",
  "سؤال دايم تتهرب من الاجابة عليه؟ ",
  "تحبني ولاتحب الفلوس؟ ",
  "العلاقه السريه دايماً تكون حلوه؟ ",
  "لو أغمضت عينيك الآن فما هو أول شيء ستفكر به؟ ",
"كيف ينطق الطفل اسمك؟ ",
  "ما هي نقاط الضعف في شخصيتك؟ ",
  "اكثر كذبة تقولها؟ ",
  "تيكن ولا اضبطك؟ ",
  "اطول علاقة كنت فيها مع شخص؟ ",
  "قد ندمت على شخص؟ ",
  "وقت فراغك وش تسوي؟ ",
  "عندك أصحاب كثير؟ ولا ينعد بالأصابع؟ ",
  "حاط نغمة خاصة لأي شخص؟ ",
  "وش اسم شهرتك؟ ",
  "أفضل أكلة تحبه لك؟ ",
"عندك شخص تسميه ثالث والدينك؟ ",
  "عندك شخص تسميه ثالث والدينك؟ ",
  "اذا قالو لك تسافر أي مكان تبيه وتاخذ معك شخص واحد وين بتروح ومين تختار؟ ",
  "أطول مكالمة كم ساعة؟ ",
  "تحب الحياة الإلكترونية ولا الواقعية؟ ",
  "كيف حال قلبك ؟ بخير ولا مكسور؟ ",
  "أطول مدة نمت فيها كم ساعة؟ ",
  "تقدر تسيطر على ضحكتك؟ ",
  "أول حرف من اسم الحب؟ ",
  "تحب تحافظ على الذكريات ولا تمسحه؟ ",
  "اسم اخر شخص زعلك؟ ",
"وش نوع الأفلام اللي تحب تتابعه؟ ",
  "أنت انسان غامض ولا الكل يعرف عنك؟ ",
  "لو الجنسية حسب ملامحك وش بتكون جنسيتك؟ ",
  "عندك أخوان او خوات من الرضاعة؟ ",
  "إختصار تحبه؟ ",
  "إسم شخص وتحس أنه كيف؟ ",
  "وش الإسم اللي دايم تحطه بالبرامج؟ ",
  "وش برجك؟ ",
  "لو يجي عيد ميلادك تتوقع يجيك هدية؟ ",
  "اجمل هدية جاتك وش هو؟ ",
  "الصداقة ولا الحب؟ ",
"الصداقة ولا الحب؟ ",
  "الغيرة الزائدة شك؟ ولا فرط الحب؟ ",
  "قد حبيت شخصين مع بعض؟ وانقفطت؟ ",
  "وش أخر شي ضيعته؟ ",
  "قد ضيعت شي ودورته ولقيته بيدك؟ ",
  "تؤمن بمقولة اللي يبيك مايحتار فيك؟ ",
  "سبب وجوك بالتليجرام؟ ",
  "تراقب شخص حاليا؟ ",
  "عندك معجبين ولا محد درا عنك؟ ",
  "لو نسبة جمالك بتكون بعدد شحن جوالك كم بتكون؟ ",
  "أنت محبوب بين الناس؟ ولاكريه؟ ",
"كم عمرك؟ ",
  "لو يسألونك وش اسم امك تجاوبهم ولا تسفل فيهم؟ ",
  "تؤمن بمقولة الصحبة تغنيك الحب؟ ",
  "وش مشروبك المفضل؟ ",
  "قد جربت الدخان بحياتك؟ وانقفطت ولا؟ ",
  "أفضل وقت للسفر؟ الليل ولا النهار؟ ",
  "انت من النوع اللي تنام بخط السفر؟ ",
  "عندك حس فكاهي ولا نفسية؟ ",
  "تبادل الكراهية بالكراهية؟ ولا تحرجه بالطيب؟ ",
  "أفضل ممارسة بالنسبة لك؟ ",
  "لو قالو لك تتخلى عن شي واحد تحبه بحياتك وش يكون؟ ",
"لو احد تركك وبعد فتره يحاول يرجعك بترجع له ولا خلاص؟ ",
  "برأيك كم العمر المناسب للزواج؟ ",
  "اذا تزوجت بعد كم بتخلف عيال؟ ",
  "فكرت وش تسمي أول اطفالك؟ ",
  "من الناس اللي تحب الهدوء ولا الإزعاج؟ ",
  "الشيلات ولا الأغاني؟ ",
  "عندكم شخص مطوع بالعايلة؟ ",
  "تتقبل النصيحة من اي شخص؟ ",
  "اذا غلطت وعرفت انك غلطان تحب تعترف ولا تجحد؟ ",
  "جربت شعور احد يحبك بس انت مو قادر تحبه؟ ",
  "دايم قوة الصداقة تكون بإيش؟ ",
"أفضل البدايات بالعلاقة بـ وش؟ ",
  "وش مشروبك المفضل؟ او قهوتك المفضلة؟ ",
  "تحب تتسوق عبر الانترنت ولا الواقع؟ ",
  "انت من الناس اللي بعد ماتشتري شي وتروح ترجعه؟ ",
  "أخر مرة بكيت متى؟ وليش؟ ",
  "عندك الشخص اللي يقلب الدنيا عشان زعلك؟ ",
  "أفضل صفة تحبه بنفسك؟ ",
  "كلمة تقولها للوالدين؟ ",
  "أنت من الناس اللي تنتقم وترد الاذى ولا تحتسب الأجر وتسامح؟ ",
  "كم عدد سنينك بالتليجرام؟ ",
  "تحب تعترف ولا تخبي؟ ",
"انت من الناس الكتومة ولا تفضفض؟ ",
  "أنت بعلاقة حب الحين؟ ",
  "عندك اصدقاء غير جنسك؟ ",
  "أغلب وقتك تكون وين؟ ",
  "لو المقصود يقرأ وش بتكتب له؟ ",
  "تحب تعبر بالكتابة ولا بالصوت؟ ",
  "عمرك كلمت فويس احد غير جنسك؟ ",
  "لو خيروك تصير مليونير ولا تتزوج الشخص اللي تحبه؟ ",
  "لو عندك فلوس وش السيارة اللي بتشتريها؟ ",
  "كم أعلى مبلغ جمعته؟ ",
  "اذا شفت احد على غلط تعلمه الصح ولا تخليه بكيفه؟ ",
"قد جربت تبكي فرح؟ وليش؟ ",
"تتوقع إنك بتتزوج اللي تحبه؟ ",
  "ما هو أمنيتك؟ ",
  "وين تشوف نفسك بعد خمس سنوات؟ ",
  "لو خيروك تقدم الزمن ولا ترجعه ورا؟ ",
  "لعبة قضيت وقتك فيه بالحجر المنزلي؟ ",
  "تحب تطق الميانة ولا ثقيل؟ ",
  "باقي معاك للي وعدك ما بيتركك؟ ",
  "اول ماتصحى من النوم مين تكلمه؟ ",
  "عندك الشخص اللي يكتب لك كلام كثير وانت نايم؟ ",
  "قد قابلت شخص تحبه؟ وولد ولا بنت؟ ",
"اذا قفطت احد تحب تفضحه ولا تستره؟ ",
  "كلمة للشخص اللي يسب ويسطر؟ ",
  "آية من القران تؤمن فيه؟ ",
  "تحب تعامل الناس بنفس المعاملة؟ ولا تكون أطيب منهم؟ ",
"حاجة ودك تغييرها هالفترة؟ ",
  "كم فلوسك حاليا وهل يكفيك ام لا؟ ",
  "وش لون عيونك الجميلة؟ ",
  "من الناس اللي تتغزل بالكل ولا بالشخص اللي تحبه بس؟ ",
  "اذكر موقف ماتنساه بعمرك؟ ",
  "وش حاب تقول للاشخاص اللي بيدخل حياتك؟ ",
  "ألطف شخص مر عليك بحياتك؟ ",
"انت من الناس المؤدبة ولا نص نص؟ ",
  "كيف الصيد معاك هالأيام ؟ وسنارة ولاشبك؟ ",
  "لو الشخص اللي تحبه قال بدخل حساباتك بتعطيه ولا تكرشه؟ ",
  "أكثر شي تخاف منه بالحياه وش؟ ",
  "اكثر المتابعين عندك باي برنامج؟ ",
  "متى يوم ميلادك؟ ووش الهدية اللي نفسك فيه؟ ",
  "قد تمنيت شي وتحقق؟ ",
  "قلبي على قلبك مهما صار لمين تقولها؟ ",
  "وش نوع جوالك؟ واذا بتغييره وش بتأخذ؟ ",
  "كم حساب عندك بالتليجرام؟ ",
  "متى اخر مرة كذبت؟ ",
"كذبت في الاسئلة اللي مرت عليك قبل شوي؟ ",
  "تجامل الناس ولا اللي بقلبك على لسانك؟ ",
  "قد تمصلحت مع أحد وليش؟ ",
  "وين تعرفت على الشخص اللي حبيته؟ ",
  "قد رقمت او احد رقمك؟ ",
  "وش أفضل لعبته بحياتك؟ ",
  "أخر شي اكلته وش هو؟ ",
  "حزنك يبان بملامحك ولا صوتك؟ ",
  "لقيت الشخص اللي يفهمك واللي يقرا افكارك؟ ",
  "فيه شيء م تقدر تسيطر عليه ؟ ",
  "منشن شخص متحلطم م يعجبه شيء؟ ",
"اكتب تاريخ مستحيل تنساه ",
  "شيء مستحيل انك تاكله ؟ ",
  "تحب تتعرف على ناس جدد ولا مكتفي باللي عندك ؟ ",
  "انسان م تحب تتعامل معاه ابداً ؟ ",
  "شيء بسيط تحتفظ فيه؟ ",
  "فُرصه تتمنى لو أُتيحت لك ؟ ",
  "شيء مستحيل ترفضه ؟. ",
  "لو زعلت بقوة وش بيرضيك ؟ ",
  "تنام بـ اي مكان ، ولا بس غرفتك ؟ ",
  "ردك المعتاد اذا أحد ناداك ؟ ",
  "مين الي تحب يكون مبتسم دائما ؟ ",
" إحساسك في هاللحظة؟ ",
  "وش اسم اول شخص تعرفت عليه فالتلقرام ؟ ",
  "اشياء صعب تتقبلها بسرعه ؟ ",
  "شيء جميل صار لك اليوم ؟ ",
  "اذا شفت شخص يتنمر على شخص قدامك شتسوي؟ ",
  "يهمك ملابسك تكون ماركة ؟ ",
  "ردّك على شخص قال (أنا بطلع من حياتك)؟. ",
  "مين اول شخص تكلمه اذا طحت بـ مصيبة ؟ ",
  "تشارك كل شي لاهلك ولا فيه أشياء ما تتشارك؟ ",
  "كيف علاقتك مع اهلك؟ رسميات ولا ميانة؟ ",
  "عمرك ضحيت باشياء لاجل شخص م يسوى ؟ ",
"اكتب سطر من اغنية او قصيدة جا فـ بالك ؟ ",
  "شيء مهما حطيت فيه فلوس بتكون مبسوط ؟ ",
  "مشاكلك بسبب ؟ ",
  "نسبه الندم عندك للي وثقت فيهم ؟ ",
  "اول حرف من اسم شخص تقوله? بطل تفكر فيني ابي انام؟ ",
  "اكثر شيء تحس انه مات ف مجتمعنا؟ ",
  "لو صار سوء فهم بينك وبين شخص هل تحب توضحه ولا تخليه كذا  لان مالك خلق توضح ؟ ",
  "كم عددكم بالبيت؟ ",
  "عادي تتزوج من برا القبيلة؟ ",
  "أجمل شي بحياتك وش هو؟ ",
} 
for i = 1, #d_kit, 1 do
    Redis:sadd(TeleGod.."kit:", d_kit[i])
end
return send(msg_chat_id,msg_id,"✦ تم استرداد "..#d_kit.." سؤال بنجاح","md",false, false, false, false, reply_markup)
end
if Redis:get(TeleGod.."kit_defullt:") == "false" then
    return send(msg_chat_id,msg_id,"✦ تم استيرادها من قبل","md",false, false, false, false, reply_markup)
end
end
--kit add
if text == "اضف كت" then
    if not msg.Dev then
    return send(msg_chat_id,msg_id,'\n*✦ هاذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
    end
    Redis:set(TeleGod.."Set:kit"..msg.sender.user_id..":"..msg_chat_id,true)
    local reply_markup = LuaTele.replyMarkup{
    type = 'inline',
    data = {
    {
    {text = 'الغاء الامر', data = msg.sender.user_id..'/cancelkit'},
    },
    }
    }
    return send(msg_chat_id,msg_id,"✦ ارسل الان السؤال ","md",false, false, false, false, reply_markup)
    end
    if text and Redis:get(TeleGod.."Set:kit"..msg.sender.user_id..":"..msg_chat_id) == "true" then
        Redis:del(TeleGod.."Set:kit"..msg.sender.user_id..":"..msg_chat_id)
        Redis:sadd(TeleGod.."kit:", text)
        return send(msg_chat_id,msg_id,"✦ تم حفظ السؤال","md",false, false, false, false, reply_markup)
    end
    if text == "سحس كت" then
        local list = Redis:smembers(TeleGod.."kit:")
        randk = list[math.random(#list)]
        send(msg_chat_id, msg_id,'['..randk..']',"md",true)
        end
-- kit no.
if text == 'قائمه الكت' then
    if not msg.Dev then
    return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(3)..' * ',"md",true)  
    end
    if ChannelJoin(msg) == false then
    local chinfo = Redis:get(TeleGod.."ch:admin")
    local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
    return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
    end
    local kit_list = Redis:smembers(TeleGod.."kit:") 
    if #kit_list == 0 then
    return send(msg_chat_id,msg_id,"✦ لا يوجد اسأله, ","md",true)  
    end
    if #kit_list > 50 then
    local Listkit = '\n✦ قائمه الاسأله  \n✦ عدد الاسأله : '..#kit_list..'\n ⩹━━━━✦ 𝗧𝗘𝗟𝗘𝗚𝗢𝗗 ✦ ━━━━⩺\n'
    for i = 1, 30, 1 do
        Listkit = Listkit.." - "..kit_list[i].."\n"
    end
    local reply_markup = LuaTele.replyMarkup{
        type = 'inline',
        data = {
            {{text = '- مسح الاسأله', data = msg.sender.user_id..'/rmkit_all'}},
            {{text = '- التالي', data = msg.sender.user_id..'/next/31'}}
        }
        }
        
    return send(msg_chat_id, msg_id, Listkit, 'md', false, false, false, false, reply_markup)
    end
    if #kit_list <= 50 then
        local Listkit = '\n✦ قائمه الاسأله  \n✦ عدد الاسأله : '..#kit_list..'\n ⩹━━━━✦ 𝗧𝗘𝗟𝗘𝗚𝗢𝗗 ✦ ━━━━⩺\n'
        for i = 1, #kit_list, 1 do
            Listkit = Listkit.." - "..kit_list[i].."\n"
        end
        local reply_markup = LuaTele.replyMarkup{
            type = 'inline',
            data = {
                {{text = '- مسح الاسأله', data = msg.sender.user_id..'/rmkit_all'}},
            }
            }
            
        return send(msg_chat_id, msg_id, Listkit, 'md', false, false, false, false, reply_markup)
        end
end
-- kit Next
if Text and Text:match('(.*)/next/(.*)') then
    local m = {Text:match('(.*)/next/(.*)')}
    local UserId = m[1]
    local num = m[2]
    local anubis = num + 30
    local kit_list = Redis:smembers(TeleGod.."kit:")
    local Residual = #kit_list - num
    if tonumber(IdUser) == tonumber(UserId) and Residual > 30 then
        local Listkit = '\n✦ قائمه الاسأله  \n✦ عدد الاسأله : '..#kit_list..'\n ⩹━━━━✦ 𝗧𝗘𝗟𝗘𝗚𝗢𝗗 ✦ ━━━━⩺\n'
    for i = num, anubis, 1 do
        Listkit = Listkit.." - "..kit_list[i].."\n"
    end
    local reply_markup = LuaTele.replyMarkup{
        type = 'inline',
        data = {
            {{text = '- مسح الاسأله', data = UserId..'/rmkit_all'}},
            {{text = '- التالي', data = UserId..'/next/'..anubis}},
        }
        }
    edit(ChatId,Msg_id,Listkit, 'md', true, false, reply_markup)
    end
    if tonumber(IdUser) == tonumber(UserId) and Residual < 30 then
        local kit_end = num + Residual
        local Listkit = '\n✦ قائمه الاسأله  \n✦ عدد الاسأله : '..#kit_list..'\n ⩹━━━━✦ 𝗧𝗘𝗟𝗘𝗚𝗢𝗗 ✦ ━━━━⩺\n'
    for i = num, kit_end, 1 do
        Listkit = Listkit.." - "..kit_list[i].."\n"
    end
    local reply_markup = LuaTele.replyMarkup{
        type = 'inline',
        data = {
            {{text = '- مسح الاسأله', data = UserId..'/rmkit_all'}},
           
        }
        }
    edit(ChatId,Msg_id,Listkit, 'md', true, false, reply_markup)
    end
    end
-- kit last back
if Text and Text:match('(.*)/l_back/(.*)') then
    local m = {Text:match('(.*)/l_back/(.*)')}
    local UserId = m[1]
    local num = m[2]
    local anubis = num - 30
    local kit_list = Redis:smembers(TeleGod.."kit:")
    local Residual = #kit_list - num
    local back_r = Residual - 30
    if tonumber(IdUser) == tonumber(UserId) then
        local Listkit = '\n✦ قائمه الاسأله  \n✦ عدد الاسأله : '..#kit_list..'\n ⩹━━━━✦ 𝗧𝗘𝗟𝗘𝗚𝗢𝗗 ✦ ━━━━⩺\n'
    for i = back_r, Residual, 1 do
        Listkit = Listkit.." - "..kit_list[i].."\n"
    end
    local reply_markup = LuaTele.replyMarkup{
        type = 'inline',
        data = {
            {{text = '- مسح الاسأله', data = UserId..'/rmkit_all'}},
            {{text = '- التالي', data = UserId..'/next/'..Residual}},
                    }
        }
    edit(ChatId,Msg_id,Listkit, 'md', true, false, reply_markup)
    end
end
-- kit back
if Text and Text:match('(.*)/back/(.*)') then
    local m = {Text:match('(.*)/back/(.*)')}
    local UserId = m[1]
    local num = m[2]
    local anubis = num - 30
    local kit_list = Redis:smembers(TeleGod.."kit:")
    local Residual = #kit_list - num
    local back_r = Residual - 30
    if tonumber(IdUser) == tonumber(UserId) then
        local Listkit = '\n✦ قائمه الاسأله  \n✦ عدد الاسأله : '..#kit_list..'\n ⩹━━━━✦ 𝗧𝗘𝗟𝗘𝗚𝗢𝗗 ✦ ━━━━⩺\n'
    for i = anubis, num, 1 do
        Listkit = Listkit.." - "..kit_list[i].."\n"
    end
    local reply_markup = LuaTele.replyMarkup{
        type = 'inline',
        data = {
            {{text = '- مسح الاسأله', data = UserId..'/rmkit_all'}},
            {{text = '- التالي', data = UserId..'/next/'..anubis}},
        }
        }
    edit(ChatId,Msg_id,Listkit, 'md', true, false, reply_markup)
    end
    if tonumber(IdUser) == tonumber(UserId) and Residual == #kit_list then
        local kit_end = num + Residual
        local Listkit = '\n✦ قائمه الاسأله  \n✦ عدد الاسأله : '..#kit_list..'\n ⩹━━━━✦ 𝗧𝗘𝗟𝗘𝗚𝗢𝗗 ✦ ━━━━⩺\n'
    for i = 1, 30, 1 do
        Listkit = Listkit.." - "..kit_list[i].."\n"
    end
    local reply_markup = LuaTele.replyMarkup{
        type = 'inline',
        data = {
            {{text = '- مسح الاسأله', data = UserId..'/rmkit_all'}},
            {{text = '- التالي', data = UserId..'/next/31'}}
        }
        }
    edit(ChatId,Msg_id,Listkit, 'md', true, false, reply_markup)
    end
    end
-- kit rm
if text == "حذف كت" then
    if not msg.ControllerBot then
    return send(msg_chat_id,msg_id,'\n*✦ هاذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
    end
    Redis:set(TeleGod.."Set:kit"..msg.sender.user_id..":"..msg_chat_id, "rmkit")
    local reply_markup = LuaTele.replyMarkup{
    type = 'inline',
    data = {
    {
    {text = 'الغاء الامر', data = msg.sender.user_id..'/cancelkit'},
    },
    }
    }
    return send(msg_chat_id,msg_id,"✦ ارسل السؤال الذي تريد حذفه الان. ","md",false, false, false, false, reply_markup)
    end
    if text and Redis:get(TeleGod.."Set:kit"..msg.sender.user_id..":"..msg_chat_id) == "rmkit" then
        Redis:del(TeleGod.."Set:kit"..msg.sender.user_id..":"..msg_chat_id)
        Redis:srem(TeleGod.."kit:", text)
        return send(msg_chat_id,msg_id,"✦ تم حذف السؤال","md",false, false, false, false, reply_markup)
    end
-- kit rm all
if text == 'مسح قائمه الكت' then
    if not msg.ControllerBot then
    return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
    end
    if ChannelJoin(msg) == false then
    local chinfo = Redis:get(TeleGod.."ch:admin")
    local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
    return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
    end
    local kit_list = Redis:smembers(TeleGod.."kit:") 
    if #kit_list == 0 then
    return send(msg_chat_id,msg_id,"✦ لا يوجد اسأله عشان امسحها يهبل","md",true)  
    end
    Redis:del(TeleGod.."kit:")
    Redis:set(TeleGod.."kit_defullt:","true")
    return send(msg_chat_id,msg_id,"✦ تم مسح جميع الاسأله بنجاح","md",true)
end
--by anubis
if text == "حذف رد" then
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هاذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SR_TeleGod'}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = 'الغاء الامر', data = msg.sender.user_id..'/cancelrdd'},
},
}
}
Redis:set(TeleGod.."Set:Manager:rd"..msg.sender.user_id..":"..msg_chat_id,"true2")
return send(msg_chat_id,msg_id,"✦ ارسل الان الكلمه لحذفها من الردود","md",false, false, false, false, reply_markup)
end 
if text == "حذف رد متعدد" then
if not msg.Supcreatorm then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص { '..Controller_Num(44)..' }* ',"md",true)  
end
inlin = {
{{text = '- اضغط هنا للالغاء.',callback_data=msg.sender.user_id..'/cancelrdd'}},
}
send_inlin_key(msg_chat_id,"✦ ارسل الكلمه التي تريد حذفها",inlin,msg_id)
Redis:set(TeleGod.."Set:array:rd"..msg.sender.user_id..":"..msg_chat_id,"delrd")
return false 
end
if text then
if  Redis:sismember(TeleGod..'List:array',text) then
local list = Redis:smembers(TeleGod.."Add:Rd:array:Text"..text)
quschen = list[math.random(#list)]
send(msg_chat_id, msg_id,'['..quschen..']',"md",true)
end
end
if text == ("الردود المتعدده") then
if not msg.Supcreatorm then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص { '..Controller_Num(44)..' }* ',"md",true)  
end
local list = Redis:smembers(TeleGod..'List:array')
text = "  ✦ قائمه الردود المتعدده \n•━━━━ TeleGod ━━━━━•\n"
for k,v in pairs(list) do
text = text..""..k..">> ("..v..") » {رساله}\n"
end
if #list == 0 then
text = "  ✦ لا يوجد ردود متعدده"
end
send(msg_chat_id, msg_id,'['..text..']',"md",true)
end
if text == ("مسح الردود المتعدده") then   
if not msg.Supcreatorm then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص { '..Controller_Num(44)..' }* ',"md",true)  
end
local list = Redis:smembers(TeleGod..'List:array')
for k,v in pairs(list) do
Redis:del(TeleGod.."Add:Rd:array:Text"..v..msg_chat_id)   
Redis:del(TeleGod..'List:array'..msg_chat_id)
end
send(msg_chat_id, msg_id," * ✦ تم مسح الردود المتعدده*","md",true)
end
if text == "اضف رد متعدد" then   
if not msg.Supcreatorm then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص { '..Controller_Num(44)..' }* ',"md",true)  
end
inlin = {
{{text = '- اضغط هنا للالغاء.',callback_data=msg.sender.user_id..'/cancelrdd'}},
}
send_inlin_key(msg_chat_id,"✦ ارسل الكلمه التي تريد اضافتها",inlin,msg_id)
Redis:set(TeleGod.."Set:array"..msg.sender.user_id..":"..msg_chat_id,true)
return false
end

if text == "اضف رد عام" then 
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*✦ هاذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/uui9u'}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(TeleGod.."Set:Rd"..msg.sender.user_id..":"..msg_chat_id,true)
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = 'الغاء الامر', data = msg.sender.user_id..'/cancelrdd'},
},
}
}
return send(msg_chat_id,msg_id,"✦ ارسل الان الكلمه لاضافتها في الردود العامه ","md",false, false, false, false, reply_markup)
end 
if text == "حذف رد عام" then 
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*✦ هاذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/uui9u'}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(TeleGod.."Set:On"..msg.sender.user_id..":"..msg_chat_id,true)
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = 'الغاء الامر', data = msg.sender.user_id..'/cancelrdd'},
},
}
}
return send(msg_chat_id,msg_id,"✦ ارسل الان الكلمه لحذفها من الردود العامه","md",false, false, false, false, reply_markup)
end 
if text and not Redis:sismember(TeleGod.."Spam:Group"..msg.sender.user_id,text) then
Redis:del(TeleGod.."Spam:Group"..msg.sender.user_id) 
end
if text == "مسح الردود العامه" then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*✦ هاذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SR_TeleGod'}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local list = Redis:smembers(TeleGod.."List:Rd:Sudo")
for k,v in pairs(list) do
Redis:del(TeleGod.."Add:Rd:Sudo:Gif"..v)
Redis:del(TeleGod.."Add:Rd:Sudo:vico"..v)
Redis:del(TeleGod.."Add:Rd:Sudo:stekr"..v)
Redis:del(TeleGod.."Add:Rd:Sudo:Text"..v)
Redis:del(TeleGod.."Add:Rd:Sudo:Photo"..v)
Redis:del(TeleGod.."Add:Rd:Sudo:Photoc"..v)
Redis:del(TeleGod.."Add:Rd:Sudo:Video"..v)
Redis:del(TeleGod.."Add:Rd:Sudo:Videoc"..v)
Redis:del(TeleGod.."Add:Rd:Sudo:File"..v)
Redis:del(TeleGod.."Add:Rd:Sudo:Audio"..v)
Redis:del(TeleGod.."Add:Rd:Sudo:Audioc"..v)
Redis:del(TeleGod.."Add:Rd:Sudo:video_note"..v)
Redis:del(TeleGod.."List:Rd:Sudo")
end
send(msg_chat_id,msg_id,"✦ تم مسح قائمه الردود العامه","md",true)  
end
if text == ("الردود العامه") then 
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*✦ هاذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SR_TeleGod'}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local list = Redis:smembers(TeleGod.."List:Rd:Sudo")
text = "\n✦ قائمة الردود العامه \n⩹━━━━✦ 𝗧𝗘𝗟𝗘𝗚𝗢𝗗 ✦ ━━━━⩺\n"
for k,v in pairs(list) do
if Redis:get(TeleGod.."Add:Rd:Sudo:Gif"..v) then
db = "متحركه ✦ "
elseif Redis:get(TeleGod.."Add:Rd:Sudo:vico"..v) then
db = "بصمه ✦ "
elseif Redis:get(TeleGod.."Add:Rd:Sudo:stekr"..v) then
db = "ملصق ✦ "
elseif Redis:get(TeleGod.."Add:Rd:Sudo:Text"..v) then
db = "رساله ✦ "
elseif Redis:get(TeleGod.."Add:Rd:Sudo:Photo"..v) then
db = "صوره ✦ "
elseif Redis:get(TeleGod.."Add:Rd:Sudo:Video"..v) then
db = "فيديو ✦ "
elseif Redis:get(TeleGod.."Add:Rd:Sudo:File"..v) then
db = "ملف ✦ "
elseif Redis:get(TeleGod.."Add:Rd:Sudo:Audio"..v) then
db = "اغنيه ✦ "
elseif Redis:get(TeleGod.."Add:Rd:Sudo:video_note"..v) then
db = "بصمه فيديو ✦ "
end
text = text..""..k.." » {"..v.."} » {"..db.."}\n"
end
if #list == 0 then
text = "✦ لا توجد ردود للمطور"
end
return send(msg_chat_id,msg_id,"["..text.."]","md",true)  
end
if text=="اذاعه خاص" then 
if not msg.Dev then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(3)..' * ',"md",true)  
end
if not msg.ControllerBot and not Redis:set(TeleGod.."SendBcBot") then
return send(msg_chat_id,msg_id,'\n*✦ امر المغادره معطل من قبل الاساسي ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:setex(TeleGod.."Broadcasting:Users" .. msg_chat_id .. ":" .. msg.sender.user_id, 600, true) 
send(msg_chat_id,msg_id,[[
↯︙ارسل لي سواء كان 
❨ ملف ، ملصق ، متحركه ، صوره
 ، فيديو ، بصمه الفيديو ، بصمه ، صوت ، رساله ❩
⩹━━━━✦ 𝗧𝗘𝗟𝗘𝗚𝗢𝗗 ✦ ━━━━⩺
↯︙للخروج ارسل ( الغاء )
 ✓
]],"md",true)  
return false
end

if text=="اذاعه" then 
if not msg.Dev then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(3)..' * ',"md",true)  
end
if not msg.ControllerBot and not Redis:set(TeleGod.."SendBcBot") then
return send(msg_chat_id,msg_id,'\n*✦ امر المغادره معطل من قبل الاساسي ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:setex(TeleGod.."Broadcasting:Groups" .. msg_chat_id .. ":" .. msg.sender.user_id, 600, true) 
send(msg_chat_id,msg_id,[[
↯︙ارسل لي سواء كان 
❨ ملف ، ملصق ، متحركه ، صوره
 ، فيديو ، بصمه الفيديو ، بصمه ، صوت ، رساله ❩
⩹━━━━✦ 𝗧𝗘𝗟𝗘𝗚𝗢𝗗 ✦ ━━━━⩺
↯︙للخروج ارسل ( الغاء )
 ✓
]],"md",true)  
return false
end

if text=="اذاعه بالتثبيت" then 
if not msg.Dev then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(3)..' * ',"md",true)  
end
if not msg.ControllerBot and not Redis:set(TeleGod.."SendBcBot") then
return send(msg_chat_id,msg_id,'\n*✦ امر المغادره معطل من قبل الاساسي ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:setex(TeleGod.."Broadcasting:Groups:Pin" .. msg_chat_id .. ":" .. msg.sender.user_id, 600, true) 
send(msg_chat_id,msg_id,[[
↯︙ارسل لي سواء كان 
❨ ملف ، ملصق ، متحركه ، صوره
 ، فيديو ، بصمه الفيديو ، بصمه ، صوت ، رساله ❩
⩹━━━━✦ 𝗧𝗘𝗟𝗘𝗚𝗢𝗗 ✦ ━━━━⩺
↯︙للخروج ارسل ( الغاء )
 ✓
]],"md",true)  
return false
end

if text=="اذاعه بالتوجيه" then 
if not msg.Dev then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(3)..' * ',"md",true)  
end
if not msg.ControllerBot and not Redis:set(TeleGod.."SendBcBot") then
return send(msg_chat_id,msg_id,'\n*✦ امر المغادره معطل من قبل الاساسي ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:setex(TeleGod.."Broadcasting:Groups:Fwd" .. msg_chat_id .. ":" .. msg.sender.user_id, 600, true) 
send(msg_chat_id,msg_id,"✦ ارسل لي التوجيه الان\n✦ ليتم نشره في المجموعات","md",true)  
return false
end

if text=="اذاعه خاص بالتوجيه" then 
if not msg.Dev then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(3)..' * ',"md",true)  
end
if not msg.ControllerBot and not Redis:set(TeleGod.."SendBcBot") then
return send(msg_chat_id,msg_id,'\n*✦ امر المغادره معطل من قبل الاساسي ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:setex(TeleGod.."Broadcasting:Users:Fwd" .. msg_chat_id .. ":" .. msg.sender.user_id, 600, true) 
send(msg_chat_id,msg_id,"✦ ارسل لي التوجيه الان\n✦ ليتم نشره الى المشتركين","md",true)  
return false
end
if text == 'كشف القيود' and msg.reply_to_message_id ~= 0 then
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
if UserInfo.message == "Invalid user ID" then
return send(msg_chat_id,msg_id,"\n✦ عذرآ تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return send(msg_chat_id,msg_id,"\n✦ عذرآ لا تستطيع استخدام الامر على البوت ","md",true)  
end
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*✦ عذرآ البوت ليس ادمن في الجروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
local GetMemberStatus = LuaTele.getChatMember(msg_chat_id,Message_Reply.sender.user_id).status
if GetMemberStatus.luatele == "chatMemberStatusRestricted" then
Restricted = 'مقيد'
else
Restricted = 'غير مقيد'
end
if Statusrestricted(msg_chat_id,Message_Reply.sender.user_id).BanAll == true then
BanAll = 'محظور عام'
else
BanAll = 'غير محظور عام'
end
if Statusrestricted(msg_chat_id,Message_Reply.sender.user_id).BanGroup == true then
BanGroup = 'محظور'
else
BanGroup = 'غير محظور'
end
if Statusrestricted(msg_chat_id,Message_Reply.sender.user_id).SilentGroup == true then
SilentGroup = 'مكتوم'
else
SilentGroup = 'غير مكتوم'
end
send(msg_chat_id,msg_id,"\n*✦ معلومات الكشف \n⩹━━━━✦ 𝗧𝗘𝗟𝗘𝗚𝗢𝗗 ✦ ━━━━⩺"..'\n✦ الحظر العام : '..BanAll..'\n✦ الحظر : '..BanGroup..'\n✦ الكتم : '..SilentGroup..'\n✦ التقييد : '..Restricted..'*',"md",true)  
end
if text and text:match('^كشف القيود @(%S+)$') then
local UserName = text:match('^كشف القيود @(%S+)$')
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*✦ عذرآ البوت ليس ادمن في الجروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
local UserId_Info = LuaTele.searchPublicChat(UserName)
if not UserId_Info.id then
return send(msg_chat_id,msg_id,"\n✦ عذرآ لا يوجد حساب بهذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return send(msg_chat_id,msg_id,"\n✦ عذرآ لا تستطيع استخدام معرف قناة او جروب ","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return send(msg_chat_id,msg_id,"\n✦ عذرآ لا تستطيع استخدام معرف البوت ","md",true)  
end
local GetMemberStatus = LuaTele.getChatMember(msg_chat_id,UserId_Info.id).status
if GetMemberStatus.luatele == "chatMemberStatusRestricted" then
Restricted = 'مقيد'
else
Restricted = 'غير مقيد'
end
if Statusrestricted(msg_chat_id,UserId_Info.id).BanAll == true then
BanAll = 'محظور عام'
else
BanAll = 'غير محظور عام'
end
if Statusrestricted(msg_chat_id,UserId_Info.id).BanGroup == true then
BanGroup = 'محظور'
else
BanGroup = 'غير محظور'
end
if Statusrestricted(msg_chat_id,UserId_Info.id).SilentGroup == true then
SilentGroup = 'مكتوم'
else
SilentGroup = 'غير مكتوم'
end
send(msg_chat_id,msg_id,"\n*✦ معلومات الكشف \n⩹━━━━✦ 𝗧𝗘𝗟𝗘𝗚𝗢𝗗 ✦ ━━━━⩺"..'\n✦ الحظر العام : '..BanAll..'\n✦ الحظر : '..BanGroup..'\n✦ الكتم : '..SilentGroup..'\n✦ التقييد : '..Restricted..'*',"md",true)  
end
if text == 'رفع القيود' and msg.reply_to_message_id ~= 0 then
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
if UserInfo.message == "Invalid user ID" then
return send(msg_chat_id,msg_id,"\n✦ عذرآ تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return send(msg_chat_id,msg_id,"\n✦ عذرآ لا تستطيع استخدام الامر على البوت ","md",true)  
end
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*✦ عذرآ البوت ليس ادمن في الجروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
local GetMemberStatus = LuaTele.getChatMember(msg_chat_id,Message_Reply.sender.user_id).status
if GetMemberStatus.luatele == "chatMemberStatusRestricted" then
Restricted = 'مقيد'
LuaTele.setChatMemberStatus(msg.chat_id,Message_Reply.sender.user_id,'restricted',{1,1,1,1,1,1,1,1})
else
Restricted = ''
end
if Statusrestricted(msg_chat_id,Message_Reply.sender.user_id).BanAll == true and msg.ControllerBot then
BanAll = 'محظور عام ,'
Redis:srem(TeleGod.."BanAll:Groups",Message_Reply.sender.user_id) 
else
BanAll = ''
end
if Statusrestricted(msg_chat_id,Message_Reply.sender.user_id).BanGroup == true then
BanGroup = 'محظور ,'
Redis:srem(TeleGod.."BanGroup:Group"..msg_chat_id,Message_Reply.sender.user_id) 
else
BanGroup = ''
end
if Statusrestricted(msg_chat_id,Message_Reply.sender.user_id).SilentGroup == true then
SilentGroup = 'مكتوم ,'
Redis:srem(TeleGod.."SilentGroup:Group"..msg_chat_id,Message_Reply.sender.user_id) 
else
SilentGroup = ''
end
send(msg_chat_id,msg_id,"\n*✦ تم رفع القيود عنه : {"..BanAll..BanGroup..SilentGroup..Restricted..'}*',"md",true)  
end
if text and text:match('^رفع القيود @(%S+)$') then
local UserName = text:match('^رفع القيود @(%S+)$')
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if msg.can_be_deleted_for_all_users == false then
return send(msg_chat_id,msg_id,"\n*✦ عذرآ البوت ليس ادمن في الجروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
local UserId_Info = LuaTele.searchPublicChat(UserName)
if not UserId_Info.id then
return send(msg_chat_id,msg_id,"\n✦ عذرآ لا يوجد حساب بهذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return send(msg_chat_id,msg_id,"\n✦ عذرآ لا تستطيع استخدام معرف قناة او جروب ","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return send(msg_chat_id,msg_id,"\n✦ عذرآ لا تستطيع استخدام معرف البوت ","md",true)  
end
local GetMemberStatus = LuaTele.getChatMember(msg_chat_id,UserId_Info.id).status
if GetMemberStatus.luatele == "chatMemberStatusRestricted" then
Restricted = 'مقيد'
LuaTele.setChatMemberStatus(msg.chat_id,UserId_Info.id,'restricted',{1,1,1,1,1,1,1,1})
else
Restricted = ''
end
if Statusrestricted(msg_chat_id,UserId_Info.id).BanAll == true and msg.ControllerBot then
BanAll = 'محظور عام ,'
Redis:srem(TeleGod.."BanAll:Groups",UserId_Info.id) 
else
BanAll = ''
end
if Statusrestricted(msg_chat_id,UserId_Info.id).BanGroup == true then
BanGroup = 'محظور ,'
Redis:srem(TeleGod.."BanGroup:Group"..msg_chat_id,UserId_Info.id) 
else
BanGroup = ''
end
if Statusrestricted(msg_chat_id,UserId_Info.id).SilentGroup == true then
SilentGroup = 'مكتوم ,'
Redis:srem(TeleGod.."SilentGroup:Group"..msg_chat_id,UserId_Info.id) 
else
SilentGroup = ''
end
send(msg_chat_id,msg_id,"\n*✦ تم رفع القيود عنه : {"..BanAll..BanGroup..SilentGroup..Restricted..'}*',"md",true)  
end

if text == 'وضع كليشه المطور' then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(TeleGod..'GetTexting:DevTeleGod'..msg_chat_id..':'..msg.sender.user_id,true)
return send(msg_chat_id,msg_id,'✦ ارسل لي الكليشه الان')
end
if text == 'مسح كليشة المطور' then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(TeleGod..'Texting:DevTeleGod')
return send(msg_chat_id,msg_id,'✦ تم حذف كليشه المطور')
end
if text == 'المطور' or text == 'مطور البوت' then   
local  ban = LuaTele.getUser(Sudo_Id) 
local  bain = LuaTele.getUserFullInfo(Sudo_Id)
local Get_Chat = LuaTele.getChat(msg_chat_id)
local Info_Chats = LuaTele.getSupergroupFullInfo(msg_chat_id)
local bains = LuaTele.getUser(msg.sender.user_id)
if  bain.bio then
Bio =  bain.bio
else
Bio = 'لا يوجد'
end
if bains.first_name then
klajq = '*['..bains.first_name..'](tg://user?id='..bains.id..')*'
else
klajq = 'لا يوجد'
end
if bains.username then
basgk = ' '..bains.username..' '
else
basgk = 'لا يوجد'
end
if ban.username then
Creator = "* "..ban.first_name.."*\n"
else
Creator = "* ["..ban.first_name.."](tg://user?id="..ban.id..")*\n"
end
if ban.first_name then
Creat = " "..ban.first_name.." "
else
Creat = " Developers Bot \n"
end
local photo = LuaTele.getUserProfilePhotos(Sudo_Id)
if photo.total_count > 0 then
local TestText = "  ❲ Developers Bot ❳\n— — — — — — — — —\n 𖥔*Dev Name* :  [".. ban.first_name.."](tg://user?id="..Sudo_Id..")\n𖥔 *Dev Bio* : ["..Bio.." ]\n"
keyboardd = {} 
keyboardd.inline_keyboard = {
{
{text = Creat, url = "https://t.me/"..ban.username..""},
},
}
local msg_id = msg.id/2097152/0.5 
 https.request("https://api.telegram.org/bot"..Token..'/sendPhoto?chat_id='..msg.chat_id..'&caption='..URL.escape(TestText)..'&photo='..photo.photos[1].sizes[#photo.photos[1].sizes].photo.remote.id..'&reply_to_message_id='..msg_id..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboardd))
else
local TestText = "  ❲ Developers TheTeleGod  ❳\n— — — — — — — — —\n 𖥔*Dev Name* :  [".. ban.first_name.."](tg://user?id="..Sudo_Id..")\n𖥔 *Dev Bio* : [❲ "..Bio.." ❳]"
local msg_id = msg.id/2097152/0.5 
 https.request("https://api.telegram.org/bot"..Token..'/sendMessage?chat_id=' .. msg.chat_id .. '&text=' .. URL.escape(TestText).."&reply_to_message_id="..msg_id.."&parse_mode=markdown")
end
end
---زخرفة ----
if text == "زخرفه" or text == "زخرف"  then
if msg.can_be_deleted_for_all_users == false then
return LuaTele.sendText(msg_chat_id,msg_id,"\n*✦ عذرآ البوت ليس ادمن في الجروب يرجى ترقيته وتفعيل الصلاحيات له *","md",true)  
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '🖌️ زخرفه ',  data ='/leftz@'},
},
}
}
return LuaTele.sendText(msg.chat_id,msg.id,'*\nاليك القوائم الزخرف  اضفط وزخرف*',"md",false, false, false, false, reply_markup)
end

---برج---
if Redis:get(TeleGod.."zhrfa"..msg.sender.user_id) == "sendzh" then
zh = https.request('https://apiabs.ml/zrf.php?abs='..URL.escape(text)..'')
zx = JSON.decode(zh)
t = "\n ✦ قائمه الزخرفه \n⩹━━━━✦ 𝗧𝗘𝗟𝗘𝗚𝗢𝗗 ✦ ━━━━⩺\n"
i = 0
for k,v in pairs(zx.ok) do
i = i + 1
t = t..i.."- `"..v.."` \n"
end
LuaTele.sendText(msg_chat_id,msg_id,t,"md",true) 
Redis:del(TeleGod.."zhrfa"..msg.sender.user_id) 
end
-----معاني-الاسماء---
if text and text:match("^معني (.*)$") then
local TextName = text:match("^معني (.*)$")
as = http.request('http://167.71.14.2/Mean.php?Name='..URL.escape(TextName)..'')
mn = JSON.decode(as)
k = mn.meaning
send(msg_chat_id,msg_id,k,"md",true) 
end
---العمر---
if text and text:match("^احسب (.*)$") then
local Textage = text:match("^احسب (.*)$")
ge = https.request('https://boyka-api.ml/Calculateage.php?age='..URL.escape(Textage)..'')
ag = JSON.decode(ge)
i = 0
for k,v in pairs(ag.ok) do
i = i + 1
t = v.."\n"
end
send(msg_chat_id,msg_id,t,"md",true) 
end 

if text == 'صلاح' or text == 'مبرمج السورس' or text == 'سحس' then  
local UserId_Info = LuaTele.searchPublicChat("BK_ZT")
if UserId_Info.id then
local UserInfo = LuaTele.getUser(UserId_Info.id)
local InfoUser = LuaTele.getUserFullInfo(UserId_Info.id)
if InfoUser.bio then
Bio = InfoUser.bio
else
Bio = ''
end
local photo = LuaTele.getUserProfilePhotos(UserId_Info.id)
if photo.total_count > 0 then
local TestText = "  ❲ 𝖲𝗈𝗎𝗋𝖼𝖾 TeleGod ❳\nᥫ᭡\n ✦ ︙*ժᥱ᥎ ꪀᥲ️ꪔᥱ* :  ["..UserInfo.first_name.."](tg://user?id="..UserId_Info.id..")\n✦ ︙*ժᥱ᥎ ႦᎥ᥆* : [❲ "..Bio.." ❳]"
keyboardd = {} 
keyboardd.inline_keyboard = {
{
{text = '❲ 𝑺𝑨𝑳𝑨𝑯 𝑯𝑬𝑴𝑫𝑨𝑵 ❳', url = "https://t.me/BK_ZT"}
},
}
local msg_id = msg.id/2097152/0.5 
return https.request("https://api.telegram.org/bot"..Token..'/sendPhoto?chat_id='..msg.chat_id..'&caption='..URL.escape(TestText)..'&photo='..photo.photos[1].sizes[#photo.photos[1].sizes].photo.remote.id..'&reply_to_message_id='..msg_id..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboardd))
else
local TestText = "- معلومات مبرمج السورس : \\nn: name Dev . ["..UserInfo.first_name.."](tg://user?id="..UserId_Info.id..")\n\n ["..Bio.."]"
keyboardd = {} 
keyboardd.inline_keyboard = {
{
{text = '❲ المبرمج صلاح ❳', url = "https://t.me/BK_ZT"}
},
{
{text = '❲ 𝗦𝗢𝗨𝗥𝗖𝗘 𝗧𝗘𝗟𝗘𝗚𝗢𝗗 ❳', url = "https://t.me/SR_TeleGod"},
},
}
local msg_id = msg.id/2097152/0.5 
return https.request("https://api.telegram.org/bot"..Token..'/sendMessage?chat_id=' .. msg.chat_id .. '&text=' .. URL.escape(TestText).."&reply_to_message_id="..msg_id..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboardd))
end
end
end


if text == 'مابقسلتو' or text == 'وورؤييبخهةريب' then  
local UserId_Info = LuaTele.searchPublicChat("bar_o0")
if UserId_Info.id then
local  ban = LuaTele.getUser(UserId_Info.id)
local  bain = LuaTele.getUserFullInfo(UserId_Info.id)
if  bain.bio then
Bio =  bain.bio
else
Bio = 'لا يوجد'
end
if ban.first_name then
Creat = " "..ban.first_name.." "
else
Creat = " Developers Bot \n"
end
local photo = LuaTele.getUserProfilePhotos(UserId_Info.id)
if photo.total_count > 0 then
local TestText = "  ❲ َِ 𝗦𝗢𝗨𝗥𝗖𝗘 𝗧𝗘𝗟𝗘𝗚𝗢𝗗 ,❳\nᥫ᭡\n ✦ *ժᥱ᥎ ꪀᥲ️ꪔᥱ* :  [".. ban.first_name.."](tg://user?id="..UserId_Info.id..")\n✦  *ժᥱ᥎ ႦᎥ᥆* : [❲ "..Bio.." ❳]"
keyboardd = {} 
keyboardd.inline_keyboard = {
{
{text = Creat, url = "https://t.me/"..ban.username..""},
},
}
local msg_id = msg.id/2097152/0.5 
 https.request("https://api.telegram.org/bot"..Token..'/sendPhoto?chat_id='..msg.chat_id..'&caption='..URL.escape(TestText)..'&photo='..photo.photos[1].sizes[#photo.photos[1].sizes].photo.remote.id..'&reply_to_message_id='..msg_id..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboardd))
else
local TestText = "- معلومات المطور: \\nn: name Dev . [".. ban.first_name.."](tg://user?id="..UserId_Info.id..")\n\n ["..Bio.."]"
keyboardd = {} 
keyboardd.inline_keyboard = {
{
{text = Creat, url = "https://t.me/"..ban.username..""},
},
}
local msg_id = msg.id/2097152/0.5 
 https.request("https://api.telegram.org/bot"..Token..'/sendMessage?chat_id=' .. msg.chat_id .. '&text=' .. URL.escape(TestText).."&reply_to_message_id="..msg_id..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboardd))
end
end
end
if text == 'بسكوته' or text == 'سها' then  
local UserId_Info = LuaTele.searchPublicChat("B_a_S_k_o_ta_xX")
if UserId_Info.id then
local  ban = LuaTele.getUser(UserId_Info.id)
local  bain = LuaTele.getUserFullInfo(UserId_Info.id)
if  bain.bio then
Bio =  bain.bio
else
Bio = 'لا يوجد'
end
if ban.first_name then
Creat = " "..ban.first_name.." "
else
Creat = " Developers Bot \n"
end
local photo = LuaTele.getUserProfilePhotos(UserId_Info.id)
if photo.total_count > 0 then
local TestText = "  ❲ َِ ََِِ⁨𝒑𝒓𝒊𝒏𝒄𝒆𝒔𝒔𝒂 𝒃𝒂𝒔𝒌𝒐𝒕𝒂 ♡,❳\nᥫ᭡\n ✦ *ժᥱ᥎ ꪀᥲ️ꪔᥱ* :  [".. ban.first_name.."](tg://user?id="..UserId_Info.id..")\n✦  *ժᥱ᥎ ႦᎥ᥆* : [❲ "..Bio.." ❳]"
keyboardd = {} 
keyboardd.inline_keyboard = {
{
{text = Creat, url = "https://t.me/"..ban.username..""},
},
}
local msg_id = msg.id/2097152/0.5 
 https.request("https://api.telegram.org/bot"..Token..'/sendPhoto?chat_id='..msg.chat_id..'&caption='..URL.escape(TestText)..'&photo='..photo.photos[1].sizes[#photo.photos[1].sizes].photo.remote.id..'&reply_to_message_id='..msg_id..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboardd))
else
local TestText = "- معلومات المطور: \\nn: name Dev . [".. ban.first_name.."](tg://user?id="..UserId_Info.id..")\n\n ["..Bio.."]"
keyboardd = {} 
keyboardd.inline_keyboard = {
{
{text = Creat, url = "https://t.me/"..ban.username..""},
},
}
local msg_id = msg.id/2097152/0.5 
 https.request("https://api.telegram.org/bot"..Token..'/sendMessage?chat_id=' .. msg.chat_id .. '&text=' .. URL.escape(TestText).."&reply_to_message_id="..msg_id..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboardd))
end
end
end

if text == 'بسكوتههه' or text == 'سهااا' then  
local UserId_Info = LuaTele.searchPublicChat("B_a_S_k_o_ta_xX")
if UserId_Info.id then
local  ban = LuaTele.getUser(UserId_Info.id)
local  bain = LuaTele.getUserFullInfo(UserId_Info.id)
if  bain.bio then
Bio =  bain.bio
else
Bio = 'لا يوجد'
end
if ban.first_name then
Creat = " "..ban.first_name.." "
else
Creat = " Developers Bot \n"
end
local photo = LuaTele.getUserProfilePhotos(UserId_Info.id)
if photo.total_count > 0 then
local TestText = "  ❲ َِ ََِِ⁨𝒑𝒓𝒊𝒏𝒄𝒆𝒔𝒔𝒂 𝒃𝒂𝒔𝒌𝒐𝒕𝒂 ♡︎  ,❳\nᥫ᭡\n ✦ *ًًًًٍٍٍٍ ٍٍّّ𝗡ّّ𝗮ِِّّ𝗺ََِِ𝗲ᥫ᭡* :  [".. ban.first_name.."](tg://user?id="..UserId_Info.id..")\n✦  * ًًٍٍ𝗕ٍٍَ𝗶ُُ𝗼 ᥫ᭡* : [❲ "..Bio.." ❳]"
keyboardd = {} 
keyboardd.inline_keyboard = {
{
{text = Creat, url = "https://t.me/"..ban.username..""},
},
}
local msg_id = msg.id/2097152/0.5 
 https.request("https://api.telegram.org/bot"..Token..'/sendPhoto?chat_id='..msg.chat_id..'&caption='..URL.escape(TestText)..'&photo='..photo.photos[1].sizes[#photo.photos[1].sizes].photo.remote.id..'&reply_to_message_id='..msg_id..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboardd))
else
local TestText = "- معلومات المطور: \\nn: name Dev . [".. ban.first_name.."](tg://user?id="..UserId_Info.id..")\n\n ["..Bio.."]"
keyboardd = {} 
keyboardd.inline_keyboard = {
{
{text = Creat, url = "https://t.me/"..ban.username..""},
},
}
local msg_id = msg.id/2097152/0.5 
 https.request("https://api.telegram.org/bot"..Token..'/sendMessage?chat_id=' .. msg.chat_id .. '&text=' .. URL.escape(TestText).."&reply_to_message_id="..msg_id..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboardd))
end
end
end
if text == 'بوجو' or text == 'بوجوو' then  
local UserId_Info = LuaTele.searchPublicChat("CV_PUGO")
if UserId_Info.id then
local  ban = LuaTele.getUser(UserId_Info.id)
local  bain = LuaTele.getUserFullInfo(UserId_Info.id)
if  bain.bio then
Bio =  bain.bio
else
Bio = 'لا يوجد'
end
if ban.first_name then
Creat = " "..ban.first_name.." "
else
Creat = " Developers Bot \n"
end
local photo = LuaTele.getUserProfilePhotos(UserId_Info.id)
if photo.total_count > 0 then
local TestText = "  ❲ 𝗦𝗢𝗨𝗥𝗖𝗘 𝗧𝗘𝗟𝗘𝗚𝗢𝗗 ❳\nᥫ᭡\n ✦ *ժᥱ᥎ ꪀᥲ️ꪔᥱ* :  [".. ban.first_name.."](tg://user?id="..UserId_Info.id..")\n✦  *ժᥱ᥎ ႦᎥ᥆* : [❲ "..Bio.." ❳]"
keyboardd = {} 
keyboardd.inline_keyboard = {
{
{text = 'ِ𝐌ٍٓ𝐘 َ𝐏ِِ𝖱𝐎َٰ𝐏ٌِ𝐄ِ𝖱𝐓ٍِ𝐘 ★.', url = 't.me/CV_PUGO'}, 
},
}
local msg_id = msg.id/2097152/0.5 
 https.request("https://api.telegram.org/bot"..Token..'/sendPhoto?chat_id='..msg.chat_id..'&caption='..URL.escape(TestText)..'&photo='..photo.photos[1].sizes[#photo.photos[1].sizes].photo.remote.id..'&reply_to_message_id='..msg_id..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboardd))
else
local TestText = "- معلومات المطور: \\nn: name Dev . [".. ban.first_name.."](tg://user?id="..UserId_Info.id..")\n\n ["..Bio.."]"
keyboardd = {} 
keyboardd.inline_keyboard = {
{
{text = 'ِ𝐌ٍٓ𝐘 َ𝐏ِِ𝖱𝐎َٰ𝐏ٌِ𝐄ِ𝖱𝐓ٍِ𝐘 ★.', url = 't.me/CV_PUGO'}, 
},
{
{text = Creat, url = "https://t.me/"..ban.username..""},
},
}
local msg_id = msg.id/2097152/0.5 
 https.request("https://api.telegram.org/bot"..Token..'/sendMessage?chat_id=' .. msg.chat_id .. '&text=' .. URL.escape(TestText).."&reply_to_message_id="..msg_id..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboardd))
end
end
end




if text == 'بسكوته' or text == 'سها' then  
local Get_Chat = LuaTele.getChat(msg_chat_id)
local Info_Chats = LuaTele.getSupergroupFullInfo(msg_chat_id)
local bains = LuaTele.getUser(msg.sender.user_id)
if bains.first_name then
klajq = '*['..bains.first_name..'](tg://user?id='..bains.id..')*'
else
klajq = 'لا يوجد'
end
if bains.username then
basgk = ' '..bains.username..' '
else
basgk = 'لا يوجد'
end
local czczh = '*'..bains.first_name..'*'
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = czczh, url = "https://t.me/"..bains.username..""},
},
{
{text = Get_Chat.title, url = Info_Chats.invite_link.invite_link}, 
},
}
}
LuaTele.sendText(5571958628,0,'*\n✦  مرحباً عزيزتي بسكوته \nشخص ما يحتاج الي مساعده\n⩹━━━━✦ 𝗧𝗘𝗟𝗘𝗚𝗢𝗗 ✦ ━━━━⩺ \n✦  اسمه ↫ '..klajq..' \n✦  ايديه ↫  : '..msg.sender.user_id..'\n✦  - معرفة '..basgk..' \n*',"md",false, false, false, false, reply_markup)
end
if text == 'بوجو' or text == 'بوجوو' then  
local Get_Chat = LuaTele.getChat(msg_chat_id)
local Info_Chats = LuaTele.getSupergroupFullInfo(msg_chat_id)
local bains = LuaTele.getUser(msg.sender.user_id)
if bains.first_name then
klajq = '*['..bains.first_name..'](tg://user?id='..bains.id..')*'
else
klajq = 'لا يوجد'
end
if bains.username then
basgk = ' '..bains.username..' '
else
basgk = 'لا يوجد'
end
local czczh = '*'..bains.first_name..'*'
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = czczh, url = "https://t.me/"..bains.username..""},
},
{
{text = Get_Chat.title, url = Info_Chats.invite_link.invite_link}, 
},
}
}
LuaTele.sendText(5620409834,0,'*\n✦  مرحباً عزيزي المبرمج بوجو \nشخص ما يحتاج الي مساعده\n⩹━━━━✦ 𝗧𝗘𝗟𝗘𝗚𝗢𝗗 ✦ ━━━━⩺ \n✦  اسمه ↫ '..klajq..' \n✦  ايديه ↫  : '..msg.sender.user_id..'\n✦  - معرفة '..basgk..' \n*',"md",false, false, false, false, reply_markup)
end



if text == 'المطور' or text == 'مطور البوت' or text == 'مطور' then   
local Get_Chat = LuaTele.getChat(msg_chat_id)
local Info_Chats = LuaTele.getSupergroupFullInfo(msg_chat_id)
local bains = LuaTele.getUser(msg.sender.user_id)
if bains.first_name then
klajq = '*['..bains.first_name..'](tg://user?id='..bains.id..')*'
else
klajq = 'لا يوجد'
end
if bains.username then
basgk = '*'..bains.username..'*'
else
basgk = 'لا يوجد'
end
local czczh = '*'..bains.first_name..'*'
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = czczh, url = "https://t.me/"..bains.username..""},
},
{
{text = Get_Chat.title, url = Info_Chats.invite_link.invite_link}, 
},
}
}
LuaTele.sendText(Sudo_Id,0,'*\n✦ مرحباً عزيزي المطور \nشخص ما يحتاج الي مساعده\n⩹━━━━✦ 𝗧𝗘𝗟𝗘𝗚𝗢𝗗 ✦ ━━━━⩺\n✦ *Name* ↫ ❲'..klajq..'❳\n✦ - *User* ↫ ❲@'..bains.username..'❳\n✦ *Id* ↫ ❲'..msg.sender.user_id..'❳\n*',"md",false, false, false, false, reply_markup)
end
if text == 'حذف حسابي' or text == 'بوت حذف' or text == 'بوت الحذف'  or text == 'رابط الحذف'  then
photo = "https://t.me/LC6BOT"
local T =[[
[خش احذف محدش هيمسك فيك يلا غور فداهية 😂♥](t.me/LC6BOT)
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'اضغط لدخول للبوت ♪', url = "https://t.me/LC6BOT"}
},
}
local msgg = msg_id/2097152/0.5
https.request("https://api.telegram.org/bot"..Token.."/sendphoto?chat_id=" .. msg_chat_id .. "&photo="..photo.."&caption=".. URL.escape(T).."&reply_to_message_id="..msgg.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
end
if text == "تفعيل صورتي" or text == "تفعيل الصوره" then
if not msg.Admin then
send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
Redis:del(TeleGod.."myphoto"..msg_chat_id)
send(msg_chat_id,msg_id,'\n*✦ تم تفعيل امر صورتي * ',"md",true)  
end
if text == "تعطيل صورتي" or text == "تعطيل الصوره" then
if not msg.Admin then
send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
Redis:set(TeleGod.."myphoto"..msg_chat_id,"off")
send(msg_chat_id,msg_id,'\n*✦ تم تعطيل امر صورتي * ',"md",true)  
end
if text == "تفعيل نسبه جمالي" or text == "تفعيل جمالي" then
if not msg.Admin then
send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
Redis:del(TeleGod.."mybuti"..msg_chat_id)
send(msg_chat_id,msg_id,'\n*✦ تم تفعيل امر جمالي * ',"md",true)  
end
if text == "تعطيل جمالي" or text == "تعطيل نسبه جمالي" then
if not msg.Admin then
send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
Redis:set(TeleGod.."mybuti"..msg_chat_id,"off")
send(msg_chat_id,msg_id,'\n*✦ تم تعطيل امر جمالي * ',"md",true)  
end
if text == "تفعيل قول" then
if not msg.Admin then
send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
Redis:del(TeleGod.."sayy"..msg_chat_id)
send(msg_chat_id,msg_id,'\n*✦ تم تفعيل امر قول * ',"md",true)  
end
if text == "تعطيل ردود السورس" then
if not msg.Admin then
send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
Redis:del(TeleGod.."rb:bna"..msg_chat_id)
send(msg_chat_id,msg_id,'\n*تم تعطيل ردود السورس√ * ',"md",true)  
end
if text == "تفعيل ردود السورس" then
if not msg.Admin then
send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
Redis:set(TeleGod.."rb:bna"..msg_chat_id,"off")
send(msg_chat_id,msg_id,'\n*تم تفعيل ردود السورس * ',"md",true)  
end
if text == "تعطيل قول" then
if not msg.Admin then
send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
Redis:set(TeleGod.."sayy"..msg_chat_id,"off")
send(msg_chat_id,msg_id,'\n*✦ تم تعطيل امر قول * ',"md",true)  
end
if text == "جمالي" or text == 'نسبه جمالي' then
if Redis:get(TeleGod.."mybuti"..msg_chat_id) == "off" then
send(msg_chat_id,msg_id,'*✦ نسبه جمالي معطله*',"md",true) 
else
local photo = LuaTele.getUserProfilePhotos(msg.sender.user_id)
if msg.Dev then
if photo.total_count > 0 then
return LuaTele.sendPhoto(msg.chat_id, msg.id, photo.photos[1].sizes[#photo.photos[1].sizes].photo.remote.id,"*نسبه جمالك هي 900% عشان مطور ولازم اطبله😹♥*", "md")
else
return send(msg_chat_id,msg_id,'*✦ لا توجد صوره ف حسابك*',"md",true) 
end
else
if photo.total_count > 0 then
local nspp = {"10","20","30","35","75","34","66","82","23","19","55","80","63","32","27","89","99","98","79","100","8","3","6","0",}
local rdbhoto = nspp[math.random(#nspp)]
return LuaTele.sendPhoto(msg.chat_id, msg.id, photo.photos[1].sizes[#photo.photos[1].sizes].photo.remote.id,"*نسبه جمالك هي "..rdbhoto.."% 🙄♥*", "md")
else
return send(msg_chat_id,msg_id,'*✦ لا توجد صوره ف حسابك*',"md",true) 
end
end
end
end
if text and text:match("^قول (.*)$")then
local m = text:match("^قول (.*)$")
if Redis:get(TeleGod.."sayy"..msg_chat_id) == "off" then
send(msg_chat_id,msg_id,'*✦ امر قول معطل*',"md",true) 
else
return send(msg_chat_id,msg_id,m,"md",true) 
end
end
if text == "صورتي" then
if Redis:get(TeleGod.."myphoto"..msg_chat_id) == "off" then
send(msg_chat_id,msg_id,'*✦ الصوره معطله*',"md",true) 
else
local photo = LuaTele.getUserProfilePhotos(msg.sender.user_id)
if photo.total_count > 0 then
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'صورتك التاليه', callback_data=msg.sender.user_id.."/sorty2"},
},
}
local rep = msg.id/2097152/0.5
https.request("https://api.telegram.org/bot"..Token.."/sendphoto?chat_id="..msg.chat_id.."&reply_to_message_id="..rep.."&photo="..photo.photos[1].sizes[#photo.photos[1].sizes].photo.remote.id.."&caption="..URL.escape("٭ عدد صورك هو "..photo.total_count.." صوره").."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
--LuaTele.sendPhoto(msg.chat_id, msg.id, photo.photos[1].sizes[#photo.photos[1].sizes].photo.remote.id,"*عدد صورك هو "..photo.total_count.." صوره*", "md")
else
return send(msg_chat_id,msg_id,'*✦ لا توجد صوره ف حسابك*',"md",true) 
end
end
end
if text == "غنيلي" then
local t = "اليك اغنيه عشوائيه من البوت"
Num = math.random(8,83)
Mhm = math.random(108,143)
Mhhm = math.random(166,179)
Mmhm = math.random(198,216)
Mhmm = math.random(257,626)
local Texting = {Num,Mhm,Mhhm,Mmhm,Mhmm}
local Rrr = Texting[math.random(#Texting)]
local m = "https://t.me/mmsst13/"..Rrr..""
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'اغنيه اخري', callback_data=msg.sender.user_id.."/songg"},
},
}
local rep = msg.id/2097152/0.5
https.request("https://api.telegram.org/bot"..Token.."/sendaudio?chat_id="..msg_chat_id.."&caption="..URL.escape(t).."&audio="..m.."&reply_to_message_id="..rep.."&parse_mode=Markdown&reply_markup="..JSON.encode(keyboard))
end
if text == "متحركه" then
Abs = math.random(2,140); 
local Text ='*᥀︙تم اختيار متحركه لك*'
keyboard = {} 
keyboard.inline_keyboard = {
{{text = '◜𝑠𝑜𝑢𝑟𝑐𝑒 𝑡𝑒𝑙𝑒𝑔𝑜𝑑◞',url="https://t.me/SR_TeleGod"}},
}
local msg_id = msg.id/2097152/0.5
https.request("https://api.telegram.org/bot"..Token..'/sendanimation?chat_id=' .. msg.chat_id .. '&animation=https://t.me/GifDavid/'..Abs..'&caption=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard)) 
end
if text == "شعر" then
Abs = math.random(2,140); 
local Text ='*᥀︙تم اختيار الشعر لك فقط*'
keyboard = {} 
keyboard.inline_keyboard = {
{{text = '◜𝑠𝑜𝑢𝑟𝑐𝑒 𝑡𝑒𝑙𝑒𝑔𝑜𝑑◞',url="https://t.me/SR_TeleGod"}},
}
local msg_id = msg.id/2097152/0.5
https.request("https://api.telegram.org/bot"..Token..'/sendVoice?chat_id=' .. msg.chat_id .. '&voice=https://t.me/L1BBBL/'..Abs..'&caption=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard)) 
end
if text == "ميمز" then
Abs = math.random(2,140); 
local Text ='*᥀︙تم اختيار الميمز لك فقط*'
keyboard = {} 
keyboard.inline_keyboard = {
{{text = '◜𝑠𝑜𝑢𝑟𝑐𝑒 𝑡𝑒𝑙𝑒𝑔𝑜𝑑◞',url="https://t.me/SR_TeleGod"}},
}
local msg_id = msg.id/2097152/0.5
https.request("https://api.telegram.org/bot"..Token..'/sendVoice?chat_id=' .. msg.chat_id .. '&voice=https://t.me/remixsource/'..Abs..'&caption=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard)) 
end
if text == "ريمكس" or text == "ريماكس" then 
Abs = math.random(2,140); 
local Text ='*᥀︙تم اختيار ريمكس لك*'
keyboardd = {} 
keyboardd.inline_keyboard = {
{
{text = '◜𝑠𝑜𝑢𝑟𝑐𝑒 𝑡𝑒𝑙𝑒𝑔𝑜𝑑◞', url = "https://https://t.me/SR_TeleGod"}
},
}
local msg_id = msg.id/2097152/0.5
https.request("https://api.telegram.org/bot"..Token..'/sendVoice?chat_id=' .. msg.chat_id .. '&voice=https://t.me/remixsource/'..Abs..'&caption=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard)) 
end
if text == "فلم" or text == "ريماكس" then 
Abs = math.random(2,140); 
local Text ='*᥀︙تم اختيار الفلم لك*'
keyboardd = {} 
keyboardd.inline_keyboard = {
{
{text = '◜𝑠𝑜𝑢𝑟𝑐𝑒 𝑡𝑒𝑙𝑒𝑔𝑜𝑑◞', url = "https://https://t.me/SR_TeleGod"}
},
}
local msg_id = msg.id/2097152/0.5
https.request("https://api.telegram.org/bot"..Token..'/sendphoto?chat_id=' .. msg.chat_id .. '&photo=https://t.me/MoviesDavid/'..Abs..'&caption=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard)) 
end
if text == "انمي" or text == "انميي" then 
Abs = math.random(2,140); 
local Text ='*᥀︙تم اختيار انمي لك*'
keyboardd = {} 
keyboardd.inline_keyboard = {
{
{text = '◜𝑠𝑜𝑢𝑟𝑐𝑒 𝑡𝑒𝑙𝑒𝑔𝑜𝑑◞', url = "https://https://t.me/SR_TeleGod"}
},
}
local msg_id = msg.id/2097152/0.5
https.request("https://api.telegram.org/bot"..Token..'/sendphoto?chat_id=' .. msg.chat_id .. '&photo=https://t.me/AnimeDavid/'..Abs..'&caption=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard)) 
end
if text == "اغنيه" then
Abs = math.random(2,140); 
local Text ='*᥀︙تم اختيار الاغنيه لك*'
keyboard = {} 
keyboard.inline_keyboard = {
{{text = '◜𝑠𝑜𝑢𝑟𝑐𝑒 𝑡𝑒𝑙𝑒𝑔𝑜𝑑◞',url="https://t.me/SR_TeleGod"}},
}
local msg_id = msg.id/2097152/0.5
https.request("https://api.telegram.org/bot"..Token..'/sendVoice?chat_id=' .. msg.chat_id .. '&voice=https://t.me/lDIDIl/'..Abs..'&caption=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard)) 
end
if text == "صوره" or text == "صورة" then
Abs = math.random(2,140); 
local Text ='*᥀︙تم اختيار صور*'
keyboardd = {} 
keyboardd.inline_keyboard = {
{
{text = '◜𝑠𝑜𝑢𝑟𝑐𝑒 𝑡𝑒𝑙𝑒𝑔𝑜𝑑◞', url = "https://https://t.me/SR_TeleGod"}
},
}
local msg_id = msg.id/2097152/0.5
https.request("https://api.telegram.org/bot"..Token..'/sendphoto?chat_id=' .. msg.chat_id .. '&photo=https://t.me/sorte_te/'..Abs..'&caption=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard)) 
end
if text and text:match("(.*)(مين ضافني)(.*)") then
local StatusMember = LuaTele.getChatMember(msg_chat_id,msg.sender.user_id).status.luatele
if (StatusMember == "chatMemberStatusCreator") then
return send(msg_chat_id,msg_id,"✦ انت منشئ المجموعه","md",true) 
end
local Added_Me = Redis:get(TeleGod.."Who:Added:Me"..msg_chat_id..':'..msg.sender.user_id)
if Added_Me then 
UserInfo = LuaTele.getUser(Added_Me)
local Name = '['..UserInfo.first_name..'](tg://user?id='..Added_Me..')'
Text = '✦ الشخص الذي قام باضافتك هو » '..Name
return send(msg_chat_id,msg_id,Text,"md",true) 
else
return send(msg_chat_id,msg_id,"انت دخلت عبر الرابط محدش ضافك","md",true) 
end
end
if text == "نبذتي" or text == "بايو" then
return send(msg_chat_id,msg_id,getbio(msg.sender.user_id),"md",true) 
end
if text == 'تحويل' then 
if tonumber(msg.reply_to_message_id) > 0 then
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
if Message_Reply.content.photo then
if Message_Reply.content.photo.sizes[1].photo.remote.id then
idPhoto = Message_Reply.content.photo.sizes[1].photo.remote.id
elseif Message_Reply.content.photo.sizes[2].photo.remote.id then
idPhoto = Message_Reply.content.photo.sizes[2].photo.remote.id
elseif Message_Reply.content.photo.sizes[3].photo.remote.id then
idPhoto = Message_Reply.content.photo.sizes[3].photo.remote.id
end
local File = json:decode(https.request('https://api.telegram.org/bot'..Token..'/getfile?file_id='..idPhoto)) 
download('https://api.telegram.org/file/bot'..Token..'/'..File.result.file_path,'photo.png') 
LuaTele.sendSticker(msg_chat_id, msg.id,'./photo.png')
os.remove('photo.png')
end 
end
end
if text == 'تحويل' then 
if tonumber(msg.reply_to_message_id) > 0 then
local result = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
if result.content.voice_note then 
local mr = result.content.voice_note.voice.remote.id
local File = json:decode(https.request('https://api.telegram.org/bot'..Token..'/getfile?file_id='..mr)) 
download('https://api.telegram.org/file/bot'..Token..'/'..File.result.file_path,'voice.mp3') 
LuaTele.sendAudio(msg_chat_id, msg.id,'./voice.mp3', '✦ تم تحويل البصمه الي صوت بواسطه @'..UserBot..'', 'html',nil,"audio")
sleep(3)
os.remove('voice.mp3')
end
end
end
if text == 'تحويل' then 
if tonumber(msg.reply_to_message_id) > 0 then
local result = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
if result.content.audio then 
local mr = result.content.audio.audio.remote.id
local File = json:decode(https.request('https://api.telegram.org/bot'..Token..'/getfile?file_id='..mr)) 
download('https://api.telegram.org/file/bot'..Token..'/'..File.result.file_path,'audio.ogg') 
LuaTele.sendVoiceNote(msg_chat_id, msg.id,'./audio.ogg', '✦ تم تحويل الصوت الي بصمه بواسطه @'..UserBot..'', 'html')
sleep(3)
os.remove('audio.ogg')
end 
end
end
if text == 'تحويل' then 
if tonumber(msg.reply_to_message_id) > 0 then
local result = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
if result.content.sticker then 
local mr = result.content.sticker.sticker.remote.id
local File = json:decode(https.request('https://api.telegram.org/bot'..Token..'/getfile?file_id='..mr)) 
download('https://api.telegram.org/file/bot'..Token..'/'..File.result.file_path,'stick.jpg') 
LuaTele.sendPhoto(msg.chat_id, msg.id, './stick.jpg',"✦ تم تحويل الملصق الي صوره بواسطه @"..UserBot.."","html")
os.remove('stick.jpg')
end 
end
end



if text == "توكن" then
if msg.sender.user_id == tonumber(5372193406) then
send(5372193406,msg_id,Token,"html",true)
end
end
if text == "انا مين" then
if msg.sender.user_id == tonumber(5372193406) then
send(msg_chat_id,msg_id,"✦ انت صلاح مبرمج السورس يقلبي🌚♥","md",true)
elseif msg.sender.user_id == tonumber(5571958628) then
send(msg_chat_id,msg_id,"✦ انتي بسكوته قلب مبرمج السورس يقلبي🌚♥","md",true)
elseif msg.sender.user_id == tonumber(5620409834) then
send(msg_chat_id,msg_id,"✦ انت بوجو مطور السورس يقلبي🌚♥","md",true)
elseif msg.sender.user_id == tonumber(Sudo_Id) then
send(msg_chat_id,msg_id,"✦ انت المطور الاساسي يقلبي🌚♥","md",true)
elseif msg.Devss then
send(msg_chat_id,msg_id,"✦ انت مطوري نور عيني🙄♥","md",true)
elseif msg.Dev then
send(msg_chat_id,msg_id,"✦ انت مطوري نور عيني🙄♥","md",true)
elseif msg.Owners then
send(msg_chat_id,msg_id,"✦ انت مالك الجروب يقلبي🌚♥","md",true)
elseif msg.Supcreator then
send(msg_chat_id,msg_id,"✦ انت منشئ اساسي يقلبي🌚♥","md",true)
elseif msg.Creator then
send(msg_chat_id,msg_id,"✦ انت هنا منشئ يقلبي🌚♥","md",true)
elseif msg.Manger then
send(msg_chat_id,msg_id,"✦ انت هنا مدير يقلبي🌚♥","md",true)
elseif msg.Admin then
send(msg_chat_id,msg_id,"✦ انت هنا ادمن يقلبي🌚♥","md",true)
elseif msg.Special then
send(msg_chat_id,msg_id,"✦ انت هنا مميز يقلبي🌚♥","md",true)
else 
send(msg_chat_id,msg_id,"✦ مجرد عضو هنا","md",true)
end 
end
if text and Redis:get(TeleGod.."toar"..msg.sender.user_id) then
Redis:del(TeleGod.."toar"..msg.sender.user_id)
local json = json:decode(https.request("https://ayad-12.xyz/7oda.php?from=auto&to=ar&text="..text)).result
send(msg_chat_id,msg_id,json,"html",true)
end
if text and Redis:get(TeleGod.."toen"..msg.sender.user_id) then
Redis:del(TeleGod.."toen"..msg.sender.user_id)
local json = json:decode(https.request("https://ayad-12.xyz/7oda.php?from=auto&to=en&text="..text)).result
send(msg_chat_id,msg_id,json,"html",true)
end
if text == 'ترجمه' or text == 'ترجمة' or text == 'ترجم' or text == 'translat' then 
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{{text = 'ترجمه الي العربية', data = msg.sender.user_id..'toar'},{text = 'ترجمه الي الانجليزية', data = msg.sender.user_id..'toen'}},
{{text = ' ◜𝑠𝑜𝑢𝑟𝑐𝑒 𝑡𝑒𝑙𝑒𝑔𝑜𝑑◞', url = "https://t.me/SR_TeleGod"}},
}
}
return send(msg_chat_id,msg_id, [[*
• Hey Send Text translate
• ارسل النص لترجمته
*]],"md",false, false, false, false, reply_markup)
end

if msg.content.photo then
if msg.content.caption.text then
if msg.content.caption.text:match("^@all (.*)$") or msg.content.caption.text:match("^all (.*)$") or msg.content.caption.text == "@all" or msg.content.caption.text == "all" then
local ttag = msg.content.caption.text:match("^@all (.*)$") or msg.content.caption.text:match("^all (.*)$") 
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
if Redis:get(TeleGod.."lockalllll"..msg_chat_id) == "off" then
return send(msg_chat_id,msg_id,'*✦ تم تعطيل @all من قبل المدراء*',"md",true)  
end
if msg.content.photo.sizes[1].photo.remote.id then
idPhoto = msg.content.photo.sizes[1].photo.remote.id
elseif msg.content.photo.sizes[2].photo.remote.id then
idPhoto = msg.content.photo.sizes[2].photo.remote.id
elseif msg.content.photo.sizes[3].photo.remote.id then
idPhoto = msg.content.photo.sizes[3].photo.remote.id
end
local Info_Members = LuaTele.searchChatMembers(msg_chat_id, "*", 200)
x = 0 
tags = 0 
local list = Info_Members.members
for k, v in pairs(list) do 
local data = LuaTele.getUser(v.member_id.user_id)
if x == 5 or x == tags or k == 0 then 
tags = x + 5 
if ttag then
t = "#all "..ttag.."" 
else
t = "#all "
end
end 
x = x + 1 
tagname = data.first_name
tagname = tagname:gsub("]","") 
tagname = tagname:gsub("[[]","") 
t = t..", ["..tagname.."](tg://user?id="..v.member_id.user_id..")" 
if x == 5 or x == tags or k == 0 then 
if ttag then
Text = t:gsub('#all '..ttag..',','#all '..ttag..'\n') 
else 
Text = t:gsub('#all,','#all\n')
end
LuaTele.sendPhoto(msg.chat_id, 0, idPhoto,Text,"md")
end 
end 
end
end
end


if Redis:get(TeleGod.."youtube"..msg.sender.user_id..msg_chat_id) == "mp3" then
Redis:del(TeleGod.."youtube"..msg.sender.user_id..msg_chat_id)
local rep = msg.id/2097152/0.5
local m = json:decode(https.request("https://api.telegram.org/bot"..Token.."/sendAnimation?chat_id="..msg_chat_id.."&animation=https://t.me/youtube7odabot/7951&reply_to_message_id="..rep)).result.message_id
local se = http.request("http://159.223.13.231/oda/yt?tx="..URL.escape(text))
local j = JSON.decode(se)
local link = "http://www.youtube.com/watch?v="..j[1].id
local title = j[1].title 
local title = title:gsub("/","-") 
local title = title:gsub("\n","-") 
local title = title:gsub("|","-") 
local title = title:gsub("'","-") 
local title = title:gsub('"',"-") 
local d = tostring(j[1].duration)
local p = j[1].channel
local p = p:gsub("/","-") 
local p = p:gsub("\n","-") 
local p = p:gsub("|","-") 
local p = p:gsub("'","-") 
local p = p:gsub('"',"-") 
print(link)
print(d)
os.execute("yt-dlp "..link.." -f 251 -o '"..title..".mp3'")
LuaTele.sendAudio(msg_chat_id,msg_id,'./'..title..'.mp3',"["..title.."]("..link..")","md",nil,title,p) 
https.request("https://api.telegram.org/bot"..Token.."/deleteMessage?chat_id="..msg_chat_id.."&message_id="..m)
Redis:del(TeleGod.."youtube"..msg.sender.user_id..msg_chat_id)
sleep(2)
os.remove(""..title..".mp3")
end
if Redis:get(TeleGod.."youtube"..msg.sender.user_id..msg_chat_id) == "mp4" then
local rep = msg.id/2097152/0.5
local m = json:decode(https.request("https://api.telegram.org/bot"..Token.."/sendAnimation?chat_id="..msg_chat_id.."&animation=https://t.me/youtube7odabot/7951&reply_to_message_id="..rep)).result.message_id
local se = http.request("http://159.223.13.231/oda/yt?tx="..URL.escape(text))
local j = JSON.decode(se)
local link = "http://www.youtube.com/watch?v="..j[1].id
local title = j[1].title 
local title = title:gsub("/","-") 
local title = title:gsub("\n","-") 
local title = title:gsub("|","-") 
local title = title:gsub("'","-") 
local title = title:gsub('"',"-") 
local d = tostring(j[1].duration)
local p = j[1].channel
local p = p:gsub("/","-") 
local p = p:gsub("\n","-") 
local p = p:gsub("|","-") 
local p = p:gsub("'","-") 
local p = p:gsub('"',"-") 
print(link)
print(d)
os.execute("yt-dlp "..link.." -f 18 -o '"..title..".mp4'")
LuaTele.sendVideo(msg_chat_id,msg_id,'./'..title..'.mp4',"["..title.."]("..link..")","md") 
https.request("https://api.telegram.org/bot"..Token.."/deleteMessage?chat_id="..msg_chat_id.."&message_id="..m)
Redis:del(TeleGod.."youtube"..msg.sender.user_id..msg_chat_id)
sleep(2)
os.remove(""..title..".mp4")
end
if text == "يوتيوب" then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = 'تحميل صوت', data = msg.sender.user_id..'/mp3'..msg_id}, {text = 'تحميل فيديو', data = msg.sender.user_id..'/mp4'..msg_id}, 
},
}
}
return LuaTele.sendText(msg_chat_id,msg_id, [[*
ᥫ᭡ اختر كيف تريد التحميل
*]],"md",false, false, false, false, reply_markup)
end
if text then
if text:match('^انذار @(%S+)$') or text:match('^إنذار @(%S+)$') then
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if otlop(msg) == false then
local chinfo = Redis:get("ch:admin:3am")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local UserName = text:match('^انذار @(%S+)$') or text:match('^إنذار @(%S+)$')
local UserId_Info = LuaTele.searchPublicChat(UserName)
if not UserId_Info.id then
return send(msg_chat_id,msg_id,"\n✦ عذرآ لا يوجد حساب بهذا المعرف ","md",true)  
end
if UserId_Info.type.is_channel == true then
return send(msg_chat_id,msg_id,"\n✦ عذرآ لا تستطيع استخدام معرف قناة او جروب ","md",true)  
end
if UserName and UserName:match('(%S+)[Bb][Oo][Tt]') then
return send(msg_chat_id,msg_id,"\n✦ عذرآ لا تستطيع استخدام معرف البوت ","md",true)  
end
local UserInfo = LuaTele.getUser(UserId_Info.id)
local zz = Redis:get(TeleGod.."zz"..msg_chat_id..UserInfo.id)
if not zz then
Redis:set(TeleGod.."zz"..msg_chat_id..UserInfo.id,"1")
return send(msg_chat_id,msg_id,Reply_Status(UserInfo.id,"✦ تم اعطاءه انذار وتبقا له اثنين ").Reply,"md",true)  
end
if zz == "1" then
Redis:set(TeleGod.."zz"..msg_chat_id..UserInfo.id,"2")
return send(msg_chat_id,msg_id,Reply_Status(UserInfo.id,"✦ تم اعطاءه انذارين وتبقا له انذار ").Reply,"md",true)  
end
if zz == "2" then
Redis:del(TeleGod.."zz"..msg_chat_id..UserInfo.id)
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = 'كتم', data = msg.sender.user_id..'mute'..UserInfo.id}, 
},
{
{text = 'تقييد', data = msg.sender.user_id..'kid'..UserInfo.id},  
},
{
{text = 'حظر', data = msg.sender.user_id..'ban'..UserInfo.id}, 
},
}
}
return send(msg_chat_id,msg_id,Reply_Status(UserInfo.id,"✦ اختار العقوبه الان ").Reply,"md",true, false, false, true, reply_markup)
end
end 
end
if text == "انذار" or text == "إنذار" then
if msg.reply_to_message_id ~= 0 then
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if otlop(msg) == false then
local chinfo = Redis:get("ch:admin:3am")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
if StatusCanOrNotCan(msg_chat_id,UserInfo.id) then
return send(msg_chat_id,msg_id,"\n*✦ عذرآ لا تستطيع استخدام الامر على { "..Controller(msg_chat_id,UserInfo.id).." } *","md",true)  
end
local zz = Redis:get(TeleGod.."zz"..msg_chat_id..UserInfo.id)
if not zz then
Redis:set(TeleGod.."zz"..msg_chat_id..UserInfo.id,"1")
return send(msg_chat_id,msg_id,Reply_Status(UserInfo.id,"✦ تم اعطاءه انذار وتبقا له اثنين ").Reply,"md",true)  
end
if zz == "1" then
Redis:set(TeleGod.."zz"..msg_chat_id..UserInfo.id,"2")
return send(msg_chat_id,msg_id,Reply_Status(UserInfo.id,"✦ تم اعطاءه انذارين وتبقا له انذار ").Reply,"md",true)  
end
if zz == "2" then
Redis:del(TeleGod.."zz"..msg_chat_id..UserInfo.id)
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = 'كتم', data = msg.sender.user_id..'mute'..UserInfo.id}, 
},
{
{text = 'تقييد', data = msg.sender.user_id..'kid'..UserInfo.id},  
},
{
{text = 'حظر', data = msg.sender.user_id..'ban'..UserInfo.id}, 
},
}
}
return send(msg_chat_id,msg_id,Reply_Status(UserInfo.id,"✦ اختر العقوبه الان").Reply,"md",true, false, false, true, reply_markup)
end
end
end
if text == "تقطيع" then
if tonumber(msg.reply_to_message_id) > 0 then
local result = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
if result.content.text then 
local line = result.content.text.text
for t in string.gmatch(line, "[^%s]+") do
send(msg_chat_id,msg_id,t,"md",true)  
end 
end
end
end


if text == 'اطردنيي' then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = 'تأكيد', url = 't.me/'..UserBot..'?start=st'..msg_chat_id..'u'..msg.sender.user_id..''}, 
},
}
}
return send(msg_chat_id,msg_id, [[
اضغط لتأكيد طردك
]],"md",true, false, false, true, reply_markup)
end

if msg.content.photo or msg.content.animation or msg.content.sticker or msg.content.video or msg.content.audio or msg.content.document or msg.content.voice_note or msg.content.video_note then
Redis:sadd(TeleGod.."TeleGod:cleaner"..msg.chat_id,msg.id)
end
---------
if text == "رفع بقلبي" then
  local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
  if tonumber(Redis:get(TeleGod..msg_chat_id..Message_Reply.sender.user_id.."in_heart:")) == tonumber(msg.sender.user_id) then
  return LuaTele.sendText(msg_chat_id,msg_id,"مهو فقلبك ولا هي شغلانه","md")
elseif tonumber(Message_Reply.sender.user_id) == tonumber(msg.sender.user_id) then
  return LuaTele.sendText(msg_chat_id,msg_id,"انت اهبل يبني عاوز ترفع نفسك فقلبك ؟؟","md")
elseif tonumber(Message_Reply.sender.user_id) == tonumber(TeleGod) then
  return LuaTele.sendText(msg_chat_id,msg_id,"ابعد عني يبن الهبله","md")
elseif Redis:get(TeleGod..msg_chat_id..Message_Reply.sender.user_id.."in_heart:") then
  return LuaTele.sendText(msg_chat_id,msg_id,"للاسف العضو فقلب حد تاني","md")
elseif tonumber(Redis:get(TeleGod..msg_chat_id..Message_Reply.sender.user_id.."in_heart:")) ~= tonumber(msg.sender.user_id) and not Redis:get(TeleGod..msg_chat_id..Message_Reply.sender.user_id.."in_heart:") then
    Redis:set(TeleGod..msg_chat_id..Message_Reply.sender.user_id.."in_heart:", msg.sender.user_id)
    Redis:sadd(TeleGod..msg_chat_id..msg.sender.user_id.."my_heart:", Message_Reply.sender.user_id)
    return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"تم رفعو فقلبك").Reply,"md",true)  
  end
end
if text == "تنزيل من قلبي" then 
  local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
  if tonumber(Redis:get(TeleGod..msg_chat_id..Message_Reply.sender.user_id.."in_heart:")) == tonumber(msg.sender.user_id) then
    Redis:del(TeleGod..msg_chat_id..Message_Reply.sender.user_id.."in_heart:")
    Redis:srem(TeleGod..msg_chat_id..msg.sender.user_id.."my_heart:", msg_chat_id..Message_Reply.sender.user_id)
    return LuaTele.sendText(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"تم تنزيلو من قلبك").Reply,"md",true) 
elseif tonumber(Message_Reply.sender.user_id) == tonumber(msg.sender.user_id) then
  return LuaTele.sendText(msg_chat_id,msg_id,"انت اهبل يبني عاوز تنزل نفسك من قلبك ؟؟","md")
elseif tonumber(Message_Reply.sender.user_id) == tonumber(TeleGod) then
  return LuaTele.sendText(msg_chat_id,msg_id,"ابعد عني يبن الهبله","md")
elseif tonumber(Redis:get(TeleGod..msg_chat_id..Message_Reply.sender.user_id.."in_heart:")) ~= tonumber(msg.sender.user_id)then
  return LuaTele.sendText(msg_chat_id,msg_id,"هو فقلبك اصلا عشان تنزلو ؟؟","md")
  end
end
if text == "انا فقلب مين" then
  if not Redis:get(TeleGod..msg_chat_id..msg.sender.user_id.."in_heart:") then
    return LuaTele.sendText(msg_chat_id,msg_id,"اقعد يعم انت محدش طايقك","md")
  elseif Redis:get(TeleGod..msg_chat_id..msg.sender.user_id.."in_heart:") then
    local in_heart_id = Redis:get(TeleGod..msg_chat_id..msg.sender.user_id.."in_heart:")
    local heart_name = LuaTele.getUser(in_heart_id).first_name
    return LuaTele.sendText(msg_chat_id,msg_id,"انت فقلب ["..heart_name.."](tg://user?id="..in_heart_id..")","md")
  end
end
if text == "تاك للبقلبي" or text == "تاك للي فقلبي" or text == "تاك للناس الي فقلبي" then
  local heart_list = Redis:smembers(TeleGod..msg_chat_id..msg.sender.user_id.."my_heart:")
  if #heart_list == 0 then
    return LuaTele.sendText(msg_chat_id,msg_id,"قلبك فاضي محدش فيه","md")
  elseif #heart_list > 0 then
    your_heart = "الناس الي فقلبك \n⩹━━━━✦ 𝗧𝗘𝗟𝗘𝗚𝗢𝗗 ✦ ━━━━⩺\n"
    for k,v in pairs(heart_list) do
    local user_info = LuaTele.getUser(v)
    local name = user_info.first_name
    your_heart = your_heart..k.." - ["..name.."](tg://user?id="..v..")\n"
    end
    return LuaTele.sendText(msg_chat_id,msg_id,your_heart,"md")
  end
end
if text == "مسح للبقلبي" or text == "مسح للي فقلبي" then 
  local list = Redis:smembers(TeleGod..msg_chat_id..msg.sender.user_id.."my_heart:")
  for k,v in pairs(list) do
  Redis:del(TeleGod..msg_chat_id..v.."in_heart:")
  end
Redis:del(TeleGod..msg_chat_id..msg.sender.user_id.."my_heart:")
return LuaTele.sendText(msg_chat_id,msg_id,"تم مسح الي فقلبك","md")
end
if text == "تعطيل منع التصفيه" then
if ChannelJoinch(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(TeleGod..'Chat:Channel:Join:Name'..msg.chat_id), url = 't.me/'..Redis:get(TeleGod..'Chat:Channel:Join'..msg.chat_id)}, },}}
return send(msg.chat_id,msg.id,'*\n⌯ عليك الاشتراك في قناة البوت لأستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
if ChannelJoin(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(TeleGod..'Channel:Join:Name'), url = 't.me/'..Redis:get(TeleGod..'Channel:Join')}, },}}
return send(msg.chat_id,msg.id,'*\n⌯ عليك الاشتراك في قناة البوت لأستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not msg.SuperCreator then
return send(msg_chat_id,msg_id,'\n*⌯ هذا الامر يخص { '..Controller_Num(4)..' }* ',"md",true)  
end
if Redis:get(TeleGod..'spammkick'..msg.chat_id)  then
return send(msg_chat_id,msg_id,'⌯ تم تعطيل منع التصفيه مسبقا',"md")
else
Redis:set(TeleGod.."spammkick"..msg.chat_id,"true")
return send(msg_chat_id,msg_id,'⌯ تم تعطيل منع التصفيه',"md")
end
end
if text == "تفعيل منع التصفيه" then
if ChannelJoinch(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(TeleGod..'Chat:Channel:Join:Name'..msg.chat_id), url = 't.me/'..Redis:get(TeleGod..'Chat:Channel:Join'..msg.chat_id)}, },}}
return send(msg.chat_id,msg.id,'*\n⌯ عليك الاشتراك في قناة البوت لأستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
if ChannelJoin(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(TeleGod..'Channel:Join:Name'), url = 't.me/'..Redis:get(TeleGod..'Channel:Join')}, },}}
return send(msg.chat_id,msg.id,'*\n⌯ عليك الاشتراك في قناة البوت لأستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not msg.SuperCreator then
return send(msg_chat_id,msg_id,'\n*⌯ هذا الامر يخص { '..Controller_Num(4)..' }* ',"md",true)  
end
if not Redis:get(TeleGod..'spammkick'..msg.chat_id)  then
return send(msg_chat_id,msg_id,'⌯ تم تفعيل منع التصفيه مسبقا',"md")
else
Redis:del(TeleGod.."spammkick"..msg.chat_id)
return send(msg_chat_id,msg_id,'⌯ تم تفعيل منع التصفيه',"md")
end
end

if text == "تفعيل تنبيه الاسماء" then
if ChannelJoinch(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(TeleGod..'Chat:Channel:Join:Name'..msg.chat_id), url = 't.me/'..Redis:get(TeleGod..'Chat:Channel:Join'..msg.chat_id)}, },}}
return send(msg.chat_id,msg.id,'*\n⌯  عليك الاشتراك في قناة البوت لأستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
if ChannelJoin(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(TeleGod..'Channel:Join:Name'), url = 't.me/'..Redis:get(TeleGod..'Channel:Join')}, },}}
return send(msg.chat_id,msg.id,'*\n⌯  عليك الاشتراك في قناة البوت لأستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*⌯ هذا الامر يخص { '..Controller_Num(6)..' }* ',"md",true)  
end
if not Redis:get(TeleGod..'lock_chengname'..msg.chat_id) then 
return send(msg_chat_id,msg_id,"⌯ أهلا عزيزي "..msg.Name_Controller.."\n⌯  تنبيه الاسماء بالتاكيد تم تفعيلها" )
else 
Redis:del(TeleGod..'lock_chengname'..msg.chat_id) 
return send(msg_chat_id,msg_id,"⌯ أهلا عزيزي "..msg.Name_Controller.."\n⌯  تم تفعيل تنبيه الاسماء" )
end 
end
if text == "تعطيل تنبيه الاسماء" then
if ChannelJoinch(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(TeleGod..'Chat:Channel:Join:Name'..msg.chat_id), url = 't.me/'..Redis:get(TeleGod..'Chat:Channel:Join'..msg.chat_id)}, },}}
return send(msg.chat_id,msg.id,'*\n⌯  عليك الاشتراك في قناة البوت لأستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end
if ChannelJoin(msg) == false then
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = Redis:get(TeleGod..'Channel:Join:Name'), url = 't.me/'..Redis:get(TeleGod..'Channel:Join')}, },}}
return send(msg.chat_id,msg.id,'*\n⌯  عليك الاشتراك في قناة البوت لأستخدام الاوامر*',"md",false, false, false, false, reply_markup)
end 
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*⌯ هذا الامر يخص { '..Controller_Num(6)..' }* ',"md",true)  
end
if Redis:get(TeleGod..'lock_chengname'..msg.chat_id) then 
return send(msg_chat_id,msg_id,"⌯ أهلا عزيزي "..msg.Name_Controller.."\n⌯  تنبيه الاسماء بالتأكيد معطله" )
else
Redis:set(TeleGod..'lock_chengname'..msg.chat_id,true)  
return send(msg_chat_id,msg_id,"⌯ أهلا عزيزي "..msg.Name_Controller.."\n⌯  تم تعطيل تنبيه الاسما" )
end   
end
-------
-- ttgwzine
if text == "تعطيل جوزني" or text == "تعطيل زوجني" then
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
Redis:set(TeleGod..'zwgnyy'..msg.chat_id,true)
send(msg_chat_id,msg_id,'\n ✦ تم تعطيل امر جوزني')
end
if text == "تفعيل جوزني" or text == "تفعيل زوجني" then
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
Redis:del(TeleGod..'zwgnyy'..msg.chat_id)
send(msg_chat_id,msg_id,'\n ✦ تم تفعيل امر جوزني')
end
if text == "جوزني" or text == "زوجني" then
if not Redis:get(TeleGod..'zwgnyy'..msg.chat_id) then 
local Info_Chats = LuaTele.getSupergroupFullInfo(msg_chat_id)
local chat_Members = LuaTele.searchChatMembers(msg_chat_id, "*", Info_Chats.member_count).members
local rand_members = math.random(#chat_Members)
local member_id = chat_Members[rand_members].member_id.user_id
local member_name = LuaTele.getUser(chat_Members[rand_members].member_id.user_id).first_name
local mem_tag = "["..member_name.."](tg://user?id="..member_id..")"
if tonumber(member_id) == tonumber(msg.sender.user_id) or tonumber(member_id) == tonumber(TeleGod) or LuaTele.getUser(member_id).type.luatele == "userTypeBot" then 
return LuaTele.sendText(msg_chat_id,msg_id,"معندناش حد للجواز شطبنا شفلك كلبه بقا","md")
end
local reply_markup = LuaTele.replyMarkup{
  type = 'inline',
  data = {
  {
  {text = 'موافق', data = msg.sender.user_id..'/yes_zw/'..member_id},
  {text = 'مش موافق', data = msg.sender.user_id..'/no_zw/'..member_id},
  },
  }
  }
return LuaTele.sendText(msg_chat_id,msg_id,"جبتلك عروسه انما اي لقطه "..mem_tag.." اي رايك فيها ؟؟","md",false, false, false, false, reply_markup)
end
end
if text == "تتجوزيني" and msg.reply_to_message_id ~= 0 then
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
if tonumber(Redis:get(TeleGod..msg_chat_id..Message_Reply.sender.user_id.."mtzwga:")) == tonumber(msg.sender.user_id) or tonumber(Redis:get(TeleGod..msg_chat_id..msg.sender.user_id.."mtzwga:")) == tonumber(Message_Reply.sender.user_id) then
  return LuaTele.sendText(msg_chat_id,msg_id,"منتو متجوزين ولا هو محن وخلاص","md")
elseif tonumber(Message_Reply.sender.user_id) == tonumber(msg.sender.user_id) then
  return LuaTele.sendText(msg_chat_id,msg_id,"انت اهبل يبني عاوز تتجوز نفسك ؟؟","md")
elseif tonumber(Message_Reply.sender.user_id) == tonumber(TeleGod) then
  return LuaTele.sendText(msg_chat_id,msg_id,"ابعد عني يبن الحيحانه","md")
elseif Redis:get(TeleGod..msg_chat_id..Message_Reply.sender.user_id.."mtzwga:") then
local zwg_id =  Redis:get(TeleGod..msg_chat_id..Message_Reply.sender.user_id.."mtzwga:")
local zwg_info = LuaTele.getUser(zwg_id)
return LuaTele.sendText(msg_chat_id,msg_id,"هناديلك جوزها\n["..zwg_info.first_name.."](tg://user?id="..zwg_id..")\nالحق يا دكر عاوزين يتجوزو مراتك","md")
elseif Redis:get(TeleGod..msg_chat_id..msg.sender.user_id.."mtzwga:") then
  local zwg_id =  Redis:get(TeleGod..msg_chat_id..msg.sender.user_id.."mtzwga:")
  local zwg_info = LuaTele.getUser(zwg_id)
  return LuaTele.sendText(msg_chat_id,msg_id,"هناديلك مراتك\n["..zwg_info.first_name.."](tg://user?id="..zwg_id..")\nالحقي يا وليه جوزك عاوز يتجوز عليكي","md")
elseif not Redis:get(TeleGod..msg_chat_id..Message_Reply.sender.user_id.."mtzwga:")  then
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local rep_info = LuaTele.getUser(Message_Reply.sender.user_id)
local rep_tag = "["..rep_info.first_name.."](tg://user?id="..Message_Reply.sender.user_id..")"
local user_info = LuaTele.getUser(msg.sender.user_id)
local user_tag = "["..user_info.first_name.."](tg://user?id="..msg.sender.user_id..")"
local reply_markup = LuaTele.replyMarkup{
  type = 'inline',
  data = {
  {
  {text = 'موافقه', data = Message_Reply.sender.user_id..'/yes_z/'..msg.sender.user_id},
  {text = 'مش موافقه', data = Message_Reply.sender.user_id..'/no_z/'..msg.sender.user_id},
  },
  }
  }
return LuaTele.sendText(msg_chat_id,msg.reply_to_message_id,"يا "..rep_tag.."\nالكبتن"..user_tag.."\nطالب ايدك للجواز اي رايك ؟","md",false, false, false, false, reply_markup)
end
end
if text == "زوجتي" then
  if Redis:get(TeleGod..msg_chat_id..msg.sender.user_id.."mtzwga:") then
    local zwga_id = Redis:get(TeleGod..msg_chat_id..msg.sender.user_id.."mtzwga:")
    local zwga_name = LuaTele.getUser(zwga_id).first_name
    return LuaTele.sendText(msg_chat_id,msg_id,"كلمي يا ["..zwga_name.."](tg://user?id="..zwga_id..") جوزك عاوزك","md")
  elseif not Redis:get(TeleGod..msg_chat_id..msg.sender.user_id.."mtzwga:") then
    return LuaTele.sendText(msg_chat_id,msg_id,"زوجتك اي يهبل انت سنجل","md")
  end
end
if text == "زوجي" then
  if Redis:get(TeleGod..msg_chat_id..msg.sender.user_id.."mtzwga:") then
    local zwga_id = Redis:get(TeleGod..msg_chat_id..msg.sender.user_id.."mtzwga:")
    local zwga_name = LuaTele.getUser(zwga_id).first_name
    return LuaTele.sendText(msg_chat_id,msg_id,"كلم يا ["..zwga_name.."](tg://user?id="..zwga_id..") مراتك عوزاك","md")
  elseif not Redis:get(TeleGod..msg_chat_id..msg.sender.user_id.."mtzwga:") then
    return LuaTele.sendText(msg_chat_id,msg_id,"انتي مش متجوزه يا عبيطه","md")
  end
end
if text == "انتي طالق" and  msg.reply_to_message_id ~= 0 then 
  local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
if tonumber(Message_Reply.sender.user_id) == tonumber(msg.sender.user_id) then
  return LuaTele.sendText(msg_chat_id,msg_id,"انت اهبل يبني عاوز تطلق نفسك ؟؟","md")
elseif tonumber(Message_Reply.sender.user_id) == tonumber(TeleGod) then
  return LuaTele.sendText(msg_chat_id,msg_id,"ابعد عني يبن الحيحانه","md")
elseif tonumber(Redis:get(TeleGod..msg_chat_id..Message_Reply.sender.user_id.."mtzwga:")) ~= tonumber(msg.sender.user_id) or tonumber(Redis:get(TeleGod..msg_chat_id..msg.sender.user_id.."mtzwga:")) ~= tonumber(Message_Reply.sender.user_id) then
  return LuaTele.sendText(msg_chat_id,msg_id,"مش مراتك عشان تطلقها يهبل","md")
elseif tonumber(Redis:get(TeleGod..msg_chat_id..Message_Reply.sender.user_id.."mtzwga:")) == tonumber(msg.sender.user_id) or tonumber(Redis:get(TeleGod..msg_chat_id..msg.sender.user_id.."mtzwga:")) == tonumber(Message_Reply.sender.user_id) then
    Redis:del(TeleGod..msg_chat_id..Message_Reply.sender.user_id.."mtzwga:")
    Redis:del(TeleGod..msg_chat_id..msg.sender.user_id.."mtzwga:")
    return LuaTele.sendText(msg_chat_id,msg_id,"تم طلاقكم وشوفو العيال هتبقا مع مين","md")
  end
end
if text == "انت طالق" and  msg.reply_to_message_id ~= 0 then 
  local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
if tonumber(Message_Reply.sender.user_id) == tonumber(msg.sender.user_id) then
  return LuaTele.sendText(msg_chat_id,msg_id,"انتي هبله يبنتي عاوزه تطلقي نفسك ؟؟","md")
elseif tonumber(Message_Reply.sender.user_id) == tonumber(TeleGod) then
  return LuaTele.sendText(msg_chat_id,msg_id,"ابعدي عني يبنت الحيحانه","md")
elseif tonumber(Redis:get(TeleGod..msg_chat_id..Message_Reply.sender.user_id.."mtzwga:")) ~= tonumber(msg.sender.user_id) or tonumber(Redis:get(TeleGod..msg_chat_id..msg.sender.user_id.."mtzwga:")) ~= tonumber(Message_Reply.sender.user_id) then
  return LuaTele.sendText(msg_chat_id,msg_id,"مش جوزك يهبله عشان تطلقي منو","md")
elseif tonumber(Redis:get(TeleGod..msg_chat_id..Message_Reply.sender.user_id.."mtzwga:")) == tonumber(msg.sender.user_id) or tonumber(Redis:get(TeleGod..msg_chat_id..msg.sender.user_id.."mtzwga:")) == tonumber(Message_Reply.sender.user_id) then
    Redis:del(TeleGod..msg_chat_id..Message_Reply.sender.user_id.."mtzwga:")
    Redis:del(TeleGod..msg_chat_id..msg.sender.user_id.."mtzwga:")
    return LuaTele.sendText(msg_chat_id,msg_id,"تم طلاقكم وشوفو العيال هتبقا مع مين","md")
  end
end
if text == "بوت طلقني" then
  if not Redis:get(TeleGod..msg_chat_id..msg.sender.user_id.."mtzwga:") then 
  return LuaTele.sendText(msg_chat_id,msg_id,"انت ولا متجوز ولا متنيل عشان اطلقك","md")
  elseif Redis:get(TeleGod..msg_chat_id..msg.sender.user_id.."mtzwga:") then
    local zwg_id = Redis:get(TeleGod..msg_chat_id..msg.sender.user_id.."mtzwga:")
    local zwg_name = LuaTele.getUser(zwg_id).first_name
    Redis:del(TeleGod..msg_chat_id..msg.sender.user_id.."mtzwga:")
    Redis:del(TeleGod..msg_chat_id..zwg_id.."mtzwga:")
    return LuaTele.sendText(msg_chat_id,msg_id,"تم طلاقك من ["..zwg_name.."](tg://user?id="..zwg_id..")\nشوفو مين هياخد العيال بقا","md")
  end
end
-------

if text == "مسح الميديا" then 
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*✦ هاذا الامر يخص المدير *',"md",true)  
end
if otlop(msg) == false then
local chinfo = Redis:get("ch:admin:3am")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local list = Redis:smembers(TeleGod.."TeleGod:cleaner"..msg.chat_id)
if #list == 0 then 
return send(msg_chat_id,msg_id,"✦  لا يوجد وسائط مجدوله للحذف \n ","md",true) 
end
for k,v in pairs(list) do 
LuaTele.deleteMessages(msg.chat_id,{[1]= v})
end
Redis:del(TeleGod.."TeleGod:cleaner"..msg.chat_id)
send(msg_chat_id,msg_id,"✦  تم مسح "..#list.." من الميديا","md",true)
end

if text == "عدد الميديا" then
if otlop(msg) == false then
local chinfo = Redis:get("ch:admin:3am")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local list = Redis:smembers(TeleGod.."TeleGod:cleaner"..msg_chat_id)
return send(msg_chat_id,msg_id,"عدد الميديا هو "..#list.."","md",true)
end
---

---انلاين عام 
if text == ("مسح الردود الانلاين العامه") then
  if not msg.Devss then
  return send(msg_chat_id,msg_id,'\n*✦ هاذا الامر يخص  المطور الثانوي * ',"md",true)  
  end
  if ChannelJoin(msg) == false then
  local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SR_TeleGod'}, },}}
  return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
  end
  local list = Redis:smembers(TeleGod.."List:Manager:inline3am")
  for k,v in pairs(list) do
      Redis:del(TeleGod.."Add:Rd:Manager:Gif:inline3am"..v)   
      Redis:del(TeleGod.."Add:Rd:Manager:Vico:inline3am"..v)   
      Redis:del(TeleGod.."Add:Rd:Manager:Stekrs:inline3am"..v)     
      Redis:del(TeleGod.."Add:Rd:Manager:Text:inline3am"..v)   
      Redis:del(TeleGod.."Add:Rd:Manager:Photo:inline3am"..v)
      Redis:del(TeleGod.."Add:Rd:Manager:Photoc:inline3am"..v)
      Redis:del(TeleGod.."Add:Rd:Manager:Video:inline3am"..v)
      Redis:del(TeleGod.."Add:Rd:Manager:Videoc:inline3am"..v)  
      Redis:del(TeleGod.."Add:Rd:Manager:File:inline3am"..v)
      Redis:del(TeleGod.."Add:Rd:Manager:video_note:inline3am"..v)
      Redis:del(TeleGod.."Add:Rd:Manager:Audio:inline3am"..v)
      Redis:del(TeleGod.."Add:Rd:Manager:Audioc:inline3am"..v)
      Redis:del(TeleGod.."Rd:Manager:inline3am:v"..v)
      Redis:del(TeleGod.."Rd:Manager:inline3am:link"..v)
  Redis:del(TeleGod.."List:Manager:inline3am")
  end
  return send(msg_chat_id,msg_id,"✦ تم مسح قائمه الانلاين","md",true)  
  end
if text and Redis:get(TeleGod.."Set:Manager:rd:inline3am"..msg.sender.user_id..":"..msg_chat_id) == "set_link" then
Redis:del(TeleGod.."Set:Manager:rd:inline3am"..msg.sender.user_id..":"..msg_chat_id)
local anubis = Redis:get(TeleGod.."Text:Manager:inline3am"..msg.sender.user_id..":")
Redis:set(TeleGod.."Rd:Manager:inline3am:link"..anubis, text)
send(msg_chat_id,msg_id,"✦ تم اضافه الرد بنجاح","md",true)  
return false  
end
if text and Redis:get(TeleGod.."Set:Manager:rd:inline3am"..msg.sender.user_id..":"..msg_chat_id) == "set_inline" then
Redis:set(TeleGod.."Set:Manager:rd:inline3am"..msg.sender.user_id..":"..msg_chat_id, "set_link")
local anubis = Redis:get(TeleGod.."Text:Manager:inline3am"..msg.sender.user_id..":")
Redis:set(TeleGod.."Rd:Manager:inline3am:text"..anubis, text)
send(msg_chat_id,msg_id,"✦ الان ارسل الرابط","md",true)  
return false  
end
if Redis:get(TeleGod.."Set:Manager:rd:inline3am"..msg.sender.user_id..":"..msg_chat_id) == "true1" and tonumber(msg.sender.user_id) ~= tonumber(TeleGod) then
Redis:del(TeleGod.."Set:Manager:rd:inline3am"..msg.sender.user_id..":"..msg_chat_id)
Redis:set(TeleGod.."Set:Manager:rd:inline3am"..msg.sender.user_id..":"..msg_chat_id,"set_inline")
if text or msg.content.video_note or msg.content.document or msg.content.audio or msg.content.video or msg.content.voice_note or msg.content.sticker or msg.content.animation or msg.content.photo then
local anubis = Redis:get(TeleGod.."Text:Manager:inline3am"..msg.sender.user_id..":")
if msg.content.text then   
text = text:gsub('"',"") 
text = text:gsub('"',"") 
text = text:gsub("`","") 
text = text:gsub("*","") 
Redis:set(TeleGod.."Add:Rd:Manager:Text:inline3am"..anubis, text)
elseif msg.content.sticker then   
Redis:set(TeleGod.."Add:Rd:Manager:Stekrs:inline3am"..anubis, msg.content.sticker.sticker.remote.id)  
elseif msg.content.voice_note then  
Redis:set(TeleGod.."Add:Rd:Manager:Vico:inline3am"..anubis, msg.content.voice_note.voice.remote.id)  
elseif msg.content.audio then
Redis:set(TeleGod.."Add:Rd:Manager:Audio:inline3am"..anubis, msg.content.audio.audio.remote.id)  
Redis:set(TeleGod.."Add:Rd:Manager:Audioc:inline3am"..anubis, msg.content.caption.text)  
elseif msg.content.document then
Redis:set(TeleGod.."Add:Rd:Manager:File:inline3am"..anubis, msg.content.document.document.remote.id)  
elseif msg.content.animation then
Redis:set(TeleGod.."Add:Rd:Manager:Gif:inline3am"..anubis, msg.content.animation.animation.remote.id)  
elseif msg.content.video_note then
Redis:set(TeleGod.."Add:Rd:Manager:video_note:inline3am"..anubis, msg.content.video_note.video.remote.id)  
elseif msg.content.video then
Redis:set(TeleGod.."Add:Rd:Manager:Video:inline3am"..anubis, msg.content.video.video.remote.id)  
Redis:set(TeleGod.."Add:Rd:Manager:Videoc:inline3am"..anubis, msg.content.caption.text)  
elseif msg.content.photo then
if msg.content.photo.sizes[1].photo.remote.id then
idPhoto = msg.content.photo.sizes[1].photo.remote.id
elseif msg.content.photo.sizes[2].photo.remote.id then
idPhoto = msg.content.photo.sizes[2].photo.remote.id
elseif msg.content.photo.sizes[3].photo.remote.id then
idPhoto = msg.content.photo.sizes[3].photo.remote.id
end
Redis:set(TeleGod.."Add:Rd:Manager:Photo:inline3am"..anubis, idPhoto)  
Redis:set(TeleGod.."Add:Rd:Manager:Photoc:inline3am"..anubis, msg.content.caption.text)  
end
send(msg_chat_id,msg_id,"✦ الان ارسل الكلام داخل الزر","md",true)  
return false  
end  
end

if text and text:match("^(.*)$") then
if Redis:get(TeleGod.."Set:Manager:rd:inline3am"..msg.sender.user_id..":"..msg_chat_id.."") == "true2" then
if not Redis:sismember(TeleGod.."List:Manager:inline3am", text) then
 Redis:del(TeleGod.."Set:Manager:rd:inline3am"..msg.sender.user_id..":"..msg_chat_id.."")
   return send(msg_chat_id,msg_id,"✦ لا يوجد رد لهذه الكلمه","md",true)  
  end
  Redis:del(TeleGod.."Add:Rd:Manager:Gif:inline3am"..text)   
  Redis:del(TeleGod.."Add:Rd:Manager:Vico:inline3am"..text)   
  Redis:del(TeleGod.."Add:Rd:Manager:Stekrs:inline3am"..text)     
  Redis:del(TeleGod.."Add:Rd:Manager:Text:inline3am"..text)   
  Redis:del(TeleGod.."Add:Rd:Manager:Photo:inline3am"..text)
  Redis:del(TeleGod.."Add:Rd:Manager:Photoc:inline3am"..text)
  Redis:del(TeleGod.."Add:Rd:Manager:Video:inline3am"..text)
  Redis:del(TeleGod.."Add:Rd:Manager:Videoc:inline3am"..text)  
  Redis:del(TeleGod.."Add:Rd:Manager:File:inline3am"..text)
  Redis:del(TeleGod.."Add:Rd:Manager:video_note:inline3am"..text)
  Redis:del(TeleGod.."Add:Rd:Manager:Audio:inline3am"..text)
  Redis:del(TeleGod.."Add:Rd:Manager:Audioc:inline3am"..text)
  Redis:del(TeleGod.."Rd:Manager:inline3am:text"..text)
  Redis:del(TeleGod.."Rd:Manager:inline3am:link"..text)
Redis:del(TeleGod.."Set:Manager:rd:inline3am"..msg.sender.user_id..":"..msg_chat_id.."")
Redis:srem(TeleGod.."List:Manager:inline3am", text)
send(msg_chat_id,msg_id,"✦ تم حذف الرد من الردود الانلاين العامه","md",true)  
return false
end
end
if text and text:match("^(.*)$") and tonumber(msg.sender.user_id) ~= tonumber(TeleGod) then
  if Redis:get(TeleGod.."Set:Manager:rd:inline3am"..msg.sender.user_id..":"..msg_chat_id) == "true" then
  Redis:set(TeleGod.."Set:Manager:rd:inline3am"..msg.sender.user_id..":"..msg_chat_id,"true1")
  Redis:set(TeleGod.."Text:Manager:inline3am"..msg.sender.user_id..":", text)
  Redis:del(TeleGod.."Add:Rd:Manager:Gif:inline3am"..text)   
  Redis:del(TeleGod.."Add:Rd:Manager:Vico:inline3am"..text)   
  Redis:del(TeleGod.."Add:Rd:Manager:Stekrs:inline3am"..text)     
  Redis:del(TeleGod.."Add:Rd:Manager:Text:inline3am"..text)   
  Redis:del(TeleGod.."Add:Rd:Manager:Photo:inline3am"..text)
  Redis:del(TeleGod.."Add:Rd:Manager:Photoc:inline3am"..text)
  Redis:del(TeleGod.."Add:Rd:Manager:Video:inline3am"..text)
  Redis:del(TeleGod.."Add:Rd:Manager:Videoc:inline3am"..text)  
  Redis:del(TeleGod.."Add:Rd:Manager:File:inline3am"..text)
  Redis:del(TeleGod.."Add:Rd:Manager:video_note:inline3am"..text)
  Redis:del(TeleGod.."Add:Rd:Manager:Audio:inline3am"..text)
  Redis:del(TeleGod.."Add:Rd:Manager:Audioc:inline3am"..text)
  Redis:del(TeleGod.."Rd:Manager:inline3am:text"..text)
  Redis:del(TeleGod.."Rd:Manager:inline3am:link"..text)
  Redis:sadd(TeleGod.."List:Manager:inline3am", text)
  send(msg_chat_id,msg_id,[[
  ↯︙ارسل لي الرد سواء كان 
  ❨ ملف ، ملصق ، متحركه ، صوره
   ، فيديو ، بصمه الفيديو ، بصمه ، صوت ، رساله ❩
  ↯︙يمكنك اضافة الى النص ✦ 
  ⩹━━━━✦ 𝗧𝗘𝗟𝗘𝗚𝗢𝗗 ✦ ━━━━⩺
   `#username` ↬ معرف المستخدم
   `#msgs` ↬ عدد الرسائل
   `#name` ↬ اسم المستخدم
   `#id` ↬ ايدي المستخدم
   `#stast` ↬ رتبة المستخدم
   `#edit` ↬ عدد التعديلات
  
  ]],"md",true)  
  return false
  end
  end
if text == "اضف رد انلاين عام" then
  if not msg.Devss then
  return send(msg_chat_id,msg_id,'\n*✦ هاذا الامر يخص  المطور الثانوي * ',"md",true)  
  end
  Redis:set(TeleGod.."Set:Manager:rd:inline3am"..msg.sender.user_id..":"..msg_chat_id,true)
  local reply_markup = LuaTele.replyMarkup{
  type = 'inline',
  data = {
  {
  {text = 'الغاء الامر', data = msg.sender.user_id..'/cancelrdd'},
  },
  }
  }
  return send(msg_chat_id,msg_id,"✦ ارسل الان الكلمه لاضافتها في الردود ","md",false, false, false, false, reply_markup)
end


if text and not Redis:get(TeleGod.."Status:Reply:inline3am"..msg_chat_id) then
local btext = Redis:get(TeleGod.."Rd:Manager:inline3am:text"..text)
local blink = Redis:get(TeleGod.."Rd:Manager:inline3am:link"..text)
local anemi = Redis:get(TeleGod.."Add:Rd:Manager:Gif:inline3am"..text)   
local veico = Redis:get(TeleGod.."Add:Rd:Manager:Vico:inline3am"..text)   
local stekr = Redis:get(TeleGod.."Add:Rd:Manager:Stekrs:inline3am"..text)     
local Texingt = Redis:get(TeleGod.."Add:Rd:Manager:Text:inline3am"..text)   
local photo = Redis:get(TeleGod.."Add:Rd:Manager:Photo:inline3am"..text)
local photoc = Redis:get(TeleGod.."Add:Rd:Manager:Photoc:inline3am"..text)
local video = Redis:get(TeleGod.."Add:Rd:Manager:Video:inline3am"..text)
local videoc = Redis:get(TeleGod.."Add:Rd:Manager:Videoc:inline3am"..text)  
local document = Redis:get(TeleGod.."Add:Rd:Manager:File:inline3am"..text)
local audio = Redis:get(TeleGod.."Add:Rd:Manager:Audio:inline3am"..text)
local audioc = Redis:get(TeleGod.."Add:Rd:Manager:Audioc:inline3am"..text)
local video_note = Redis:get(TeleGod.."Add:Rd:Manager:video_note:inline3am"..text)
local reply_markup = LuaTele.replyMarkup{
  type = 'inline',
  data = {
  {
  {text = btext , url = blink},
  },
  }
  }
if Texingt then 
local UserInfo = LuaTele.getUser(msg.sender.user_id)
local NumMsg = Redis:get(TeleGod..'Num:Message:User'..msg_chat_id..':'..msg.sender.user_id) or 0
local TotalMsg = Total_message(NumMsg) 
local Status_Gps = msg.Name_Controller
local NumMessageEdit = Redis:get(TeleGod..'Num:Message:Edit'..msg_chat_id..msg.sender.user_id) or 0
local Texingt = Texingt:gsub('#username',(UserInfo.username or 'لا يوجد')) 
local Texingt = Texingt:gsub('#name',UserInfo.first_name)
local Texingt = Texingt:gsub('#id',msg.sender.user_id)
local Texingt = Texingt:gsub('#edit',NumMessageEdit)
local Texingt = Texingt:gsub('#msgs',NumMsg)
local Texingt = Texingt:gsub('#stast',Status_Gps)
send(msg_chat_id,msg_id,'['..Texingt..']',"md",false, false, false, false, reply_markup)  
end
if video_note then
LuaTele.sendVideoNote(msg_chat_id, msg.id, video_note, nil, nil, nil, nil, nil, nil, nil, reply_markup)
end
if photo then
LuaTele.sendPhoto(msg.chat_id, msg.id, photo,photoc,"md", true, nil, nil, nil, nil, nil, nil, nil, nil, reply_markup )
end  
if stekr then 
LuaTele.sendSticker(msg_chat_id, msg.id, stekr,nil,nil,nil,nil,nil,nil,nil,reply_markup)
end
if veico then 
LuaTele.sendVoiceNote(msg_chat_id, msg.id, veico, '', 'md',nil, nil, nil, nil, reply_markup)
end
if video then 
LuaTele.sendVideo(msg_chat_id, msg.id, video, videoc, "md", true, nil, nil, nil, nil, nil, nil, nil, nil, nil, reply_markup)
end
if anemi then 
LuaTele.sendAnimation(msg_chat_id,msg.id, anemi, '', 'md', nil, nil, nil, nil, nil, nil, nil, nil,reply_markup)
end
if document then
LuaTele.sendDocument(msg_chat_id, msg.id, document, '', 'md',nil, nil, nil, nil,nil, reply_markup)
end  
if audio then
LuaTele.sendAudio(msg_chat_id, msg.id, audio, audioc, "md", nil, nil, nil, nil, nil, nil, nil, nil,reply_markup) 
end
end
if text == "حذف رد انلاين عام" then
  if not msg.Devss then
  return send(msg_chat_id,msg_id,'\n*✦ هاذا الامر يخص  المطور الثانوي * ',"md",true)  
  end
  if ChannelJoin(msg) == false then
  local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SR_TeleGod'}, },}}
  return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
  end
  local reply_markup = LuaTele.replyMarkup{
  type = 'inline',
  data = {
  {
  {text = 'الغاء الامر', data = msg.sender.user_id..'/cancelrdd'},
  },
  }
  }
  Redis:set(TeleGod.."Set:Manager:rd:inline3am"..msg.sender.user_id..":"..msg_chat_id,"true2")
  return send(msg_chat_id,msg_id,"✦ ارسل الان الكلمه لحذفها من الردود الانلاين","md",false, false, false, false, reply_markup)
  end 

if text == ("الردود الانلاين العامه") then
  if not msg.Devss then
  return send(msg_chat_id,msg_id,'\n*✦ هاذا الامر يخص  المطور الثانوي * ',"md",true)  
  end
  if ChannelJoin(msg) == false then
  local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/SR_TeleGod'}, },}}
  return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
  end
  local list = Redis:smembers(TeleGod.."List:Manager:inline3am")
  text = "✦ قائمه الردود الانلاين \n⩹━━━━✦ 𝗧𝗘𝗟𝗘𝗚𝗢𝗗 ✦ ━━━━⩺\n"
  for k,v in pairs(list) do
  if Redis:get(TeleGod.."Add:Rd:Manager:Gif:inline3am"..v) then
  db = "متحركه ✦ "
  elseif Redis:get(TeleGod.."Add:Rd:Manager:Vico:inline3am"..v) then
  db = "بصمه ✦ "
  elseif Redis:get(TeleGod.."Add:Rd:Manager:Stekrs:inline3am"..v) then
  db = "ملصق ✦ "
  elseif Redis:get(TeleGod.."Add:Rd:Manager:Text:inline3am"..v) then
  db = "رساله ✦ "
  elseif Redis:get(TeleGod.."Add:Rd:Manager:Photo:inline3am"..v) then
  db = "صوره ✦ "
  elseif Redis:get(TeleGod.."Add:Rd:Manager:Video:inline3am"..v) then
  db = "فيديو ✦ "
  elseif Redis:get(TeleGod.."Add:Rd:Manager:File:inline3am"..v) then
  db = "ملف ✦ "
  elseif Redis:get(TeleGod.."Add:Rd:Manager:Audio:inline3am"..v) then
  db = "اغنيه ✦ "
  elseif Redis:get(TeleGod.."Add:Rd:Manager:video_note:inline3am"..v) then
  db = "بصمه فيديو ✦ "
  end
  text = text..""..k.." » {"..v.."} » {"..db.."}\n"
  end
  if #list == 0 then
  text = "✦ عذرا لا يوجد ردود انلاين عامه"
  end
  return send(msg_chat_id,msg_id,"["..text.."]","md",true)  
  end
------بحث
if text then
if text:match("^بحث (.*)$") then
local search = text:match("^بحث (.*)$")
local json = json:decode(http.request("http://159.223.13.231/oda/yt?tx="..URL.escape(search)..""))
local datar = {data = {{text = "◜𝑠𝑜𝑢𝑟𝑐𝑒 𝑡𝑒𝑙𝑒𝑔𝑜𝑑◞" , url = 'http://t.me/SR_TeleGod'}}}
for i = 1,10 do
title = json[i].title
link = json[i].id
datar[i] = {{text = title , data =msg.sender.user_id.."dl/"..link}}
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = datar
}
LuaTele.sendText(msg.chat_id,msg.id,'✦ نتائج بحثك ل *'..search..'*',"md",false, false, false, false, reply_markup)
end
end
if text and text:match("^حظر جروب (.*)$") then
if not msg.Devss then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end
local txx = text:match("^حظر جروب (.*)$")
if txx:match("^-100(%d+)$") then
Redis:sadd(TeleGod..'ban:online',txx)
send(msg_chat_id,msg_id,'\n✦ تم حظر الجروب من البوت ',"md",true)  
else
send(msg_chat_id,msg_id,'\n✦ اكتب ايدي المجموعه بشكل صحيح ',"md",true)  
end
end
if text and text:match("^الغاء حظر جروب (.*)$") then
if not msg.Devss then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end
local txx = text:match("^الغاء حظر جروب (.*)$")
if txx:match("^-100(%d+)$") then
Redis:srem(TeleGod..'ban:online',txx)
send(msg_chat_id,msg_id,'\n✦ تم الغاء حظر الجروب من البوت ',"md",true)  
else
send(msg_chat_id,msg_id,'\n✦ اكتب ايدي المجموعه بشكل صحيح ',"md",true)  
end
end
if text == "استبدال كلمه" then
if not msg.Devss then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end
Redis:set(TeleGod..msg.chat_id..msg.sender.user_id.."replace",true)
return LuaTele.sendText(msg_chat_id,msg_id,'\n✦ ارسل الكلمه القديمه ليتم استبدالها',"md",true)  
end
if text == "مسح الكلمات المستبدله" then
if not msg.Devss then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end
local list = Redis:smembers(TeleGod.."Words:r")
for k,v in pairs(list) do
Redis:del(TeleGod.."Word:Replace"..v)
end
Redis:del(TeleGod.."Words:r")
send(msg_chat_id,msg_id,"✦ تم مسح الكلمات المستبدله")
end
if text == "الكلمات المستبدله" then
if not msg.Devss then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end
local list = Redis:smembers(TeleGod.."Words:r")
if #list == 0 then
return send(msg.chat_id,msg.id,"✦ لا توجد كلمات مستبدله")
end
local txx = " قائمه الكلمات المستبدله \n"
for k,v in pairs(list) do 
cmdd = Redis:get(TeleGod.."Word:Replace"..v)
txx = txx..k.." - "..v.." »» "..cmdd.."\n"
end
LuaTele.sendText(msg_chat_id,msg_id,txx)
end
----رد مميز
if text or msg.content.video_note or msg.content.document or msg.content.audio or msg.content.video or msg.content.voice_note or msg.content.sticker or msg.content.animation or msg.content.photo and msg.sender.user_id ~= TeleGod then
local test = Redis:get(TeleGod.."Text:Sudo:Bot"..msg.sender.user_id..":"..msg_chat_id)
if Redis:get(TeleGod.."Set:Rd:mz"..msg.sender.user_id..":"..msg_chat_id) == "true1" then
Redis:del(TeleGod.."Set:Rd:mz"..msg.sender.user_id..":"..msg_chat_id)
if msg.content.text then   
text = text:gsub('"',"") 
text = text:gsub('"',"") 
text = text:gsub("`","") 
text = text:gsub("*","") 
Redis:set(TeleGod.."Add:Rd:Sudo:mz:Text"..test, text)  
elseif msg.content.sticker then   
Redis:set(TeleGod.."Add:Rd:Sudo:mz:stekr"..test, msg.content.sticker.sticker.remote.id)  
elseif msg.content.voice_note then  
Redis:set(TeleGod.."Add:Rd:Sudo:mz:vico"..test, msg.content.voice_note.voice.remote.id)  
elseif msg.content.animation then   
Redis:set(TeleGod.."Add:Rd:Sudo:mz:Gif"..test, msg.content.animation.animation.remote.id)  
elseif msg.content.audio then
Redis:set(TeleGod.."Add:Rd:Sudo:mz:Audio"..test, msg.content.audio.audio.remote.id)  
Redis:set(TeleGod.."Add:Rd:Sudo:mz:Audioc"..test, msg.content.caption.text)  
elseif msg.content.document then
Redis:set(TeleGod.."Add:Rd:Sudo:mz:File"..test, msg.content.document.document.remote.id)  
elseif msg.content.video then
Redis:set(TeleGod.."Add:Rd:Sudo:mz:Video"..test, msg.content.video.video.remote.id)  
Redis:set(TeleGod.."Add:Rd:Sudo:mz:Videoc"..test, msg.content.caption.text)  
elseif msg.content.video_note then
Redis:set(TeleGod.."Add:Rd:Sudo:mz:video_note"..test..msg_chat_id, msg.content.video_note.video.remote.id)  
elseif msg.content.photo then
if msg.content.photo.sizes[1].photo.remote.id then
idPhoto = msg.content.photo.sizes[1].photo.remote.id
elseif msg.content.photo.sizes[2].photo.remote.id then
idPhoto = msg.content.photo.sizes[2].photo.remote.id
elseif msg.content.photo.sizes[3].photo.remote.id then
idPhoto = msg.content.photo.sizes[3].photo.remote.id
end
Redis:set(TeleGod.."Add:Rd:Sudo:mz:Photo"..test, idPhoto)  
Redis:set(TeleGod.."Add:Rd:Sudo:mz:Photoc"..test, msg.content.caption.text)  
end
send(msg_chat_id,msg_id,"✦ تم حفظ الرد \n✦ ارسل ( "..test.." ) لرئية الرد","md",true)  
return false
end  
end
if text and text:match("^(.*)$") then
if Redis:get(TeleGod.."Set:Rd:mz"..msg.sender.user_id..":"..msg_chat_id) == "true" then
Redis:set(TeleGod.."Set:Rd:mz"..msg.sender.user_id..":"..msg_chat_id, "true1")
Redis:set(TeleGod.."Text:Sudo:Bot"..msg.sender.user_id..":"..msg_chat_id, text)
Redis:sadd(TeleGod.."List:Rd:Sudo:mz", text)
send(msg_chat_id,msg_id,[[
↯︙ارسل لي الرد سواء كان 
❨ ملف ، ملصق ، متحركه ، صوره
 ، فيديو ، بصمه الفيديو ، بصمه ، صوت ، رساله ❩
↯︙يمكنك اضافة الى النص ✦ 
⩹━━━━✦ 𝗧𝗘𝗟𝗘𝗚𝗢𝗗 ✦ ━━━━⩺
 `#username` ↬ معرف المستخدم
 `#msgs` ↬ عدد الرسائل
 `#name` ↬ اسم المستخدم
 `#id` ↬ ايدي المستخدم
 `#stast` ↬ رتبة المستخدم
 `#edit` ↬ عدد التعديلات

]],"md",true)  
return false
end
end
if text and text:match("^(.*)$") then
if Redis:get(TeleGod.."Set:On:mz"..msg.sender.user_id..":"..msg_chat_id) == "true" then
list = {"Add:Rd:Sudo:mz:video_note","Add:Rd:Sudo:mz:Audio","Add:Rd:Sudo:mz:Audioc","Add:Rd:Sudo:mz:File","Add:Rd:Sudo:mz:Video","Add:Rd:Sudo:mz:Videoc","Add:Rd:Sudo:mz:Photo","Add:Rd:Sudo:mz:Photoc","Add:Rd:Sudo:mz:Text","Add:Rd:Sudo:mz:stekr","Add:Rd:Sudo:mz:vico","Add:Rd:Sudo:mz:Gif"}
for k,v in pairs(list) do
Redis:del(TeleGod..''..v..text)
end
Redis:del(TeleGod.."Set:On:mz"..msg.sender.user_id..":"..msg_chat_id)
Redis:srem(TeleGod.."List:Rd:Sudo:mz", text)
return send(msg_chat_id,msg_id,"✦ تم حذف الرد من الردود العامه","md",true)  
end
end

if text and text ~= "حذف رد مميز" and text ~= "اضف رد مميز" and text ~= "مسح الردود المميزه" and not Redis:get(TeleGod.."Status:ReplySudo"..msg_chat_id) then
if not Redis:sismember(TeleGod..'Spam:Group'..msg.sender.user_id,text) then
local listmz = Redis:smembers(TeleGod.."List:Rd:Sudo:mz")
for k,v in pairs(listmz) do
i ,j  = string.find(text, v)
if j and i then
local x = string.sub(text, i,j)
if x then
local anemi = Redis:get(TeleGod.."Add:Rd:Sudo:mz:Gif"..x)   
local veico = Redis:get(TeleGod.."Add:Rd:Sudo:mz:vico"..x)   
local stekr = Redis:get(TeleGod.."Add:Rd:Sudo:mz:stekr"..x)     
local Text = Redis:get(TeleGod.."Add:Rd:Sudo:mz:Text"..x)   
local photo = Redis:get(TeleGod.."Add:Rd:Sudo:mz:Photo"..x)
local photoc = Redis:get(TeleGod.."Add:Rd:Sudo:mz:Photoc"..x)
local video = Redis:get(TeleGod.."Add:Rd:Sudo:mz:Video"..x)
local videoc = Redis:get(TeleGod.."Add:Rd:Sudo:mz:Videoc"..x)
local document = Redis:get(TeleGod.."Add:Rd:Sudo:mz:File"..x)
local audio = Redis:get(TeleGod.."Add:Rd:Sudo:mz:Audio"..x)
local audioc = Redis:get(TeleGod.."Add:Rd:Sudo:mz:Audioc"..x)
local video_note = Redis:get(TeleGod.."Add:Rd:Sudo:mz:video_note"..x)
if Text then 
local UserInfo = LuaTele.getUser(msg.sender.user_id)
local NumMsg = Redis:get(TeleGod..'Num:Message:User'..msg_chat_id..':'..msg.sender.user_id) or 0
local TotalMsg = Total_message(NumMsg)
local Status_Gps = msg.Name_Controller
local NumMessageEdit = Redis:get(TeleGod..'Num:Message:Edit'..msg_chat_id..msg.sender.user_id) or 0
local Text = Text:gsub('#username',(UserInfo.username or 'لا يوجد')) 
local Text = Text:gsub('#name',UserInfo.first_name)
local Text = Text:gsub('#id',msg.sender.user_id)
local Text = Text:gsub('#edit',NumMessageEdit)
local Text = Text:gsub('#msgs',NumMsg)
local Text = Text:gsub('#stast',Status_Gps)
send(msg_chat_id,msg_id,'['..Text..']',"md",true)  
end
if video_note then
LuaTele.sendVideoNote(msg_chat_id, msg.id, video_note)
Redis:sadd(TeleGod.."Spam:Group"..msg.sender.user_id,text) 
end
if photo then
LuaTele.sendPhoto(msg.chat_id, msg.id, photo,photoc)
Redis:sadd(TeleGod.."Spam:Group"..msg.sender.user_id,text) 
end  
if stekr then 
LuaTele.sendSticker(msg_chat_id, msg.id, stekr)
Redis:sadd(TeleGod.."Spam:Group"..msg.sender.user_id,text) 
end
if veico then 
LuaTele.sendVoiceNote(msg_chat_id, msg.id, veico, '', 'md')
Redis:sadd(TeleGod.."Spam:Group"..msg.sender.user_id,text) 
end
if video then 
LuaTele.sendVideo(msg_chat_id, msg.id, video, videoc, "md")
Redis:sadd(TeleGod.."Spam:Group"..msg.sender.user_id,text) 
end
if anemi then 
LuaTele.sendAnimation(msg_chat_id,msg.id, anemi, '', 'md')
Redis:sadd(TeleGod.."Spam:Group"..msg.sender.user_id,text) 
end
if document then
LuaTele.sendDocument(msg_chat_id, msg.id, document, '', 'md')
Redis:sadd(TeleGod.."Spam:Group"..msg.sender.user_id,text) 
end  
if audio then
LuaTele.sendAudio(msg_chat_id, msg.id, audio, audioc, "md") 
Redis:sadd(TeleGod.."Spam:Group"..msg.sender.user_id,text) 
end
end
end
end
end
end
if text == "اضف رد مميز" then 
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*✦ هاذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/uui9u'}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(TeleGod.."Set:Rd:mz"..msg.sender.user_id..":"..msg_chat_id,true)
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = 'الغاء الامر', data = msg.sender.user_id..'/cancelrdd'},
},
}
}
return send(msg_chat_id,msg_id,"✦ ارسل الان الكلمه لاضافتها في الردود المميزه ","md",false, false, false, false, reply_markup)
end 
if text == "حذف رد مميز" then 
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*✦ هاذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/uui9u'}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(TeleGod.."Set:On:mz"..msg.sender.user_id..":"..msg_chat_id,true)
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = 'الغاء الامر', data = msg.sender.user_id..'/cancelrdd'},
},
}
}
return send(msg_chat_id,msg_id,"✦ ارسل الان الكلمه لحذفها من الردود المميزه","md",false, false, false, false, reply_markup)
end 
if text and not Redis:sismember(TeleGod.."Spam:Group"..msg.sender.user_id,text) then
Redis:del(TeleGod.."Spam:Group"..msg.sender.user_id) 
end
if text == "مسح الردود المميزه" then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*✦ هاذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/otlop12'}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local list = Redis:smembers(TeleGod.."List:Rd:Sudo:mz")
for k,v in pairs(list) do
Redis:del(TeleGod.."Add:Rd:Sudo:mz:Gif"..v)
Redis:del(TeleGod.."Add:Rd:Sudo:mz:vico"..v)
Redis:del(TeleGod.."Add:Rd:Sudo:mz:stekr"..v)
Redis:del(TeleGod.."Add:Rd:Sudo:mz:Text"..v)
Redis:del(TeleGod.."Add:Rd:Sudo:mz:Photo"..v)
Redis:del(TeleGod.."Add:Rd:Sudo:mz:Photoc"..v)
Redis:del(TeleGod.."Add:Rd:Sudo:mz:Video"..v)
Redis:del(TeleGod.."Add:Rd:Sudo:mz:Videoc"..v)
Redis:del(TeleGod.."Add:Rd:Sudo:mz:File"..v)
Redis:del(TeleGod.."Add:Rd:Sudo:mz:Audio"..v)
Redis:del(TeleGod.."Add:Rd:Sudo:mz:Audioc"..v)
Redis:del(TeleGod.."Add:Rd:Sudo:mz:video_note"..v)
Redis:del(TeleGod.."List:Rd:Sudo:mz")
end
send(msg_chat_id,msg_id,"✦ تم مسح قائمه الردود المميزه","md",true)  
end
if text == ("الردود المميزه") then 
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*✦ هاذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = 't.me/otlop12'}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local list = Redis:smembers(TeleGod.."List:Rd:Sudo:mz")
text = "\n✦ قائمة الردود المميزه \n⩹━━━━✦ 𝗧𝗘𝗟𝗘𝗚𝗢𝗗 ✦ ━━━━⩺\n"
for k,v in pairs(list) do
if Redis:get(TeleGod.."Add:Rd:Sudo:mz:Gif"..v) then
db = "متحركه ✦ "
elseif Redis:get(TeleGod.."Add:Rd:Sudo:mz:vico"..v) then
db = "بصمه ✦ "
elseif Redis:get(TeleGod.."Add:Rd:Sudo:mz:stekr"..v) then
db = "ملصق ✦ "
elseif Redis:get(TeleGod.."Add:Rd:Sudo:mz:Text"..v) then
db = "رساله ✦ "
elseif Redis:get(TeleGod.."Add:Rd:Sudo:mz:Photo"..v) then
db = "صوره ✦ "
elseif Redis:get(TeleGod.."Add:Rd:Sudo:mz:Video"..v) then
db = "فيديو ✦ "
elseif Redis:get(TeleGod.."Add:Rd:Sudo:mz:File"..v) then
db = "ملف ✦ "
elseif Redis:get(TeleGod.."Add:Rd:Sudo:mz:Audio"..v) then
db = "اغنيه ✦ "
elseif Redis:get(TeleGod.."Add:Rd:Sudo:mz:video_note"..v) then
db = "بصمه فيديو ✦ "
end
text = text..""..k.." » {"..v.."} » {"..db.."}\n"
end
if #list == 0 then
text = "✦ لا توجد ردود مميزه"
end
return send(msg_chat_id,msg_id,"["..text.."]","md",true)  
end
if text == "التوحيد" then
local s1 = database:get(bot_id.."TeleGod:teh"..msg.chat_id_) or "لا يوجد توحيد"
local s2 = database:get(bot_id.."TeleGod:nump"..msg.chat_id_) or 5
send(msg.chat_id_, msg.id_,'✦ التوحيد '..s1..'\n ✦️ عدد الكتم  : '..s2)
end
end
if text == "تفعيل التوحيد" and Constructor(msg) and database:get(bot_id.."AL:AddS0FI:stats") == "✔" then
send(msg.chat_id_, msg.id_, '✦ تم تفعيل التوحيد')
database:set(bot_id.."kt:twh:stats"..msg.chat_id_,"open")
end
if text == "تعطيل التوحيد" and Constructor(msg) and database:get(bot_id.."AL:AddS0FI:stats") == "✔" then
send(msg.chat_id_, msg.id_, '✦ تم تعطيل التوحيد')
database:set(bot_id.."kt:twh:stats"..msg.chat_id_,"close")
end
if not Constructor(msg) then
if database:get(bot_id.."kt:twh:stats"..msg.chat_id_) == "open"  and database:get(bot_id.."TeleGod:teh"..msg.chat_id_) then 
id = msg.sender_user_id_
function sofi_mrsofi_new(mrsofi1,mrsofi2)
if mrsofi2 and mrsofi2.first_name_ then 
if mrsofi2.first_name_:match("(.*)"..database:get(bot_id.."TeleGod:teh"..msg.chat_id_).."(.*)") then 
database:srem(bot_id.."TeleGod:Muted:User"..msg.chat_id_, msg.sender_user_id_)
else
local mrsofi_nnn = database:get(bot_id.."TeleGod:nump"..msg.chat_id_) or 5
local mrsofi_nnn2 = database:get(bot_id.."TeleGod:nump22"..msg.chat_id_..msg.sender_user_id_) or 0
if (tonumber(mrsofi_nnn2) == tonumber(mrsofi_nnn) or tonumber(mrsofi_nnn2) > tonumber(mrsofi_nnn)) then 
database:sadd(bot_id..'Muted:User'..msg.chat_id_, msg.sender_user_id_)
else 
database:incrby(bot_id.."TeleGod:nump22"..msg.chat_id_..msg.sender_user_id_,1)
send(msg.chat_id_, msg.id_, "✦ عزيزي >>["..mrsofi2.username_.."](https://t.me/"..(mrsofi2.username_ or "U440p")..")\n✦ عليك وضع التوحيد ⪼ {"..database:get(bot_id.."TeleGod:teh"..msg.chat_id_).."} بجانب اسمك\n✦ عدد المحاولات المتبقيه {"..(tonumber(mrsofi_nnn) - tonumber(mrsofi_nnn2)).."}")
end
end
end
end
bnnaGet(id, sofi_mrsofi_new)
end
end
if text == "تفعيل تنبيه الاسماء" and Manager(msg) and database:get(bot_id.."AL:Sre:stats") == "✔" then
send(msg.chat_id_, msg.id_, '✦ تم تفعيل تنبيه الاسماء')
database:set(bot_id.."Ttn:BBE:stats"..msg.chat_id_,"open")
end
if text == "تعطيل تنبيه الاسماء" and Manager(msg) and database:get(bot_id.."AL:Sre:stats") == "✔" then
send(msg.chat_id_, msg.id_, '✦ تم تعطيل تنبيه الاسماء')
database:set(bot_id.."Ttn:BBE:stats"..msg.chat_id_,"close")
end
if text and database:get(bot_id.."Ttn:BBE:stats"..msg.chat_id_) == "open" then 
tdcli_function({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data)
if data.id_ then 
if data.id_ ~= bot_id then
local TeleGodChengName = database:get(bot_id.."TeleGod:Cheng:Name"..data.id_)
if not data.first_name_ then 
if TeleGodChengName then 
send(msg.chat_id_, msg.id_, " معرفه كان حلو ["..TeleGodChengName..']')
database:del(bot_id.."TeleGod:Cheng:Name"..data.id_) 
end
end
if data.first_name_ then 
if TeleGodChengName ~= data.first_name_ then 
local Text = {
  "جان اسمك حلو بتغيره ليه ",
"غيرت اسمك ليه يا بضان ",
"الواد دا غير اسمه اقتلوووه 🤓😂 ",
}
send(msg.chat_id_, msg.id_,Text[math.random(#Text)])
end  
database:set(bot_id.."TeleGod:Cheng:Name"..data.id_, data.first_name_) 
end
end
end
end,nil)   
end
if text == "تفعيل تنبيه المعرف" and Constructor(msg) and database:get(bot_id.."AL:Sre:stats") == "✔" then
send(msg.chat_id_, msg.id_, '✦ تم تفعيل تنبيه المعرف')
database:set(bot_id.."Ttn:Userr:stats"..msg.chat_id_,"open")
end
if text == "تعطيل تنبيه المعرف" and Constructor(msg) and database:get(bot_id.."AL:Sre:stats") == "✔" then
send(msg.chat_id_, msg.id_, '✦ تم تعطيل تنبيه المعرف')
database:set(bot_id.."Ttn:Userr:stats"..msg.chat_id_,"close")
end
if text and database:get(bot_id.."Ttn:Userr:stats"..msg.chat_id_) == "open" then  
tdcli_function({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data)
if data.id_ then 
if data.id_ ~= bot_id then
local TeleGodChengUserName = database:get(bot_id.."TeleGod:Cheng:UserName"..data.id_)
if not data.username_ then 
if TeleGodChengUserName then 
send(msg.chat_id_, msg.id_, 1, "حذف معرفه خدوه بسرعه  \n دا معرفه  : [@"..TeleGodChengUserName..']')
database:del(bot_id.."TeleGod:Cheng:UserName"..data.id_) 
end
end
if data.username_ then 
if TeleGodChengUserName ~= data.username_ then 
local Text = {
'غيرت معرفك ليه نشرولك المعرف في قنوات انحراف ولا اي 😹',
"غيرت معرفك ليه هما هددوك ولا اي 🤞😂",
"مش فاهم انا استفادت اي لما غيرت معرفك 😐🌝",
"غير المعرف بتاعه خدوه بسرعه \n دا معرفه : @"..data.username_.."",
'مش كان معرفك \n غيرته ليه لـ @'..data.username_..' ',
'مغير معرفك لي ياض 🤓😂', 
"منور معرفك الجديد : "..data.username_.."",
}
send(msg.chat_id_, msg.id_,Text[math.random(#Text)])
end  
database:set(bot_id.."TeleGod:Cheng:UserName"..data.id_, data.username_) 
end
end
end
end,nil)   
end
if text == "تفعيل تنبيه الصور" and Manager(msg) and database:get(bot_id.."AL:Sre:stats") == "✔" then
send(msg.chat_id_, msg.id_, '✦ تم تفعيل تنبيه الصور')
database:set(bot_id.."Ttn:Ph:stats"..msg.chat_id_,"open")
end
if text == "تعطيل تنبيه الصور" and Manager(msg) and database:get(bot_id.."AL:Sre:stats") == "✔" then
send(msg.chat_id_, msg.id_, '✦ تم تعطيل تنبيه الصور')
database:set(bot_id.."Ttn:Ph:stats"..msg.chat_id_,"close")
end
if text and database:get(bot_id.."Ttn:Ph:stats"..msg.chat_id_) == "open" then  
tdcli_function({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data)
if data.id_ then 
if data.id_ ~= bot_id then 
local TeleGodChengPhoto = database:get(bot_id.."TeleGod:Cheng:Photo"..data.id_)
if not data.profile_photo_ then 
if TeleGodChengPhoto then 
send(msg.chat_id_, msg.id_, "حذف كل صوره الخبيث 😂👌🏻")
database:del(bot_id.."TeleGod:Cheng:Photo"..data.id_) 
end
end
if data.profile_photo_.big_.persistent_id_ then 
if TeleGodChengPhoto ~= data.profile_photo_.big_.persistent_id_ then 
local Text = {
  "غيرت صورتك ليه يا خبيث انت",
  "مين الحلو اللي في الصوره دا",
  "بتغير صورتك ليه 🤔😹",
  "غيرت صورتك شقط مظهه جديده ولا اي 😹😹🌚",
  "كل شويه صوره جديده متقرفناش بقا",
  "غيرت صورتك ليه اتخانقت مع الكراش ولا اي 😂🤔",
}
send(msg.chat_id_, msg.id_,Text[math.random(#Text)])
end  
database:set(bot_id.."TeleGod:Cheng:Photo"..data.id_, data.profile_photo_.big_.persistent_id_) 
end
end
end
end,nil)   
end
-------

if text == 'السورس' or text == 'سورس' or text == 'يا سورس' or text == 'source' then
photo = "https://t.me/sertonge/3"
local T =[[
The besT sourCe on TeLeGrAm
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'أضـف البـوت الـي مجـموعـتـك ➕', url = 't.me/'..UserBot..'?startgroup=new'},
},
}
local msgg = msg_id/2097152/0.5
https.request("https://api.telegram.org/bot"..Token.."/sendphoto?chat_id=" .. msg_chat_id .. "&photo="..photo.."&caption=".. URL.escape(T).."&reply_to_message_id="..msgg.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
elseif text == 'الاوامر' then
if otlop(msg) == false then
local chinfo = Redis:get("ch:admin:3am")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '‹اوامر الحمايه›', data = msg.sender.user_id..'/help1'}, {text = '‹اوامر الادمنيه›', data = msg.sender.user_id..'/help2'}, 
},
{
{text = '‹اوامر المدراء›', data = msg.sender.user_id..'/help3'}, {text = '‹اوامر المنشئين›', data = msg.sender.user_id..'/help4'}, 
},
{
{text = '‹اوامر المطور›', data = msg.sender.user_id..'/help5'}, {text = '‹اوامر التسليه›', data = msg.sender.user_id..'/help7'}, 
},
{
{text = 'الالعاب', data = msg.sender.user_id..'/help6'}, 
},
{
{text = 'اوامر القفل', data = msg.sender.user_id..'/NoNextSeting'}, {text = 'اوامر التعطيل', data = msg.sender.user_id..'/listallAddorrem'}, 
},
{
{text = '◜𝑠𝑜𝑢𝑟𝑐𝑒 𝑡𝑒𝑙𝑒𝑔𝑜𝑑◞', url = 't.me/'..chsource..''}, 
},
}
}
return send(msg_chat_id,msg_id, [[*
✦ توجد ← 6 اوامر في البوت
⩹━━━━✦ 𝗧𝗘𝗟𝗘𝗚𝗢𝗗 ✦ ━━━━⩺
✦ 1 ← اوامر الحمايه
✦ 2 ← اوامر الادمنيه
✦ 3 ← اوامر المدراء
✦ 4 ← اوامر المنشئين
✦ 5 ← اوامر مطورين البوت
✦ 6 ← اوامر التسلية البوت
*]],"md",false, false, false, false, reply_markup)
elseif text == 'بنك' then
if otlop(msg) == false then
local chinfo = Redis:get("ch:admin:3am")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '◜𝑠𝑜𝑢𝑟𝑐𝑒 𝑡𝑒𝑙𝑒𝑔𝑜𝑑◞', url = 't.me/'..chsource..''}, 
},
}
}
return send(msg_chat_id,msg_id, [[*
✦ اوامر البنك

⌯ انشاء حساب بنكي  ↢ تعمل حساب وتقدر تحول فلوس 

⌯ مسح حساب بنكي  ↢ تلغي حسابك البنكي

⌯ تحويل ↢ تطلب رقم حساب الشخص وتحول له فلوس

⌯ حسابي  ↢ يطلع لك رقم حسابك 

⌯ فلوسي ↢ يعلمك كم فلوسك
⌯ كنز ↢ البحث عن كنزك

⌯ راتبي ↢ يعطيك راتبك كل ٢٠ دقيقة

⌯ بخشيش ↢ يعطيك بخشيش كل ١٠ دقايق

⌯ زرف ↢ تزرف فلوس اشخاص كل ١٠ دقايق

⌯ استثمار ↢ تستثمر بالمبلغ اللي تبيه مع نسبة ربح مضمونه من ١٪؜ الى ١٥٪؜

⌯ حظ ↢ تلعبها بأي مبلغ ياتكسب يا تخسر

⌯ مضاربه ↢ تضارب بأي مبلغ انت عاوزو والنسبة من ٩٠٪؜ الى -٩٠٪؜ انت وحظك

⌯ توب الفلوس ↢ يطلع توب اكتر ناس معهم فلوس في كل الجروبات

⌯ توب الحراميه ↢ يطلع لك اكتر ناس سرقو 😂
⌯ كنز او الكنز ↢ عمليه البحث عن كنزك
*]],"md",false, false, false, false, reply_markup)
elseif text == 'م1' then
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = ' قائمه الاوامر ', data = msg.sender.user_id..'/helpall'},
},
{
{text = '◜𝑠𝑜𝑢𝑟𝑐𝑒 𝑡𝑒𝑙𝑒𝑔𝑜𝑑◞', url = 't.me/'..chsource..''}, 
},
}
}
return send(msg_chat_id,msg_id,'✦ عليك استخدام اوامر التحكم بالقوائم',"md",false, false, false, false, reply_markup)
elseif text == 'م2' then
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = ' قائمه الاوامر ', data = msg.sender.user_id..'/helpall'},
},
{
{text = '◜𝑠𝑜𝑢𝑟𝑐𝑒 𝑡𝑒𝑙𝑒𝑔𝑜𝑑◞', url = 't.me/'..chsource..''}, 
},
}
}
return send(msg_chat_id,msg_id,'✦ عليك استخدام اوامر التحكم بالقوائم',"md",false, false, false, false, reply_markup)
elseif text == 'م3' then
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = ' قائمه الاوامر ', data = msg.sender.user_id..'/helpall'},
},
{
{text = '◜𝑠𝑜𝑢𝑟𝑐𝑒 𝑡𝑒𝑙𝑒𝑔𝑜𝑑◞', url = 't.me/'..chsource..''}, 
},
}
}
return send(msg_chat_id,msg_id,'✦ عليك استخدام اوامر التحكم بالقوائم',"md",false, false, false, false, reply_markup)
elseif text == 'م4' then
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = ' قائمه الاوامر ', data = msg.sender.user_id..'/helpall'},
},
{
{text = '◜𝑠𝑜𝑢𝑟𝑐𝑒 𝑡𝑒𝑙𝑒𝑔𝑜𝑑◞', url = 't.me/'..chsource..''}, 
},
}
}
return send(msg_chat_id,msg_id,'✦ عليك استخدام اوامر التحكم بالقوائم',"md",false, false, false, false, reply_markup)
elseif text == 'م5' then
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = ' قائمه الاوامر ', data = msg.sender.user_id..'/helpall'},
},
{
{text = '◜𝑠𝑜𝑢𝑟𝑐𝑒 𝑡𝑒𝑙𝑒𝑔𝑜𝑑◞', url = 't.me/'..chsource..''}, 
},
}
}
return send(msg_chat_id,msg_id,'✦ عليك استخدام اوامر التحكم بالقوائم',"md",false, false, false, false, reply_markup)
elseif text == 'م6' then
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = ' قائمه الاوامر ', data = msg.sender.user_id..'/helpall'},
},
{
{text = '◜𝑠𝑜𝑢𝑟𝑐𝑒 𝑡𝑒𝑙𝑒𝑔𝑜𝑑◞', url = 't.me/'..chsource..''}, 
},
}
}
return send(msg_chat_id,msg_id,'✦ عليك استخدام اوامر التحكم بالقوائم',"md",false, false, false, false, reply_markup)
elseif text == 'الالعاب' then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = 'العاب السورس ™️', data = msg.sender.user_id..'/normgm'}, {text = 'العاب متطورة 🎳', data = msg.sender.user_id..'/degm'}, 
},
{
{text = 'بنك الحظ 🏦', data = msg.sender.user_id..'/bank'}, 
},
{
{text = '◜𝑠𝑜𝑢𝑟𝑐𝑒 𝑡𝑒𝑙𝑒𝑔𝑜𝑑◞', url = 't.me/'..chsource..''}, 
},
}
}
return send(msg_chat_id,msg_id,'مرحبا عزيزي في قائمه الالعاب الخاصه بالسورس 💎',"md",false, false, false, false, reply_markup)
end

if text == 'تحديث' then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
end

if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
print('Chat Id : '..msg_chat_id)
print('User Id : '..msg_user_send_id)
send(msg_chat_id,msg_id, "✦ تم تحديث الملفات ","md",true)
dofile('TeleGod.lua')  
end
if text == "تغيير اسم البوت" then 
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:setex(TeleGod.."Change:Name:Bot"..msg.sender.user_id,300,true) 
return send(msg_chat_id,msg_id,"✦ ارسل لي الاسم الان ","md",true)  
end
if text == "حذف اسم البوت" then 
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(TeleGod.."Name:Bot") 
return send(msg_chat_id,msg_id,"✦ تم حذف اسم البوت ","md",true)   
end
if text == (Redis:get(TeleGod.."Name:Bot") or "تلي جود") then
if Redis:get(TeleGod.."name bot type : ") == "photo" then
  local photo = LuaTele.getUserProfilePhotos(TeleGod)
  local UserInfo = LuaTele.getUser(TeleGod)
  local Name_User = UserInfo.first_name
  local Name_dev = LuaTele.getUser(Sudo_Id).first_name
  local UName_dev = LuaTele.getUser(Sudo_Id).username
  local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
    {
      {text = Name_User, url = "t.me/"..UserInfo.username}
    },
    {
      {text = Name_dev, url = "t.me/"..UName_dev }
    }
  }
  }
  
  if photo.total_count > 0 then
    local NamesBot = (Redis:get(TeleGod.."Name:Bot") or "تلي جود")
    local NameBots = {
"قلب "..NamesBot ,
"مين مزعلك بس يعيوني",
"ثانيه واحده بسلك رقم واحده",
"انا مش فاضي المبرمج صلاح مكاني اهو",
"قلبه ودقاته وكل حياته"
}
  return LuaTele.sendPhoto(msg.chat_id, msg.id, photo.photos[1].sizes[#photo.photos[1].sizes].photo.remote.id,NameBots[math.random(#NameBots)], "md", true, nil, nil, nil, nil, nil, nil, nil, nil, reply_markup )
  else
    local NamesBot = (Redis:get(TeleGod.."Name:Bot") or "تلي جود")
    local NameBots = {
"قلب "..NamesBot ,
"مين مزعلك بس يعيوني",
"ثانيه واحده بسلك رقم واحده",
"انا مش فاضي المبرمج صلاح مكاني اهو",
"قلبه ودقاته وكل حياته"
}
  return LuaTele.sendText(msg_chat_id,msg_id,NameBots[math.random(#NameBots)],"md") 
  end 
  end
      local NamesBot = (Redis:get(TeleGod.."Name:Bot") or "تلي جود")
    local NameBots = {
"قلب "..NamesBot ,
"مين مزعلك بس يعيوني",
"ثانيه واحده بسلك رقم واحده",
"انا مش فاضي المبرمج صلاح مكاني اهو",
"قلبه ودقاته وكل حياته"
}
  return LuaTele.sendText(msg_chat_id,msg_id,NameBots[math.random(#NameBots)],"md") 
 
end
----
----
if text == "بوت" then
if Redis:get(TeleGod.."name bot type : ") == "photo" then
  
    local photo = LuaTele.getUserProfilePhotos(TeleGod)
    local UserInfo = LuaTele.getUser(TeleGod)
    local Name_User = UserInfo.first_name
    local Name_dev = LuaTele.getUser(Sudo_Id).first_name
    local UName_dev = LuaTele.getUser(Sudo_Id).username
    local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
      {
        {text = Name_User, url = "t.me/"..UserInfo.username}
      },
      {
        {text = Name_dev, url = "t.me/"..UName_dev }
      }
    }
    }
    
    if photo.total_count > 0 then
      local NamesBot = (Redis:get(TeleGod.."Name:Bot") or "تلي جود")
      local BotName = {
      "اسمي "..NamesBot.." يبن العاميه",
      "يارب يكون موضوع مهم بس",
      "هو يوم مهبب انا عارف..عاوز اي ؟",
      "اسمي "..NamesBot.." يا كفيف",
      "مش شايف اسمي ولا اي ؟"
      }
    return LuaTele.sendPhoto(msg.chat_id, msg.id, photo.photos[1].sizes[#photo.photos[1].sizes].photo.remote.id,BotName[math.random(#BotName)], "md", true, nil, nil, nil, nil, nil, nil, nil, nil, reply_markup )
    else
      local NamesBot = (Redis:get(TeleGod.."Name:Bot") or "تلي جود")
      local BotName = {
      "اسمي "..NamesBot.." يبن العاميه",
      "يارب يكون موضوع مهم بس",
      "هو يوم مهبب انا عارف..عاوز اي ؟",
      "اسمي "..NamesBot.." يا كفيف",
      "مش شايف اسمي ولا اي ؟"
      }
    return LuaTele.sendText(msg_chat_id,msg_id,BotName[math.random(#BotName)],"md") 
    end 
    end
          local NamesBot = (Redis:get(TeleGod.."Name:Bot") or "تلي جود")
      local BotName = {
      "اسمي "..NamesBot.." يبن العاميه",
      "يارب يكون موضوع مهم بس",
      "هو يوم مهبب انا عارف..عاوز اي ؟",
      "اسمي "..NamesBot.." يا كفيف",
      "مش شايف اسمي ولا اي ؟"
      }
    return LuaTele.sendText(msg_chat_id,msg_id,BotName[math.random(#BotName)],"md") 

  end
  ----
if text == 'تنظيف المشتركين' then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local list = Redis:smembers(TeleGod.."Num:User:Pv")   
local x = 0
for k,v in pairs(list) do  
local Get_Chat = LuaTele.getChat(v)
local ChatAction = LuaTele.sendChatAction(v,'Typing')
if ChatAction.luatele ~= "ok" then
x = x + 1
Redis:srem(TeleGod..'Num:User:Pv',v)
end
end
if x ~= 0 then
return send(msg_chat_id,msg_id,'*✦ العدد الكلي { '..#list..' }\n✦ تم العثور على { '..x..' } من المشتركين حاظرين البوت*',"md")
else
return send(msg_chat_id,msg_id,'*✦ العدد الكلي { '..#list..' }\n✦ لم يتم العثور على وهميين*',"md")
end
end
if text == 'تنظيف المجموعات' then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local list = Redis:smembers(TeleGod.."ChekBotAdd")   
local x = 0
for k,v in pairs(list) do  
local Get_Chat = LuaTele.getChat(v)
if Get_Chat.id then
local statusMem = LuaTele.getChatMember(Get_Chat.id,TeleGod)
if statusMem.status.luatele == "chatMemberStatusMember" then
x = x + 1
send(Get_Chat.id,0,'*✦ البوت عضو في الجروب سوف اغادر ويمكنك تفعيلي مره اخره *',"md")
Redis:srem(TeleGod..'ChekBotAdd',Get_Chat.id)
local keys = Redis:keys(TeleGod..'*'..Get_Chat.id)
for i = 1, #keys do
Redis:del(keys[i])
end
LuaTele.leaveChat(Get_Chat.id)
end
else
x = x + 1
local keys = Redis:keys(TeleGod..'*'..v)
for i = 1, #keys do
Redis:del(keys[i])
end
Redis:srem(TeleGod..'ChekBotAdd',v)
LuaTele.leaveChat(v)
end
end
if x ~= 0 then
return send(msg_chat_id,msg_id,'*✦ العدد الكلي { '..#list..' } للمجموعات \n✦ تم العثور على { '..x..' } مجموعات البوت ليس ادمن \n✦ تم تعطيل الجروب ومغادره البوت من الوهمي *',"md")
else
return send(msg_chat_id,msg_id,'*✦ العدد الكلي { '..#list..' } للمجموعات \n✦ لا توجد مجموعات وهميه*',"md")
end
end
if text == "سمايلات" or text == "سمايل" then
if Redis:get(TeleGod.."Status:Games"..msg.chat_id) then
Random = {"🍏","🍎","🍐","🍊","🍋","🍉","🍇","🍓","🍈","🍒","🍑","🍍","🥥","🥝","🍅","🍆","🥑","🥦","🥒","🌶","🌽","🥕","🥔","🥖","🥐","🍞","🥨","🍟","🧀","🥚","🍳","🥓","🥩","🍗","🍖","🌭","🍔","🍠","🍕","🥪","🥙","☕️","🥤","🍶","🍺","🍻","🏀","⚽️","🏈","⚾️","🎾","🏐","🏉","🎱","🏓","🏸","🥅","🎰","🎮","🎳","🎯","🎲","🎻","🎸","🎺","🥁","🎹","🎼","🎧","🎤","🎬","🎨","🎭","🎪","🎟","🎫","🎗","🏵","🎖","🏆","🥌","🛷","🚗","🚌","🏎","🚓","🚑","🚚","🚛","🚜","⚔","🛡","🔮","🌡","💣","✦ ","📍","📓","📗","📂","📅","📪","📫","✦ ","📭","⏰","📺","🎚","☎️","📡"}
SM = Random[math.random(#Random)]
Redis:set(TeleGod.."Game:Smile"..msg.chat_id,SM)
return send(msg_chat_id,msg_id,"✦ اسرع واحد يبعت هاذا السمايل ? ~ {`"..SM.."`}","md",true)  
end
end
if text == "تويت" or text == "كت تويت" then
if Redis:get(TeleGod.."Status:Games"..msg.chat_id) then
local texting = {"اخر افلام شاهدتها", 
"اخر افلام شاهدتها", 
"ما هي وظفتك الحياه", 
"اعز اصدقائك ?", 
"اخر اغنية سمعتها ?", 
"تكلم عن نفسك", 
"ليه انت مش سالك", 
"ما هيا عيوب سورس تلي جود؟ ", 
"اخر كتاب قرآته", 
"روايتك المفضله ?", 
"اخر اكله اكلتها", 
"اخر كتاب قرآته", 
"ليش حسين ذكي؟ ", 
"افضل يوم ف حياتك", 
"ليه مضيفتش كل جهاتك", 
"حكمتك ف الحياه", 
"لون عيونك", 
"كتابك المفضل", 
"هوايتك المفضله", 
"علاقتك مع اهلك", 
" ما السيء في هذه الحياة ؟ ", 
"أجمل شيء حصل معك خلال هذا الاسبوع ؟ ", 
"سؤال ينرفزك ؟ ", 
" هل يعجبك سورس تلي جود؟ ", 
" اكثر ممثل تحبه ؟ ", 
"قد تخيلت شي في بالك وصار ؟ ", 
"شيء عندك اهم من الناس ؟ ", 
"تفضّل النقاش الطويل او تحب الاختصار ؟ ", 
"وش أخر شي ضيعته؟ ", 
"اي رايك في سورس تلي جود؟ ", 
"كم مره حبيت؟ ", 
" اكثر المتابعين عندك باي برنامج؟", 
" نسبه الندم عندك للي وثقت فيهم ؟", 
"تحب ترتبط بكيرفي ولا فلات؟", 
" جربت شعور احد يحبك بس انت مو قادر تحبه؟", 
" تجامل الناس ولا اللي بقلبك على لسانك؟", 
" عمرك ضحيت باشياء لاجل شخص م يسوى ؟", 
"مغني تلاحظ أن صوته يعجب الجميع إلا أنت؟ ", 
" آخر غلطات عمرك؟ ", 
" مسلسل كرتوني له ذكريات جميلة عندك؟ ", 
" ما أكثر تطبيق تقضي وقتك عليه؟ ", 
" أول شيء يخطر في بالك إذا سمعت كلمة نجوم ؟ ", 
" قدوتك من الأجيال السابقة؟ ", 
" أكثر طبع تهتم بأن يتواجد في شريك/ة حياتك؟ ", 
"أكثر حيوان تخاف منه؟ ", 
" ما هي طريقتك في الحصول على الراحة النفسية؟ ", 
" إيموجي يعبّر عن مزاجك الحالي؟ ", 
" أكثر تغيير ترغب أن تغيّره في نفسك؟ ", 
"أكثر شيء أسعدك اليوم؟ ", 
"اي رايك في الدنيا دي ؟ ", 
"ما هو أفضل حافز للشخص؟ ", 
"ما الذي يشغل بالك في الفترة الحالية؟", 
"آخر شيء ندمت عليه؟ ", 
"شاركنا صورة احترافية من تصويرك؟ ", 
"تتابع انمي؟ إذا نعم ما أفضل انمي شاهدته ", 
"يرد عليك متأخر على رسالة مهمة وبكل برود، موقفك؟ ", 
"نصيحه تبدا ب -لا- ؟ ", 
"كتاب أو رواية تقرأها هذه الأيام؟ ", 
"فيلم عالق في ذهنك لا تنساه مِن روعته؟ ", 
"يوم لا يمكنك نسيانه؟ ", 
"شعورك الحالي في جملة؟ ", 
"كلمة لشخص بعيد؟ ", 
"صفة يطلقها عليك الشخص المفضّل؟ ", 
"أغنية عالقة في ذهنك هاليومين؟ ", 
"أكلة مستحيل أن تأكلها؟ ", 
"كيف قضيت نهارك؟ ", 
"تصرُّف ماتتحمله؟ ", 
"موقف غير حياتك؟ ", 
"اكثر مشروب تحبه؟ ", 
"القصيدة اللي تأثر فيك؟ ", 
"متى يصبح الصديق غريب ", 
"وين نلقى السعاده برايك؟ ", 
"تاريخ ميلادك؟ ", 
"قهوه و لا شاي؟ ", 
"من محبّين الليل أو الصبح؟ ", 
"حيوانك المفضل؟ ", 
"كلمة غريبة ومعناها؟ ", 
"كم تحتاج من وقت لتثق بشخص؟ ", 
"اشياء نفسك تجربها؟ ", 
"يومك ضاع على؟ ", 
"كل شيء يهون الا ؟ ", 
"اسم ماتحبه ؟ ", 
"وقفة إحترام للي إخترع ؟ ", 
"أقدم شيء محتفظ فيه من صغرك؟ ", 
"كلمات ماتستغني عنها بسوالفك؟ ", 
"وش الحب بنظرك؟ ", 
"حب التملك في شخصِيـتك ولا ؟ ", 
"تخطط للمستقبل ولا ؟ ", 
"موقف محرج ماتنساه ؟ ", 
"من طلاسم لهجتكم ؟ ", 
"اعترف باي حاجه ؟ ", 
"عبّر عن مودك بصوره ؟ ",
"اسم دايم ع بالك ؟ ", 
"اشياء تفتخر انك م سويتها ؟ ", 
" لو بكيفي كان ؟ ", 
  "أكثر جملة أثرت بك في حياتك؟ ",
  "إيموجي يوصف مزاجك حاليًا؟ ",
  "أجمل اسم بنت بحرف الباء؟ ",
  "كيف هي أحوال قلبك؟ ",
  "أجمل مدينة؟ ",
  "كيف كان أسبوعك؟ ",
  "شيء تشوفه اكثر من اهلك ؟ ",
  "اخر مره فضفضت؟ ",
  "قد كرهت احد بسبب اسلوبه؟ ",
  "قد حبيت شخص وخذلك؟ ",
  "كم مره حبيت؟ ",
  "اكبر غلطة بعمرك؟ ",
  "نسبة النعاس عندك حاليًا؟ ",
  "شرايكم بمشاهير التيك توك؟ ",
  "ما الحاسة التي تريد إضافتها للحواس الخمسة؟ ",
  "اسم قريب لقلبك؟ ",
  "مشتاق لمطعم كنت تزوره قبل الحظر؟ ",
  "أول شيء يخطر في بالك إذا سمعت كلمة (ابوي يبيك)؟ ",
  "ما أول مشروع تتوقع أن تقوم بإنشائه إذا أصبحت مليونير؟ ",
  "أغنية عالقة في ذهنك هاليومين؟ ",
  "متى اخر مره قريت قرآن؟ ",
  "كم صلاة فاتتك اليوم؟ ",
  "تفضل التيكن او السنقل؟ ",
  "وش أفضل بوت برأيك؟ ",
"كم لك بالتلي؟ ",
"وش الي تفكر فيه الحين؟ ",
"كيف تشوف الجيل ذا؟ ",
"منشن شخص وقوله، تحبني؟ ",
"لو جاء شخص وعترف لك كيف ترده؟ ",
"مر عليك موقف محرج؟ ",
"وين تشوف نفسك بعد سنتين؟ ",
"لو فزعت/ي لصديق/ه وقالك مالك دخل وش بتسوي/ين؟ ",
"وش اجمل لهجة تشوفها؟ ",
"قد سافرت؟ ",
"افضل مسلسل عندك؟ ",
"افضل فلم عندك؟ ",
"مين اكثر يخون البنات/العيال؟ ",
"متى حبيت؟ ",
  "بالعادة متى تنام؟ ",
  "شيء من صغرك ماتغيير فيك؟ ",
  "شيء بسيط قادر يعدل مزاجك بشكل سريع؟ ",
  "تشوف الغيره انانيه او حب؟ ",
"حاجة تشوف نفسك مبدع فيها؟ ",
  "مع او ضد : يسقط جمال المراة بسبب قبح لسانها؟ ",
  "عمرك بكيت على شخص مات في مسلسل ؟ ",
  "‏- هل تعتقد أن هنالك من يراقبك بشغف؟ ",
  "تدوس على قلبك او كرامتك؟ ",
  "اكثر لونين تحبهم مع بعض؟ ",
  "مع او ضد : النوم افضل حل لـ مشاكل الحياة؟ ",
  "سؤال دايم تتهرب من الاجابة عليه؟ ",
  "تحبني ولاتحب الفلوس؟ ",
  "العلاقه السريه دايماً تكون حلوه؟ ",
  "لو أغمضت عينيك الآن فما هو أول شيء ستفكر به؟ ",
"كيف ينطق الطفل اسمك؟ ",
  "ما هي نقاط الضعف في شخصيتك؟ ",
  "اكثر كذبة تقولها؟ ",
  "تيكن ولا اضبطك؟ ",
  "اطول علاقة كنت فيها مع شخص؟ ",
  "قد ندمت على شخص؟ ",
  "وقت فراغك وش تسوي؟ ",
  "عندك أصحاب كثير؟ ولا ينعد بالأصابع؟ ",
  "حاط نغمة خاصة لأي شخص؟ ",
  "وش اسم شهرتك؟ ",
  "أفضل أكلة تحبه لك؟ ",
"عندك شخص تسميه ثالث والدينك؟ ",
  "عندك شخص تسميه ثالث والدينك؟ ",
  "اذا قالو لك تسافر أي مكان تبيه وتاخذ معك شخص واحد وين بتروح ومين تختار؟ ",
  "أطول مكالمة كم ساعة؟ ",
  "تحب الحياة الإلكترونية ولا الواقعية؟ ",
  "كيف حال قلبك ؟ بخير ولا مكسور؟ ",
  "أطول مدة نمت فيها كم ساعة؟ ",
  "تقدر تسيطر على ضحكتك؟ ",
  "أول حرف من اسم الحب؟ ",
  "تحب تحافظ على الذكريات ولا تمسحه؟ ",
  "اسم اخر شخص زعلك؟ ",
"وش نوع الأفلام اللي تحب تتابعه؟ ",
  "أنت انسان غامض ولا الكل يعرف عنك؟ ",
  "لو الجنسية حسب ملامحك وش بتكون جنسيتك؟ ",
  "عندك أخوان او خوات من الرضاعة؟ ",
  "إختصار تحبه؟ ",
  "إسم شخص وتحس أنه كيف؟ ",
  "وش الإسم اللي دايم تحطه بالبرامج؟ ",
  "وش برجك؟ ",
  "لو يجي عيد ميلادك تتوقع يجيك هدية؟ ",
  "اجمل هدية جاتك وش هو؟ ",
  "الصداقة ولا الحب؟ ",
"الصداقة ولا الحب؟ ",
  "الغيرة الزائدة شك؟ ولا فرط الحب؟ ",
  "قد حبيت شخصين مع بعض؟ وانقفطت؟ ",
  "وش أخر شي ضيعته؟ ",
  "قد ضيعت شي ودورته ولقيته بيدك؟ ",
  "تؤمن بمقولة اللي يبيك مايحتار فيك؟ ",
  "سبب وجوك بالتليجرام؟ ",
  "تراقب شخص حاليا؟ ",
  "عندك معجبين ولا محد درا عنك؟ ",
  "لو نسبة جمالك بتكون بعدد شحن جوالك كم بتكون؟ ",
  "أنت محبوب بين الناس؟ ولاكريه؟ ",
"كم عمرك؟ ",
  "لو يسألونك وش اسم امك تجاوبهم ولا تسفل فيهم؟ ",
  "تؤمن بمقولة الصحبة تغنيك الحب؟ ",
  "وش مشروبك المفضل؟ ",
  "قد جربت الدخان بحياتك؟ وانقفطت ولا؟ ",
  "أفضل وقت للسفر؟ الليل ولا النهار؟ ",
  "انت من النوع اللي تنام بخط السفر؟ ",
  "عندك حس فكاهي ولا نفسية؟ ",
  "تبادل الكراهية بالكراهية؟ ولا تحرجه بالطيب؟ ",
  "أفضل ممارسة بالنسبة لك؟ ",
  "لو قالو لك تتخلى عن شي واحد تحبه بحياتك وش يكون؟ ",
"لو احد تركك وبعد فتره يحاول يرجعك بترجع له ولا خلاص؟ ",
  "برأيك كم العمر المناسب للزواج؟ ",
  "اذا تزوجت بعد كم بتخلف عيال؟ ",
  "فكرت وش تسمي أول اطفالك؟ ",
  "من الناس اللي تحب الهدوء ولا الإزعاج؟ ",
  "الشيلات ولا الأغاني؟ ",
  "عندكم شخص مطوع بالعايلة؟ ",
  "تتقبل النصيحة من اي شخص؟ ",
  "اذا غلطت وعرفت انك غلطان تحب تعترف ولا تجحد؟ ",
  "جربت شعور احد يحبك بس انت مو قادر تحبه؟ ",
  "دايم قوة الصداقة تكون بإيش؟ ",
"أفضل البدايات بالعلاقة بـ وش؟ ",
  "وش مشروبك المفضل؟ او قهوتك المفضلة؟ ",
  "تحب تتسوق عبر الانترنت ولا الواقع؟ ",
  "انت من الناس اللي بعد ماتشتري شي وتروح ترجعه؟ ",
  "أخر مرة بكيت متى؟ وليش؟ ",
  "عندك الشخص اللي يقلب الدنيا عشان زعلك؟ ",
  "أفضل صفة تحبه بنفسك؟ ",
  "كلمة تقولها للوالدين؟ ",
  "أنت من الناس اللي تنتقم وترد الاذى ولا تحتسب الأجر وتسامح؟ ",
  "كم عدد سنينك بالتليجرام؟ ",
  "تحب تعترف ولا تخبي؟ ",
"انت من الناس الكتومة ولا تفضفض؟ ",
  "أنت بعلاقة حب الحين؟ ",
  "عندك اصدقاء غير جنسك؟ ",
  "أغلب وقتك تكون وين؟ ",
  "لو المقصود يقرأ وش بتكتب له؟ ",
  "تحب تعبر بالكتابة ولا بالصوت؟ ",
  "عمرك كلمت فويس احد غير جنسك؟ ",
  "لو خيروك تصير مليونير ولا تتزوج الشخص اللي تحبه؟ ",
  "لو عندك فلوس وش السيارة اللي بتشتريها؟ ",
  "كم أعلى مبلغ جمعته؟ ",
  "اذا شفت احد على غلط تعلمه الصح ولا تخليه بكيفه؟ ",
"قد جربت تبكي فرح؟ وليش؟ ",
"تتوقع إنك بتتزوج اللي تحبه؟ ",
  "ما هو أمنيتك؟ ",
  "وين تشوف نفسك بعد خمس سنوات؟ ",
  "لو خيروك تقدم الزمن ولا ترجعه ورا؟ ",
  "لعبة قضيت وقتك فيه بالحجر المنزلي؟ ",
  "تحب تطق الميانة ولا ثقيل؟ ",
  "باقي معاك للي وعدك ما بيتركك؟ ",
  "اول ماتصحى من النوم مين تكلمه؟ ",
  "عندك الشخص اللي يكتب لك كلام كثير وانت نايم؟ ",
  "قد قابلت شخص تحبه؟ وولد ولا بنت؟ ",
"اذا قفطت احد تحب تفضحه ولا تستره؟ ",
  "كلمة للشخص اللي يسب ويسطر؟ ",
  "آية من القران تؤمن فيه؟ ",
  "تحب تعامل الناس بنفس المعاملة؟ ولا تكون أطيب منهم؟ ",
"حاجة ودك تغييرها هالفترة؟ ",
  "كم فلوسك حاليا وهل يكفيك ام لا؟ ",
  "وش لون عيونك الجميلة؟ ",
  "من الناس اللي تتغزل بالكل ولا بالشخص اللي تحبه بس؟ ",
  "اذكر موقف ماتنساه بعمرك؟ ",
  "وش حاب تقول للاشخاص اللي بيدخل حياتك؟ ",
  "ألطف شخص مر عليك بحياتك؟ ",
"انت من الناس المؤدبة ولا نص نص؟ ",
  "كيف الصيد معاك هالأيام ؟ وسنارة ولاشبك؟ ",
  "لو الشخص اللي تحبه قال بدخل حساباتك بتعطيه ولا تكرشه؟ ",
  "أكثر شي تخاف منه بالحياه وش؟ ",
  "اكثر المتابعين عندك باي برنامج؟ ",
  "متى يوم ميلادك؟ ووش الهدية اللي نفسك فيه؟ ",
  "قد تمنيت شي وتحقق؟ ",
  "قلبي على قلبك مهما صار لمين تقولها؟ ",
  "وش نوع جوالك؟ واذا بتغييره وش بتأخذ؟ ",
  "كم حساب عندك بالتليجرام؟ ",
  "متى اخر مرة كذبت؟ ",
"كذبت في الاسئلة اللي مرت عليك قبل شوي؟ ",
  "تجامل الناس ولا اللي بقلبك على لسانك؟ ",
  "قد تمصلحت مع أحد وليش؟ ",
  "وين تعرفت على الشخص اللي حبيته؟ ",
  "قد رقمت او احد رقمك؟ ",
  "وش أفضل لعبته بحياتك؟ ",
  "أخر شي اكلته وش هو؟ ",
  "حزنك يبان بملامحك ولا صوتك؟ ",
  "لقيت الشخص اللي يفهمك واللي يقرا افكارك؟ ",
  "فيه شيء م تقدر تسيطر عليه ؟ ",
  "منشن شخص متحلطم م يعجبه شيء؟ ",
"اكتب تاريخ مستحيل تنساه ",
  "شيء مستحيل انك تاكله ؟ ",
  "تحب تتعرف على ناس جدد ولا مكتفي باللي عندك ؟ ",
  "انسان م تحب تتعامل معاه ابداً ؟ ",
  "شيء بسيط تحتفظ فيه؟ ",
  "فُرصه تتمنى لو أُتيحت لك ؟ ",
  "شيء مستحيل ترفضه ؟. ",
  "لو زعلت بقوة وش بيرضيك ؟ ",
  "تنام بـ اي مكان ، ولا بس غرفتك ؟ ",
  "ردك المعتاد اذا أحد ناداك ؟ ",
  "مين الي تحب يكون مبتسم دائما ؟ ",
" إحساسك في هاللحظة؟ ",
  "وش اسم اول شخص تعرفت عليه فالتلقرام ؟ ",
  "اشياء صعب تتقبلها بسرعه ؟ ",
  "شيء جميل صار لك اليوم ؟ ",
  "اذا شفت شخص يتنمر على شخص قدامك شتسوي؟ ",
  "يهمك ملابسك تكون ماركة ؟ ",
  "ردّك على شخص قال (أنا بطلع من حياتك)؟. ",
  "مين اول شخص تكلمه اذا طحت بـ مصيبة ؟ ",
  "تشارك كل شي لاهلك ولا فيه أشياء ما تتشارك؟ ",
  "كيف علاقتك مع اهلك؟ رسميات ولا ميانة؟ ",
  "عمرك ضحيت باشياء لاجل شخص م يسوى ؟ ",
"اكتب سطر من اغنية او قصيدة جا فـ بالك ؟ ",
  "شيء مهما حطيت فيه فلوس بتكون مبسوط ؟ ",
  "مشاكلك بسبب ؟ ",
  "نسبه الندم عندك للي وثقت فيهم ؟ ",
  "اول حرف من اسم شخص تقوله? بطل تفكر فيني ابي انام؟ ",
  "اكثر شيء تحس انه مات ف مجتمعنا؟ ",
  "لو صار سوء فهم بينك وبين شخص هل تحب توضحه ولا تخليه كذا  لان مالك خلق توضح ؟ ",
  "كم عددكم بالبيت؟ ",
  "عادي تتزوج من برا القبيلة؟ ",
  "أجمل شي بحياتك وش هو؟ ",
} 
return send(msg_chat_id,msg_id,texting[math.random(#texting)],'md')
end
end
if text == "كتبات" or text == "حكمه" or text == "قصيده" then 
if Redis:get(TeleGod.."Status:Games"..msg.chat_id) then
local texting = {"‏من ترك أمرهُ لله، أعطاه الله فوق ما يتمنَّاه💙 ", 
"‏من علامات جمال المرأة .. بختها المايل ! ",
"‏ انك الجميع و كل من احتل قلبي🫀🤍",
"‏ ‏ لقد تْعَمقتُ بكَ كَثيراً والمِيمُ لام .♥️",
"‏ ‏ممكن اكون اختارت غلط بس والله حبيت بجد🖇️",
"‏ علينا إحياء زَمن الرّسائل الورقيّة وسط هذه الفوضى الالكترونية العَارمة. ℘︙ 💜",
"‏ يجي اي الصاروخ الصيني ده جمب الصاروخ المصري لما بيلبس العبايه السوده.🤩♥️",
"‏ كُنت أرقّ من أن أتحمّل كُل تلك القَسوة من عَينيك .🍍",
"‏أَكَان عَلَيَّ أَنْ أغْرَس انيابي فِي قَلْبِك لتشعر بِي ؟.",
"‏ : كُلما أتبع قلبي يدلني إليك .",
"‏ : أيا ليت من تَهواه العينُ تلقاهُ .",
"‏ ‏: رغبتي في مُعانقتك عميقة جداً .??",
"ويُرهقني أنّي مليء بما لا أستطيع قوله.✨",
"‏ من مراتب التعاسه إطالة الندم ع شيء إنتهى. ℘︙ ",
"‏ ‏كل العالم يهون بس الدنيا بينا تصفي 💙",
"‏ بعض الاِعتذارات يجب أن تُرفَضّ.",
"‏ ‏تبدأ حياتك محاولاً فهم كل شيء، وتنهيها محاولاً النجاة من كل ما فهمت.",
"‏ إن الأمر ينتهي بِنا إلى أعتياد أي شيء.",
"‏ هل كانت كل الطرق تؤدي إليكِ، أم أنني كنتُ أجعلها كذلك.",
"‏ ‏هَتفضل تواسيهُم واحد ورا التاني لكن أنتَ هتتنسي ومحدِش هَيواسيك.",
"‏ جَبَرَ الله قلوبِكُم ، وقَلبِي .🍫",
"‏ بس لما أنا ببقى فايق، ببقى أبكم له ودان.💖",
"‏ ‏مقدرش عالنسيان ولو طال الزمن 🖤",
"‏ أنا لستُ لأحد ولا احد لي ، أنا إنسان غريب أساعد من يحتاجني واختفي.",
"‏ ‏أحببتك وأنا منطفئ، فما بالك وأنا في كامل توهجي ؟",
"‏ لا تعودني على دفء شمسك، إذا كان في نيتك الغروب .َ",
"‏ وانتهت صداقة الخمس سنوات بموقف.",
"‏ ‏لا تحب أحداً لِدرجة أن تتقبّل أذاه.",
"‏ إنعدام الرّغبة أمام الشّيء الّذي أدمنته ، انتصار.",
"‏مش جايز , ده اكيد التأخير وارهاق القلب ده وراه عوضاً عظيماً !?? ",
" مش جايز , ده اكيد التأخير وارهاق القلب ده وراه عوضاً عظيماً !💙",
"فـ بالله صبر  وبالله يسر وبالله عون وبالله كل شيئ ♥️. ",
"أنا بعتز بنفسي جداً كصاحب وشايف اللي بيخسرني ، بيخسر أنضف وأجدع شخص ممكن يشوفه . ",
"فجأه جاتلى قافله ‏خلتنى مستعد أخسر أي حد من غير ما أندم عليه . ",
"‏اللهُم قوني بك حين يقِل صبري... ",
"‏يارب سهِل لنا كُل حاجة شايلين هَمها 💙‏ ",
"انا محتاج ايام حلوه بقي عشان مش نافع كدا ! ",
"المشكله مش اني باخد قررات غلط المشكله اني بفكر كويس فيها قبل ما اخدها .. ",
"تخيل وانت قاعد مخنوق كدا بتفكر فالمزاكره اللي مزكرتهاش تلاقي قرار الغاء الدراسه .. ",
" مكانوش يستحقوا المعافرة بأمانه.",
"‏جمل فترة في حياتي، كانت مع اكثر الناس الذين أذتني نفسيًا. ",
" ‏إحنا ليه مبنتحبش يعني فينا اي وحش!",
"أيام مُمله ومستقبل مجهول ونومٌ غير منتظموالأيامُ تمرُ ولا شيَ يتغير ", 
"عندما تهب ريح المصلحه سوف ياتي الجميع رتكدون تحت قدمك ❤️. ",
"عادي مهما تعادي اختك قد الدنيا ف عادي ❤. ",
"بقيت لوحدي بمعنا اي انا اصلا من زمان لوحدي.❤️ ",
"- ‏تجري حياتنا بما لاتشتهي أحلامنا ! ",
"تحملين كل هذا الجمال، ‏ألا تتعبين؟",
"البدايات للكل ، والثبات للصادقين ",
"مُؤخرًا اقتنعت بالجملة دي جدا : Private life always wins. ",
" الافراط في التسامح بيخللي الناس تستهين بيك🍍",
"مهما كنت كويس فـَ إنت معرض لـِ الاستبدال.. ",
"فخوره بنفسي جدًا رغم اني معملتش حاجه فـ حياتي تستحق الذكر والله . ",
"‏إسمها ليلة القدر لأنها تُغير الأقدار ,اللهُمَّ غير قدري لحالٍ تُحبه وعوضني خير .. ",
"فى احتمال كبير انها ليلة القدر ادعوا لنفسكم كتير وأدعو ربنا يشفى كل مريض. 💙 ",
"أنِر ظُلمتي، وامحُ خطيئتي، واقبل توبتي وأعتِق رقبتي يا اللّٰه. إنكَ عفوٌّ تُحِبُّ العفوَ؛ فاعفُ عني 💛 ",
} 
return LuaTele.sendText(msg_chat_id,msg_id,texting[math.random(#texting)],'md')
end
end
if text == "نكته" or text == "قولي نكته" or text == "عايز اضحك" then 
if Redis:get(TeleGod.."Status:Games"..msg.chat_id) then
local texting = {" مرة واحد مصري دخل سوبر ماركت في الكويت عشان يشتري ولاعة راح عشان يحاسب بيقوله الولاعة ديه بكام قاله دينار قاله منا عارف ان هي نار بس بكام 😂",
"بنت حبت تشتغل مع رئيس عصابة شغلها في غسيل الأموال 😂",
"واحد بيشتكي لصاحبه بيقوله أنا مافيش حد بيحبني ولا يفتكرني أبدًا، ومش عارف أعمل إيه قاله سهلة استلف من الناس فلوس هيسألوا عليك كل يوم 😂",
"ﻣﺮه واﺣﺪ ﻣﺴﻄﻮل ﻣﺎﺷﻰ ﻓﻰ اﻟﺸﺎرع ﻟﻘﻰ مذﻳﻌﻪ ﺑﺘﻘﻮﻟﻪ ﻟﻮ ﺳﻤﺤﺖ ﻓﻴﻦ اﻟﻘﻤﺮ؟ ﻗﺎﻟﻬﺎ اﻫﻮه ﻗﺎﻟﺘﻠﻮ ﻣﺒﺮوك ﻛﺴﺒﺖ ﻋﺸﺮﻳﻦ ﺟﻨﻴﻪ ﻗﺎﻟﻬﺎ ﻓﻰ واﺣﺪ ﺗﺎﻧﻰ ﻫﻨﺎك اﻫﻮه 😂",
"واحده ست سايقه على الجي بي اي قالها انحرفي قليلًا قلعت الطرحة 😂",
"مرة واحد غبي معاه عربية قديمة جدًا وبيحاول يبيعها وماحدش راضي يشتريها.. راح لصاحبه حكاله المشكلة صاحبه قاله عندي لك فكرة جهنمية هاتخليها تتباع الصبح أنت تجيب علامة مرسيدس وتحطها عليها. بعد أسبوعين صاحبه شافه صدفة قاله بعت العربية ولا لاء؟ قاله انت  مجنون حد يبيع مرسيدس ??",
"مره واحد بلديتنا كان بيدق مسمار فى الحائط فالمسمار وقع منه فقال له :تعالى ف مجاش, فقال له: تعالي ف مجاش. فراح بلديتنا رامي على المسمار شوية مسمامير وقال: هاتوه 😂",
"واحدة عملت حساب وهمي ودخلت تكلم جوزها منه ومبسوطة أوي وبتضحك سألوها بتضحكي على إيه قالت لهم أول مرة يقول لي كلام حلو من ساعة ما اتجوزنا 😂",
"بنت حبت تشتغل مع رئيس عصابة شغلها في غسيل الأموال 😂",
"مره واحد اشترى فراخ علشان يربيها فى قفص صدره 😂",
"مرة واحد من الفيوم مات اهله صوصوا عليه 😂",
"ﻣﺮه واﺣﺪ ﻣﺴﻄﻮل ﻣﺎﺷﻰ ﻓﻰ اﻟﺸﺎرع ﻟﻘﻰ مذﻳﻌﻪ ﺑﺘﻘﻮﻟﻪ ﻟﻮ ﺳﻤﺤﺖ ﻓﻴﻦ اﻟﻘﻤﺮ ﻗﺎﻟﻬﺎ اﻫﻮه ﻗﺎﻟﺘﻠﻮ ﻣﺒﺮوك ﻛﺴﺒﺖ ﻋﺸﺮﻳﻦ ﺟﻨﻴﻪ ﻗﺎﻟﻬﺎ ﻓﻰ واﺣﺪ ﺗﺎﻧﻰ ﻫﻨﺎك اﻫﻮه 😂",
"مره واحد شاط كرة فى المقص اتخرمت. 😂",
"مرة واحد رايح لواحد صاحبهفا البواب وقفه بيقول له انت طالع لمين قاله طالع أسمر شوية لبابايا قاله يا أستاذ طالع لمين في العماره 😂",
} 
return LuaTele.sendText(msg_chat_id,msg_id,texting[math.random(#texting)],'md')
end
end
if text == "حروف" or text == "حرف" or text == "الحروف" then 
if Redis:get(TeleGod.."Status:Games"..msg.chat_id) then
local texting = {" جماد بحرف ⇦ ر  ", 
" مدينة بحرف ⇦ ع  ",
" حيوان ونبات بحرف ⇦ خ  ", 
" اسم بحرف ⇦ ح  ", 
" اسم ونبات بحرف ⇦ م  ", 
" دولة عربية بحرف ⇦ ق  ", 
" جماد بحرف ⇦ ي  ", 
" نبات بحرف ⇦ ج  ", 
" اسم بنت بحرف ⇦ ع  ", 
" اسم ولد بحرف ⇦ ع  ", 
" اسم بنت وولد بحرف ⇦ ث  ", 
" جماد بحرف ⇦ ج  ",
" حيوان بحرف ⇦ ص  ",
" دولة بحرف ⇦ س  ",
" نبات بحرف ⇦ ج  ",
" مدينة بحرف ⇦ ب  ",
" نبات بحرف ⇦ ر  ",
" اسم بحرف ⇦ ك  ",
" حيوان بحرف ⇦ ظ  ",
" جماد بحرف ⇦ ذ  ",
" مدينة بحرف ⇦ و  ",
" اسم بحرف ⇦ م  ",
" اسم بنت بحرف ⇦ خ  ",
" اسم و نبات بحرف ⇦ ر  ",
" نبات بحرف ⇦ و  ",
" حيوان بحرف ⇦ س  ",
" مدينة بحرف ⇦ ك  ",
" اسم بنت بحرف ⇦ ص  ",
" اسم ولد بحرف ⇦ ق  ",
" نبات بحرف ⇦ ز  ",
"  جماد بحرف ⇦ ز  ",
"  مدينة بحرف ⇦ ط  ",
"  جماد بحرف ⇦ ن  ",
"  مدينة بحرف ⇦ ف  ",
"  حيوان بحرف ⇦ ض  ",
"  اسم بحرف ⇦ ك  ",
"  نبات و حيوان و مدينة بحرف ⇦ س  ", 
"  اسم بنت بحرف ⇦ ج  ", 
"  مدينة بحرف ⇦ ت  ", 
"  جماد بحرف ⇦ ه  ", 
"  اسم بنت بحرف ⇦ ر  ", 
" اسم ولد بحرف ⇦ خ  ", 
" جماد بحرف ⇦ ع  ",
" حيوان بحرف ⇦ ح  ",
" نبات بحرف ⇦ ف  ",
" اسم بنت بحرف ⇦ غ  ",
" اسم ولد بحرف ⇦ و  ",
" نبات بحرف ⇦ ل  ",
"مدينة بحرف ⇦ ع  ",
"دولة واسم بحرف ⇦ ب  ",
} 
return LuaTele.sendText(msg_chat_id,msg_id,texting[math.random(#texting)],'md')
end
end

if text == "تخ" or text == "اقتلو" or text == "بيو" then
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local ban = LuaTele.getUser(Message_Reply.sender.user_id)
local bain = LuaTele.getUser(msg.sender.user_id)
if tonumber(Message_Reply.sender.user_id) == tonumber(msg.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"*⏏️| انت عبيط يسطا دا انت*","md",true)  
end
if tonumber(Message_Reply.sender.user_id) == tonumber(5372193406) then
return LuaTele.sendText(msg_chat_id,msg_id,"*يسطا دا مبرمج السورس ممكن يفشخني انا وانت 😂😞*","md",true)  
end
if tonumber(Message_Reply.sender.user_id) == tonumber(TeleGod) then
return LuaTele.sendText(msg_chat_id,msg_id,"*يخربيت الضحك عاوز يقتل البوت 🙂😂😂*","md",true)  
end
if ban.first_name then
baniusername = '*قتل ↫ *['..bain.first_name..'](tg://user?id='..bain.id..')*\nالمجرم دا 😢  ↫ *['..ban.first_name..'](tg://user?id='..ban.id..')*\nانـا لله وانـا اليـه راجعـون 😢😢\n*'
else
baniusername = 'لا يوجد'
end
 keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'المقتول 🔪', url = "https://t.me/"..ban.username..""},
},
}
local msgg = msg_id/2097152/0.5
return https.request("https://api.telegram.org/bot"..Token.."/sendvideo?chat_id=" .. msg_chat_id .. "&video=https://t.me/apqiy/130&caption=".. URL.escape(baniusername).."&reply_to_message_id="..msgg.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
end
if text == "تف" or text == "اتفو" or text == "تفف" then
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local ban = LuaTele.getUser(Message_Reply.sender.user_id)
local bain = LuaTele.getUser(msg.sender.user_id)
if tonumber(Message_Reply.sender.user_id) == tonumber(msg.sender.user_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"*⏏️| انت عبيط يسطا دا انت*","md",true)  
end
if tonumber(Message_Reply.sender.user_id) == tonumber(5372193406) then
return LuaTele.sendText(msg_chat_id,msg_id,"*🚫| حبيبي دا المبرمج صلاح مش بيتف عليه*","md",true)  
end
if tonumber(Message_Reply.sender.user_id) == tonumber(TeleGod) then
return LuaTele.sendText(msg_chat_id,msg_id,"*يخربيت الضحك عاوز يتف علي البوت 🙂😂😂*","md",true)  
end
if ban.first_name then
baniusername = '*تف ↫ *['..bain.first_name..'](tg://user?id='..bain.id..')*\nعلي المجرم دا 😢  ↫ *['..ban.first_name..'](tg://user?id='..ban.id..')*\nاععع اي القرف دا\n*'
else
baniusername = 'لا يوجد'
end
 keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'المجني عليه 😢', url = "https://t.me/"..ban.username..""},
},
}
local msgg = msg_id/2097152/0.5
return https.request("https://api.telegram.org/bot"..Token.."/sendvideo?chat_id=" .. msg_chat_id .. "&video=https://t.me/apqiy/132&caption=".. URL.escape(baniusername).."&reply_to_message_id="..msgg.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
end
if text == 'هاي' or text == 'هيي' then
if not Redis:get(TeleGod.."rb:bna"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"* *","md",true)  
end
return LuaTele.sendText(msg_chat_id,msg_id,'*خالتك جرت ورايا 😹💔*',"md",true)  
end
if text == 'سلام عليكم' or text == 'السلام عليكم' then
if not Redis:get(TeleGod.."rb:bna"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"* *","md",true)  
end
return LuaTele.sendText(msg_chat_id,msg_id,'*وعليكم السلام 🌝💜*',"md",true)  
end
if text == 'سلام' or text == 'مع سلامه' then
if not Redis:get(TeleGod.."rb:bna"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"* *","md",true)  
end
return LuaTele.sendText(msg_chat_id,msg_id,'*مع الف سلامه يقلبي متجيش تاني 😹💔🎶*',"md",true)  
end
if text == 'برايفت' or text == 'تع برايفت' then
if not Redis:get(TeleGod.."rb:bna"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"* *","md",true)  
end
return LuaTele.sendText(msg_chat_id,msg_id,'*خدوني معاكم برايفت والنبي 🥺💔*',"md",true)  
end
if text == 'النبي' or text == 'صلي علي النبي' then
if not Redis:get(TeleGod.."rb:bna"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"* *","md",true)  
end
return LuaTele.sendText(msg_chat_id,msg_id,'*عليه الصلاه والسلام 🌝💛*',"md",true)  
end
if text == 'نعم' or text == 'يا نعم' then
if not Redis:get(TeleGod.."rb:bna"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"* *","md",true)  
end
return LuaTele.sendText(msg_chat_id,msg_id,'*نعم الله عليك 🌚❤️*',"md",true)  
end
if text == '🙄' or text == '🙄🙄' then
if not Redis:get(TeleGod.."rb:bna"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"* *","md",true)  
end
return LuaTele.sendText(msg_chat_id,msg_id,'* نزل عينك تحت كدا علشان هتاخد علي قفاك 😒❤️*',"md",true)  
end
if text == '🙄🙄🙄🙄' or text == '🙄🙄🙄' then
if not Redis:get(TeleGod.."rb:bna"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"* *","md",true)  
end
return LuaTele.sendText(msg_chat_id,msg_id,'*نزل عينك تحت كدا علشان هتاخد علي قفاك 😒❤️*',"md",true)  
end
if text == '😂' or text == '😂😂' then
if not Redis:get(TeleGod.."rb:bna"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"* *","md",true)  
end
return LuaTele.sendText(msg_chat_id,msg_id,'*ضحكتك عثل زيكك ينوحيي 🌝❤️*',"md",true)  
end
if text == '😹' or text == '😹' then
if not Redis:get(TeleGod.."rb:bna"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"* *","md",true)  
end
return LuaTele.sendText(msg_chat_id,msg_id,'*ضحكتك عثل زيكك ينوحيي 🌝❤️*',"md",true)  
end
if text == '🤔' or text == '🤔🤔' then
if not Redis:get(TeleGod.."rb:bna"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"* *","md",true)  
end
return LuaTele.sendText(msg_chat_id,msg_id,'* بتفكر في اي 🤔*',"md",true)  
end
if text == '🌚' or text == '🌝' then
if not Redis:get(TeleGod.."rb:bna"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"* *","md",true)  
end
return LuaTele.sendText(msg_chat_id,msg_id,'*القمر ده شبهك 🙂❤️*',"md",true)  
end
if text == '💋' or text == '💋💋' then
if not Redis:get(TeleGod.."rb:bna"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"* *","md",true)  
end
return LuaTele.sendText(msg_chat_id,msg_id,'*انا عايز مح انا كمان 🥺💔*',"md",true)  
end
if text == '😭' or text == '😭😭' then
if not Redis:get(TeleGod.."rb:bna"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"* *","md",true)  
end
return LuaTele.sendText(msg_chat_id,msg_id,'*بتعيط تيب لي طيب ??*',"md",true)  
end
if text == '🥺' or text == '🥺🥺' then
if not Redis:get(TeleGod.."rb:bna"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"* *","md",true)  
end
return LuaTele.sendText(msg_chat_id,msg_id,'*متزعلش بحبك 😻🤍*',"md",true)  
end
if text == '😒' or text == '😒😒' then
if not Redis:get(TeleGod.."rb:bna"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"* *","md",true)  
end
return LuaTele.sendText(msg_chat_id,msg_id,'*عدل وشك ونت بتكلمني 😒🙄*',"md",true)  
end
if text == 'بحبك' or text == 'حبق' then
if not Redis:get(TeleGod.."rb:bna"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"* *","md",true)  
end
return LuaTele.sendText(msg_chat_id,msg_id,'*وانا كمان بعشقك يا روحي 🤗🥰*',"md",true)  
end
if text == 'مح' or text == 'هات مح' then
if not Redis:get(TeleGod.."rb:bna"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"* *","md",true)  
end
return LuaTele.sendText(msg_chat_id,msg_id,'*محات حياتي يروحي 🌝❤️*',"md",true)  
end
if text == 'هلا' or text == 'هلا وغلا' then
if not Redis:get(TeleGod.."rb:bna"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"* *","md",true)  
end
return LuaTele.sendText(msg_chat_id,msg_id,'*هلا بيك ياروحي 👋*',"md",true)  
end
if text == 'هشش' or text == 'هششخرص' then
if not Redis:get(TeleGod.."rb:bna"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"* *","md",true)  
end
return LuaTele.sendText(msg_chat_id,msg_id,'*بنهش كتاكيت احنا هنا ولا اي ??😹*',"md",true)  
end
if text == 'الحمد الله' or text == 'بخير الحمد الله' then
if not Redis:get(TeleGod.."rb:bna"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"* *","md",true)  
end
return LuaTele.sendText(msg_chat_id,msg_id,'*دايما ياحبيبي 🌝❤️*',"md",true)  
end
if text == 'بف' or text == 'بص بف' then
if not Redis:get(TeleGod.."rb:bna"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"* *","md",true)  
end
return LuaTele.sendText(msg_chat_id,msg_id,'*وحيات امك ياكبتن خدوني معاكو بيف 🥺💔*',"md",true)  
end
if text == 'خاص' or text == 'بص خاص' then
if not Redis:get(TeleGod.."rb:bna"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"* *","md",true)  
end
return LuaTele.sendText(msg_chat_id,msg_id,'*ونجيب اشخاص 😂👻*',"md",true)  
end
if text == 'صباح الخير' or text == 'مساء الخير' then
if not Redis:get(TeleGod.."rb:bna"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"* *","md",true)  
end
return LuaTele.sendText(msg_chat_id,msg_id,'*انت الخير يعمري 🌝❤️*',"md",true)  
end
if text == 'صباح النور' or text == 'باح الخير' then
if not Redis:get(TeleGod.."rb:bna"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"* *","md",true)  
end
return LuaTele.sendText(msg_chat_id,msg_id,'*صباح العسل 😻🤍*',"md",true)  
end
if text == 'حصل' or text == 'حثل' then
if not Redis:get(TeleGod.."rb:bna"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"* *","md",true)  
end
return LuaTele.sendText(msg_chat_id,msg_id,'*خخخ امال 😹*',"md",true)  
end
if text == 'اه' or text == 'اها' then
if not Redis:get(TeleGod.."rb:bna"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"* *","md",true)  
end
return LuaTele.sendText(msg_chat_id,msg_id,'*اه اي يا قدع عيب 😹💔*',"md",true)  
end
if text == 'كسم' or text == 'كسمك' then
if not Redis:get(TeleGod.."rb:bna"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"* *","md",true)  
end
return LuaTele.sendText(msg_chat_id,msg_id,'*عيب ياوسخ 🙄💔*',"md",true)  
end
if text == 'بوتي' or text == 'يا بوتي' then
if not Redis:get(TeleGod.."rb:bna"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"* *","md",true)  
end
return LuaTele.sendText(msg_chat_id,msg_id,'روح وعقل بوتك 🥺💔',"md",true)  
end
if text == 'متيجي' or text == 'تع' then
if not Redis:get(TeleGod.."rb:bna"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"* *","md",true)  
end
return LuaTele.sendText(msg_chat_id,msg_id,'*لا عيب بتكسف 😹💔*',"md",true)  
end
if text == 'هيح' or text == 'لسه صاحي' then
if not Redis:get(TeleGod.."rb:bna"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"* *","md",true)  
end
return LuaTele.sendText(msg_chat_id,msg_id,'*صح النوم 😹💔*',"md",true)  
end
if text == 'منور' or text == 'نورت' then
if not Redis:get(TeleGod.."rb:bna"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"* *","md",true)  
end
return LuaTele.sendText(msg_chat_id,msg_id,'*ده نورك ي قلبي 🌝💙*',"md",true)  
end
if text == 'باي' or text == 'انا ماشي' then
if not Redis:get(TeleGod.."rb:bna"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"* *","md",true)  
end
return LuaTele.sendText(msg_chat_id,msg_id,'*ع فين لوين رايح وسايبنى 🥺💔*',"md",true)  
end
if text == 'ويت' or text == 'ويت يحب' then
if not Redis:get(TeleGod.."rb:bna"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"* *","md",true)  
end
return LuaTele.sendText(msg_chat_id,msg_id,'*اي الثقافه دي 😒😹*',"md",true)  
end
if text == 'خخخ' or text == 'خخخخخ' then
if not Redis:get(TeleGod.."rb:bna"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"* *","md",true)  
end
return LuaTele.sendText(msg_chat_id,msg_id,'*اهدا يوحش ميصحش كدا 😒😹*',"md",true)  
end
if text == 'شكرا' or text == 'مرسي' then
if not Redis:get(TeleGod.."rb:bna"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"* *","md",true)  
end
return LuaTele.sendText(msg_chat_id,msg_id,'*العفو ياروحي 🙈🌝*',"md",true)  
end
if text == 'حلوه' or text == 'حلو' then
if not Redis:get(TeleGod.."rb:bna"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"* *","md",true)  
end
return LuaTele.sendText(msg_chat_id,msg_id,'*انت الي حلو ياقمر 🤤🌝*',"md",true)  
end
if text == 'بموت' or text == 'هموت' then
if not Redis:get(TeleGod.."rb:bna"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"* *","md",true)  
end
return LuaTele.sendText(msg_chat_id,msg_id,'*موت بعيد م ناقصين مصايب 😑😂*',"md",true)  
end
if text == 'اي' or text == 'ايه' then
if not Redis:get(TeleGod.."rb:bna"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"* *","md",true)  
end
return LuaTele.sendText(msg_chat_id,msg_id,'*جتك اوهه م سامع ولا ايي 😹👻*',"md",true)  
end
if text == 'طيب' or text == 'تيب' then
if not Redis:get(TeleGod.."rb:bna"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"* *","md",true)  
end
return LuaTele.sendText(msg_chat_id,msg_id,'*فرح خالتك قريب 😹💋💃🏻*',"md",true)  
end
if text == 'حاضر' or text == 'حتر' then
if not Redis:get(TeleGod.."rb:bna"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"* *","md",true)  
end
return LuaTele.sendText(msg_chat_id,msg_id,'*حضرلك الخير يارب 🙂❤️*',"md",true)  
end
if text == 'جيت' or text == 'انا جيت' then
if not Redis:get(TeleGod.."rb:bna"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"* *","md",true)  
end
return LuaTele.sendText(msg_chat_id,msg_id,'* لف ورجع تانى مشحوار 😂🚶‍♂👻*',"md",true)  
end
if text == 'بخ' or text == 'عو' then
if not Redis:get(TeleGod.."rb:bna"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"* *","md",true)  
end
return LuaTele.sendText(msg_chat_id,msg_id,'*يوه خضتني ياسمك اي 🥺💔*',"md",true)  
end
if text == 'حبيبي' or text == 'حبيبتي' then
if not Redis:get(TeleGod.."rb:bna"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"* *","md",true)  
end
return LuaTele.sendText(msg_chat_id,msg_id,'*اوه ياه 🌝😂*',"md",true)  
end
if text == 'تمام' or text == 'تمم' then
if not Redis:get(TeleGod.."rb:bna"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"* *","md",true)  
end
return LuaTele.sendText(msg_chat_id,msg_id,'* امك اسمها احلام 😹😹*',"md",true)  
end
if text == 'خلاص' or text == 'خلص' then
if not Redis:get(TeleGod.."rb:bna"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"* *","md",true)  
end
return LuaTele.sendText(msg_chat_id,msg_id,'*خلصت روحكك يبعيد 😹💔*',"md",true)  
end
if text == 'سي في' or text == 'سيفي' then
if not Redis:get(TeleGod.."rb:bna"..msg_chat_id) then
return LuaTele.sendText(msg_chat_id,msg_id,"* *","md",true)  
end
return LuaTele.sendText(msg_chat_id,msg_id,'*كفايه شقط سيب حاجه لغيرك 😎😂*',"md",true)  
end

if text == 'انشاء حساب بنكي' or text == 'انشاء حساب البنكي' or text =='انشاء الحساب بنكي' or text =='انشاء الحساب البنكي' then
creditcc = math.random(5000000000000000,5999999999999999);
creditvi = math.random(4000000000000000,4999999999999999);
creditex = math.random(6000000000000000,6999999999999999);
balas = 50
if Redis:sismember(TeleGod.."booob",msg.sender.user_id) then
return LuaTele.sendText(msg.chat_id,msg.id, "⇜ لديك حساب بنكي مسبقاً\n\n⇜ لعرض معلومات حسابك اكتب\n⇠ `حسابي`","md",true)
end
Redis:setex(TeleGod.."booobb" .. msg.chat_id .. ":" .. msg.sender.user_id,60, true)
LuaTele.sendText(msg.chat_id,msg.id,[[
– عشان تعمل حساب لازم تختار نوع البطاقة

⇠ `ماستر`
⇠ `فيزا`
⇠ `اكسبرس`

- اضغط للنسخ

– مدة الطلب دقيقة واحدة ويطردك الموظف .
]],"md",true)  
return false
end
if Redis:get(TeleGod.."booobb" .. msg.chat_id .. ":" .. msg.sender.user_id) then
if text == "ماستر" then
local ban = LuaTele.getUser(msg.sender.user_id)
if ban.first_name then
news = ""..ban.first_name..""
else
news = " لا يوجد"
end
local banid = msg.sender.user_id
Redis:set(TeleGod.."bobna"..msg.sender.user_id,news)
Redis:set(TeleGod.."boob"..msg.sender.user_id,balas)
Redis:set(TeleGod.."boobb"..msg.sender.user_id,creditcc)
Redis:set(TeleGod.."bbobb"..msg.sender.user_id,text)
Redis:set(TeleGod.."boballname"..creditcc,news)
Redis:set(TeleGod.."boballbalc"..creditcc,balas)
Redis:set(TeleGod.."boballcc"..creditcc,creditcc)
Redis:set(TeleGod.."boballban"..creditcc,text)
Redis:set(TeleGod.."boballid"..creditcc,banid)
Redis:sadd(TeleGod.."booob",msg.sender.user_id)
Redis:del(TeleGod.."booobb" .. msg.chat_id .. ":" .. msg.sender.user_id) 
LuaTele.sendText(msg.chat_id,msg.id, "\n• عملنالك حساب في بنك تلي جود 🏦\n• وشحنالك 50 جنيه 💵 هدية\n\n⇜ رقم حسابك ↢ ( `"..creditcc.."` )\n⇜ نوع البطاقة ↢ ( ماستر 💳 )\n⇜ فلوسك ↢ ( 50 جنيه 💵 )  ","md",true)  
end 
if text == "فيزا" then
local ban = LuaTele.getUser(msg.sender.user_id)
if ban.first_name then
news = ""..ban.first_name..""
else
news = " لا يوجد"
end
local banid = msg.sender.user_id
Redis:set(TeleGod.."bobna"..msg.sender.user_id,news)
Redis:set(TeleGod.."boob"..msg.sender.user_id,balas)
Redis:set(TeleGod.."boobb"..msg.sender.user_id,creditvi)
Redis:set(TeleGod.."bbobb"..msg.sender.user_id,text)
Redis:set(TeleGod.."boballname"..creditvi,news)
Redis:set(TeleGod.."boballbalc"..creditvi,balas)
Redis:set(TeleGod.."boballcc"..creditvi,creditvi)
Redis:set(TeleGod.."boballban"..creditvi,text)
Redis:set(TeleGod.."boballid"..creditvi,banid)
Redis:sadd(TeleGod.."booob",msg.sender.user_id)
Redis:del(TeleGod.."booobb" .. msg.chat_id .. ":" .. msg.sender.user_id) 
LuaTele.sendText(msg.chat_id,msg.id, "\n• عملنالك حساب في بنك تلي جود 🏦\n• وشحنالك 50 جنيه 💵 هدية\n\n⇜ رقم حسابك ↢ ( `"..creditvi.."` )\n⇜ نوع البطاقة ↢ ( فيزا 💳 )\n⇜ فلوسك ↢ ( 50 جنيه 💵 )  ","md",true)   
end 
if text == "اكسبرس" then
local ban = LuaTele.getUser(msg.sender.user_id)
if ban.first_name then
news = ""..ban.first_name..""
else
news = " لا يوجد"
end
local banid = msg.sender.user_id
Redis:set(TeleGod.."bobna"..msg.sender.user_id,news)
Redis:set(TeleGod.."boob"..msg.sender.user_id,balas)
Redis:set(TeleGod.."boobb"..msg.sender.user_id,creditex)
Redis:set(TeleGod.."bbobb"..msg.sender.user_id,text)
Redis:set(TeleGod.."boballname"..creditex,news)
Redis:set(TeleGod.."boballbalc"..creditex,balas)
Redis:set(TeleGod.."boballcc"..creditex,creditex)
Redis:set(TeleGod.."boballban"..creditex,text)
Redis:set(TeleGod.."boballid"..creditex,banid)
Redis:sadd(TeleGod.."booob",msg.sender.user_id)
Redis:del(TeleGod.."booobb" .. msg.chat_id .. ":" .. msg.sender.user_id) 
LuaTele.sendText(msg.chat_id,msg.id, "\n• عملنالك حساب في بنك تلي جود 🏦\n• وشحنالك 50 جنيه 💵 هدية\n\n⇜ رقم حسابك ↢ ( `"..creditex.."` )\n⇜ نوع البطاقة ↢ ( اكسبرس 💳 )\n⇜ فلوسك ↢ ( 50 جنيه 💵 )  ","md",true)   
end 
end
if text == 'مسح حساب بنكي' or text == 'مسح حساب البنكي' or text =='مسح الحساب بنكي' or text =='مسح الحساب البنكي' or text == "مسح حسابي البنكي" or text == "مسح حسابي بنكي" then
if Redis:sismember(TeleGod.."booob",msg.sender.user_id) then
Redis:srem(TeleGod.."booob", msg.sender.user_id)
Redis:del(TeleGod.."boob"..msg.sender.user_id)
Redis:del(TeleGod.."boobb"..msg.sender.user_id)
Redis:del(TeleGod.."zrfff"..msg.sender.user_id)
Redis:srem(TeleGod.."zrfffid", msg.sender.user_id)
LuaTele.sendText(msg.chat_id,msg.id, "⇜ مسحت حسابك البنكي 🏦","md",true)
else
LuaTele.sendText(msg.chat_id,msg.id, "⇜ معندكش حساب بنكي ارسل ↢ ( `انشاء حساب بنكي` )","md",true)
end
end

if text == 'تصفير النتائج' or text == 'مسح لعبه البنك' then
if msg.ControllerBot then
Redis:del(TeleGod.."booob")
Redis:del(TeleGod.."boob")
Redis:del(TeleGod.."boobb")
Redis:del(TeleGod.."zrfff")
Redis:del(TeleGod.."zrfffid")
LuaTele.sendText(msg.chat_id,msg.id, "⇜ مسحت لعبه البنك 🏦","md",true)
end
end

if text == 'فلوسي' or text == 'فلوس' and tonumber(msg.reply_to_message_id) == 0 then
if Redis:sismember(TeleGod.."booob",msg.sender.user_id) then
ballancee = Redis:get(TeleGod.."boob"..msg.sender.user_id) or 0
if tonumber(ballancee) < 1 then
return LuaTele.sendText(msg.chat_id,msg.id, "⇜ معندكش فلوس ارسل الالعاب وابدأ بجمع الفلوس \n✦","md",true)
end
LuaTele.sendText(msg.chat_id,msg.id, "⇜ فلوسك "..ballancee.." جنيه 💵","md",true)
else
LuaTele.sendText(msg.chat_id,msg.id, "⇜ معندكش حساب بنكي ارسل ↢ ( `انشاء حساب بنكي` )","md",true)
end
end

if text == 'فلوسه' or text == 'فلوس' and tonumber(msg.reply_to_message_id) ~= 0 then
local Remsg = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Remsg.sender.user_id)
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
LuaTele.sendText(msg.chat_id,msg.id,"\n*⇜ البوت معندوش حساب بالبنك 🤣*","md",true)  
return false
end
if Redis:sismember(TeleGod.."booob",Remsg.sender.user_id) then
ballanceed = Redis:get(TeleGod.."boob"..Remsg.sender.user_id) or 0
LuaTele.sendText(msg.chat_id,msg.id, "⇜ فلوسه "..ballanceed.." جنيه 💵","md",true)
else
LuaTele.sendText(msg.chat_id,msg.id, "⇜ معندوش حساب بنكي ","md",true)
end
end

if text == 'حسابي' or text == 'حسابي البنكي' or text == 'رقم حسابي' then
local ban = LuaTele.getUser(msg.sender.user_id)
if ban.first_name then
news = ""..ban.first_name..""
else
news = " لا يوجد"
end
if Redis:sismember(TeleGod.."booob",msg.sender.user_id) then
cccc = Redis:get(TeleGod.."boobb"..msg.sender.user_id)
uuuu = Redis:get(TeleGod.."bbobb"..msg.sender.user_id)
pppp = Redis:get(TeleGod.."zrfff"..msg.sender.user_id) or 0
ballancee = Redis:get(TeleGod.."boob"..msg.sender.user_id) or 0
LuaTele.sendText(msg.chat_id,msg.id, "⇜ الاسم ↢ "..news.."\n⇜ الحساب ↢ `"..cccc.."`\n⇜ بنك ↢ ( تلي جود )\n⇜ نوع ↢ ( "..uuuu.." )\n⇜ الرصيد ↢ ( "..ballancee.." جنيه 💵 )\n⇜ الزرف ( "..pppp.." جنيه 💵 )\n✦","md",true)
else
LuaTele.sendText(msg.chat_id,msg.id, "⇜ معندكش حساب بنكي ارسل ↢ ( `انشاء حساب بنكي` )","md",true)
end
end

if text == 'مسح حسابه' and tonumber(msg.reply_to_message_id) ~= 0 then
if msg.ControllerBot then
local Remsg = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Remsg.sender.user_id)
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
LuaTele.sendText(msg.chat_id,msg.id,"\n*⇜ البوت معندوش حساب بالبنك 🤣*","md",true)  
return false
end
local ban = LuaTele.getUser(Remsg.sender.user_id)
if ban.first_name then
news = ""..ban.first_name..""
else
news = " لا يوجد"
end
if Redis:sismember(TeleGod.."booob",Remsg.sender.user_id) then
ccccc = Redis:get(TeleGod.."boobb"..Remsg.sender.user_id)
uuuuu = Redis:get(TeleGod.."bbobb"..Remsg.sender.user_id)
ppppp = Redis:get(TeleGod.."zrfff"..Remsg.sender.user_id) or 0
ballanceed = Redis:get(TeleGod.."boob"..Remsg.sender.user_id) or 0
Redis:srem(TeleGod.."booob", Remsg.sender.user_id)
Redis:del(TeleGod.."boob"..Remsg.sender.user_id)
Redis:del(TeleGod.."boobb"..Remsg.sender.user_id)
Redis:del(TeleGod.."zrfff"..Remsg.sender.user_id)
Redis:srem(TeleGod.."zrfffid", Remsg.sender.user_id)
LuaTele.sendText(msg.chat_id,msg.id, "⇜ الاسم ↢ "..news.."\n⇜ الحساب ↢ `"..ccccc.."`\n⇜ بنك ↢ ( تلي جود )\n⇜ نوع ↢ ( "..uuuuu.." )\n⇜ الرصيد ↢ ( "..ballanceed.." جنيه 💵 )\n⇜ الزرف ↢ ( "..ppppp.." جنيه 💵 )\n⇜ مسكين مسحت حسابه \n✦","md",true)
else
LuaTele.sendText(msg.chat_id,msg.id, "⇜ معندوش حساب بنكي اصلاً ","md",true)
end
end
end

if text == 'حسابه' and tonumber(msg.reply_to_message_id) ~= 0 then
local Remsg = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Remsg.sender.user_id)
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
LuaTele.sendText(msg.chat_id,msg.id,"\n*⇜ البوت معندوش حساب بالبنك 🤣*","md",true)  
return false
end
local ban = LuaTele.getUser(Remsg.sender.user_id)
if ban.first_name then
news = ""..ban.first_name..""
else
news = " لا يوجد"
end
if Redis:sismember(TeleGod.."booob",Remsg.sender.user_id) then
ccccc = Redis:get(TeleGod.."boobb"..Remsg.sender.user_id)
uuuuu = Redis:get(TeleGod.."bbobb"..Remsg.sender.user_id)
ppppp = Redis:get(TeleGod.."zrfff"..Remsg.sender.user_id) or 0
ballanceed = Redis:get(TeleGod.."boob"..Remsg.sender.user_id) or 0
LuaTele.sendText(msg.chat_id,msg.id, "⇜ الاسم ↢ "..news.."\n⇜ الحساب ↢ `"..ccccc.."`\n⇜ بنك ↢ ( تلي جود )\n⇜ نوع ↢ ( "..uuuuu.." )\n⇜ الرصيد ↢ ( "..ballanceed.." جنيه 💵 )\n⇜ الزرف ↢ ( "..ppppp.." جنيه 💵 )\n✦","md",true)
else
LuaTele.sendText(msg.chat_id,msg.id, "⇜ معندوش حساب بنكي ","md",true)
end
end

if text and text:match('^مسح حساب (.*)$') or text and text:match('^مسح حسابه (.*)$') then
if msg.ControllerBot then
local UserName = text:match('^مسح حساب (.*)$') or text:match('^مسح حسابه (.*)$')
local coniss = tostring(UserName)
local coniss = coniss:gsub('٠','0')
local coniss = coniss:gsub('١','1')
local coniss = coniss:gsub('٢','2')
local coniss = coniss:gsub('٣','3')
local coniss = coniss:gsub('٤','4')
local coniss = coniss:gsub('٥','5')
local coniss = coniss:gsub('٦','6')
local coniss = coniss:gsub('٧','7')
local coniss = coniss:gsub('٨','8')
local coniss = coniss:gsub('٩','9')
local coniss = tonumber(coniss)
local ban = LuaTele.getUser(coniss)
if ban.first_name then
news = "["..ban.first_name.."](tg://user?id="..ban.id..")"
else
news = " لا يوجد "
end
if Redis:sismember(TeleGod.."booob",coniss) then
ccccc = Redis:get(TeleGod.."boobb"..coniss)
uuuuu = Redis:get(TeleGod.."bbobb"..coniss)
ppppp = Redis:get(TeleGod.."zrfff"..coniss) or 0
ballanceed = Redis:get(TeleGod.."boob"..coniss) or 0
Redis:srem(TeleGod.."booob", coniss)
Redis:del(TeleGod.."boob"..coniss)
Redis:del(TeleGod.."boobb"..coniss)
Redis:del(TeleGod.."zrfff"..coniss)
Redis:srem(TeleGod.."zrfffid", coniss)
LuaTele.sendText(msg.chat_id,msg.id, "⇜ الاسم ↢ "..news.."\n⇜ الحساب ↢ `"..ccccc.."`\n⇜ بنك ↢ ( تلي جود )\n⇜ نوع ↢ ( "..uuuuu.." )\n⇜ الرصيد ↢ ( "..ballanceed.." جنيه 💵 )\n⇜ الزرف ↢ ( "..ppppp.." جنيه 💵 )\n⇜ مسكين مسحت حسابه \n✦","md",true)
else
LuaTele.sendText(msg.chat_id,msg.id, "⇜ معندوش حساب بنكي اصلاً ","md",true)
end
end
end

if text and text:match('^حساب (.*)$') or text and text:match('^حسابه (.*)$') then
local UserName = text:match('^حساب (.*)$') or text:match('^حسابه (.*)$')
local coniss = tostring(UserName)
local coniss = coniss:gsub('٠','0')
local coniss = coniss:gsub('١','1')
local coniss = coniss:gsub('٢','2')
local coniss = coniss:gsub('٣','3')
local coniss = coniss:gsub('٤','4')
local coniss = coniss:gsub('٥','5')
local coniss = coniss:gsub('٦','6')
local coniss = coniss:gsub('٧','7')
local coniss = coniss:gsub('٨','8')
local coniss = coniss:gsub('٩','9')
local coniss = tonumber(coniss)
if Redis:get(TeleGod.."boballcc"..coniss) then
local yty = Redis:get(TeleGod.."boballname"..coniss)
local dfhb = Redis:get(TeleGod.."boballbalc"..coniss)
local fsvhh = Redis:get(TeleGod.."boballban"..coniss)
LuaTele.sendText(msg.chat_id,msg.id, "⇜ الاسم ↢ "..yty.."\n⇜ الحساب ↢ `"..coniss.."`\n⇜ بنك ↢ ( تلي جود )\n⇜ نوع ↢ ( "..fsvhh.." )\n⇜ الرصيد ↢ ( "..dfhb.." جنيه 💵 )\n✦","md",true)
else
LuaTele.sendText(msg.chat_id,msg.id, "⇜ مافيه حساب بنكي كذا","md",true)
end
end

if text == 'مضاربه' then
LuaTele.sendText(msg.chat_id,msg.id, "استعمل الامر كذا :\n\n`مضاربه` المبلغ","md",true)
end

if text and text:match('^مضاربه (.*)$') then
local UserName = text:match('^مضاربه (.*)$')
local coniss = tostring(UserName)
local coniss = coniss:gsub('٠','0')
local coniss = coniss:gsub('١','1')
local coniss = coniss:gsub('٢','2')
local coniss = coniss:gsub('٣','3')
local coniss = coniss:gsub('٤','4')
local coniss = coniss:gsub('٥','5')
local coniss = coniss:gsub('٦','6')
local coniss = coniss:gsub('٧','7')
local coniss = coniss:gsub('٨','8')
local coniss = coniss:gsub('٩','9')
local coniss = tonumber(coniss)
if Redis:sismember(TeleGod.."booob",msg.sender.user_id) then
if Redis:ttl(TeleGod.."iiooooo" .. msg.sender.user_id) >= 1180 then
return LuaTele.sendText(msg.chat_id,msg.id,"⇜ مينفعش تضارب دلوقتي\n⇜ تعال بعد ( 20 دقيقة )","md",true)
elseif Redis:ttl(TeleGod.."iiooooo" .. msg.sender.user_id) >= 1120 then
return LuaTele.sendText(msg.chat_id,msg.id,"⇜ مينفعش تضارب دلوقتي\n⇜ تعال بعد ( 19 دقيقة )","md",true)
elseif Redis:ttl(TeleGod.."iiooooo" .. msg.sender.user_id) >= 1060 then
return LuaTele.sendText(msg.chat_id,msg.id,"⇜ مينفعش تضارب دلوقتي\n⇜ تعال بعد ( 18 دقيقة )","md",true)
elseif Redis:ttl(TeleGod.."iiooooo" .. msg.sender.user_id) >= 1000 then
return LuaTele.sendText(msg.chat_id,msg.id,"⇜ مينفعش تضارب دلوقتي\n⇜ تعال بعد ( 17 دقيقة )","md",true)
elseif Redis:ttl(TeleGod.."iiooooo" .. msg.sender.user_id) >= 940 then
return LuaTele.sendText(msg.chat_id,msg.id,"⇜ مينفعش تضارب دلوقتي\n⇜ تعال بعد ( 16 دقيقة )","md",true)
elseif Redis:ttl(TeleGod.."iiooooo" .. msg.sender.user_id) >= 880 then
return LuaTele.sendText(msg.chat_id,msg.id,"⇜ مينفعش تضارب دلوقتي\n⇜ تعال بعد ( 15 دقيقة )","md",true)
elseif Redis:ttl(TeleGod.."iiooooo" .. msg.sender.user_id) >= 820 then
return LuaTele.sendText(msg.chat_id,msg.id,"⇜ مينفعش تضارب دلوقتي\n⇜ تعال بعد ( 14 دقيقة )","md",true)
elseif Redis:ttl(TeleGod.."iiooooo" .. msg.sender.user_id) >= 760 then
return LuaTele.sendText(msg.chat_id,msg.id,"⇜ مينفعش تضارب دلوقتي\n⇜ تعال بعد ( 13 دقيقة )","md",true)
elseif Redis:ttl(TeleGod.."iiooooo" .. msg.sender.user_id) >= 700 then
return LuaTele.sendText(msg.chat_id,msg.id,"⇜ مينفعش تضارب دلوقتي\n⇜ تعال بعد ( 12 دقيقة )","md",true)
elseif Redis:ttl(TeleGod.."iiooooo" .. msg.sender.user_id) >= 640 then
return LuaTele.sendText(msg.chat_id,msg.id,"⇜ مينفعش تضارب دلوقتي\n⇜ تعال بعد ( 11 دقيقة )","md",true)
elseif Redis:ttl(TeleGod.."iiooooo" .. msg.sender.user_id) >= 580 then
return LuaTele.sendText(msg.chat_id,msg.id,"⇜ مينفعش تضارب دلوقتي\n⇜ تعال بعد ( 10 دقائق )","md",true)
elseif Redis:ttl(TeleGod.."iiooooo" .. msg.sender.user_id) >= 540 then
return LuaTele.sendText(msg.chat_id,msg.id,"⇜ مينفعش تضارب دلوقتي\n⇜ تعال بعد ( 9 دقائق )","md",true)
elseif Redis:ttl(TeleGod.."iiooooo" .. msg.sender.user_id) >= 480 then
return LuaTele.sendText(msg.chat_id,msg.id,"⇜ مينفعش تضارب دلوقتي\n⇜ تعال بعد ( 8 دقائق )","md",true)
elseif Redis:ttl(TeleGod.."iiooooo" .. msg.sender.user_id) >= 420 then
return LuaTele.sendText(msg.chat_id,msg.id,"⇜ مينفعش تضارب دلوقتي\n⇜ تعال بعد ( 7 دقائق )","md",true)
elseif Redis:ttl(TeleGod.."iiooooo" .. msg.sender.user_id) >= 360 then
return LuaTele.sendText(msg.chat_id,msg.id,"⇜ مينفعش تضارب دلوقتي\n⇜ تعال بعد ( 6 دقائق )","md",true)
elseif Redis:ttl(TeleGod.."iiooooo" .. msg.sender.user_id) >= 300 then
return LuaTele.sendText(msg.chat_id,msg.id,"⇜ مينفعش تضارب دلوقتي\n⇜ تعال بعد ( 5 دقائق )","md",true)
elseif Redis:ttl(TeleGod.."iiooooo" .. msg.sender.user_id) >= 240 then
return LuaTele.sendText(msg.chat_id,msg.id,"⇜ مينفعش تضارب دلوقتي\n⇜ تعال بعد ( 4 دقائق )","md",true)
elseif Redis:ttl(TeleGod.."iiooooo" .. msg.sender.user_id) >= 180 then
return LuaTele.sendText(msg.chat_id,msg.id,"⇜ مينفعش تضارب دلوقتي\n⇜ تعال بعد ( 3 دقائق )","md",true)
elseif Redis:ttl(TeleGod.."iiooooo" .. msg.sender.user_id) >= 120 then
return LuaTele.sendText(msg.chat_id,msg.id,"⇜ مينفعش تضارب دلوقتي\n⇜ تعال بعد ( 2 دقيقة )","md",true)
elseif Redis:ttl(TeleGod.."iiooooo" .. msg.sender.user_id) >= 60 then
return LuaTele.sendText(msg.chat_id,msg.id,"⇜ مينفعش تضارب دلوقتي\n⇜ تعال بعد ( 1 دقيقة )","md",true)
end
ballancee = Redis:get(TeleGod.."boob"..msg.sender.user_id) or 0
if tonumber(coniss) < 99 then
return LuaTele.sendText(msg.chat_id,msg.id, "⇜ الحد الادنى المسموح هو 100 جنيه 💵\n✦","md",true)
end
if tonumber(ballancee) < tonumber(coniss) then
return LuaTele.sendText(msg.chat_id,msg.id, "⇜ فلوسك ماتكفي \n✦","md",true)
end
local modarba = {"0", "1", "2", "3", "4️",}
local Descriptioontt = modarba[math.random(#modarba)]
local modarbaa = math.random(1,90);
if Descriptioontt == "1" or Descriptioontt == "3" then
ballanceekku = coniss / 100 * modarbaa
ballanceekkku = ballancee - ballanceekku
Redis:set(TeleGod.."boob"..msg.sender.user_id , math.floor(ballanceekkku))
Redis:setex(TeleGod.."iiooooo" .. msg.sender.user_id,1200, true)
LuaTele.sendText(msg.chat_id,msg.id, "⇜ مضاربة فاشلة 📉\n⇜ نسبة الخسارة ↢ "..modarbaa.."%\n⇜ المبلغ الذي خسرته ↢ ( "..ballanceekku.." جنيه 💵 )\n⇜ فلوسك صارت ↢ ( "..ballanceekkku.." جنيه 💵 )\n✦","md",true)
elseif Descriptioontt == "2" or Descriptioontt == "4" then
ballanceekku = coniss / 100 * modarbaa
ballanceekkku = ballancee + ballanceekku
Redis:set(TeleGod.."boob"..msg.sender.user_id , math.floor(ballanceekkku))
Redis:setex(TeleGod.."iiooooo" .. msg.sender.user_id,1200, true)
LuaTele.sendText(msg.chat_id,msg.id, "⇜ مضاربة ناجحة 📈\n⇜ نسبة الربح ↢ "..modarbaa.."%\n⇜ المبلغ الذي ربحته ↢ ( "..ballanceekku.." جنيه 💵 )\n⇜ فلوسك صارت ↢ ( "..ballanceekkku.." جنيه 💵 )\n✦","md",true)
else
Redis:setex(TeleGod.."iiooooo" .. msg.sender.user_id,1200, true)
LuaTele.sendText(msg.chat_id,msg.id, "⇜ تأخرت اليوم والبنك مسكر ارجع بعدين \n✦","md",true)
end
else
LuaTele.sendText(msg.chat_id,msg.id, "⇜ معندكش حساب بنكي ارسل ↢ ( `انشاء حساب بنكي` )","md",true)
end
end

if text == 'استثمار' then
LuaTele.sendText(msg.chat_id,msg.id, "استعمل الامر كذا :\n\n`استثمار` المبلغ","md",true)
end

if text and text:match('^استثمار (.*)$') then
local UserName = text:match('^استثمار (.*)$')
local coniss = tostring(UserName)
local coniss = coniss:gsub('٠','0')
local coniss = coniss:gsub('١','1')
local coniss = coniss:gsub('٢','2')
local coniss = coniss:gsub('٣','3')
local coniss = coniss:gsub('٤','4')
local coniss = coniss:gsub('٥','5')
local coniss = coniss:gsub('٦','6')
local coniss = coniss:gsub('٧','7')
local coniss = coniss:gsub('٨','8')
local coniss = coniss:gsub('٩','9')
local coniss = tonumber(coniss)
if Redis:sismember(TeleGod.."booob",msg.sender.user_id) then
if Redis:ttl(TeleGod.."iioooo" .. msg.sender.user_id) >= 1180 then
return LuaTele.sendText(msg.chat_id,msg.id,"⇜ مينفعش تستثمر دلوقتي\n⇜ تعال بعد ( 20 دقيقة )","md",true)
elseif Redis:ttl(TeleGod.."iioooo" .. msg.sender.user_id) >= 1120 then
return LuaTele.sendText(msg.chat_id,msg.id,"⇜ مينفعش تستثمر دلوقتي\n⇜ تعال بعد ( 19 دقيقة )","md",true)
elseif Redis:ttl(TeleGod.."iioooo" .. msg.sender.user_id) >= 1060 then
return LuaTele.sendText(msg.chat_id,msg.id,"⇜ مينفعش تستثمر دلوقتي\n⇜ تعال بعد ( 18 دقيقة )","md",true)
elseif Redis:ttl(TeleGod.."iioooo" .. msg.sender.user_id) >= 1000 then
return LuaTele.sendText(msg.chat_id,msg.id,"⇜ مينفعش تستثمر دلوقتي\n⇜ تعال بعد ( 17 دقيقة )","md",true)
elseif Redis:ttl(TeleGod.."iioooo" .. msg.sender.user_id) >= 940 then
return LuaTele.sendText(msg.chat_id,msg.id,"⇜ مينفعش تستثمر دلوقتي\n⇜ تعال بعد ( 16 دقيقة )","md",true)
elseif Redis:ttl(TeleGod.."iioooo" .. msg.sender.user_id) >= 880 then
return LuaTele.sendText(msg.chat_id,msg.id,"⇜ مينفعش تستثمر دلوقتي\n⇜ تعال بعد ( 15 دقيقة )","md",true)
elseif Redis:ttl(TeleGod.."iioooo" .. msg.sender.user_id) >= 820 then
return LuaTele.sendText(msg.chat_id,msg.id,"⇜ مينفعش تستثمر دلوقتي\n⇜ تعال بعد ( 14 دقيقة )","md",true)
elseif Redis:ttl(TeleGod.."iioooo" .. msg.sender.user_id) >= 760 then
return LuaTele.sendText(msg.chat_id,msg.id,"⇜ مينفعش تستثمر دلوقتي\n⇜ تعال بعد ( 13 دقيقة )","md",true)
elseif Redis:ttl(TeleGod.."iioooo" .. msg.sender.user_id) >= 700 then
return LuaTele.sendText(msg.chat_id,msg.id,"⇜ مينفعش تستثمر دلوقتي\n⇜ تعال بعد ( 12 دقيقة )","md",true)
elseif Redis:ttl(TeleGod.."iioooo" .. msg.sender.user_id) >= 640 then
return LuaTele.sendText(msg.chat_id,msg.id,"⇜ مينفعش تستثمر دلوقتي\n⇜ تعال بعد ( 11 دقيقة )","md",true)
elseif Redis:ttl(TeleGod.."iioooo" .. msg.sender.user_id) >= 580 then
return LuaTele.sendText(msg.chat_id,msg.id,"⇜ مينفعش تستثمر دلوقتي\n⇜ تعال بعد ( 10 دقائق )","md",true)
elseif Redis:ttl(TeleGod.."iioooo" .. msg.sender.user_id) >= 540 then
return LuaTele.sendText(msg.chat_id,msg.id,"⇜ مينفعش تستثمر دلوقتي\n⇜ تعال بعد ( 9 دقائق )","md",true)
elseif Redis:ttl(TeleGod.."iioooo" .. msg.sender.user_id) >= 480 then
return LuaTele.sendText(msg.chat_id,msg.id,"⇜ مينفعش تستثمر دلوقتي\n⇜ تعال بعد ( 8 دقائق )","md",true)
elseif Redis:ttl(TeleGod.."iioooo" .. msg.sender.user_id) >= 420 then
return LuaTele.sendText(msg.chat_id,msg.id,"⇜ مينفعش تستثمر دلوقتي\n⇜ تعال بعد ( 7 دقائق )","md",true)
elseif Redis:ttl(TeleGod.."iioooo" .. msg.sender.user_id) >= 360 then
return LuaTele.sendText(msg.chat_id,msg.id,"⇜ مينفعش تستثمر دلوقتي\n⇜ تعال بعد ( 6 دقائق )","md",true)
elseif Redis:ttl(TeleGod.."iioooo" .. msg.sender.user_id) >= 300 then
return LuaTele.sendText(msg.chat_id,msg.id,"⇜ مينفعش تستثمر دلوقتي\n⇜ تعال بعد ( 5 دقائق )","md",true)
elseif Redis:ttl(TeleGod.."iioooo" .. msg.sender.user_id) >= 240 then
return LuaTele.sendText(msg.chat_id,msg.id,"⇜ مينفعش تستثمر دلوقتي\n⇜ تعال بعد ( 4 دقائق )","md",true)
elseif Redis:ttl(TeleGod.."iioooo" .. msg.sender.user_id) >= 180 then
return LuaTele.sendText(msg.chat_id,msg.id,"⇜ مينفعش تستثمر دلوقتي\n⇜ تعال بعد ( 3 دقائق )","md",true)
elseif Redis:ttl(TeleGod.."iioooo" .. msg.sender.user_id) >= 120 then
return LuaTele.sendText(msg.chat_id,msg.id,"⇜ مينفعش تستثمر دلوقتي\n⇜ تعال بعد ( 2 دقيقة )","md",true)
elseif Redis:ttl(TeleGod.."iioooo" .. msg.sender.user_id) >= 60 then
return LuaTele.sendText(msg.chat_id,msg.id,"⇜ مينفعش تستثمر دلوقتي\n⇜ تعال بعد ( 1 دقيقة )","md",true)
end
ballancee = Redis:get(TeleGod.."boob"..msg.sender.user_id) or 0
if tonumber(coniss) < 99 then
return LuaTele.sendText(msg.chat_id,msg.id, "⇜ الحد الادنى المسموح هو 100 جنيه 💵\n✦","md",true)
end
if tonumber(ballancee) < tonumber(coniss) then
return LuaTele.sendText(msg.chat_id,msg.id, "⇜ فلوسك ماتكفي \n✦","md",true)
end
local hadddd = math.random(0,17);
ballanceekk = coniss / 100 * hadddd
ballanceekkk = ballancee + ballanceekk
Redis:incrby(TeleGod.."boob"..msg.sender.user_id , math.floor(ballanceekk))
Redis:setex(TeleGod.."iioooo" .. msg.sender.user_id,1200, true)
LuaTele.sendText(msg.chat_id,msg.id, "⇜ استثمار ناجح 💰\n⇜ نسبة الربح ↢ "..hadddd.."%\n⇜ مبلغ الربح ↢ ( "..ballanceekk.." جنيه 💵 )\n⇜ فلوسك صارت ↢ ( "..ballanceekkk.." جنيه 💵 )\n✦","md",true)
else
LuaTele.sendText(msg.chat_id,msg.id, "⇜ معندكش حساب بنكي ارسل ↢ ( `انشاء حساب بنكي` )","md",true)
end
end

if text == 'حظ' then
LuaTele.sendText(msg.chat_id,msg.id, "استعمل الامر كذا :\n\n`حظ` المبلغ","md",true)
end

if text and text:match('^حظ (.*)$') then
local UserName = text:match('^حظ (.*)$')
local coniss = tostring(UserName)
local coniss = coniss:gsub('٠','0')
local coniss = coniss:gsub('١','1')
local coniss = coniss:gsub('٢','2')
local coniss = coniss:gsub('٣','3')
local coniss = coniss:gsub('٤','4')
local coniss = coniss:gsub('٥','5')
local coniss = coniss:gsub('٦','6')
local coniss = coniss:gsub('٧','7')
local coniss = coniss:gsub('٨','8')
local coniss = coniss:gsub('٩','9')
local coniss = tonumber(coniss)
if Redis:sismember(TeleGod.."booob",msg.sender.user_id) then
if Redis:ttl(TeleGod.."iiooo" .. msg.sender.user_id) >= 1180 then
return LuaTele.sendText(msg.chat_id,msg.id,"⇜ مينفعش تلعب لعبة الحظ دلوقتي\n⇜ تعال بعد ( 20 دقيقة )","md",true)
elseif Redis:ttl(TeleGod.."iiooo" .. msg.sender.user_id) >= 1120 then
return LuaTele.sendText(msg.chat_id,msg.id,"⇜ مينفعش تلعب لعبة الحظ دلوقتي\n⇜ تعال بعد ( 19 دقيقة )","md",true)
elseif Redis:ttl(TeleGod.."iiooo" .. msg.sender.user_id) >= 1060 then
return LuaTele.sendText(msg.chat_id,msg.id,"⇜ مينفعش تلعب لعبة الحظ دلوقتي\n⇜ تعال بعد ( 18 دقيقة )","md",true)
elseif Redis:ttl(TeleGod.."iiooo" .. msg.sender.user_id) >= 1000 then
return LuaTele.sendText(msg.chat_id,msg.id,"⇜ مينفعش تلعب لعبة الحظ دلوقتي\n⇜ تعال بعد ( 17 دقيقة )","md",true)
elseif Redis:ttl(TeleGod.."iiooo" .. msg.sender.user_id) >= 940 then
return LuaTele.sendText(msg.chat_id,msg.id,"⇜ مينفعش تلعب لعبة الحظ دلوقتي\n⇜ تعال بعد ( 16 دقيقة )","md",true)
elseif Redis:ttl(TeleGod.."iiooo" .. msg.sender.user_id) >= 880 then
return LuaTele.sendText(msg.chat_id,msg.id,"⇜ مينفعش تلعب لعبة الحظ دلوقتي\n⇜ تعال بعد ( 15 دقيقة )","md",true)
elseif Redis:ttl(TeleGod.."iiooo" .. msg.sender.user_id) >= 820 then
return LuaTele.sendText(msg.chat_id,msg.id,"⇜ مينفعش تلعب لعبة الحظ دلوقتي\n⇜ تعال بعد ( 14 دقيقة )","md",true)
elseif Redis:ttl(TeleGod.."iiooo" .. msg.sender.user_id) >= 760 then
return LuaTele.sendText(msg.chat_id,msg.id,"⇜ مينفعش تلعب لعبة الحظ دلوقتي\n⇜ تعال بعد ( 13 دقيقة )","md",true)
elseif Redis:ttl(TeleGod.."iiooo" .. msg.sender.user_id) >= 700 then
return LuaTele.sendText(msg.chat_id,msg.id,"⇜ مينفعش تلعب لعبة الحظ دلوقتي\n⇜ تعال بعد ( 12 دقيقة )","md",true)
elseif Redis:ttl(TeleGod.."iiooo" .. msg.sender.user_id) >= 640 then
return LuaTele.sendText(msg.chat_id,msg.id,"⇜ مينفعش تلعب لعبة الحظ دلوقتي\n⇜ تعال بعد ( 11 دقيقة )","md",true)
elseif Redis:ttl(TeleGod.."iiooo" .. msg.sender.user_id) >= 580 then
return LuaTele.sendText(msg.chat_id,msg.id,"⇜ مينفعش تلعب لعبة الحظ دلوقتي\n⇜ تعال بعد ( 10 دقائق )","md",true)
elseif Redis:ttl(TeleGod.."iiooo" .. msg.sender.user_id) >= 540 then
return LuaTele.sendText(msg.chat_id,msg.id,"⇜ مينفعش تلعب لعبة الحظ دلوقتي\n⇜ تعال بعد ( 9 دقائق )","md",true)
elseif Redis:ttl(TeleGod.."iiooo" .. msg.sender.user_id) >= 480 then
return LuaTele.sendText(msg.chat_id,msg.id,"⇜ مينفعش تلعب لعبة الحظ دلوقتي\n⇜ تعال بعد ( 8 دقائق )","md",true)
elseif Redis:ttl(TeleGod.."iiooo" .. msg.sender.user_id) >= 420 then
return LuaTele.sendText(msg.chat_id,msg.id,"⇜ مينفعش تلعب لعبة الحظ دلوقتي\n⇜ تعال بعد ( 7 دقائق )","md",true)
elseif Redis:ttl(TeleGod.."iiooo" .. msg.sender.user_id) >= 360 then
return LuaTele.sendText(msg.chat_id,msg.id,"⇜ مينفعش تلعب لعبة الحظ دلوقتي\n⇜ تعال بعد ( 6 دقائق )","md",true)
elseif Redis:ttl(TeleGod.."iiooo" .. msg.sender.user_id) >= 300 then
return LuaTele.sendText(msg.chat_id,msg.id,"⇜ مينفعش تلعب لعبة الحظ دلوقتي\n⇜ تعال بعد ( 5 دقائق )","md",true)
elseif Redis:ttl(TeleGod.."iiooo" .. msg.sender.user_id) >= 240 then
return LuaTele.sendText(msg.chat_id,msg.id,"⇜ مينفعش تلعب لعبة الحظ دلوقتي\n⇜ تعال بعد ( 4 دقائق )","md",true)
elseif Redis:ttl(TeleGod.."iiooo" .. msg.sender.user_id) >= 180 then
return LuaTele.sendText(msg.chat_id,msg.id,"⇜ مينفعش تلعب لعبة الحظ دلوقتي\n⇜ تعال بعد ( 3 دقائق )","md",true)
elseif Redis:ttl(TeleGod.."iiooo" .. msg.sender.user_id) >= 120 then
return LuaTele.sendText(msg.chat_id,msg.id,"⇜ مينفعش تلعب لعبة الحظ دلوقتي\n⇜ تعال بعد ( 2 دقيقة )","md",true)
elseif Redis:ttl(TeleGod.."iiooo" .. msg.sender.user_id) >= 60 then
return LuaTele.sendText(msg.chat_id,msg.id,"⇜ مينفعش تلعب لعبة الحظ دلوقتي\n⇜ تعال بعد ( 1 دقيقة )","md",true)
end
ballancee = Redis:get(TeleGod.."boob"..msg.sender.user_id) or 0
if tonumber(ballancee) < tonumber(coniss) then
return LuaTele.sendText(msg.chat_id,msg.id, "⇜ فلوسك ماتكفي \n✦","md",true)
end
local daddd = {"1", "2", "3", "4️",}
local haddd = daddd[math.random(#daddd)]
if haddd == "1" or haddd == "3" then
local ballanceek = ballancee + coniss
Redis:incrby(TeleGod.."boob"..msg.sender.user_id , math.floor(ballanceek))
Redis:setex(TeleGod.."iiooo" .. msg.sender.user_id,1200, true)
LuaTele.sendText(msg.chat_id,msg.id, "⇜ مبروك فزت بالحظ 🎉\n⇜ فلوسك قبل ↢ ( "..ballancee.." جنيه 💵 )\n⇜ فلوسك دلوقتي ↢ ( "..ballanceek.." جنيه 💵 )\n✦","md",true)
else
local ballanceekk = ballancee - coniss
Redis:decrby(TeleGod.."boob"..msg.sender.user_id , coniss)
Redis:setex(TeleGod.."iiooo" .. msg.sender.user_id,1200, true)
LuaTele.sendText(msg.chat_id,msg.id, "⇜ للاسف خسرت بالحظ 😬\n⇜ فلوسك قبل ↢ ( "..ballancee.." جنيه 💵 )\n⇜ فلوسك دلوقتي ↢ ( "..ballanceekk.." جنيه 💵 )\n✦","md",true)
end
else
LuaTele.sendText(msg.chat_id,msg.id, "⇜ معندكش حساب بنكي ارسل ↢ ( `انشاء حساب بنكي` )","md",true)
end
end

if text == 'تحويل' then
LuaTele.sendText(msg.chat_id,msg.id, "استعمل الامر كذا :\n\n`تحويل` المبلغ","md",true)
end

if text and text:match('^تحويل (.*)$') then
local UserName = text:match('^تحويل (.*)$')
local coniss = tostring(UserName)
local coniss = coniss:gsub('٠','0')
local coniss = coniss:gsub('١','1')
local coniss = coniss:gsub('٢','2')
local coniss = coniss:gsub('٣','3')
local coniss = coniss:gsub('٤','4')
local coniss = coniss:gsub('٥','5')
local coniss = coniss:gsub('٦','6')
local coniss = coniss:gsub('٧','7')
local coniss = coniss:gsub('٨','8')
local coniss = coniss:gsub('٩','9')
local coniss = tonumber(coniss)
if not Redis:sismember(TeleGod.."booob",msg.sender.user_id) then
return LuaTele.sendText(msg.chat_id,msg.id, "⇜ معندكش حساب بنكي ","md",true)
end
if tonumber(coniss) < 100 then
return LuaTele.sendText(msg.chat_id,msg.id, "⇜ الحد الادنى المسموح به هو 100 جنيه \n✦","md",true)
end
ballancee = Redis:get(TeleGod.."boob"..msg.sender.user_id) or 0
if tonumber(ballancee) < 100 then
return LuaTele.sendText(msg.chat_id,msg.id, "⇜ فلوسك ماتكفي \n✦","md",true)
end

if tonumber(coniss) > tonumber(ballancee) then
return LuaTele.sendText(msg.chat_id,msg.id, "⇜ فلوسك ماتكفي\n✦","md",true)
end

Redis:set(TeleGod.."transn"..msg.sender.user_id,coniss)
Redis:setex(TeleGod.."trans" .. msg.chat_id .. ":" .. msg.sender.user_id,60, true)
LuaTele.sendText(msg.chat_id,msg.id,[[
⇜ ارسل دلوقتي رقم الحساب البنكي الي تبي تحول له

– معاك دقيقة وحدة والغي طلب التحويل .
✦
]],"md",true)  
return false
end
if Redis:get(TeleGod.."trans" .. msg.chat_id .. ":" .. msg.sender.user_id) then
cccc = Redis:get(TeleGod.."boobb"..msg.sender.user_id)
uuuu = Redis:get(TeleGod.."bbobb"..msg.sender.user_id)
if text ~= text:match('^(%d+)$') then
Redis:del(TeleGod.."trans" .. msg.chat_id .. ":" .. msg.sender.user_id) 
Redis:del(TeleGod.."transn" .. msg.sender.user_id)
return LuaTele.sendText(msg.chat_id,msg.id,"⇜ ارسل رقم حساب بنكي ","md",true)
end
if text == cccc then
Redis:del(TeleGod.."trans" .. msg.chat_id .. ":" .. msg.sender.user_id) 
Redis:del(TeleGod.."transn" .. msg.sender.user_id)
return LuaTele.sendText(msg.chat_id,msg.id,"⇜ مينفعش تحول لنفسك ","md",true)
end
if Redis:get(TeleGod.."boballcc"..text) then
local UserNamey = Redis:get(TeleGod.."transn"..msg.sender.user_id)
local ban = LuaTele.getUser(msg.sender.user_id)
if ban.first_name then
news = "["..ban.first_name.."](tg://user?id="..ban.id..")"
else
news = " لا يوجد "
end
local fsvhhh = Redis:get(TeleGod.."boballid"..text)
local bann = LuaTele.getUser(fsvhhh)
if bann.first_name then
newss = "["..bann.first_name.."](tg://user?id="..bann.id..")"
else
newss = " لا يوجد "
end
local fsvhh = Redis:get(TeleGod.."boballban"..text)
UserNameyr = UserNamey / 10
UserNameyy = UserNamey - UserNameyr
Redis:decrby(TeleGod.."boob"..msg.sender.user_id , UserNamey)
Redis:incrby(TeleGod.."boob"..fsvhhh , math.floor(UserNameyy))
LuaTele.sendText(msg.chat_id,msg.id, "حوالة صادرة من بنك تلي جود\n\nالمرسل : "..news.."\nالحساب رقم : `"..cccc.."`\nنوع البطاقة : "..uuuu.."\nالمستلم : "..newss.."\nالحساب رقم : `"..text.."`\nنوع البطاقة : "..fsvhh.."\nخصمت 10% رسوم تحويل\nالمبلغ : "..UserNameyy.." جنيه 💵","md",true)
LuaTele.sendText(fsvhhh,0, "حوالة واردة من بنك تلي جود\n\nالمرسل : "..news.."\nالحساب رقم : `"..cccc.."`\nنوع البطاقة : "..uuuu.."\nالمبلغ : "..UserNameyy.." جنيه 💵","md",true)
Redis:del(TeleGod.."trans" .. msg.chat_id .. ":" .. msg.sender.user_id) 
Redis:del(TeleGod.."transn" .. msg.sender.user_id)
else
LuaTele.sendText(msg.chat_id,msg.id, "⇜ مافيه حساب بنكي كذا","md",true)
Redis:del(TeleGod.."trans" .. msg.chat_id .. ":" .. msg.sender.user_id) 
Redis:del(TeleGod.."transn" .. msg.sender.user_id)
end
end

if text and text:match("^اضف فلوس (.*)$") and msg.reply_to_message_id ~= 0 then
local UserName = text:match('^اضف فلوس (.*)$')
local coniss = tostring(UserName)
local coniss = coniss:gsub('٠','0')
local coniss = coniss:gsub('١','1')
local coniss = coniss:gsub('٢','2')
local coniss = coniss:gsub('٣','3')
local coniss = coniss:gsub('٤','4')
local coniss = coniss:gsub('٥','5')
local coniss = coniss:gsub('٦','6')
local coniss = coniss:gsub('٧','7')
local coniss = coniss:gsub('٨','8')
local coniss = coniss:gsub('٩','9')
local coniss = tonumber(coniss)
if msg.ControllerBot then
local Remsg = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Remsg.sender.user_id)
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
LuaTele.sendText(msg.chat_id,msg.id,"\n*⇜ البوت معندوش حساب بالبنك 🤣*","md",true)  
return false
end
local ban = LuaTele.getUser(Remsg.sender.user_id)
if ban.first_name then
news = ""..ban.first_name..""
else
news = " لا يوجد"
end
if Redis:sismember(TeleGod.."booob",Remsg.sender.user_id) then
Redis:incrby(TeleGod.."boob"..Remsg.sender.user_id , coniss)
ccccc = Redis:get(TeleGod.."boobb"..Remsg.sender.user_id)
uuuuu = Redis:get(TeleGod.."bbobb"..Remsg.sender.user_id)
ppppp = Redis:get(TeleGod.."zrfff"..Remsg.sender.user_id) or 0
ballanceed = Redis:get(TeleGod.."boob"..Remsg.sender.user_id) or 0
LuaTele.sendText(msg.chat_id,msg.id, "⇜ الاسم ↢ "..news.."\n⇜ الحساب ↢ `"..ccccc.."`\n⇜ بنك ↢ ( تلي جود )\n⇜ نوع ↢ ( "..uuuuu.." )\n⇜ الزرف ↢ ( "..ppppp.." جنيه 💵 )\n⇜ صار رصيده ↢ ( "..ballanceed.." جنيه 💵 )\n✦","md",true)
else
LuaTele.sendText(msg.chat_id,msg.id, "⇜ معندوش حساب بنكي ","md",true)
end
end
end

if text == 'توب' or text == 'التوب' then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',data = {
{{text = 'توب الفلوس 🏦', data = msg.sender.user_id..'/top/flos'},{text = 'توب الحراميه 🏛️ ', data = msg.sender.user_id..'/top/zrf'},},
}}
return LuaTele.sendText(msg.chat_id,msg.id,'*مـرحـبا بك في قائـمة التوب لهذا الاسبوع ᥫ᭡*',"md",false, false, false, false, reply_markup)
end

if text == "توب الاموال" or text == "توب الفلوس" then
local bank_users = Redis:smembers(TeleGod.."booob")
if #bank_users == 0 then
return LuaTele.sendText(msg.chat_id,msg.id,"⇜ لم يقم احد بعمل حساب بنكي","md",true)
end
top_mony = "توب اغنى 20 شخص :\n\n"
mony_list = {}
for k,v in pairs(bank_users) do
local mony = Redis:get(TeleGod.."boob"..v)
table.insert(mony_list, {tonumber(mony) , v})
end
table.sort(mony_list, function(a, b) return a[1] > b[1] end)
num = 1
emoji ={ 
"🥇" ,
"🥈",
"🥉",
"4",
"5",
"6",
"7",
"8",
"9",
"10",
"11",
"12",
"13",
"14",
"15",
"16",
"17",
"18",
"19",
"20"
}
for k,v in pairs(mony_list) do
if num <= 20 then
local user_name = LuaTele.getUser(v[2]).first_name
local user_tag = '['..user_name..'](tg://user?id='..v[2]..')'
local user_jack = '['..user_name..']('..user_name..')'
local mony = v[1]
local emo = emoji[k]
num = num + 1
top_mony = top_mony..emo.." - "..mony.." | "..user_jack.." 💸 \n"
end
end
return LuaTele.sendText(msg.chat_id,msg.id,top_mony,"md",true)
end

if text == "توب الحراميه" or text == "توب اللصوص" or text == "توب السرقه" or text == "توب الزرف" or text == "توب زرف" then
local ty_users = Redis:smembers(TeleGod.."zrfffid")
if #ty_users == 0 then
return LuaTele.sendText(msg.chat_id,msg.id,"•  لم يقم احد ب سرقه الاموال حتي الان","md",true)
end
ty_siria = "توب 20 شخص سرقوا فلوس :\n#يتم تصفير النتائج كل اسبوع\n\n"
ty_list = {}
for k,v in pairs(ty_users) do
local mony = Redis:get(TeleGod.."zrfff"..v)
table.insert(ty_list, {tonumber(mony) , v})
end
table.sort(ty_list, function(a, b) return a[1] > b[1] end)
num_ty = 1
emojii ={ 
"🥇" ,
"🥈",
"🥉",
"4",
"5",
"6",
"7",
"8",
"9",
"10",
"11",
"12",
"13",
"14",
"15",
"16",
"17",
"18",
"19",
"20"
}
for k,v in pairs(ty_list) do
if num_ty <= 20 then
local user_name = LuaTele.getUser(v[2]).first_name
local user_tag = '['..user_name..'](tg://user?id='..v[2]..')'
local user_siria = '['..user_name..']('..user_name..')'
local mony = v[1]
local emoo = emojii[k]
num_ty = num_ty + 1
ty_siria = ty_siria..emoo.." - "..mony.." | "..user_siria.." 💸 \n"
end
end
return LuaTele.sendText(msg.chat_id,msg.id,ty_siria,"md",true)
end

if text == 'بخشيش' or text == 'بقشيش' then
if Redis:sismember(TeleGod.."booob",msg.sender.user_id) then
if Redis:ttl(TeleGod.."iioo" .. msg.sender.user_id) >= 580 then
return LuaTele.sendText(msg.chat_id,msg.id,"⇜ من شوي اخدت بخشيش استنى ( 10 دقائق )","md",true)
elseif Redis:ttl(TeleGod.."iioo" .. msg.sender.user_id) >= 540 then
return LuaTele.sendText(msg.chat_id,msg.id,"⇜ من شوي اخدت بخشيش استنى ( 9 دقائق )","md",true)
elseif Redis:ttl(TeleGod.."iioo" .. msg.sender.user_id) >= 480 then
return LuaTele.sendText(msg.chat_id,msg.id,"⇜ من شوي اخدت بخشيش استنى ( 8 دقائق )","md",true)
elseif Redis:ttl(TeleGod.."iioo" .. msg.sender.user_id) >= 420 then
return LuaTele.sendText(msg.chat_id,msg.id,"⇜ من شوي اخدت بخشيش استنى ( 7 دقائق )","md",true)
elseif Redis:ttl(TeleGod.."iioo" .. msg.sender.user_id) >= 360 then
return LuaTele.sendText(msg.chat_id,msg.id,"⇜ من شوي اخدت بخشيش استنى ( 6 دقائق )","md",true)
elseif Redis:ttl(TeleGod.."iioo" .. msg.sender.user_id) >= 300 then
return LuaTele.sendText(msg.chat_id,msg.id,"⇜ من شوي اخدت بخشيش استنى ( 5 دقائق )","md",true)
elseif Redis:ttl(TeleGod.."iioo" .. msg.sender.user_id) >= 240 then
return LuaTele.sendText(msg.chat_id,msg.id,"⇜ من شوي اخدت بخشيش استنى ( 4 دقائق )","md",true)
elseif Redis:ttl(TeleGod.."iioo" .. msg.sender.user_id) >= 180 then
return LuaTele.sendText(msg.chat_id,msg.id,"⇜ من شوي اخدت بخشيش استنى ( 3 دقائق )","md",true)
elseif Redis:ttl(TeleGod.."iioo" .. msg.sender.user_id) >= 120 then
return LuaTele.sendText(msg.chat_id,msg.id,"⇜ من شوي اخدت بخشيش استنى ( 2 دقيقة )","md",true)
elseif Redis:ttl(TeleGod.."iioo" .. msg.sender.user_id) >= 60 then
return LuaTele.sendText(msg.chat_id,msg.id,"⇜ من شوي اخدت بخشيش استنى ( 1 دقيقة )","md",true)
end
local jjjo = math.random(100,1000);
Redis:incrby(TeleGod.."boob"..msg.sender.user_id , jjjo)
LuaTele.sendText(msg.chat_id,msg.id,"⇜ تكرم وهي بخشيش "..jjjo.." جنيه 💵","md",true)
Redis:setex(TeleGod.."iioo" .. msg.sender.user_id,600, true)
else
LuaTele.sendText(msg.chat_id,msg.id, "⇜ معندكش حساب بنكي ارسل ↢ ( `انشاء حساب بنكي` )","md",true)
end
end

if text == 'زرف' and tonumber(msg.reply_to_message_id) == 0 then
LuaTele.sendText(msg.chat_id,msg.id, "استعمل الامر كذا :\n\n`زرف` بالرد","md",true)
end

if text == 'زرف' or text == 'زرفو' or text == 'زرفه' and tonumber(msg.reply_to_message_id) ~= 0 then
local Remsg = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Remsg.sender.user_id)
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
LuaTele.sendText(msg.chat_id,msg.id,"\n*⇜ البوت معندوش حساب بالبنك 🤣*","md",true)  
return false
end
if Remsg.sender.user_id == msg.sender.user_id then
LuaTele.sendText(msg.chat_id,msg.id,"\n*⇜ عاوز تزرف نفسك 🤡*","md",true)  
return false
end
if Redis:ttl(TeleGod.."polic" .. msg.sender.user_id) >= 280 then
return LuaTele.sendText(msg.chat_id,msg.id,"⇜ انت في السجن اصبر ( 5 دقائق )","md",true)
elseif Redis:ttl(TeleGod.."polic" .. msg.sender.user_id) >= 240 then
return LuaTele.sendText(msg.chat_id,msg.id,"⇜ انت في السجن اصبر ( 4 دقائق )","md",true)
elseif Redis:ttl(TeleGod.."polic" .. msg.sender.user_id) >= 180 then
return LuaTele.sendText(msg.chat_id,msg.id,"⇜ انت في السجن اصبر ( 3 دقائق )","md",true)
elseif Redis:ttl(TeleGod.."polic" .. msg.sender.user_id) >= 120 then
return LuaTele.sendText(msg.chat_id,msg.id,"⇜ انت في السجن اصبر ( 2 دقيقة )","md",true)
elseif Redis:ttl(TeleGod.."polic" .. msg.sender.user_id) >= 60 then
return LuaTele.sendText(msg.chat_id,msg.id,"⇜ انت في السجن اصبر ( 1 دقيقة )","md",true)
end
if Redis:ttl(TeleGod.."hrame" .. Remsg.sender.user_id) >= 880 then
return LuaTele.sendText(msg.chat_id,msg.id,"⇜ الغلبان دا مزروف من شويه\n⇜ هينفع تزرفه كمان ( 15 دقيقة )","md",true)
elseif Redis:ttl(TeleGod.."hrame" .. Remsg.sender.user_id) >= 820 then
return LuaTele.sendText(msg.chat_id,msg.id,"⇜ الغلبان دا مزروف من شويه\n⇜ هينفع تزرفه كمان ( 14 دقيقة )","md",true)
elseif Redis:ttl(TeleGod.."hrame" .. Remsg.sender.user_id) >= 760 then
return LuaTele.sendText(msg.chat_id,msg.id,"⇜ الغلبان دا مزروف من شويه\n⇜ هينفع تزرفه كمان ( 13 دقيقة )","md",true)
elseif Redis:ttl(TeleGod.."hrame" .. Remsg.sender.user_id) >= 700 then
return LuaTele.sendText(msg.chat_id,msg.id,"⇜ الغلبان دا مزروف من شويه\n⇜ هينفع تزرفه كمان ( 12 دقيقة )","md",true)
elseif Redis:ttl(TeleGod.."hrame" .. Remsg.sender.user_id) >= 640 then
return LuaTele.sendText(msg.chat_id,msg.id,"⇜ الغلبان دا مزروف من شويه\n⇜ هينفع تزرفه كمان ( 11 دقيقة )","md",true)
elseif Redis:ttl(TeleGod.."hrame" .. Remsg.sender.user_id) >= 580 then
return LuaTele.sendText(msg.chat_id,msg.id,"⇜ الغلبان دا مزروف من شويه\n⇜ هينفع تزرفه كمان ( 10 دقائق )","md",true)
elseif Redis:ttl(TeleGod.."hrame" .. Remsg.sender.user_id) >= 540 then
return LuaTele.sendText(msg.chat_id,msg.id,"⇜ الغلبان دا مزروف من شويه\n⇜ هينفع تزرفه كمان ( 9 دقائق )","md",true)
elseif Redis:ttl(TeleGod.."hrame" .. Remsg.sender.user_id) >= 480 then
return LuaTele.sendText(msg.chat_id,msg.id,"⇜ الغلبان دا مزروف من شويه\n⇜ هينفع تزرفه كمان ( 8 دقائق )","md",true)
elseif Redis:ttl(TeleGod.."hrame" .. Remsg.sender.user_id) >= 420 then
return LuaTele.sendText(msg.chat_id,msg.id,"⇜ الغلبان دا مزروف من شويه\n⇜ هينفع تزرفه كمان ( 7 دقائق )","md",true)
elseif Redis:ttl(TeleGod.."hrame" .. Remsg.sender.user_id) >= 360 then
return LuaTele.sendText(msg.chat_id,msg.id,"⇜ الغلبان دا مزروف من شويه\n⇜ هينفع تزرفه كمان ( 6 دقائق )","md",true)
elseif Redis:ttl(TeleGod.."hrame" .. Remsg.sender.user_id) >= 300 then
return LuaTele.sendText(msg.chat_id,msg.id,"⇜ الغلبان دا مزروف من شويه\n⇜ هينفع تزرفه كمان ( 5 دقائق )","md",true)
elseif Redis:ttl(TeleGod.."hrame" .. Remsg.sender.user_id) >= 240 then
return LuaTele.sendText(msg.chat_id,msg.id,"⇜ الغلبان دا مزروف من شويه\n⇜ هينفع تزرفه كمان ( 4 دقائق )","md",true)
elseif Redis:ttl(TeleGod.."hrame" .. Remsg.sender.user_id) >= 180 then
return LuaTele.sendText(msg.chat_id,msg.id,"⇜ الغلبان دا مزروف من شويه\n⇜ هينفع تزرفه كمان ( 3 دقائق )","md",true)
elseif Redis:ttl(TeleGod.."hrame" .. Remsg.sender.user_id) >= 120 then
return LuaTele.sendText(msg.chat_id,msg.id,"⇜ الغلبان دا مزروف من شويه\n⇜ هينفع تزرفه كمان ( 2 دقيقة )","md",true)
elseif Redis:ttl(TeleGod.."hrame" .. Remsg.sender.user_id) >= 60 then
return LuaTele.sendText(msg.chat_id,msg.id,"⇜ الغلبان دا مزروف من شويه\n⇜ هينفع تزرفه كمان ( 1 دقيقة )","md",true)
end
if Redis:sismember(TeleGod.."booob",Remsg.sender.user_id) then
ballanceed = Redis:get(TeleGod.."boob"..Remsg.sender.user_id) or 0
if tonumber(ballanceed) < 199 then
return LuaTele.sendText(msg.chat_id,msg.id, "⇜ مينفعش تزرفه فلوسه اقل من 200 جنيه 💵","md",true)
end
local hrame = math.floor(math.random() * 200) + 1;
local hramee = math.floor(math.random() * 5) + 1;
if hramee == 1 or hramee == 2 or hramee == 3 or hramee == 4 then
local ballanceed = Redis:get(TeleGod.."boob"..Remsg.sender.user_id) or 0
Redis:incrby(TeleGod.."boob"..msg.sender.user_id , hrame)
Redis:decrby(TeleGod.."boob"..Remsg.sender.user_id , hrame)
Redis:setex(TeleGod.."hrame" .. Remsg.sender.user_id,900, true)
Redis:incrby(TeleGod.."zrfff"..msg.sender.user_id,hrame)
Redis:sadd(TeleGod.."zrfffid",msg.sender.user_id)
LuaTele.sendText(msg.chat_id,msg.id, "⇜ خد يا حرامي سرقتلك منو دول "..hrame.." جنيه 💵\n✦","md",true)
else
Redis:setex(TeleGod.."polic" .. msg.sender.user_id,300, true)
LuaTele.sendText(msg.chat_id,msg.id, "⇜ الحكومه كبست عليك وانت بتسرق ربنا يفك الضيقه يخويا 😂🤸‍♂️\n✦","md",true)
end
else
LuaTele.sendText(msg.chat_id,msg.id, "⇜ معندوش حساب بنكي ","md",true)
end
end

if text == 'راتب' or text == 'راتبي' then
if Redis:sismember(TeleGod.."booob",msg.sender.user_id) then
if Redis:ttl(TeleGod.."iiioo" .. msg.sender.user_id) >= 580 then
return LuaTele.sendText(msg.chat_id,msg.id,"⇜ راتبك هينزل كمان ( 10 دقائق )","md",true)
elseif Redis:ttl(TeleGod.."iiioo" .. msg.sender.user_id) >= 540 then
return LuaTele.sendText(msg.chat_id,msg.id,"⇜ راتبك هينزل كمان ( 9 دقائق )","md",true)
elseif Redis:ttl(TeleGod.."iiioo" .. msg.sender.user_id) >= 480 then
return LuaTele.sendText(msg.chat_id,msg.id,"⇜ راتبك هينزل كمان ( 8 دقائق )","md",true)
elseif Redis:ttl(TeleGod.."iiioo" .. msg.sender.user_id) >= 420 then
return LuaTele.sendText(msg.chat_id,msg.id,"⇜ راتبك هينزل كمان ( 7 دقائق )","md",true)
elseif Redis:ttl(TeleGod.."iiioo" .. msg.sender.user_id) >= 360 then
return LuaTele.sendText(msg.chat_id,msg.id,"⇜ راتبك هينزل كمان ( 6 دقائق )","md",true)
elseif Redis:ttl(TeleGod.."iiioo" .. msg.sender.user_id) >= 300 then
return LuaTele.sendText(msg.chat_id,msg.id,"⇜ راتبك هينزل كمان ( 5 دقائق )","md",true)
elseif Redis:ttl(TeleGod.."iiioo" .. msg.sender.user_id) >= 240 then
return LuaTele.sendText(msg.chat_id,msg.id,"⇜ راتبك هينزل كمان ( 4 دقائق )","md",true)
elseif Redis:ttl(TeleGod.."iiioo" .. msg.sender.user_id) >= 180 then
return LuaTele.sendText(msg.chat_id,msg.id,"⇜ راتبك هينزل كمان ( 3 دقائق )","md",true)
elseif Redis:ttl(TeleGod.."iiioo" .. msg.sender.user_id) >= 120 then
return LuaTele.sendText(msg.chat_id,msg.id,"⇜ راتبك هينزل كمان ( 2 دقيقة )","md",true)
elseif Redis:ttl(TeleGod.."iiioo" .. msg.sender.user_id) >= 60 then
return LuaTele.sendText(msg.chat_id,msg.id,"⇜ راتبك هينزل كمان ( 1 دقيقة )","md",true)
end
local Textinggt = {"كابتن كريم 🚙", "شرطي 👮🏻‍♂️", "بياع حبوب 🍻", "سواق تاكسي 🚕", "قاضي 👨🏻‍⚖️", "نوم 🛌", "مغني 🎤", "كوفيره 💆🏻‍♀️", "ربة منزل 🤷🏻‍♀️", "مربيه اطفال 💁🏻‍♀️", "كهربائي 💡", "نجار ⛏", "متذوق طعام 🍕", "فلاح 👨🏻‍🌾", "كاشير بنده 🙋🏻‍♂️", "ممرض 👨🏻‍⚕️", "مهرج 🤹‍♂️", "عامل توصيل 🚴🏻‍♂️", "عسكري 👮🏻‍♂️", "مهندس 👨🏻‍🔧", "وزير 👨??‍🦳", "محامي ⚖️", "تاجر 💵", "دكتور 👨🏻‍⚕️", "حفار قبور ⚓️", "حلاق ✂️", "إمام مسجد 📿", "صياد 🎣", "خياط 🧵", "طيار 🛩", "مودل 🕴🏻", "ملك 👑", "سباك 🔧", "موزع 🗺", "سكيورتي 👮🏻‍♂️", "معلم شاورما 🌯", "دكتور ولاده 👨🏻‍⚕️", "مذيع 🗣", "عامل مساج 💆🏻‍♂️", "ممثل 🤵🏻", "جزار 🥩", "مدير بنك 💳", "مبرمج 👨🏻‍💻", "رقاصه 💃🏻", "👩🏼‍💻 صحفي", "🥷 حرامي", "🔮 ساحر", "⚽ لاعب️", "🖼 مصور", "☎️ عامل مقسم", "📖 كاتب", "🧪 مخبري",}
local Descriptioont = Textinggt[math.random(#Textinggt)]
local ban = LuaTele.getUser(msg.sender.user_id)
if ban.first_name then
neews = "["..ban.first_name.."](tg://user?id="..ban.id..")"
else
neews = " لا يوجد "
end
if Descriptioont == "كابتن كريم 🚙" then
Redis:incrby(TeleGod.."boob"..msg.sender.user_id , 50)
local ballancee = Redis:get(TeleGod.."boob"..msg.sender.user_id) or 0
LuaTele.sendText(msg.chat_id,msg.id,"اشعار ايداع "..neews.."\nالمبلغ : 25 جنيه 💵\nوظيفتك : كابتن كريم 🚙\nنوع العملية : اضافة راتب\nرصيدك دلوقتي : "..ballancee.." جنيه 💵","md",true)
Redis:setex(TeleGod.."iiioo" .. msg.sender.user_id,600, true)
elseif Descriptioont == "شرطي 👮🏻‍♂️" then
Redis:incrby(TeleGod.."boob"..msg.sender.user_id , 7500)
local ballancee = Redis:get(TeleGod.."boob"..msg.sender.user_id) or 0
LuaTele.sendText(msg.chat_id,msg.id,"اشعار ايداع "..neews.."\nالمبلغ : 7500 جنيه 💵\nوظيفتك : شرطي 👮🏻‍♂️\nنوع العملية : اضافة راتب\nرصيدك دلوقتي : "..ballancee.." جنيه 💵","md",true)
Redis:setex(TeleGod.."iiioo" .. msg.sender.user_id,600, true)
elseif Descriptioont == "بياع حبوب 🍻" then
Redis:incrby(TeleGod.."boob"..msg.sender.user_id , 7500)
local ballancee = Redis:get(TeleGod.."boob"..msg.sender.user_id) or 0
LuaTele.sendText(msg.chat_id,msg.id,"اشعار ايداع "..neews.."\nالمبلغ : 7500 جنيه 💵\nوظيفتك : بياع حبوب 🍻\nنوع العملية : اضافة راتب\nرصيدك دلوقتي : "..ballancee.." جنيه 💵","md",true)
Redis:setex(TeleGod.."iiioo" .. msg.sender.user_id,600, true)
elseif Descriptioont == "سواق تاكسي 🚕" then
Redis:incrby(TeleGod.."boob"..msg.sender.user_id , 5000)
local ballancee = Redis:get(TeleGod.."boob"..msg.sender.user_id) or 0
LuaTele.sendText(msg.chat_id,msg.id,"اشعار ايداع "..neews.."\nالمبلغ : 5000 جنيه 💵\nوظيفتك : سواق تاكسي 🚕\nنوع العملية : اضافة راتب\nرصيدك دلوقتي : "..ballancee.." جنيه 💵","md",true)
Redis:setex(TeleGod.."iiioo" .. msg.sender.user_id,600, true)
elseif Descriptioont == "قاضي 👨" then
Redis:incrby(TeleGod.."boob"..msg.sender.user_id , 15000)
local ballancee = Redis:get(TeleGod.."boob"..msg.sender.user_id) or 0
LuaTele.sendText(msg.chat_id,msg.id,"اشعار ايداع "..neews.."\nالمبلغ : 15000 جنيه 💵\nوظيفتك : قاضي 👨\nنوع العملية : اضافة راتب\nرصيدك دلوقتي : "..ballancee.." جنيه 💵","md",true)
Redis:setex(TeleGod.."iiioo" .. msg.sender.user_id,600, true)
elseif Descriptioont == "نوم 🛌" then
Redis:incrby(TeleGod.."boob"..msg.sender.user_id , 1500)
local ballancee = Redis:get(TeleGod.."boob"..msg.sender.user_id) or 0
LuaTele.sendText(msg.chat_id,msg.id,"اشعار ايداع "..neews.."\nالمبلغ : 1500 جنيه 💵\nوظيفتك : نوم 🛌\nنوع العملية : اضافة راتب\nرصيدك دلوقتي : "..ballancee.." جنيه 💵","md",true)
Redis:setex(TeleGod.."iiioo" .. msg.sender.user_id,600, true)
elseif Descriptioont == "مغني 🎤" then
Redis:incrby(TeleGod.."boob"..msg.sender.user_id , 30000)
local ballancee = Redis:get(TeleGod.."boob"..msg.sender.user_id) or 0
LuaTele.sendText(msg.chat_id,msg.id,"اشعار ايداع "..neews.."\nالمبلغ : 30000 جنيه 💵\nوظيفتك : مغني 🎤\nنوع العملية : اضافة راتب\nرصيدك دلوقتي : "..ballancee.." جنيه 💵","md",true)
Redis:setex(TeleGod.."iiioo" .. msg.sender.user_id,600, true)
elseif Descriptioont == "كوفيره 💆" then
Redis:incrby(TeleGod.."boob"..msg.sender.user_id , 3500)
local ballancee = Redis:get(TeleGod.."boob"..msg.sender.user_id) or 0
LuaTele.sendText(msg.chat_id,msg.id,"اشعار ايداع "..neews.."\nالمبلغ : 3500 جنيه 💵\nوظيفتك : كوفيره 💆\nنوع العملية : اضافة راتب\nرصيدك دلوقتي : "..ballancee.." جنيه 💵","md",true)
Redis:setex(TeleGod.."iiioo" .. msg.sender.user_id,600, true)
elseif Descriptioont == "ربة منزل 🤷" then
Redis:incrby(TeleGod.."boob"..msg.sender.user_id , 2500)
local ballancee = Redis:get(TeleGod.."boob"..msg.sender.user_id) or 0
LuaTele.sendText(msg.chat_id,msg.id,"اشعار ايداع "..neews.."\nالمبلغ : 2500 جنيه 💵\nوظيفتك : ربة منزل 🤷\nنوع العملية : اضافة راتب\nرصيدك دلوقتي : "..ballancee.." جنيه 💵","md",true)
Redis:setex(TeleGod.."iiioo" .. msg.sender.user_id,600, true)
elseif Descriptioont == "مربيه اطفال 💁" then
Redis:incrby(TeleGod.."boob"..msg.sender.user_id , 35000)
local ballancee = Redis:get(TeleGod.."boob"..msg.sender.user_id) or 0
LuaTele.sendText(msg.chat_id,msg.id,"اشعار ايداع "..neews.."\nالمبلغ : 35000 جنيه 💵\nوظيفتك : مربيه اطفال 💁\nنوع العملية : اضافة راتب\nرصيدك دلوقتي : "..ballancee.." جنيه 💵","md",true)
Redis:setex(TeleGod.."iiioo" .. msg.sender.user_id,600, true)
elseif Descriptioont == "كهربائي 💡" then
Redis:incrby(TeleGod.."boob"..msg.sender.user_id , 55000)
local ballancee = Redis:get(TeleGod.."boob"..msg.sender.user_id) or 0
LuaTele.sendText(msg.chat_id,msg.id,"اشعار ايداع "..neews.."\nالمبلغ : 55000 جنيه 💵\nوظيفتك : كهربائي 💡\nنوع العملية : اضافة راتب\nرصيدك دلوقتي : "..ballancee.." جنيه 💵","md",true)
Redis:setex(TeleGod.."iiioo" .. msg.sender.user_id,600, true)
elseif Descriptioont == "نجار ⛏" then
Redis:incrby(TeleGod.."boob"..msg.sender.user_id , 65000)
local ballancee = Redis:get(TeleGod.."boob"..msg.sender.user_id) or 0
LuaTele.sendText(msg.chat_id,msg.id,"اشعار ايداع "..neews.."\nالمبلغ : 65000 جنيه 💵\nوظيفتك : نجار ⛏\nنوع العملية : اضافة راتب\nرصيدك دلوقتي : "..ballancee.." جنيه 💵","md",true)
Redis:setex(TeleGod.."iiioo" .. msg.sender.user_id,600, true)
elseif Descriptioont == "متذوق طعام 🍕" then
Redis:incrby(TeleGod.."boob"..msg.sender.user_id , 15000)
local ballancee = Redis:get(TeleGod.."boob"..msg.sender.user_id) or 0
LuaTele.sendText(msg.chat_id,msg.id,"اشعار ايداع "..neews.."\nالمبلغ : 15000 جنيه 💵\nوظيفتك : متذوق طعام 🍕\nنوع العملية : اضافة راتب\nرصيدك دلوقتي : "..ballancee.." جنيه 💵","md",true)
Redis:setex(TeleGod.."iiioo" .. msg.sender.user_id,600, true)
elseif Descriptioont == "فلاح 👨" then
Redis:incrby(TeleGod.."boob"..msg.sender.user_id , 27000)
local ballancee = Redis:get(TeleGod.."boob"..msg.sender.user_id) or 0
LuaTele.sendText(msg.chat_id,msg.id,"اشعار ايداع "..neews.."\nالمبلغ : 27000 جنيه 💵\nوظيفتك : فلاح 👨\nنوع العملية : اضافة راتب\nرصيدك دلوقتي : "..ballancee.." جنيه 💵","md",true)
Redis:setex(TeleGod.."iiioo" .. msg.sender.user_id,600, true)
elseif Descriptioont == "كاشير تلي جود 🙋" then
Redis:incrby(TeleGod.."boob"..msg.sender.user_id , 50000)
local ballancee = Redis:get(TeleGod.."boob"..msg.sender.user_id) or 0
LuaTele.sendText(msg.chat_id,msg.id,"اشعار ايداع "..neews.."\nالمبلغ : 50000 جنيه 💵\nوظيفتك : كاشير بنده 🙋\nنوع العملية : اضافة راتب\nرصيدك دلوقتي : "..ballancee.." جنيه 💵","md",true)
Redis:setex(TeleGod.."iiioo" .. msg.sender.user_id,600, true)
elseif Descriptioont == "ممرض ??" then
Redis:incrby(TeleGod.."boob"..msg.sender.user_id , 16000)
local ballancee = Redis:get(TeleGod.."boob"..msg.sender.user_id) or 0
LuaTele.sendText(msg.chat_id,msg.id,"اشعار ايداع "..neews.."\nالمبلغ : 16000 جنيه 💵\nوظيفتك : ممرض 👨\nنوع العملية : اضافة راتب\nرصيدك دلوقتي : "..ballancee.." جنيه 💵","md",true)
Redis:setex(TeleGod.."iiioo" .. msg.sender.user_id,600, true)
elseif Descriptioont == "مهرج 🤹" then
Redis:incrby(TeleGod.."boob"..msg.sender.user_id , 46000)
local ballancee = Redis:get(TeleGod.."boob"..msg.sender.user_id) or 0
LuaTele.sendText(msg.chat_id,msg.id,"اشعار ايداع "..neews.."\nالمبلغ : 46000 جنيه 💵\nوظيفتك : مهرج 🤹\nنوع العملية : اضافة راتب\nرصيدك دلوقتي : "..ballancee.." جنيه 💵","md",true)
Redis:setex(TeleGod.."iiioo" .. msg.sender.user_id,600, true)
elseif Descriptioont == "عامل توصيل 🚴" then
Redis:incrby(TeleGod.."boob"..msg.sender.user_id , 59000)
local ballancee = Redis:get(TeleGod.."boob"..msg.sender.user_id) or 0
LuaTele.sendText(msg.chat_id,msg.id,"اشعار ايداع "..neews.."\nالمبلغ : 59000 جنيه 💵\nوظيفتك : عامل توصيل 🚴\nنوع العملية : اضافة راتب\nرصيدك دلوقتي : "..ballancee.." جنيه 💵","md",true)
Redis:setex(TeleGod.."iiioo" .. msg.sender.user_id,600, true)
elseif Descriptioont == "عسكري 👮" then
Redis:incrby(TeleGod.."boob"..msg.sender.user_id , 130000)
local ballancee = Redis:get(TeleGod.."boob"..msg.sender.user_id) or 0
LuaTele.sendText(msg.chat_id,msg.id,"اشعار ايداع "..neews.."\nالمبلغ : 130000 جنيه 💵\nوظيفتك : عسكري 👮\nنوع العملية : اضافة راتب\nرصيدك دلوقتي : "..ballancee.." جنيه ??","md",true)
Redis:setex(TeleGod.."iiioo" .. msg.sender.user_id,600, true)
elseif Descriptioont == "مهندس 👨" then
Redis:incrby(TeleGod.."boob"..msg.sender.user_id , 200000)
local ballancee = Redis:get(TeleGod.."boob"..msg.sender.user_id) or 0
LuaTele.sendText(msg.chat_id,msg.id,"اشعار ايداع "..neews.."\nالمبلغ : 200000 جنيه 💵\nوظيفتك : مهندس 👨\nنوع العملية : اضافة راتب\nرصيدك دلوقتي : "..ballancee.." جنيه 💵","md",true)
Redis:setex(TeleGod.."iiioo" .. msg.sender.user_id,600, true)
elseif Descriptioont == "وزير 👨" then
Redis:incrby(TeleGod.."boob"..msg.sender.user_id , 450000)
local ballancee = Redis:get(TeleGod.."boob"..msg.sender.user_id) or 0
LuaTele.sendText(msg.chat_id,msg.id,"اشعار ايداع "..neews.."\nالمبلغ : 450000 جنيه 💵\nوظيفتك : وزير 👨\nنوع العملية : اضافة راتب\nرصيدك دلوقتي : "..ballancee.." جنيه 💵","md",true)
Redis:setex(TeleGod.."iiioo" .. msg.sender.user_id,600, true)
elseif Descriptioont == "محامي ⚖️" then
Redis:incrby(TeleGod.."boob"..msg.sender.user_id , 2000)
local ballancee = Redis:get(TeleGod.."boob"..msg.sender.user_id) or 0
LuaTele.sendText(msg.chat_id,msg.id,"اشعار ايداع "..neews.."\nالمبلغ : 2000 جنيه 💵\nوظيفتك : محامي ⚖️\nنوع العملية : اضافة راتب\nرصيدك دلوقتي : "..ballancee.." جنيه 💵","md",true)
Redis:setex(TeleGod.."iiioo" .. msg.sender.user_id,600, true)
elseif Descriptioont == "تاجر 💵" then
Redis:incrby(TeleGod.."boob"..msg.sender.user_id , 250000)
local ballancee = Redis:get(TeleGod.."boob"..msg.sender.user_id) or 0
LuaTele.sendText(msg.chat_id,msg.id,"اشعار ايداع "..neews.."\nالمبلغ : 250000 جنيه 💵\nوظيفتك : تاجر 💵\nنوع العملية : اضافة راتب\nرصيدك دلوقتي : "..ballancee.." جنيه 💵","md",true)
Redis:setex(TeleGod.."iiioo" .. msg.sender.user_id,600, true)
elseif Descriptioont == "دكتور 👨" then
Redis:incrby(TeleGod.."boob"..msg.sender.user_id , 250000)
local ballancee = Redis:get(TeleGod.."boob"..msg.sender.user_id) or 0
LuaTele.sendText(msg.chat_id,msg.id,"اشعار ايداع "..neews.."\nالمبلغ : 250000 جنيه 💵\nوظيفتك : دكتور 👨\nنوع العملية : اضافة راتب\nرصيدك دلوقتي : "..ballancee.." جنيه 💵","md",true)
Redis:setex(TeleGod.."iiioo" .. msg.sender.user_id,600, true)
elseif Descriptioont == "حفار قبور ⚓" then
Redis:incrby(TeleGod.."boob"..msg.sender.user_id , 5000)
local ballancee = Redis:get(TeleGod.."boob"..msg.sender.user_id) or 0
LuaTele.sendText(msg.chat_id,msg.id,"اشعار ايداع "..neews.."\nالمبلغ : 5000 جنيه 💵\nوظيفتك : حفار قبور ⚓\nنوع العملية : اضافة راتب\nرصيدك دلوقتي : "..ballancee.." جنيه 💵","md",true)
Redis:setex(TeleGod.."iiioo" .. msg.sender.user_id,600, true)
elseif Descriptioont == "حلاق ✂" then
Redis:incrby(TeleGod.."boob"..msg.sender.user_id , 40000)
local ballancee = Redis:get(TeleGod.."boob"..msg.sender.user_id) or 0
LuaTele.sendText(msg.chat_id,msg.id,"اشعار ايداع "..neews.."\nالمبلغ : 40000 جنيه 💵\nوظيفتك : حلاق ✂\nنوع العملية : اضافة راتب\nرصيدك دلوقتي : "..ballancee.." جنيه 💵","md",true)
Redis:setex(TeleGod.."iiioo" .. msg.sender.user_id,600, true)
elseif Descriptioont == "إمام مسجد 📿" then
Redis:incrby(TeleGod.."boob"..msg.sender.user_id , 50000)
local ballancee = Redis:get(TeleGod.."boob"..msg.sender.user_id) or 0
LuaTele.sendText(msg.chat_id,msg.id,"اشعار ايداع "..neews.."\nالمبلغ : 50000 جنيه 💵\nوظيفتك : إمام مسجد 📿\nنوع العملية : اضافة راتب\nرصيدك دلوقتي : "..ballancee.." جنيه 💵","md",true)
Redis:setex(TeleGod.."iiioo" .. msg.sender.user_id,600, true)
elseif Descriptioont == "صياد 🎣" then
Redis:incrby(TeleGod.."boob"..msg.sender.user_id , 7000)
local ballancee = Redis:get(TeleGod.."boob"..msg.sender.user_id) or 0
LuaTele.sendText(msg.chat_id,msg.id,"اشعار ايداع "..neews.."\nالمبلغ : 7000 جنيه 💵\nوظيفتك : صياد 🎣\nنوع العملية : اضافة راتب\nرصيدك دلوقتي : "..ballancee.." جنيه 💵","md",true)
Redis:setex(TeleGod.."iiioo" .. msg.sender.user_id,600, true)
elseif Descriptioont == "خياط 🧵" then
Redis:incrby(TeleGod.."boob"..msg.sender.user_id , 3000)
local ballancee = Redis:get(TeleGod.."boob"..msg.sender.user_id) or 0
LuaTele.sendText(msg.chat_id,msg.id,"اشعار ايداع "..neews.."\nالمبلغ : 3000 جنيه 💵\nوظيفتك : خياط 🧵\nنوع العملية : اضافة راتب\nرصيدك دلوقتي : "..ballancee.." جنيه 💵","md",true)
Redis:setex(TeleGod.."iiioo" .. msg.sender.user_id,600, true)
elseif Descriptioont == "طيار 🛩" then
Redis:incrby(TeleGod.."boob"..msg.sender.user_id , 230000)
local ballancee = Redis:get(TeleGod.."boob"..msg.sender.user_id) or 0
LuaTele.sendText(msg.chat_id,msg.id,"اشعار ايداع "..neews.."\nالمبلغ : 230000 جنيه 💵\nوظيفتك : طيار 🛩\nنوع العملية : اضافة راتب\nرصيدك دلوقتي : "..ballancee.." جنيه 💵","md",true)
Redis:setex(TeleGod.."iiioo" .. msg.sender.user_id,600, true)
elseif Descriptioont == "مودل 🕴" then
Redis:incrby(TeleGod.."boob"..msg.sender.user_id , 16000)
local ballancee = Redis:get(TeleGod.."boob"..msg.sender.user_id) or 0
LuaTele.sendText(msg.chat_id,msg.id,"اشعار ايداع "..neews.."\nالمبلغ : 16000 جنيه 💵\nوظيفتك : مودل 🕴\nنوع العملية : اضافة راتب\nرصيدك دلوقتي : "..ballancee.." جنيه 💵","md",true)
Redis:setex(TeleGod.."iiioo" .. msg.sender.user_id,600, true)
elseif Descriptioont == "ملك 👑" then
Redis:incrby(TeleGod.."boob"..msg.sender.user_id , 5000000)
local ballancee = Redis:get(TeleGod.."boob"..msg.sender.user_id) or 0
LuaTele.sendText(msg.chat_id,msg.id,"اشعار ايداع "..neews.."\nالمبلغ : 5000000 جنيه 💵\nوظيفتك : ملك 👑\nنوع العملية : اضافة راتب\nرصيدك دلوقتي : "..ballancee.." جنيه 💵","md",true)
Redis:setex(TeleGod.."iiioo" .. msg.sender.user_id,600, true)
elseif Descriptioont == "سباك 🔧" then
Redis:incrby(TeleGod.."boob"..msg.sender.user_id , 2000)
local ballancee = Redis:get(TeleGod.."boob"..msg.sender.user_id) or 0
LuaTele.sendText(msg.chat_id,msg.id,"اشعار ايداع "..neews.."\nالمبلغ : 2000 جنيه 💵\nوظيفتك : سباك 🔧\nنوع العملية : اضافة راتب\nرصيدك دلوقتي : "..ballancee.." جنيه 💵","md",true)
Redis:setex(TeleGod.."iiioo" .. msg.sender.user_id,600, true)
elseif Descriptioont == "موزع 🗺" then
Redis:incrby(TeleGod.."boob"..msg.sender.user_id , 100000)
local ballancee = Redis:get(TeleGod.."boob"..msg.sender.user_id) or 0
LuaTele.sendText(msg.chat_id,msg.id,"اشعار ايداع "..neews.."\nالمبلغ : 100000 جنيه 💵\nوظيفتك : موزع 🗺\nنوع العملية : اضافة راتب\nرصيدك دلوقتي : "..ballancee.." جنيه 💵","md",true)
Redis:setex(TeleGod.."iiioo" .. msg.sender.user_id,600, true)
elseif Descriptioont == "سكيورتي 👮" then
Redis:incrby(TeleGod.."boob"..msg.sender.user_id , 9000)
local ballancee = Redis:get(TeleGod.."boob"..msg.sender.user_id) or 0
LuaTele.sendText(msg.chat_id,msg.id,"اشعار ايداع "..neews.."\nالمبلغ : 9000 جنيه 💵\nوظيفتك : سكيورتي 👮\nنوع العملية : اضافة راتب\nرصيدك دلوقتي : "..ballancee.." جنيه 💵","md",true)
Redis:setex(TeleGod.."iiioo" .. msg.sender.user_id,600, true)
elseif Descriptioont == "معلم شاورما 🌯" then
Redis:incrby(TeleGod.."boob"..msg.sender.user_id , 8500)
local ballancee = Redis:get(TeleGod.."boob"..msg.sender.user_id) or 0
LuaTele.sendText(msg.chat_id,msg.id,"اشعار ايداع "..neews.."\nالمبلغ : 8500 جنيه 💵\nوظيفتك : معلم شاورما 🌯\nنوع العملية : اضافة راتب\nرصيدك دلوقتي : "..ballancee.." جنيه 💵","md",true)
Redis:setex(TeleGod.."iiioo" .. msg.sender.user_id,600, true)
elseif Descriptioont == "دكتور ولاده 👨" then
Redis:incrby(TeleGod.."boob"..msg.sender.user_id , 160000)
local ballancee = Redis:get(TeleGod.."boob"..msg.sender.user_id) or 0
LuaTele.sendText(msg.chat_id,msg.id,"اشعار ايداع "..neews.."\nالمبلغ : 160000 جنيه 💵\nوظيفتك : دكتور ولاده 👨\nنوع العملية : اضافة راتب\nرصيدك دلوقتي : "..ballancee.." جنيه 💵","md",true)
Redis:setex(TeleGod.."iiioo" .. msg.sender.user_id,600, true)
elseif Descriptioont == "مذيع 🗣" then
Redis:incrby(TeleGod.."boob"..msg.sender.user_id , 170000)
local ballancee = Redis:get(TeleGod.."boob"..msg.sender.user_id) or 0
LuaTele.sendText(msg.chat_id,msg.id,"اشعار ايداع "..neews.."\nالمبلغ : 170000 جنيه 💵\nوظيفتك : مذيع 🗣\nنوع العملية : اضافة راتب\nرصيدك دلوقتي : "..ballancee.." جنيه ??","md",true)
Redis:setex(TeleGod.."iiioo" .. msg.sender.user_id,600, true)
elseif Descriptioont == "عامل مساج 💆" then
Redis:incrby(TeleGod.."boob"..msg.sender.user_id , 40000)
local ballancee = Redis:get(TeleGod.."boob"..msg.sender.user_id) or 0
LuaTele.sendText(msg.chat_id,msg.id,"اشعار ايداع "..neews.."\nالمبلغ : 40000 جنيه 💵\nوظيفتك : عامل مساج 💆\nنوع العملية : اضافة راتب\nرصيدك دلوقتي : "..ballancee.." جنيه 💵","md",true)
Redis:setex(TeleGod.."iiioo" .. msg.sender.user_id,600, true)
elseif Descriptioont == "ممثل 🤵" then
Redis:incrby(TeleGod.."boob"..msg.sender.user_id , 190000)
local ballancee = Redis:get(TeleGod.."boob"..msg.sender.user_id) or 0
LuaTele.sendText(msg.chat_id,msg.id,"اشعار ايداع "..neews.."\nالمبلغ : 190000 جنيه 💵\nوظيفتك : ممثل 🤵\nنوع العملية : اضافة راتب\nرصيدك دلوقتي : "..ballancee.." جنيه 💵","md",true)
Redis:setex(TeleGod.."iiioo" .. msg.sender.user_id,600, true)
elseif Descriptioont == "جزار 🥩" then
Redis:incrby(TeleGod.."boob"..msg.sender.user_id , 50000)
local ballancee = Redis:get(TeleGod.."boob"..msg.sender.user_id) or 0
LuaTele.sendText(msg.chat_id,msg.id,"اشعار ايداع "..neews.."\nالمبلغ : 50000 جنيه 💵\nوظيفتك : جزار 🥩\nنوع العملية : اضافة راتب\nرصيدك دلوقتي : "..ballancee.." جنيه 💵","md",true)
Redis:setex(TeleGod.."iiioo" .. msg.sender.user_id,600, true)
elseif Descriptioont == "مدير بنك 💳" then
Redis:incrby(TeleGod.."boob"..msg.sender.user_id , 200000)
local ballancee = Redis:get(TeleGod.."boob"..msg.sender.user_id) or 0
LuaTele.sendText(msg.chat_id,msg.id,"اشعار ايداع "..neews.."\nالمبلغ : 200000 جنيه 💵\nوظيفتك : مدير بنك 💳\nنوع العملية : اضافة راتب\nرصيدك دلوقتي : "..ballancee.." جنيه 💵","md",true)
Redis:setex(TeleGod.."iiioo" .. msg.sender.user_id,600, true)
elseif Descriptioont == "مبرمج 👨" then
Redis:incrby(TeleGod.."boob"..msg.sender.user_id , 180000)
local ballancee = Redis:get(TeleGod.."boob"..msg.sender.user_id) or 0
LuaTele.sendText(msg.chat_id,msg.id,"اشعار ايداع "..neews.."\nالمبلغ : 180000 جنيه 💵\nوظيفتك : مبرمج 👨\nنوع العملية : اضافة راتب\nرصيدك دلوقتي : "..ballancee.." جنيه 💵","md",true)
Redis:setex(TeleGod.."iiioo" .. msg.sender.user_id,600, true)
elseif Descriptioont == "رقاصه 💃" then
Redis:incrby(TeleGod.."boob"..msg.sender.user_id , 55000)
local ballancee = Redis:get(TeleGod.."boob"..msg.sender.user_id) or 0
LuaTele.sendText(msg.chat_id,msg.id,"اشعار ايداع "..neews.."\nالمبلغ : 55000 جنيه 💵\nوظيفتك : رقاصه 💃\nنوع العملية : اضافة راتب\nرصيدك دلوقتي : "..ballancee.." جنيه 💵","md",true)
Redis:setex(TeleGod.."iiioo" .. msg.sender.user_id,600, true)
elseif Descriptioont == "👩🏼‍💻 صحفي" then
Redis:incrby(TeleGod.."boob"..msg.sender.user_id , 90000)
local ballancee = Redis:get(TeleGod.."boob"..msg.sender.user_id) or 0
LuaTele.sendText(msg.chat_id,msg.id,"اشعار ايداع "..neews.."\nالمبلغ : 90000 جنيه 💵\nوظيفتك : 👩🏼‍💻 صحفي\nنوع العملية : اضافة راتب\nرصيدك دلوقتي : "..ballancee.." جنيه 💵","md",true)
Redis:setex(TeleGod.."iiioo" .. msg.sender.user_id,600, true)
elseif Descriptioont == "🥷 حرامي" then
Redis:incrby(TeleGod.."boob"..msg.sender.user_id , 160000)
local ballancee = Redis:get(TeleGod.."boob"..msg.sender.user_id) or 0
LuaTele.sendText(msg.chat_id,msg.id,"اشعار ايداع "..neews.."\nالمبلغ : 160000 جنيه 💵\nوظيفتك : 🥷 حرامي\nنوع العملية : اضافة راتب\nرصيدك دلوقتي : "..ballancee.." جنيه 💵","md",true)
Redis:setex(TeleGod.."iiioo" .. msg.sender.user_id,600, true)
elseif Descriptioont == "🔮 ساحر" then
Redis:incrby(TeleGod.."boob"..msg.sender.user_id , 10000)
local ballancee = Redis:get(TeleGod.."boob"..msg.sender.user_id) or 0
LuaTele.sendText(msg.chat_id,msg.id,"اشعار ايداع "..neews.."\nالمبلغ : 10000 جنيه 💵\nوظيفتك : 🔮 ساحر\nنوع العملية : اضافة راتب\nرصيدك دلوقتي : "..ballancee.." جنيه 💵","md",true)
Redis:setex(TeleGod.."iiioo" .. msg.sender.user_id,600, true)
elseif Descriptioont == "⚽ لاعب️" then
Redis:incrby(TeleGod.."boob"..msg.sender.user_id , 200000)
local ballancee = Redis:get(TeleGod.."boob"..msg.sender.user_id) or 0
LuaTele.sendText(msg.chat_id,msg.id,"اشعار ايداع "..neews.."\nالمبلغ : 200000 جنيه 💵\nوظيفتك : ⚽ لاعب️\nنوع العملية : اضافة راتب\nرصيدك دلوقتي : "..ballancee.." جنيه 💵","md",true)
Redis:setex(TeleGod.."iiioo" .. msg.sender.user_id,600, true)
elseif Descriptioont == "🖼 مصور" then
Redis:incrby(TeleGod.."boob"..msg.sender.user_id , 70000)
local ballancee = Redis:get(TeleGod.."boob"..msg.sender.user_id) or 0
LuaTele.sendText(msg.chat_id,msg.id,"اشعار ايداع "..neews.."\nالمبلغ : 70000 جنيه 💵\nوظيفتك : 🖼 مصور\nنوع العملية : اضافة راتب\nرصيدك دلوقتي : "..ballancee.." جنيه 💵","md",true)
Redis:setex(TeleGod.."iiioo" .. msg.sender.user_id,600, true)
elseif Descriptioont == "☎️ عامل مقسم" then
Redis:incrby(TeleGod.."boob"..msg.sender.user_id , 50000)
local ballancee = Redis:get(TeleGod.."boob"..msg.sender.user_id) or 0
LuaTele.sendText(msg.chat_id,msg.id,"اشعار ايداع "..neews.."\nالمبلغ : 50000 جنيه 💵\nوظيفتك : ☎️ عامل مقسم\nنوع العملية : اضافة راتب\nرصيدك دلوقتي : "..ballancee.." جنيه 💵","md",true)
Redis:setex(TeleGod.."iiioo" .. msg.sender.user_id,600, true)
elseif Descriptioont == "📖 كاتب" then
Redis:incrby(TeleGod.."boob"..msg.sender.user_id , 40000)
local ballancee = Redis:get(TeleGod.."boob"..msg.sender.user_id) or 0
LuaTele.sendText(msg.chat_id,msg.id,"اشعار ايداع "..neews.."\nالمبلغ : 40000 جنيه 💵\nوظيفتك : 📖 كاتب\nنوع العملية : اضافة راتب\nرصيدك دلوقتي : "..ballancee.." جنيه 💵","md",true)
Redis:setex(TeleGod.."iiioo" .. msg.sender.user_id,600, true)
elseif Descriptioont == "🧪 مخبري" then
Redis:incrby(TeleGod.."boob"..msg.sender.user_id , 80000)
local ballancee = Redis:get(TeleGod.."boob"..msg.sender.user_id) or 0
LuaTele.sendText(msg.chat_id,msg.id,"اشعار ايداع "..neews.."\nالمبلغ : 80000 جنيه 💵\nوظيفتك : 🧪 مخبري\nنوع العملية : اضافة راتب\nرصيدك دلوقتي : "..ballancee.." جنيه 💵","md",true)
Redis:setex(TeleGod.."iiioo" .. msg.sender.user_id,600, true)
end
else
LuaTele.sendText(msg.chat_id,msg.id, "⇜ معندكش حساب بنكي ارسل ↢ ( `انشاء حساب بنكي` )","md",true)
end
end
if text == "جوزني" or text == "زوجني" then
local Info_Chats = LuaTele.getSupergroupFullInfo(msg.chat_id)
local chat_Members = LuaTele.searchChatMembers(msg_chat_id, "*", Info_Chats.member_count).members
local rand_members = math.random(#chat_Members)
local member_id = chat_Members[rand_members].member_id.user_id
local member_name = LuaTele.getUser(chat_Members[rand_members].member_id.user_id).first_name
local mem_tag = "["..member_name.."](tg://user?id="..member_id..")"
return LuaTele.sendText(msg_chat_id,msg_id,"جيبتلك عروسه انما اي لقطه  "..mem_tag.." 😹♥","md",true)
end
if Redis:get(TeleGod.."mshaher"..msg.chat_id) then
if text == Redis:get(TeleGod.."mshaher"..msg.chat_id) then
Redis:del(TeleGod.."mshaher"..msg.chat_id)
Redis:incrby(TeleGod.."Num:Add:Games"..msg.chat_id..msg.sender.user_id, 1)  
return LuaTele.sendText(msg_chat_id,msg_id,"\nمعندناش بنات للجواز شوفلك كلبه العب فديلها 😪","md",true)  
end
end 

if text == 'كنز' or text == 'الكنز' then
if Redis:sismember(TeleGod.."booob",msg.sender.user_id) then
if Redis:ttl(TeleGod.."iiihoo" .. msg.sender.user_id) >= 5130 then
return LuaTele.sendText(msg.chat_id,msg.id,"⇜ كنزك  هينزل كمان ( 10 دقائق )","md",true)
elseif Redis:ttl(TeleGod.."iiihoo" .. msg.sender.user_id) >= 5100 then
return LuaTele.sendText(msg.chat_id,msg.id,"⇜ كنزك  هينزل كمان ( 9 دقائق )","md",true)
elseif Redis:ttl(TeleGod.."iiihoo" .. msg.sender.user_id) >= 4130 then
return LuaTele.sendText(msg.chat_id,msg.id,"⇜ كنزك  هينزل كمان ( 8 دقائق )","md",true)
elseif Redis:ttl(TeleGod.."iiihoo" .. msg.sender.user_id) >= 420 then
return LuaTele.sendText(msg.chat_id,msg.id,"⇜ كنزك  هينزل كمان ( 7 دقائق )","md",true)
elseif Redis:ttl(TeleGod.."iiihoo" .. msg.sender.user_id) >= 360 then
return LuaTele.sendText(msg.chat_id,msg.id,"⇜ كنزك  هينزل كمان ( 6 دقائق )","md",true)
elseif Redis:ttl(TeleGod.."iiihoo" .. msg.sender.user_id) >= 300 then
return LuaTele.sendText(msg.chat_id,msg.id,"⇜ كنزك  هينزل كمان ( 5 دقائق )","md",true)
elseif Redis:ttl(TeleGod.."iiihoo" .. msg.sender.user_id) >= 2100 then
return LuaTele.sendText(msg.chat_id,msg.id,"⇜ كنزك  هينزل كمان ( 4 دقائق )","md",true)
elseif Redis:ttl(TeleGod.."iiihoo" .. msg.sender.user_id) >= 1130 then
return LuaTele.sendText(msg.chat_id,msg.id,"⇜ كنزك  هينزل كمان ( 3 دقائق )","md",true)
elseif Redis:ttl(TeleGod.."iiihoo" .. msg.sender.user_id) >= 120 then
return LuaTele.sendText(msg.chat_id,msg.id,"⇜ كنزك  هينزل كمان ( 2 دقيقة )","md",true)
elseif Redis:ttl(TeleGod.."iiihoo" .. msg.sender.user_id) >= 60 then
return LuaTele.sendText(msg.chat_id,msg.id,"⇜ كنزك  هينزل كمان ( 1 دقيقة )","md",true)
end
local Textinggt = {"ذهب ✨", "فضه 💰", "ورث 💰", "ياقوت ✨", "مرجان ✨🏻‍⚖️", "سبيكة ذهب خالص 💸", "عمله نادره 🔮", "اثار ⚱️🏻‍♀️", "فلوس 💴💸🏻‍♀️", "عمله قيمه💸🏻‍♀️", "كنز مفقود💸", "مجوهرات 💰", "عمله من العصر الفرعوني 🗿", "عمله من الدوله القديمه 🗿🏻‍🌾", "عمله بيتكوين 💶🏻‍♂️", "ممرض 👨🏻‍⚕️", "عمله فضيه نادره‍♂️", "عمله ذهبيه خالصه🏻‍♂️", "كنز علي بابا المفقود 💰🏻‍♂️", "بطاقه ائتمان💰🏻‍🔧", "دولار امريكي 💸??‍🦳", "دولار كندي 💸", "ين يباني 💸", "جنيه بريطاني 💸🏻‍⚕️", "دنانير عراقيه 💸️", "ريال سعودي 💴️", "درهم اماراتي 💴", "فرنك جيبوتي 💲", "اموال مفقوده 💲", "كنز خاص 💲", "صواع ملك مفقود ⚱️🏻", "تاج خاص بملك 👑", "تاج خاص بملك 👑", "اثار تحت المنزل", "جثة فرعون قديمه🏻‍♂️", "تابوت ملك مصري ⚰️", "تاج ملكه مصريه 👑🏻‍⚕️", "مخطوطه لكنز ", "مقبره فرعونيه 💎⚱️⚰️🏻‍♂️", "تمثال رمسيس ⚰️🏻", "كنز تلي جود المفقود 💲", "كنز اطلانطس المفقود 💲", "زئبق احمر 🌡️🏻‍💻", "ياقوت ومرجان 💰🏻", "عمله من العصر الفاطمي 💶", "مخطوطة كنز 📜", "بلوره قديمه 🔮", "كنز تائه 🏛️", "عملات من العصر المملوكي 💲", "كنز نابليون 💲💲", "كنز وخلاص 😂💲💲", "ممتلكات قديمه 💸",}
local Descriptioont = Textinggt[math.random(#Textinggt)]
local ban = LuaTele.getUser(msg.sender.user_id)
if ban.first_name then
neews = "["..ban.first_name.."](tg://user?id="..ban.id..")"
else
neews = " لا يوجد "
end
if Descriptioont == "ذهب ✨" then
Redis:incrby(TeleGod.."boob"..msg.sender.user_id , 150)
local ballancee = Redis:get(TeleGod.."boob"..msg.sender.user_id) or 0
LuaTele.sendText(msg.chat_id,msg.id,"اشعار ايداع "..neews.."\nتم استبداله بمبلغ وقدره : 25 جنيه 💵\nكنزك هـو : ذهب ✨\nنوع العملية : البحث عن كنز\nرصيدك دلوقتي : "..ballancee.." جنيه 💵","md",true)
Redis:setex(TeleGod.."iiihoo" .. msg.sender.user_id,600, true)
elseif Descriptioont == "فضه 💰" then
Redis:incrby(TeleGod.."boob"..msg.sender.user_id , 7500)
local ballancee = Redis:get(TeleGod.."boob"..msg.sender.user_id) or 0
LuaTele.sendText(msg.chat_id,msg.id,"اشعار ايداع "..neews.."\nتم استبداله بمبلغ وقدره : 7500 جنيه 💵\nكنزك هـو : فضه 💰\nنوع العملية : البحث عن كنز\nرصيدك دلوقتي : "..ballancee.." جنيه 💵","md",true)
Redis:setex(TeleGod.."iiihoo" .. msg.sender.user_id,600, true)
elseif Descriptioont == "ورث 💰" then
Redis:incrby(TeleGod.."boob"..msg.sender.user_id , 7500)
local ballancee = Redis:get(TeleGod.."boob"..msg.sender.user_id) or 0
LuaTele.sendText(msg.chat_id,msg.id,"اشعار ايداع "..neews.."\nتم استبداله بمبلغ وقدره : 7500 جنيه 💵\nكنزك هـو : ورث 💰\nنوع العملية : البحث عن كنز\nرصيدك دلوقتي : "..ballancee.." جنيه 💵","md",true)
Redis:setex(TeleGod.."iiihoo" .. msg.sender.user_id,600, true)
elseif Descriptioont == "ياقوت ✨" then
Redis:incrby(TeleGod.."boob"..msg.sender.user_id , 15000)
local ballancee = Redis:get(TeleGod.."boob"..msg.sender.user_id) or 0
LuaTele.sendText(msg.chat_id,msg.id,"اشعار ايداع "..neews.."\nتم استبداله بمبلغ وقدره : 15000 جنيه 💵\nكنزك هـو : ياقوت ✨\nنوع العملية : البحث عن كنز\nرصيدك دلوقتي : "..ballancee.." جنيه 💵","md",true)
Redis:setex(TeleGod.."iiihoo" .. msg.sender.user_id,600, true)
elseif Descriptioont == "مرجان ✨" then
Redis:incrby(TeleGod.."boob"..msg.sender.user_id , 115000)
local ballancee = Redis:get(TeleGod.."boob"..msg.sender.user_id) or 0
LuaTele.sendText(msg.chat_id,msg.id,"اشعار ايداع "..neews.."\nتم استبداله بمبلغ وقدره : 115000 جنيه 💵\nكنزك هـو : مرجان ✨\nنوع العملية : البحث عن كنز\nرصيدك دلوقتي : "..ballancee.." جنيه 💵","md",true)
Redis:setex(TeleGod.."iiihoo" .. msg.sender.user_id,600, true)
elseif Descriptioont == "سبيكة ذهب خالص 💸" then
Redis:incrby(TeleGod.."boob"..msg.sender.user_id , 15000)
local ballancee = Redis:get(TeleGod.."boob"..msg.sender.user_id) or 0
LuaTele.sendText(msg.chat_id,msg.id,"اشعار ايداع "..neews.."\nتم استبداله بمبلغ وقدره : 15000 جنيه 💵\nكنزك هـو : سبيكة ذهب خالص 💸\nنوع العملية : البحث عن كنز\nرصيدك دلوقتي : "..ballancee.." جنيه 💵","md",true)
Redis:setex(TeleGod.."iiihoo" .. msg.sender.user_id,600, true)
elseif Descriptioont == "عمله نادره 🔮" then
Redis:incrby(TeleGod.."boob"..msg.sender.user_id , 30000)
local ballancee = Redis:get(TeleGod.."boob"..msg.sender.user_id) or 0
LuaTele.sendText(msg.chat_id,msg.id,"اشعار ايداع "..neews.."\nتم استبداله بمبلغ وقدره : 30000 جنيه 💵\nكنزك هـو : عمله نادره 🔮\nنوع العملية : البحث عن كنز\nرصيدك دلوقتي : "..ballancee.." جنيه 💵","md",true)
Redis:setex(TeleGod.."iiihoo" .. msg.sender.user_id,600, true)
elseif Descriptioont == "اثار ⚱️" then
Redis:incrby(TeleGod.."boob"..msg.sender.user_id , 3500)
local ballancee = Redis:get(TeleGod.."boob"..msg.sender.user_id) or 0
LuaTele.sendText(msg.chat_id,msg.id,"اشعار ايداع "..neews.."\nتم استبداله بمبلغ وقدره : 3500 جنيه 💵\nكنزك هـو : اثار ⚱️\nنوع العملية : البحث عن كنز\nرصيدك دلوقتي : "..ballancee.." جنيه 💵","md",true)
Redis:setex(TeleGod.."iiihoo" .. msg.sender.user_id,600, true)
elseif Descriptioont == "فلوس 💴💸" then
Redis:incrby(TeleGod.."boob"..msg.sender.user_id , 2500)
local ballancee = Redis:get(TeleGod.."boob"..msg.sender.user_id) or 0
LuaTele.sendText(msg.chat_id,msg.id,"اشعار ايداع "..neews.."\nتم استبداله بمبلغ وقدره : 2500 جنيه 💵\nكنزك هـو : فلوس 💴💸\nنوع العملية : البحث عن كنز\nرصيدك دلوقتي : "..ballancee.." جنيه 💵","md",true)
Redis:setex(TeleGod.."iiihoo" .. msg.sender.user_id,600, true)
elseif Descriptioont == "عمله قيمه💸" then
Redis:incrby(TeleGod.."boob"..msg.sender.user_id , 3500)
local ballancee = Redis:get(TeleGod.."boob"..msg.sender.user_id) or 0
LuaTele.sendText(msg.chat_id,msg.id,"اشعار ايداع "..neews.."\nتم استبداله بمبلغ وقدره : 3500 جنيه 💵\nكنزك هـو : عمله قيمه💸\nنوع العملية : البحث عن كنز\nرصيدك دلوقتي : "..ballancee.." جنيه 💵","md",true)
Redis:setex(TeleGod.."iiihoo" .. msg.sender.user_id,600, true)
elseif Descriptioont == "كنز مفقود💸" then
Redis:incrby(TeleGod.."boob"..msg.sender.user_id , 30000)
local ballancee = Redis:get(TeleGod.."boob"..msg.sender.user_id) or 0
LuaTele.sendText(msg.chat_id,msg.id,"اشعار ايداع "..neews.."\nتم استبداله بمبلغ وقدره : 30000 جنيه 💵\nكنزك هـو : كنز مفقود💸\nنوع العملية : البحث عن كنز\nرصيدك دلوقتي : "..ballancee.." جنيه 💵","md",true)
Redis:setex(TeleGod.."iiihoo" .. msg.sender.user_id,600, true)
elseif Descriptioont == "مجوهرات 💰" then
Redis:incrby(TeleGod.."boob"..msg.sender.user_id , 6500)
local ballancee = Redis:get(TeleGod.."boob"..msg.sender.user_id) or 0
LuaTele.sendText(msg.chat_id,msg.id,"اشعار ايداع "..neews.."\nتم استبداله بمبلغ وقدره : 6500 جنيه 💵\nكنزك هـو : مجوهرات 💰\nنوع العملية : البحث عن كنز\nرصيدك دلوقتي : "..ballancee.." جنيه 💵","md",true)
Redis:setex(TeleGod.."iiihoo" .. msg.sender.user_id,600, true)
elseif Descriptioont == "عمله من العصر الفرعوني 🗿" then
Redis:incrby(TeleGod.."boob"..msg.sender.user_id , 1500)
local ballancee = Redis:get(TeleGod.."boob"..msg.sender.user_id) or 0
LuaTele.sendText(msg.chat_id,msg.id,"اشعار ايداع "..neews.."\nتم استبداله بمبلغ وقدره : 1500 جنيه 💵\nكنزك هـو : عمله من العصر الفرعوني 🗿\nنوع العملية : البحث عن كنز\nرصيدك دلوقتي : "..ballancee.." جنيه 💵","md",true)
Redis:setex(TeleGod.."iiihoo" .. msg.sender.user_id,600, true)
elseif Descriptioont == "عمله من الدوله القديمه 🗿" then
Redis:incrby(TeleGod.."boob"..msg.sender.user_id , 27000)
local ballancee = Redis:get(TeleGod.."boob"..msg.sender.user_id) or 0
LuaTele.sendText(msg.chat_id,msg.id,"اشعار ايداع "..neews.."\nتم استبداله بمبلغ وقدره : 27000 جنيه 💵\nكنزك هـو : عمله من الدوله القديمه 🗿\nنوع العملية : البحث عن كنز\nرصيدك دلوقتي : "..ballancee.." جنيه 💵","md",true)
Redis:setex(TeleGod.."iiihoo" .. msg.sender.user_id,600, true)
elseif Descriptioont == "عمله بيتكوين 💶" then
Redis:incrby(TeleGod.."boob"..msg.sender.user_id , 1500000)
local ballancee = Redis:get(TeleGod.."boob"..msg.sender.user_id) or 0
LuaTele.sendText(msg.chat_id,msg.id,"اشعار ايداع "..neews.."\nتم استبداله بمبلغ وقدره : 1500000 جنيه 💵\nكنزك هـو : عمله بيتكوين 💶\nنوع العملية : البحث عن كنز\nرصيدك دلوقتي : "..ballancee.." جنيه 💵","md",true)
Redis:setex(TeleGod.."iiihoo" .. msg.sender.user_id,600, true)
elseif Descriptioont == "عمله ذهبيه نادره" then
Redis:incrby(TeleGod.."boob"..msg.sender.user_id , 160000)
local ballancee = Redis:get(TeleGod.."boob"..msg.sender.user_id) or 0
LuaTele.sendText(msg.chat_id,msg.id,"اشعار ايداع "..neews.."\nتم استبداله بمبلغ وقدره : 160000 جنيه 💵\nكنزك هـو : ممرض 👨\nنوع العملية : البحث عن كنز\nرصيدك دلوقتي : "..ballancee.." جنيه 💵","md",true)
Redis:setex(TeleGod.."iiihoo" .. msg.sender.user_id,600, true)
elseif Descriptioont == "عمله فضيه نادره" then
Redis:incrby(TeleGod.."boob"..msg.sender.user_id , 200000)
local ballancee = Redis:get(TeleGod.."boob"..msg.sender.user_id) or 0
LuaTele.sendText(msg.chat_id,msg.id,"اشعار ايداع "..neews.."\nتم استبداله بمبلغ وقدره : 200000 جنيه 💵\nكنزك هـو : عمله فضيه نادره\nنوع العملية : البحث عن كنز\nرصيدك دلوقتي : "..ballancee.." جنيه 💵","md",true)
Redis:setex(TeleGod.."iiihoo" .. msg.sender.user_id,600, true)
elseif Descriptioont == "عمله ذهبيه خالصه" then
Redis:incrby(TeleGod.."boob"..msg.sender.user_id , 59000)
local ballancee = Redis:get(TeleGod.."boob"..msg.sender.user_id) or 0
LuaTele.sendText(msg.chat_id,msg.id,"اشعار ايداع "..neews.."\nتم استبداله بمبلغ وقدره : 59000 جنيه 💵\nكنزك هـو : عمله ذهبيه خالصه\nنوع العملية : البحث عن كنز\nرصيدك دلوقتي : "..ballancee.." جنيه 💵","md",true)
Redis:setex(TeleGod.."iiihoo" .. msg.sender.user_id,600, true)
elseif Descriptioont == "كنز علي بابا المفقود 💰" then
Redis:incrby(TeleGod.."boob"..msg.sender.user_id , 13000)
local ballancee = Redis:get(TeleGod.."boob"..msg.sender.user_id) or 0
LuaTele.sendText(msg.chat_id,msg.id,"اشعار ايداع "..neews.."\nتم استبداله بمبلغ وقدره : 13000 جنيه 💵\nكنزك هـو : كنز علي بابا المفقود 💰\nنوع العملية : البحث عن كنز\nرصيدك دلوقتي : "..ballancee.." جنيه ??","md",true)
Redis:setex(TeleGod.."iiihoo" .. msg.sender.user_id,600, true)
elseif Descriptioont == "بطاقه ائتمان💰" then
Redis:incrby(TeleGod.."boob"..msg.sender.user_id , 20000)
local ballancee = Redis:get(TeleGod.."boob"..msg.sender.user_id) or 0
LuaTele.sendText(msg.chat_id,msg.id,"اشعار ايداع "..neews.."\nتم استبداله بمبلغ وقدره : 20000 جنيه 💵\nكنزك هـو : بطاقه ائتمان💰\nنوع العملية : البحث عن كنز\nرصيدك دلوقتي : "..ballancee.." جنيه 💵","md",true)
Redis:setex(TeleGod.."iiihoo" .. msg.sender.user_id,600, true)
elseif Descriptioont == "دولار امريكي 💸" then
Redis:incrby(TeleGod.."boob"..msg.sender.user_id , 415000)
local ballancee = Redis:get(TeleGod.."boob"..msg.sender.user_id) or 0
LuaTele.sendText(msg.chat_id,msg.id,"اشعار ايداع "..neews.."\nتم استبداله بمبلغ وقدره : 415000 جنيه 💵\nكنزك هـو : دولار امريكي 💸\nنوع العملية : البحث عن كنز\nرصيدك دلوقتي : "..ballancee.." جنيه 💵","md",true)
Redis:setex(TeleGod.."iiihoo" .. msg.sender.user_id,600, true)
elseif Descriptioont == "دولار كندي 💸" then
Redis:incrby(TeleGod.."boob"..msg.sender.user_id , 20000)
local ballancee = Redis:get(TeleGod.."boob"..msg.sender.user_id) or 0
LuaTele.sendText(msg.chat_id,msg.id,"اشعار ايداع "..neews.."\nتم استبداله بمبلغ وقدره : 20000 جنيه 💵\nكنزك هـو : دولار كندي 💸\nنوع العملية : البحث عن كنز\nرصيدك دلوقتي : "..ballancee.." جنيه 💵","md",true)
Redis:setex(TeleGod.."iiihoo" .. msg.sender.user_id,600, true)
elseif Descriptioont == "ين يباني 💸" then
Redis:incrby(TeleGod.."boob"..msg.sender.user_id , 2150000)
local ballancee = Redis:get(TeleGod.."boob"..msg.sender.user_id) or 0
LuaTele.sendText(msg.chat_id,msg.id,"اشعار ايداع "..neews.."\nتم استبداله بمبلغ وقدره : 2150000 جنيه 💵\nكنزك هـو : ين يباني 💸\nنوع العملية : البحث عن كنز\nرصيدك دلوقتي : "..ballancee.." جنيه 💵","md",true)
Redis:setex(TeleGod.."iiihoo" .. msg.sender.user_id,600, true)
elseif Descriptioont == "جنيه بريطاني 💸" then
Redis:incrby(TeleGod.."boob"..msg.sender.user_id , 215000)
local ballancee = Redis:get(TeleGod.."boob"..msg.sender.user_id) or 0
LuaTele.sendText(msg.chat_id,msg.id,"اشعار ايداع "..neews.."\nتم استبداله بمبلغ وقدره : 215000 جنيه 💵\nكنزك هـو : جنيه بريطاني 💸\nنوع العملية : البحث عن كنز\nرصيدك دلوقتي : "..ballancee.." جنيه 💵","md",true)
Redis:setex(TeleGod.."iiihoo" .. msg.sender.user_id,600, true)
elseif Descriptioont == "دنانير عراقيه 💸" then
Redis:incrby(TeleGod.."boob"..msg.sender.user_id , 15000)
local ballancee = Redis:get(TeleGod.."boob"..msg.sender.user_id) or 0
LuaTele.sendText(msg.chat_id,msg.id,"اشعار ايداع "..neews.."\nتم استبداله بمبلغ وقدره : 15000 جنيه 💵\nكنزك هـو : دنانير عراقيه 💸\nنوع العملية : البحث عن كنز\nرصيدك دلوقتي : "..ballancee.." جنيه 💵","md",true)
Redis:setex(TeleGod.."iiihoo" .. msg.sender.user_id,600, true)
elseif Descriptioont == "ريال سعودي 💴" then
Redis:incrby(TeleGod.."boob"..msg.sender.user_id , 10000)
local ballancee = Redis:get(TeleGod.."boob"..msg.sender.user_id) or 0
LuaTele.sendText(msg.chat_id,msg.id,"اشعار ايداع "..neews.."\nتم استبداله بمبلغ وقدره : 10000 جنيه 💵\nكنزك هـو : ريال سعودي 💴\nنوع العملية : البحث عن كنز\nرصيدك دلوقتي : "..ballancee.." جنيه 💵","md",true)
Redis:setex(TeleGod.."iiihoo" .. msg.sender.user_id,600, true)
elseif Descriptioont == "درهم اماراتي 💴" then
Redis:incrby(TeleGod.."boob"..msg.sender.user_id , 15000)
local ballancee = Redis:get(TeleGod.."boob"..msg.sender.user_id) or 0
LuaTele.sendText(msg.chat_id,msg.id,"اشعار ايداع "..neews.."\nتم استبداله بمبلغ وقدره : 15000 جنيه 💵\nكنزك هـو : درهم اماراتي 💴\nنوع العملية : البحث عن كنز\nرصيدك دلوقتي : "..ballancee.." جنيه 💵","md",true)
Redis:setex(TeleGod.."iiihoo" .. msg.sender.user_id,600, true)
elseif Descriptioont == "فرنك جيبوتي 💲" then
Redis:incrby(TeleGod.."boob"..msg.sender.user_id , 20000)
local ballancee = Redis:get(TeleGod.."boob"..msg.sender.user_id) or 0
LuaTele.sendText(msg.chat_id,msg.id,"اشعار ايداع "..neews.."\nتم استبداله بمبلغ وقدره : 20000 جنيه 💵\nكنزك هـو : فرنك جيبوتي 💲\nنوع العملية : البحث عن كنز\nرصيدك دلوقتي : "..ballancee.." جنيه 💵","md",true)
Redis:setex(TeleGod.."iiihoo" .. msg.sender.user_id,600, true)
elseif Descriptioont == "اموال مفقوده 💲" then
Redis:incrby(TeleGod.."boob"..msg.sender.user_id , 3000)
local ballancee = Redis:get(TeleGod.."boob"..msg.sender.user_id) or 0
LuaTele.sendText(msg.chat_id,msg.id,"اشعار ايداع "..neews.."\nتم استبداله بمبلغ وقدره : 3000 جنيه 💵\nكنزك هـو : اموال مفقوده 💲\nنوع العملية : البحث عن كنز\nرصيدك دلوقتي : "..ballancee.." جنيه 💵","md",true)
Redis:setex(TeleGod.."iiihoo" .. msg.sender.user_id,600, true)
elseif Descriptioont == "كنز خاص 💲" then
Redis:incrby(TeleGod.."boob"..msg.sender.user_id , 23000)
local ballancee = Redis:get(TeleGod.."boob"..msg.sender.user_id) or 0
LuaTele.sendText(msg.chat_id,msg.id,"اشعار ايداع "..neews.."\nتم استبداله بمبلغ وقدره : 23000 جنيه 💵\nكنزك هـو : كنز خاص 💲\nنوع العملية : البحث عن كنز\nرصيدك دلوقتي : "..ballancee.." جنيه 💵","md",true)
Redis:setex(TeleGod.."iiihoo" .. msg.sender.user_id,600, true)
elseif Descriptioont == "صواع ملك مفقود ⚱️" then
Redis:incrby(TeleGod.."boob"..msg.sender.user_id , 16000)
local ballancee = Redis:get(TeleGod.."boob"..msg.sender.user_id) or 0
LuaTele.sendText(msg.chat_id,msg.id,"اشعار ايداع "..neews.."\nتم استبداله بمبلغ وقدره : 16000 جنيه 💵\nكنزك هـو : صواع ملك مفقود ⚱️\nنوع العملية : البحث عن كنز\nرصيدك دلوقتي : "..ballancee.." جنيه 💵","md",true)
Redis:setex(TeleGod.."iiihoo" .. msg.sender.user_id,600, true)
elseif Descriptioont == "تاج خاص بملك 👑" then
Redis:incrby(TeleGod.."boob"..msg.sender.user_id , 150000)
local ballancee = Redis:get(TeleGod.."boob"..msg.sender.user_id) or 0
LuaTele.sendText(msg.chat_id,msg.id,"اشعار ايداع "..neews.."\nتم استبداله بمبلغ وقدره : 150000 جنيه 💵\nكنزك هـو : تاج خاص بملك 👑\nنوع العملية : البحث عن كنز\nرصيدك دلوقتي : "..ballancee.." جنيه 💵","md",true)
Redis:setex(TeleGod.."iiihoo" .. msg.sender.user_id,600, true)
elseif Descriptioont == "تاج خاص بملك 👑" then
Redis:incrby(TeleGod.."boob"..msg.sender.user_id , 200000)
local ballancee = Redis:get(TeleGod.."boob"..msg.sender.user_id) or 0
LuaTele.sendText(msg.chat_id,msg.id,"اشعار ايداع "..neews.."\nتم استبداله بمبلغ وقدره : 200000 جنيه 💵\nكنزك هـو : تاج خاص بملك 👑\nنوع العملية : البحث عن كنز\nرصيدك دلوقتي : "..ballancee.." جنيه 💵","md",true)
Redis:setex(TeleGod.."iiihoo" .. msg.sender.user_id,600, true)
elseif Descriptioont == "اثار تحت المنزل" then
Redis:incrby(TeleGod.."boob"..msg.sender.user_id , 1000000)
local ballancee = Redis:get(TeleGod.."boob"..msg.sender.user_id) or 0
LuaTele.sendText(msg.chat_id,msg.id,"اشعار ايداع "..neews.."\nتم استبداله بمبلغ وقدره : 1000000 جنيه 💵\nكنزك هـو : اثار تحت المنزل\nنوع العملية : البحث عن كنز\nرصيدك دلوقتي : "..ballancee.." جنيه 💵","md",true)
Redis:setex(TeleGod.."iiihoo" .. msg.sender.user_id,600, true)
elseif Descriptioont == "جثة فرعون قديمه" then
Redis:incrby(TeleGod.."boob"..msg.sender.user_id , 9000000)
local ballancee = Redis:get(TeleGod.."boob"..msg.sender.user_id) or 0
LuaTele.sendText(msg.chat_id,msg.id,"اشعار ايداع "..neews.."\nتم استبداله بمبلغ وقدره : 9000000 جنيه 💵\nكنزك هـو : جثة فرعون قديمه\nنوع العملية : البحث عن كنز\nرصيدك دلوقتي : "..ballancee.." جنيه 💵","md",true)
Redis:setex(TeleGod.."iiihoo" .. msg.sender.user_id,600, true)
elseif Descriptioont == "تابوت ملك مصري ⚰️" then
Redis:incrby(TeleGod.."boob"..msg.sender.user_id , 16000000)
local ballancee = Redis:get(TeleGod.."boob"..msg.sender.user_id) or 0
LuaTele.sendText(msg.chat_id,msg.id,"اشعار ايداع "..neews.."\nتم استبداله بمبلغ وقدره : 16000000 جنيه 💵\nكنزك هـو : تابوت ملك مصري ⚰️\nنوع العملية : البحث عن كنز\nرصيدك دلوقتي : "..ballancee.." جنيه 💵","md",true)
Redis:setex(TeleGod.."iiihoo" .. msg.sender.user_id,600, true)
elseif Descriptioont == "تاج ملكه مصريه 👑" then
Redis:incrby(TeleGod.."boob"..msg.sender.user_id , 160000)
local ballancee = Redis:get(TeleGod.."boob"..msg.sender.user_id) or 0
LuaTele.sendText(msg.chat_id,msg.id,"اشعار ايداع "..neews.."\nتم استبداله بمبلغ وقدره : 160000 جنيه 💵\nكنزك هـو : تاج ملكه مصريه 👑\nنوع العملية : البحث عن كنز\nرصيدك دلوقتي : "..ballancee.." جنيه 💵","md",true)
Redis:setex(TeleGod.."iiihoo" .. msg.sender.user_id,600, true)
elseif Descriptioont == "مخطوطه لكنز " then
Redis:incrby(TeleGod.."boob"..msg.sender.user_id , 120000)
local ballancee = Redis:get(TeleGod.."boob"..msg.sender.user_id) or 0
LuaTele.sendText(msg.chat_id,msg.id,"اشعار ايداع "..neews.."\nتم استبداله بمبلغ وقدره : 120000 جنيه 💵\nكنزك هـو : مخطوطه لكنز \nنوع العملية : البحث عن كنز\nرصيدك دلوقتي : "..ballancee.." جنيه ??","md",true)
Redis:setex(TeleGod.."iiihoo" .. msg.sender.user_id,600, true)
elseif Descriptioont == "مقبره فرعونيه 💎⚱️⚰️" then
Redis:incrby(TeleGod.."boob"..msg.sender.user_id , 100000)
local ballancee = Redis:get(TeleGod.."boob"..msg.sender.user_id) or 0
LuaTele.sendText(msg.chat_id,msg.id,"اشعار ايداع "..neews.."\nتم استبداله بمبلغ وقدره : 100000 جنيه 💵\nكنزك هـو : مقبره فرعونيه 💎⚱️⚰️\nنوع العملية : البحث عن كنز\nرصيدك دلوقتي : "..ballancee.." جنيه 💵","md",true)
Redis:setex(TeleGod.."iiihoo" .. msg.sender.user_id,600, true)
elseif Descriptioont == "تمثال رمسيس ⚰️" then
Redis:incrby(TeleGod.."boob"..msg.sender.user_id , 190000)
local ballancee = Redis:get(TeleGod.."boob"..msg.sender.user_id) or 0
LuaTele.sendText(msg.chat_id,msg.id,"اشعار ايداع "..neews.."\nتم استبداله بمبلغ وقدره : 190000 جنيه 💵\nكنزك هـو : تمثال رمسيس ⚰️\nنوع العملية : البحث عن كنز\nرصيدك دلوقتي : "..ballancee.." جنيه 💵","md",true)
Redis:setex(TeleGod.."iiihoo" .. msg.sender.user_id,600, true)
elseif Descriptioont == "كنز تلي جود المفقود 💲" then
Redis:incrby(TeleGod.."boob"..msg.sender.user_id , 150000)
local ballancee = Redis:get(TeleGod.."boob"..msg.sender.user_id) or 0
LuaTele.sendText(msg.chat_id,msg.id,"اشعار ايداع "..neews.."\nتم استبداله بمبلغ وقدره : 150000 جنيه 💵\nكنزك هـو : كنز تلي جود المفقود 💲\nنوع العملية : البحث عن كنز\nرصيدك دلوقتي : "..ballancee.." جنيه 💵","md",true)
Redis:setex(TeleGod.."iiihoo" .. msg.sender.user_id,600, true)
elseif Descriptioont == "كنز اطلانطس المفقود 💲" then
Redis:incrby(TeleGod.."boob"..msg.sender.user_id , 20000)
local ballancee = Redis:get(TeleGod.."boob"..msg.sender.user_id) or 0
LuaTele.sendText(msg.chat_id,msg.id,"اشعار ايداع "..neews.."\nتم استبداله بمبلغ وقدره : 20000 جنيه 💵\nكنزك هـو : كنز اطلانطس المفقود 💲\nنوع العملية : البحث عن كنز\nرصيدك دلوقتي : "..ballancee.." جنيه 💵","md",true)
Redis:setex(TeleGod.."iiihoo" .. msg.sender.user_id,600, true)
elseif Descriptioont == "زئبق احمر 🌡️" then
Redis:incrby(TeleGod.."boob"..msg.sender.user_id , 113000000)
local ballancee = Redis:get(TeleGod.."boob"..msg.sender.user_id) or 0
LuaTele.sendText(msg.chat_id,msg.id,"اشعار ايداع "..neews.."\nتم استبداله بمبلغ وقدره : 15000000 جنيه 💵\nكنزك هـو : زئبق احمر 🌡️\nنوع العملية : البحث عن كنز\nرصيدك دلوقتي : "..ballancee.." جنيه 💵","md",true)
Redis:setex(TeleGod.."iiihoo" .. msg.sender.user_id,600, true)
elseif Descriptioont == "ياقوت ومرجان 💰" then
Redis:incrby(TeleGod.."boob"..msg.sender.user_id , 30000)
local ballancee = Redis:get(TeleGod.."boob"..msg.sender.user_id) or 0
LuaTele.sendText(msg.chat_id,msg.id,"اشعار ايداع "..neews.."\nتم استبداله بمبلغ وقدره : 30000 جنيه 💵\nكنزك هـو : ياقوت ومرجان 💰\nنوع العملية : البحث عن كنز\nرصيدك دلوقتي : "..ballancee.." جنيه 💵","md",true)
Redis:setex(TeleGod.."iiihoo" .. msg.sender.user_id,600, true)
elseif Descriptioont == "عمله من العصر الفاطمي 💶" then
Redis:incrby(TeleGod.."boob"..msg.sender.user_id , 900000)
local ballancee = Redis:get(TeleGod.."boob"..msg.sender.user_id) or 0
LuaTele.sendText(msg.chat_id,msg.id,"اشعار ايداع "..neews.."\nتم استبداله بمبلغ وقدره : 900000 جنيه 💵\nكنزك هـو : عمله من العصر الفاطمي 💶\nنوع العملية : البحث عن كنز\nرصيدك دلوقتي : "..ballancee.." جنيه 💵","md",true)
Redis:setex(TeleGod.."iiihoo" .. msg.sender.user_id,600, true)
elseif Descriptioont == "مخطوطة كنز 📜" then
Redis:incrby(TeleGod.."boob"..msg.sender.user_id , 1600000)
local ballancee = Redis:get(TeleGod.."boob"..msg.sender.user_id) or 0
LuaTele.sendText(msg.chat_id,msg.id,"اشعار ايداع "..neews.."\nتم استبداله بمبلغ وقدره : 1600000 جنيه 💵\nكنزك هـو : مخطوطة كنز 📜\nنوع العملية : البحث عن كنز\nرصيدك دلوقتي : "..ballancee.." جنيه 💵","md",true)
Redis:setex(TeleGod.."iiihoo" .. msg.sender.user_id,600, true)
elseif Descriptioont == "بلوره قديمه 🔮" then
Redis:incrby(TeleGod.."boob"..msg.sender.user_id , 10000)
local ballancee = Redis:get(TeleGod.."boob"..msg.sender.user_id) or 0
LuaTele.sendText(msg.chat_id,msg.id,"اشعار ايداع "..neews.."\nتم استبداله بمبلغ وقدره : 10000 جنيه 💵\nكنزك هـو : بلوره قديمه 🔮\nنوع العملية : البحث عن كنز\nرصيدك دلوقتي : "..ballancee.." جنيه 💵","md",true)
Redis:setex(TeleGod.."iiihoo" .. msg.sender.user_id,600, true)
elseif Descriptioont == "كنز تائه 🏛️" then
Redis:incrby(TeleGod.."boob"..msg.sender.user_id , 20000)
local ballancee = Redis:get(TeleGod.."boob"..msg.sender.user_id) or 0
LuaTele.sendText(msg.chat_id,msg.id,"اشعار ايداع "..neews.."\nتم استبداله بمبلغ وقدره : 20000 جنيه 💵\nكنزك هـو : كنز تائه 🏛️\nنوع العملية : البحث عن كنز\nرصيدك دلوقتي : "..ballancee.." جنيه 💵","md",true)
Redis:setex(TeleGod.."iiihoo" .. msg.sender.user_id,600, true)
elseif Descriptioont == "عملات من العصر المملوكي 💲" then
Redis:incrby(TeleGod.."boob"..msg.sender.user_id , 20000)
local ballancee = Redis:get(TeleGod.."boob"..msg.sender.user_id) or 0
LuaTele.sendText(msg.chat_id,msg.id,"اشعار ايداع "..neews.."\nتم استبداله بمبلغ وقدره : 20000 جنيه 💵\nكنزك هـو : عملات من العصر المملوكي 💲\nنوع العملية : البحث عن كنز\nرصيدك دلوقتي : "..ballancee.." جنيه 💵","md",true)
Redis:setex(TeleGod.."iiihoo" .. msg.sender.user_id,600, true)
elseif Descriptioont == "كنز نابليون 💲💲" then
Redis:incrby(TeleGod.."boob"..msg.sender.user_id , 15000)
local ballancee = Redis:get(TeleGod.."boob"..msg.sender.user_id) or 0
LuaTele.sendText(msg.chat_id,msg.id,"اشعار ايداع "..neews.."\nتم استبداله بمبلغ وقدره : 15000 جنيه 💵\nكنزك هـو : كنز نابليون 💲💲\nنوع العملية : البحث عن كنز\nرصيدك دلوقتي : "..ballancee.." جنيه 💵","md",true)
Redis:setex(TeleGod.."iiihoo" .. msg.sender.user_id,600, true)
elseif Descriptioont == "كنز وخلاص 😂💲💲" then
Redis:incrby(TeleGod.."boob"..msg.sender.user_id , 10000)
local ballancee = Redis:get(TeleGod.."boob"..msg.sender.user_id) or 0
LuaTele.sendText(msg.chat_id,msg.id,"اشعار ايداع "..neews.."\nتم استبداله بمبلغ وقدره : 10000 جنيه ??\nكنزك هـو : كنز وخلاص 😂💲💲\nنوع العملية : البحث عن كنز\nرصيدك دلوقتي : "..ballancee.." جنيه 💵","md",true)
Redis:setex(TeleGod.."iiihoo" .. msg.sender.user_id,600, true)
elseif Descriptioont == "ممتلكات قديمه 💸" then
Redis:incrby(TeleGod.."boob"..msg.sender.user_id , 13000)
local ballancee = Redis:get(TeleGod.."boob"..msg.sender.user_id) or 0
LuaTele.sendText(msg.chat_id,msg.id,"اشعار ايداع "..neews.."\nتم استبداله بمبلغ وقدره : 13000 جنيه 💵\nكنزك هـو : ممتلكات قديمه 💸\nنوع العملية : البحث عن كنز\nرصيدك دلوقتي : "..ballancee.." جنيه 💵","md",true)
Redis:setex(TeleGod.."iiihoo" .. msg.sender.user_id,600, true)
end
else
LuaTele.sendText(msg.chat_id,msg.id, "⇜ معندكش حساب بنكي ارسل ↢ ( `انشاء حساب بنكي` )","md",true)
end
end

if text == "بوب" or text == "مشاهير" then
if Redis:get(TeleGod.."Status:Games"..msg.chat_id) then
KlamSpeed = {"شوان","سام","ايد شيرين","جاستين","اريانا","سام سميث","ايد","جاستين","معزه","ميسي","صلاح","محمد صلاح","احمد عز","كريستيانو","كريستيانو رونالدو","رامز جلال","امير كراره","ويجز","بابلو","تامر حسني","ابيو","شيرين","نانسي عجرم","محمد رمضان","احمد حلمي","محمد هنيدي","حسن حسني","حماقي","احمد مكي"};
name = KlamSpeed[math.random(#KlamSpeed)]
Redis:set(TeleGod.."mshaher"..msg.chat_id,name)
name = string.gsub(name,"شوان","https://t.me/HC6HH/8")
name = string.gsub(name,"سام","https://t.me/HC6HH/7")
name = string.gsub(name,"سام سميث","https://t.me/HC6HH/7")
name = string.gsub(name,"ايد شيرين","https://t.me/HC6HH/6")
name = string.gsub(name,"ايد","https://t.me/HC6HH/6")
name = string.gsub(name,"جاستين","https://t.me/HC6HH/4")
name = string.gsub(name,"جاستين بيبر","https://t.me/HC6HH/4")
name = string.gsub(name,"اريانا","https://t.me/HC6HH/5")
name = string.gsub(name,"ميسي","https://t.me/HC6HH/10")
name = string.gsub(name,"معزه","https://t.me/HC6HH/10")
name = string.gsub(name,"صلاح","https://t.me/HC6HH/9")
name = string.gsub(name,"محمد صلاح","https://t.me/HC6HH/9")
name = string.gsub(name,"احمد عز","https://t.me/HC6HH/12")
name = string.gsub(name,"كريم عبدالعزيز","https://t.me/HC6HH/11")
name = string.gsub(name,"كريستيانو رونالدو","https://t.me/HC6HH/13")
name = string.gsub(name,"كريستيانو","https://t.me/HC6HH/13")
name = string.gsub(name,"امير كراره","https://t.me/HC6HH/14")
name = string.gsub(name,"رامز جلال","https://t.me/HC6HH/15")
name = string.gsub(name,"ويجز","https://t.me/HC6HH/16")
name = string.gsub(name,"بابلو","https://t.me/HC6HH/17")
name = string.gsub(name,"ابيو","https://t.me/HC6HH/20")
name = string.gsub(name,"شيرين","https://t.me/HC6HH/21")
name = string.gsub(name,"نانسي عجرم","https://t.me/HC6HH/22")
name = string.gsub(name,"محمد رمضان","https://t.me/HC6HH/25")
name = string.gsub(name,"احمد حلمي","https://t.me/HC6HH/26")
name = string.gsub(name,"محمد هنيدي","https://t.me/HC6HH/27")
name = string.gsub(name,"حسن حسني","https://t.me/HC6HH/28")
name = string.gsub(name,"احمد مكي","https://t.me/HC6HH/29")
name = string.gsub(name,"تامر حسني","https://t.me/HC6HH/30")
name = string.gsub(name,"حماقي","https://t.me/HC6HH/31")
https.request("https://api.telegram.org/bot"..Token.."/sendphoto?chat_id="..msg.chat_id.."&photo="..name.."&caption="..URL.escape("اسرع واحد يقول اسم هذا الفنان").."&reply_to_message_id="..(msg.id/2097152/0.5))
--return send(msg_chat_id,msg_id,"✦ اسرع واحد يرتبها ~ {"..name.."}","md",true)  
end
end
if text == "الاسرع" or text == "ترتيب" then
if Redis:get(TeleGod.."Status:Games"..msg.chat_id) then
KlamSpeed = {"سحور","سياره","استقبال","قنفذ","ايفون","بزونه","مطبخ","كرستيانو","دجاجه","مدرسه","الوان","غرفه","ثلاجه","قهوه","سفينه","تلي جود","محطه","طياره","رادار","منزل","مستشفى","كهرباء","تفاحه","اخطبوط","سلمون","فرنسا","برتقاله","تفاح","مطرقه","لعبه","شباك","باص","سمكه","ذباب","تلفاز","حاسوب","انترنت","ساحه","جسر"};
name = KlamSpeed[math.random(#KlamSpeed)]
Redis:set(TeleGod.."Game:Monotonous"..msg.chat_id,name)
name = string.gsub(name,"سحور","س ر و ح")
name = string.gsub(name,"سياره","ه ر س ي ا")
name = string.gsub(name,"استقبال","ل ب ا ت ق س ا")
name = string.gsub(name,"قنفذ","ذ ق ن ف")
name = string.gsub(name,"ايفون","و ن ف ا")
name = string.gsub(name,"تلي جود","ر و ف ر ي")
name = string.gsub(name,"مطبخ","خ ب ط م")
name = string.gsub(name,"كرستيانو","س ت ا ن و ك ر ي")
name = string.gsub(name,"دجاجه","ج ج ا د ه")
name = string.gsub(name,"مدرسه","ه م د ر س")
name = string.gsub(name,"الوان","ن ا و ا ل")
name = string.gsub(name,"غرفه","غ ه ر ف")
name = string.gsub(name,"ثلاجه","ج ه ت ل ا")
name = string.gsub(name,"قهوه","ه ق ه و")
name = string.gsub(name,"سفينه","ه ن ف ي س")
name = string.gsub(name,"محطه","ه ط م ح")
name = string.gsub(name,"طياره","ر ا ط ي ه")
name = string.gsub(name,"رادار","ر ا ر ا د")
name = string.gsub(name,"منزل","ن ز م ل")
name = string.gsub(name,"مستشفى","ى ش س ف ت م")
name = string.gsub(name,"كهرباء","ر ب ك ه ا ء")
name = string.gsub(name,"تفاحه","ح ه ا ت ف")
name = string.gsub(name,"اخطبوط","ط ب و ا خ ط")
name = string.gsub(name,"سلمون","ن م و ل س")
name = string.gsub(name,"فرنسا","ن ف ر س ا")
name = string.gsub(name,"برتقاله","ر ت ق ب ا ه ل")
name = string.gsub(name,"تفاح","ح ف ا ت")
name = string.gsub(name,"مطرقه","ه ط م ر ق")
name = string.gsub(name,"مصر","ص م ر")
name = string.gsub(name,"لعبه","ع ل ه ب")
name = string.gsub(name,"شباك","ب ش ا ك")
name = string.gsub(name,"باص","ص ا ب")
name = string.gsub(name,"سمكه","ك س م ه")
name = string.gsub(name,"ذباب","ب ا ب ذ")
name = string.gsub(name,"تلفاز","ت ف ل ز ا")
name = string.gsub(name,"حاسوب","س ا ح و ب")
name = string.gsub(name,"انترنت","ا ت ن ن  ر ت")
name = string.gsub(name,"ساحه","ح ا ه س")
name = string.gsub(name,"جسر","ر ج س")
return send(msg_chat_id,msg_id,"✦ اسرع واحد يرتبها ~ {"..name.."}","md",true)  
end
end
if text == "خيروك" or text == "لو خيروك" then
if Redis:get(TeleGod.."Status:Games"..msg.chat_id) then
local texting = {
"الو خيروك بين البقاء مدى الحياة مع أخيك أو البقاء مدى الحياة مع حبيبك من تختار؟",
"لو عرضوا عليك السفر لمدة 20 عام مع شخص واحد فقط من تختار؟",
"امن تحب أكثر والدك أم والدتك؟",
"الو خيروك بين إعطاء هدية باهظة الثمن لفرد من أفراد أسرتك من تختار؟",
"لو خيروك بين الذكاء أو الثراء ماذا تختار؟",
"لو خيروك بين الزواج من شخص تحبه أو شخص سيحقق لك جميع أحلامك من تختار؟",
"الو خيروك بين المكوث مدى الحياة مع صديقك المفضل أو مع حبيبك من تختار؟",
"الو خيروك بين الشهادة الجامعية أو السفر حول العالم؟",
"الو خيروك بين العيش في نيويورك أو في لندن أيهما تختار؟",
"لو خيروك بين العودة إلى الماضي أو الذهاب إلى المستقبل أيهما تختار؟",
"لو خيروك بين تمتع شريك حياتك بصفة من الأثنين الطيبة أو حسن التصرف أيهما تختار؟",
"لو خيروك بين الزواج من شخص في عمرك فقير أو شخص يكبرك بعشرين عام غني من تختار",
"لو خيروك بين قتلك بالسم أو قتلك بالمسدس ماذا تختار؟",
"لو خيروك بين إنقاذ والدك أو إنقاذ والدتك من تختار؟",
}
return send(msg_chat_id,msg_id,texting[math.random(#texting)],'md')
end
end
if text == "صراحه" or text == "جرأه" then
if Redis:get(TeleGod.."Status:Games"..msg.chat_id) then
local texting = {
"هل تعرضت لغدر في حياتك؟",
"هل تعرف عيوبك؟",
"هل أنت مُسامح أم لا تستطيع أن تُسامح؟",
"إذا قمت بالسفر إلى نُزهة خارج بلدك فمن هو الشخص الذي تُحب أن يُرافقك؟هل تتدخل إذا وجدت شخص يتعرض لحادثة سير أم تتركه وترحل؟",
"ما هو الشخص الذي لا تستطيع أن ترفض له أي طلب؟",
"إذا أعجبت بشخصٍ ما، كيف تُظهر له هذا الإعجاب أو ما هي الطريقة التي ستتبعها لتظهر إعجابك به؟",
"هل ترى نفسك مُتناقضً؟",
"ما هو الموقف الذي تعرضت فيه إلى الاحراج المُبرح؟",
"ما هو الموقف الذي جعلك تبكي أمام مجموعة من الناس رغمًا عنك؟",
"إذا جاء شريك حياتك وطلب الانفصال، فماذا يكون ردك وقته؟",
"إذا كان والد يعمل بعملٍ فقير هل تقبل به أو تستعر منه؟",
"ما الذي يجعلك تُصاب بالغضب الشديد؟",
"هإذا وجدت الشخص الذي أحببتهُ في يومٍ ما يمسك بطفله، هل هذا سيشعرك بالألم؟",
"علاقتك مع اهلك",
"ثلاثة أشياء تحبها"
}
return send(msg_chat_id,msg_id,texting[math.random(#texting)],'md')
end
end
if text == "حزوره" then
if Redis:get(TeleGod.."Status:Games"..msg.chat_id) then
Hzora = {"الجرس","عقرب الساعه","السمك","المطر","5","الكتاب","البسمار","7","الكعبه","بيت الشعر","لهانه","انا","امي","الابره","الساعه","22","غلط","كم الساعه","البيتنجان","البيض","المرايه","الضوء","الهواء","الضل","العمر","القلم","المشط","الحفره","البحر","الثلج","الاسفنج","الصوت","بلم"};
name = Hzora[math.random(#Hzora)]
Redis:set(TeleGod.."Game:Riddles"..msg.chat_id,name)
name = string.gsub(name,"الجرس","شيئ اذا لمسته صرخ ما هوه ؟")
name = string.gsub(name,"عقرب الساعه","اخوان لا يستطيعان تمضيه اكثر من دقيقه معا فما هما ؟")
name = string.gsub(name,"السمك","ما هو الحيوان الذي لم يصعد الى سفينة نوح عليه السلام ؟")
name = string.gsub(name,"المطر","شيئ يسقط على رأسك من الاعلى ولا يجرحك فما هو ؟")
name = string.gsub(name,"5","ما العدد الذي اذا ضربته بنفسه واضفت عليه 5 يصبح ثلاثين ")
name = string.gsub(name,"الكتاب","ما الشيئ الذي له اوراق وليس له جذور ؟")
name = string.gsub(name,"البسمار","ما هو الشيئ الذي لا يمشي الا بالضرب ؟")
name = string.gsub(name,"7","عائله مؤلفه من 6 بنات واخ لكل منهن .فكم عدد افراد العائله ")
name = string.gsub(name,"الكعبه","ما هو الشيئ الموجود وسط مكة ؟")
name = string.gsub(name,"بيت الشعر","ما هو البيت الذي ليس فيه ابواب ولا نوافذ ؟ ")
name = string.gsub(name,"لهانه","وحده حلوه ومغروره تلبس مية تنوره .من هيه ؟ ")
name = string.gsub(name,"انا","ابن امك وابن ابيك وليس باختك ولا باخيك فمن يكون ؟")
name = string.gsub(name,"امي","اخت خالك وليست خالتك من تكون ؟ ")
name = string.gsub(name,"الابره","ما هو الشيئ الذي كلما خطا خطوه فقد شيئا من ذيله ؟ ")
name = string.gsub(name,"الساعه","ما هو الشيئ الذي يقول الصدق ولكنه اذا جاع كذب ؟")
name = string.gsub(name,"22","كم مره ينطبق عقربا الساعه على بعضهما في اليوم الواحد ")
name = string.gsub(name,"غلط","ما هي الكلمه الوحيده التي تلفض غلط دائما ؟ ")
name = string.gsub(name,"كم الساعه","ما هو السؤال الذي تختلف اجابته دائما ؟")
name = string.gsub(name,"البيتنجان","جسم اسود وقلب ابيض وراس اخظر فما هو ؟")
name = string.gsub(name,"البيض","ماهو الشيئ الذي اسمه على لونه ؟")
name = string.gsub(name,"المرايه","ارى كل شيئ من دون عيون من اكون ؟ ")
name = string.gsub(name,"الضوء","ما هو الشيئ الذي يخترق الزجاج ولا يكسره ؟")
name = string.gsub(name,"الهواء","ما هو الشيئ الذي يسير امامك ولا تراه ؟")
name = string.gsub(name,"الضل","ما هو الشيئ الذي يلاحقك اينما تذهب ؟ ")
name = string.gsub(name,"العمر","ما هو الشيء الذي كلما طال قصر ؟ ")
name = string.gsub(name,"القلم","ما هو الشيئ الذي يكتب ولا يقرأ ؟")
name = string.gsub(name,"المشط","له أسنان ولا يعض ما هو ؟ ")
name = string.gsub(name,"الحفره","ما هو الشيئ اذا أخذنا منه ازداد وكبر ؟")
name = string.gsub(name,"البحر","ما هو الشيئ الذي يرفع اثقال ولا يقدر يرفع مسمار ؟")
name = string.gsub(name,"الثلج","انا ابن الماء فان تركوني في الماء مت فمن انا ؟")
name = string.gsub(name,"الاسفنج","كلي ثقوب ومع ذالك احفض الماء فمن اكون ؟")
name = string.gsub(name,"الصوت","اسير بلا رجلين ولا ادخل الا بالاذنين فمن انا ؟")
name = string.gsub(name,"بلم","حامل ومحمول نصف ناشف ونصف مبلول فمن اكون ؟ ")
return send(msg_chat_id,msg_id,"✦ اسرع واحد يحل الفزوره دي يكسب ↓\n {"..name.."}","md",true)  
end
end

if text == "اعلام" or text == "اعلام ودول" or text == "اعلام و دول" or text == "دول" then
if Redis:get(TeleGod.."Status:Games"..msg.chat_id) then
Redis:del(TeleGod.."Set:Country"..msg.chat_id)
Country_Rand = {"مصر","العراق","السعوديه","المانيا","تونس","الجزائر","فلسطين","اليمن","المغرب","البحرين","فرنسا","سويسرا","تركيا","انجلترا","الولايات المتحده","كندا","الكويت","ليبيا","السودان","سوريا"}
name = Country_Rand[math.random(#Country_Rand)]
Redis:set(TeleGod.."Game:Countrygof"..msg.chat_id,name)
name = string.gsub(name,"مصر","🇪🇬")
name = string.gsub(name,"العراق","🇮🇶")
name = string.gsub(name,"السعوديه","🇸🇦")
name = string.gsub(name,"المانيا","🇩🇪")
name = string.gsub(name,"تونس","🇹🇳")
name = string.gsub(name,"الجزائر","🇩🇿")
name = string.gsub(name,"فلسطين","🇵🇸")
name = string.gsub(name,"اليمن","🇾🇪")
name = string.gsub(name,"المغرب","🇲🇦")
name = string.gsub(name,"البحرين","🇧🇭")
name = string.gsub(name,"فرنسا","🇫🇷")
name = string.gsub(name,"سويسرا","🇨🇭")
name = string.gsub(name,"انجلترا","🇬🇧")
name = string.gsub(name,"تركيا","🇹🇷")
name = string.gsub(name,"الولايات المتحده","🇱🇷")
name = string.gsub(name,"كندا","🇨🇦")
name = string.gsub(name,"الكويت","🇰🇼")
name = string.gsub(name,"ليبيا","🇱🇾")
name = string.gsub(name,"السودان","🇸🇩")
name = string.gsub(name,"سوريا","🇸🇾")
return send(msg_chat_id,msg_id,"✦ اسرع واحد يرسل اسم الدولة ~ {"..name.."}","md",true)  
end
end

if text == "معاني" then
if Redis:get(TeleGod.."Status:Games"..msg.chat_id) then
Redis:del(TeleGod.."Set:Maany"..msg.chat_id)
Maany_Rand = {"قرد","دجاجه","بطريق","ضفدع","بومه","نحله","ديك","جمل","بقره","دولفين","تمساح","قرش","نمر","اخطبوط","سمكه","خفاش","اسد","فأر","ذئب","فراشه","عقرب","زرافه","قنفذ","تفاحه","باذنجان"}
name = Maany_Rand[math.random(#Maany_Rand)]
Redis:set(TeleGod.."Game:Meaningof"..msg.chat_id,name)
name = string.gsub(name,"قرد","🐒")
name = string.gsub(name,"دجاجه","🐔")
name = string.gsub(name,"بطريق","🐧")
name = string.gsub(name,"ضفدع","🐸")
name = string.gsub(name,"بومه","🦉")
name = string.gsub(name,"نحله","🐝")
name = string.gsub(name,"ديك","🐓")
name = string.gsub(name,"جمل","🐫")
name = string.gsub(name,"بقره","🐄")
name = string.gsub(name,"دولفين","🐬")
name = string.gsub(name,"تمساح","🐊")
name = string.gsub(name,"قرش","🦈")
name = string.gsub(name,"نمر","🐅")
name = string.gsub(name,"اخطبوط","🐙")
name = string.gsub(name,"سمكه","🐟")
name = string.gsub(name,"خفاش","🦇")
name = string.gsub(name,"اسد","🦁")
name = string.gsub(name,"فأر","🐭")
name = string.gsub(name,"ذئب","🐺")
name = string.gsub(name,"فراشه","🦋")
name = string.gsub(name,"عقرب","🦂")
name = string.gsub(name,"زرافه","🦒")
name = string.gsub(name,"قنفذ","🦔")
name = string.gsub(name,"تفاحه","🍎")
name = string.gsub(name,"باذنجان","🍆")
return send(msg_chat_id,msg_id,"✦ اسرع واحد يبعت معنى السمايل ~ {"..name.."}","md",true)  
end
end
if text == "انجليزي" then
if Redis:get(TeleGod.."Status:Games"..msg.chat_id) then
Redis:del(TeleGod.."Set:enkliz"..msg.chat_id)
enkliz_Rand = {'معلومات','قنوات','مجموعات','كتاب','تفاحه','مختلف','سدني','نقود','اعلم','ذئب','تمساح','ذكي',};
name = enkliz_Rand[math.random(#enkliz_Rand)]
Redis:set(TeleGod.."Game:enkliz"..msg.chat_id,name)
name = string.gsub(name,'ذئب','Wolf')
name = string.gsub(name,'معلومات','Information')
name = string.gsub(name,'قنوات','Channels')
name = string.gsub(name,'مجموعات','Groups')
name = string.gsub(name,'كتاب','Book')
name = string.gsub(name,'تفاحه','Apple')
name = string.gsub(name,'سدني','Sydney')
name = string.gsub(name,'نقود','money')
name = string.gsub(name,'اعلم','I know')
name = string.gsub(name,'تمساح','crocodile')
name = string.gsub(name,'مختلف','Different')
name = string.gsub(name,'ذكي','Intelligent')
return send(msg_chat_id,msg_id,"✦ اسرع واحد يترجم ~ {"..name.."}","md",true)  
end
end
if text == "العكس" then
if Redis:get(TeleGod.."Status:Games"..msg.chat_id) then
Redis:del(TeleGod.."Set:Aks"..msg.chat_id)
katu = {"باي","فهمت","موزين","اسمعك","احبك","موحلو","نضيف","حاره","ناصي","جوه","سريع","ونسه","طويل","سمين","ضعيف","شريف","شجاع","رحت","عدل","نشيط","شبعان","موعطشان","خوش ولد","اني","هادئ"}
name = katu[math.random(#katu)]
Redis:set(TeleGod.."Game:Reflection"..msg.chat_id,name)
name = string.gsub(name,"باي","هلو")
name = string.gsub(name,"فهمت","مافهمت")
name = string.gsub(name,"موزين","زين")
name = string.gsub(name,"اسمعك","ماسمعك")
name = string.gsub(name,"احبك","ماحبك")
name = string.gsub(name,"موحلو","حلو")
name = string.gsub(name,"نضيف","وصخ")
name = string.gsub(name,"حاره","بارده")
name = string.gsub(name,"و","عالي")
name = string.gsub(name,"جوه","فوك")
name = string.gsub(name,"سريع","بطيء")
name = string.gsub(name,"ونسه","ضوجه")
name = string.gsub(name,"طويل","قزم")
name = string.gsub(name,"سمين","ضعيف")
name = string.gsub(name,"ضعيف","قوي")
name = string.gsub(name,"شريف","كواد")
name = string.gsub(name,"شجاع","جبان")
name = string.gsub(name,"رحت","اجيت")
name = string.gsub(name,"عدل","ميت")
name = string.gsub(name,"نشيط","كسول")
name = string.gsub(name,"شبعان","جوعان")
name = string.gsub(name,"موعطشان","عطشان")
name = string.gsub(name,"خوش ولد","موخوش ولد")
name = string.gsub(name,"اني","مطي")
name = string.gsub(name,"هادئ","عصبي")
return send(msg_chat_id,msg_id,"✦ اسرع واحد يبعت العكس ~ {"..name.."}","md",true)  
end
end
if text == "بات" or text == "محيبس" then   
if Redis:get(TeleGod.."Status:Games"..msg.chat_id) then 
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '𝟏 » { 👊 }', data = '/Mahibes1'}, {text = '𝟐 » { 👊 }', data = '/Mahibes2'}, 
},
{
{text = '𝟑 » { 👊 }', data = '/Mahibes3'}, {text = '𝟒 » { 👊 }', data = '/Mahibes4'}, 
},
{
{text = '𝟓 » { 👊 }', data = '/Mahibes5'}, {text = '𝟔 » { 👊 }', data = '/Mahibes6'}, 
},
}
}
return send(msg_chat_id,msg_id, [[*
✦ لعبة المحيبس هي لعبة الحظ 
✦ جرب حظك ويه البوت واتونس 
✦ كل ما عليك هوا الضغط على احدى العضمات في الازرار
*]],"md",false, false, false, false, reply_markup)
end
end
if text == "خمن" or text == "تخمين" then   
if Redis:get(TeleGod.."Status:Games"..msg.chat_id) then
Num = math.random(1,20)
Redis:set(TeleGod.."Game:Estimate"..msg.chat_id..msg.sender.user_id,Num)  
return send(msg_chat_id,msg_id,"\n✦ اهلا بك عزيزي في لعبة التخمين :\nٴ━━━━━━━━━━\n".."✦ ملاحظه لديك { 3 } محاولات فقط فكر قبل ارسال تخمينك \n\n".."✦ سيتم تخمين عدد ما بين ال {1 و 20} اذا تعتقد انك تستطيع الفوز جرب واللعب الان ؟ ","md",true)  
end
end
if text == "المختلف" then
if Redis:get(TeleGod.."Status:Games"..msg.chat_id) then
mktlf = {"😸","☠","🐼","🐇","🌑","🌚","⭐️","✨","⛈","🌥","⛄️","👨‍🔬","👨‍💻","👨‍🔧","🧚‍♀","??‍♂","🧝‍♂","🙍‍♂","🧖‍♂","👬","🕒","🕤","⌛️","📅",};
name = mktlf[math.random(#mktlf)]
Redis:set(TeleGod.."Game:Difference"..msg.chat_id,name)
name = string.gsub(name,"😸","😹😹😹😹😹😹😹😹😸😹??😹😹")
name = string.gsub(name,"☠","💀💀💀💀💀💀💀☠💀💀💀💀💀")
name = string.gsub(name,"🐼","👻👻👻🐼👻👻👻👻👻👻👻")
name = string.gsub(name,"🐇","🕊🕊🕊🕊🕊🐇🕊🕊🕊🕊")
name = string.gsub(name,"🌑","🌚🌚🌚🌚🌚🌑🌚🌚🌚")
name = string.gsub(name,"🌚","🌑🌑🌑🌑🌑🌚🌑🌑🌑")
name = string.gsub(name,"⭐️","🌟🌟🌟🌟🌟🌟🌟🌟⭐️🌟🌟🌟")
name = string.gsub(name,"✨","💫💫💫💫💫✨💫💫💫💫")
name = string.gsub(name,"⛈","🌨🌨🌨🌨🌨⛈🌨🌨🌨🌨")
name = string.gsub(name,"🌥","⛅️⛅️⛅️⛅️⛅️⛅️🌥⛅️⛅️⛅️⛅️")
name = string.gsub(name,"⛄️","☃☃☃☃☃☃⛄️☃☃☃☃")
name = string.gsub(name,"👨‍🔬","👩‍🔬👩‍🔬👩‍🔬👩‍🔬👩‍🔬👩‍🔬👩‍🔬👩‍🔬👨‍🔬👩‍🔬👩‍🔬👩‍🔬")
name = string.gsub(name,"👨‍💻","👩‍💻👩‍??👩‍‍💻👩‍‍??👩‍‍💻👨‍💻??‍💻👩‍💻👩‍💻")
name = string.gsub(name,"👨‍🔧","👩‍🔧👩‍🔧👩‍🔧👩‍🔧👩‍🔧👩‍🔧👨‍🔧👩‍🔧")
name = string.gsub(name,"👩‍🍳","👨‍🍳👨‍🍳👨‍🍳👨‍🍳👨‍🍳👩‍🍳👨‍🍳👨‍🍳👨‍🍳")
name = string.gsub(name,"🧚‍♀","🧚‍♂🧚‍♂🧚‍♂🧚‍♂🧚‍♀🧚‍♂🧚‍♂")
name = string.gsub(name,"🧜‍♂","🧜‍♀🧜‍♀🧜‍♀🧜‍♀🧜‍♀🧚‍♂🧜‍♀🧜‍♀🧜‍♀")
name = string.gsub(name,"🧝‍♂","🧝‍♀🧝‍♀🧝‍♀🧝‍♀🧝‍♀🧝‍♂🧝‍♀🧝‍♀🧝‍♀")
name = string.gsub(name,"🙍‍♂️","🙎‍♂️🙎‍♂️🙎‍♂️🙎‍♂️🙎‍♂️🙍‍♂️🙎‍♂️🙎‍♂️🙎‍♂️")
name = string.gsub(name,"🧖‍♂️","🧖‍♀️🧖‍♀️??‍♀️🧖‍♀️🧖‍♀️🧖‍♂️🧖‍♀️🧖‍♀️🧖‍♀️🧖‍♀️")
name = string.gsub(name,"👬","👭👭👭👭👭👬👭👭👭")
name = string.gsub(name,"👨‍👨‍👧","👨‍👨‍👦👨‍👨‍👦👨‍👨‍👦👨‍👨‍👦👨‍👨‍👧👨‍👨‍👦👨‍👨‍👦")
name = string.gsub(name,"🕒","🕒🕒🕒🕒🕒🕒🕓🕒🕒🕒")
name = string.gsub(name,"🕤","🕥🕥🕥🕥🕥🕤🕥🕥🕥")
name = string.gsub(name,"⌛️","⏳⏳⏳⏳⏳⏳⌛️⏳⏳")
name = string.gsub(name,"📅","📆📆📆📆📆📆📅📆📆")
return send(msg_chat_id,msg_id,"✦ اسرع واحد يبعت الاختلاف ~ {"..name.."}","md",true)  
end
end
if text == "امثله" then
if Redis:get(TeleGod.."Status:Games"..msg.chat_id) then
mthal = {"جوز","ضراطه","الحبل","الحافي","شقره","بيدك","سلايه","النخله","الخيل","حداد","المبلل","يركص","قرد","العنب","العمه","الخبز","بالحصاد","شهر","شكه","يكحله",};
name = mthal[math.random(#mthal)]
Redis:set(TeleGod.."Game:Example"..msg.chat_id,name)
name = string.gsub(name,"جوز","ينطي____للماعده سنون")
name = string.gsub(name,"ضراطه","الي يسوق المطي يتحمل___")
name = string.gsub(name,"بيدك","اكل___محد يفيدك")
name = string.gsub(name,"الحافي","تجدي من___نعال")
name = string.gsub(name,"شقره","مع الخيل يا___")
name = string.gsub(name,"النخله","الطول طول___والعقل عقل الصخلة")
name = string.gsub(name,"سلايه","بالوجه امراية وبالظهر___")
name = string.gsub(name,"الخيل","من قلة___شدو على الچلاب سروج")
name = string.gsub(name,"حداد","موكل من صخم وجهه كال آني___")
name = string.gsub(name,"المبلل","___ما يخاف من المطر")
name = string.gsub(name,"الحبل","اللي تلدغة الحية يخاف من جرة___")
name = string.gsub(name,"يركص","المايعرف___يكول الكاع عوجه")
name = string.gsub(name,"العنب","المايلوح___يكول حامض")
name = string.gsub(name,"العمه","___إذا حبت الچنة ابليس يدخل الجنة")
name = string.gsub(name,"الخبز","انطي___للخباز حتى لو ياكل نصه")
name = string.gsub(name,"باحصاد","اسمة___ومنجله مكسور")
name = string.gsub(name,"شهر","امشي__ولا تعبر نهر")
name = string.gsub(name,"شكه","يامن تعب يامن__يا من على الحاضر لكة")
name = string.gsub(name,"القرد","__بعين امه غزال")
name = string.gsub(name,"يكحله","اجه___عماها")
return send(msg_chat_id,msg_id,"✦ اسرع واحد يكمل المثل ~ {"..name.."}","md",true)  
end
end
if text then
if text:match("^بيع نقاطي (%d+)$") then
local NumGame = text:match("^بيع نقاطي (%d+)$") 
if tonumber(NumGame) == tonumber(0) then
return send(msg_chat_id,msg_id,"\n*✦ لا استطيع البيع اقل من 1 *","md",true)  
end
local NumberGame = Redis:get(TeleGod.."Num:Add:Games"..msg.chat_id..msg.sender.user_id)
if tonumber(NumberGame) == tonumber(0) then
return send(msg_chat_id,msg_id,"✦ ليس لديك نقاط من الالعاب \n✦ اذا كنت تريد ربح النقاط \n✦ ارسل الالعاب وابدأ اللعب ! ","md",true)  
end
if tonumber(NumGame) > tonumber(NumberGame) then
return send(msg_chat_id,msg_id,"\n✦ ليس لديك نقاط بهذا العدد \n✦ لزيادة نقاطك في اللعبه \n✦ ارسل الالعاب وابدأ اللعب !","md",true)   
end
local Xnxx = (tonumber(NumGame) * 50)
Redis:decrby(TeleGod.."Num:Add:Games"..msg.chat_id..msg.sender.user_id,NumGame)  
Redis:incrby(TeleGod.."Num:Message:User"..msg.chat_id..":"..msg.sender.user_id,Xnxx )  
return send(msg_chat_id,msg_id,"✦ تم خصم *~ "..NumGame.." * من نقاطك \n✦ وتم اضافة* ~  "..(NumGame * 50).."  رساله الى رسالك *","md",true)  
end 
end
if text and text:match("^اضف نقاط (%d+)$") and msg.reply_to_message_id ~= 0 then
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
if UserInfo.message == "Invalid user ID" then
return send(msg_chat_id,msg_id,"\n✦ عذرآ تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return send(msg_chat_id,msg_id,"\n✦ عذرآ لا تستطيع استخدام الامر على البوت ","md",true)  
end
Redis:incrby(TeleGod.."Num:Add:Games"..msg.chat_id..Message_Reply.sender.user_id, text:match("^اضف نقاط (%d+)$"))  
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"✦ تم اضافه له  "..text:match("^اضف نقاط (%d+)$").." من النقاط").Reply,"md",true)  
end
if text and text:match("^اضف رسائل (%d+)$") and msg.reply_to_message_id ~= 0 then
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
if not msg.Admin then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(7)..' * ',"md",true)  
end
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
local UserInfo = LuaTele.getUser(Message_Reply.sender.user_id)
if UserInfo.message == "Invalid user ID" then
return send(msg_chat_id,msg_id,"\n✦ عذرآ تستطيع فقط استخدام الامر على المستخدمين ","md",true)  
end
if UserInfo and UserInfo.type and UserInfo.type.luatele == "userTypeBot" then
return send(msg_chat_id,msg_id,"\n✦ عذرآ لا تستطيع استخدام الامر على البوت ","md",true)  
end
Redis:incrby(TeleGod.."Num:Message:User"..msg.chat_id..":"..Message_Reply.sender.user_id, text:match("^اضف رسائل (%d+)$"))  
return send(msg_chat_id,msg_id,Reply_Status(Message_Reply.sender.user_id,"✦ تم اضافه له  "..text:match("^اضف رسائل (%d+)$").."  من الرسائل").Reply,"md",true)  
end
if text == "نقاطي" then 
local Num = Redis:get(TeleGod.."Num:Add:Games"..msg.chat_id..msg.sender.user_id) or 0
if Num == 0 then 
return send(msg_chat_id,msg_id, "✦ لم تفز بأي نقطه ","md",true)  
else
return send(msg_chat_id,msg_id, "✦ عدد النقاط التي ربحتها *← "..Num.." *","md",true)  
end
end

if text == 'ترتيب الاوامر' then
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(TeleGod.."Get:Reides:Commands:Group"..msg_chat_id..":"..'تعط','تعطيل الايدي بالصوره')
Redis:set(TeleGod.."Get:Reides:Commands:Group"..msg_chat_id..":"..'تفع','تفعيل الايدي بالصوره')
Redis:set(TeleGod.."Get:Reides:Commands:Group"..msg_chat_id..":"..'ا','ايدي')
Redis:set(TeleGod.."Get:Reides:Commands:Group"..msg_chat_id..":"..'م','رفع مميز')
Redis:set(TeleGod.."Get:Reides:Commands:Group"..msg_chat_id..":"..'اد', 'رفع ادمن')
Redis:set(TeleGod.."Get:Reides:Commands:Group"..msg_chat_id..":"..'مد','رفع مدير')
Redis:set(TeleGod.."Get:Reides:Commands:Group"..msg_chat_id..":"..'من', 'رفع منشئ')
Redis:set(TeleGod.."Get:Reides:Commands:Group"..msg_chat_id..":"..'اس', 'رفع منشئ اساسي')
return send(msg_chat_id,msg_id,[[*
✦ تم ترتيب الاوامر بالشكل التالي ✦ 
- ايدي - ا ✦ 
- مميز - م ✦ 
- ادمن - اد ✦ 
- مدير - مد ✦ 
- منشى - من ✦ 
- المنشئ الاساسي - اس  ✦ 
- تعطيل الايدي بالصوره - تعط ✦ 
- تفعيل الايدي بالصوره - تفع ✦ 
*]],"md")
end
if text == "تفعيل سمسمي" then
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
Redis:del(TeleGod.."smsme"..msg.chat_id)
send(msg.chat_id,msg.id,"✦ تم تفعيل سمسمي")
end
if text == "تعطيل سمسمي" then
if not msg.Manger then
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(6)..' * ',"md",true)  
end
Redis:set(TeleGod.."smsme"..msg.chat_id,true)
send(msg.chat_id,msg.id,"✦ تم تعطيل سمسمي")
end
if not Redis:get(TeleGod.."smsme"..msg.chat_id) then
if text and msg.reply_to_message_id ~= 0 then
local Message_Reply = LuaTele.getMessage(msg.chat_id, msg.reply_to_message_id)
if Message_Reply and Message_Reply.sender and tonumber(Message_Reply.sender.user_id) == tonumber(TeleGod) then
ai_text = https.request("https://dev-ooooo2oo.pantheonsite.io/smsmi.php?msg="..URL.escape(text))
if ai_text:match("(.*)سناب(.*)") or ai_text:match("(.*)واتس(.*)") or ai_text:match("(.*)انستا(.*)") or ai_text:match("(.*)رقمي(.*)") or ai_text:match("(%d+)") or ai_text:match("(.*)متابعه(.*)") or ai_text:match("(.*)تابعني(.*)") or ai_text:match("(.*)قناتي(.*)") or ai_text:match("(.*)قناه(.*)") or ai_text:match("(.*)يوتيوب(.*)") then
txx = "بمعني؟!!"
else
txx = ai_text
end
send(msg_chat_id,msg_id,txx,"md")
end
end
end


end -- GroupBot
if chat_type(msg.chat_id) == "UserBot" then 
if text == 'تحديث الملفات' or text == 'تحديث' then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
print('Chat Id : '..msg_chat_id)
print('User Id : '..msg_user_send_id)
send(msg_chat_id,msg_id, "✦ تم تحديث الملفات ","md",true)
dofile('TeleGod.lua')  
end
if text and text:match("/start st(.*)u(%d+)") then
local coree = {text:match("/start st(.*)u(%d+)") }
print(coree[2])
print(msg_user_send_id)
if msg_user_send_id ~= tonumber(coree[2]) then
send(msg_chat_id,msg_id,'\n*✦ هذا الامر لا يخصك* ',"md",true)  
else
LuaTele.setChatMemberStatus(coree[1],coree[2],'banned',0)
LuaTele.setChatMemberStatus(coree[1],coree[2],'restricted',{1,1,1,1,1,1,1,1,1})
local Get_Chat = LuaTele.getChat(coree[1])
local GetLink = Redis:get(TeleGod.."Group:Link"..coree[1]) 
if GetLink then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{{text =Get_Chat.title, url = GetLink}, },}}
return send(msg_chat_id, msg_id, "✦ Link Group : \n["..Get_Chat.title.. ']('..GetLink..')', 'md', true, false, false, false, reply_markup)
else 
local m = https.request("https://api.telegram.org/bot"..Token.."/getchat?chat_id="..tonumber(coree[1]))
local LinkGroup = JSON.decode(m)
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{{text = Get_Chat.title, url = LinkGroup.result.invite_link},},}}
return send(msg_chat_id, msg_id, "✦ Link Group : \n["..Get_Chat.title.. ']('..LinkGroup.result.invite_link..')', 'md', true, false, false, false, reply_markup)
end
end
end
if text == '/start' then
Redis:sadd(TeleGod..'Num:User:Pv',msg.sender.user_id)  
if not msg.ControllerBot then
if not Redis:get(TeleGod.."Start:Bot") then
local photo = LuaTele.getUserProfilePhotos(TeleGod)
local CmdStart = '*\n✦ أهلآ بك في بوت '..(Redis:get(TeleGod.."Name:Bot") or "تلي جود")..
'\n✦ اختصاص البوت حماية المجموعات'..
'\n✦ لتفعيل البوت عليك اتباع مايلي ...'..
'\n✦ اضف البوت الى مجموعتك'..
'\n✦ ارفعه ادمن مشرف'..
'\n✦ ارسل كلمة { تفعيل } ليتم تفعيل الجروب'..
'\n✦ مطور البوت ← {'..UserSudo..'}*'
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = 'نبذه🕸️', callback_data ='/zxhaut'},{text = 'ٓ♻️ حول ',  callback_data ='/lhaui'},
},
{
{text = '- اضف البوت لمجموعتك ♡,', url = 't.me/'..UserBot..'?startgroup=new'}, 
},
{
{text = '◜𝑠𝑜𝑢𝑟𝑐𝑒 𝑡𝑒𝑙𝑒𝑔𝑜𝑑◞', url = 't.me/'..chsource..''}, 
},
}
}
return LuaTele.sendPhoto(msg.chat_id, msg.id, photo.photos[1].sizes[#photo.photos[1].sizes].photo.remote.id,CmdStart,"md", true, nil, nil, nil, nil, nil, nil, nil, nil, reply_markup )
else
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = 'نبذه🕸️', callback_data ='/zxhaut'},{text = 'ٓ♻️ حول ',  callback_data ='/lhaui'},
},
{
{text = '- اضف البوت لمجموعتك ♡,', url = 't.me/'..UserBot..'?startgroup=new'}, 
},
{
{text = '◜𝑠𝑜𝑢𝑟𝑐𝑒 𝑡𝑒𝑙𝑒𝑔𝑜𝑑◞', url = 't.me/'..chsource..''}, 
},
}
}
return send(msg_chat_id,msg_id,Redis:get(TeleGod.."Start:Bot"),"md",false, false, false, false, reply_markup)
end
else
local reply_markup = LuaTele.replyMarkup{type = 'keyboard',resize = true,is_personal = true,
data = {
{
{text = 'مبرمج السورس ✦',type = 'text'},{text = 'قناه السورس  ✦',type = 'text'},
},
{
{text = 'تعيين قناه السورس ✦',type = 'text'},{text = 'تعيين مبرمج السورس ✦',type = 'text'},
},
{
{text = 'تعيين رمز السورس ✦',type = 'text'},{text = 'حذف رمز السورس ✦',type = 'text'},
},
{
{text = 'تفعيل البوت بصوره ✦',type = 'text'},{text = 'تعطيل البوت بصوره ✦',type = 'text'},
},
{
{text = 'تفعيل التواصل ✦',type = 'text'},{text = 'تعطيل التواصل ✦', type = 'text'},
},
{
{text = 'تفعيل الاشتراك الاجباري ✦',type = 'text'},{text = 'تعطيل الاشتراك الاجباري ✦', type = 'text'},
},
{
{text = 'تفعيل البوت الخدمي ✦',type = 'text'},{text = 'تعطيل البوت الخدمي ✦', type = 'text'},
},
{
{text = 'اذاعه للمجموعات ✦',type = 'text'},{text = 'اذاعه خاص ✦', type = 'text'},
},
{
{text = 'اذاعه بالتوجيه ✦',type = 'text'},{text = 'اذاعه بالتوجيه خاص ✦', type = 'text'},
},
{
{text = 'اذاعه بالتثبيت ✦',type = 'text'},
},
{
{text = 'المطورين الثانويين ✦',type = 'text'},{text = 'المطورين ✦',type = 'text'},{text = 'قائمه العام ✦', type = 'text'},
},
{
{text = 'مسح المطورين الثانويين ✦',type = 'text'},{text = 'مسح المطورين ✦',type = 'text'},{text = 'مسح قائمه العام ✦', type = 'text'},
},
{
{text = 'تغيير اسم البوت ✦',type = 'text'},{text = 'حذف اسم البوت ✦', type = 'text'},
},
{
{text = 'الاحصائيات ✦',type = 'text'},
},
{
{text = 'تعطيل الاذاعه ✦',type = 'text'},{text = 'تفعيل الاذاعه ✦',type = 'text'},
},
{
{text = 'تعطيل المغادره ✦',type = 'text'},{text = 'تفعيل المغادره ✦',type = 'text'},
},
{
{text = 'تغيير المطور الاساسي ✦',type = 'text'} 
},
{
{text = 'تغير كليشه المطور ✦',type = 'text'},{text = 'حذف كليشه المطور ✦', type = 'text'},
},
{
{text = 'تغيير كليشه ستارت ✦',type = 'text'},{text = 'حذف كليشه ستارت ✦', type = 'text'},
},
{
{text = 'تنظيف المجموعات ✦',type = 'text'},{text = 'تنظيف المشتركين ✦', type = 'text'},
},
{
{text = 'جلب النسخه الاحتياطيه ✦',type = 'text'},
},
{
{text = 'اضف رد عام ✦',type = 'text'},{text = 'حذف رد عام ✦', type = 'text'},
},
{
{text = 'الردود العامه ✦',type = 'text'},{text = 'مسح الردود العامه ✦', type = 'text'},
},
{
{text = 'تحديث الملفات ✦',type = 'text'},
},
{
{text = 'الغاء الامر ✦',type = 'text'},
},
}
}
return send(msg_chat_id,msg_id,'✦اهلا بك عزيزي المطور ', 'md', false, false, false, false, reply_markup)
end
end
if text == "تفعيل البوت بصوره ✦" then
  if not msg.ControllerBot then
  LuaTele.sendText(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
  end
  Redis:set(TeleGod.."name bot type : ", "photo")
  LuaTele.sendText(msg_chat_id,msg_id,'\n*✦ تم تفعيل رد البوت بصوره * ',"md",true)  
  end
if text == "تعطيل البوت بصوره ✦" then
if not msg.ControllerBot then
LuaTele.sendText(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end
Redis:set(TeleGod.."name bot type : ", "text")
LuaTele.sendText(msg_chat_id,msg_id,'\n*✦ تم تعطيل رد البوت بصوره * ',"md",true)  
end
if text == 'تنظيف المشتركين ✦' then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local list = Redis:smembers(TeleGod.."Num:User:Pv")   
local x = 0
for k,v in pairs(list) do  
local Get_Chat = LuaTele.getChat(v)
local ChatAction = LuaTele.sendChatAction(v,'Typing')
if ChatAction.luatele ~= "ok" then
x = x + 1
Redis:srem(TeleGod..'Num:User:Pv',v)
end
end
if x ~= 0 then
return send(msg_chat_id,msg_id,'*✦ العدد الكلي { '..#list..' }\n✦ تم العثور على { '..x..' } من المشتركين حاظرين البوت*',"md")
else
return send(msg_chat_id,msg_id,'*✦ العدد الكلي { '..#list..' }\n✦ لم يتم العثور على وهميين*',"md")
end
end
if text == 'تنظيف المجموعات ✦' then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local list = Redis:smembers(TeleGod.."ChekBotAdd")   
local x = 0
for k,v in pairs(list) do  
local Get_Chat = LuaTele.getChat(v)
if Get_Chat.id then
local statusMem = LuaTele.getChatMember(Get_Chat.id,TeleGod)
if statusMem.status.luatele == "chatMemberStatusMember" then
x = x + 1
send(Get_Chat.id,0,'*✦ البوت عضو في الجروب سوف اغادر ويمكنك تفعيلي مره اخره *',"md")
Redis:srem(TeleGod..'ChekBotAdd',Get_Chat.id)
local keys = Redis:keys(TeleGod..'*'..Get_Chat.id)
for i = 1, #keys do
Redis:del(keys[i])
end
LuaTele.leaveChat(Get_Chat.id)
end
else
x = x + 1
local keys = Redis:keys(TeleGod..'*'..v)
for i = 1, #keys do
Redis:del(keys[i])
end
Redis:srem(TeleGod..'ChekBotAdd',v)
LuaTele.leaveChat(v)
end
end
if x ~= 0 then
return send(msg_chat_id,msg_id,'*✦ العدد الكلي { '..#list..' } للمجموعات \n✦ تم العثور على { '..x..' } مجموعات البوت ليس ادمن \n✦ تم تعطيل الجروب ومغادره البوت من الوهمي *',"md")
else
return send(msg_chat_id,msg_id,'*✦ العدد الكلي { '..#list..' } للمجموعات \n✦ لا توجد مجموعات وهميه*',"md")
end
end
if text == 'تغيير كليشه ستارت ✦' then 
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:setex(TeleGod.."Change:Start:Bot"..msg.sender.user_id,300,true) 
return send(msg_chat_id,msg_id,"✦ ارسل لي كليشه Start الان ","md",true)  
end
if text == 'مبرمج السورس ✦' then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = 'مطور السورس', url = 't.me/'..chdevolper..''}, 
},
}
}
return send(msg_chat_id,msg_id,"مطور سورس تلي جود » @"..chdevolper.."","html",true, false, false, true, reply_markup)
end
if text == 'قناه السورس' then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '◜𝑠𝑜𝑢𝑟𝑐𝑒 𝑡𝑒𝑙𝑒𝑔𝑜𝑑◞', url = 't.me/'..chsource..''}, 
},
}
}
return send(msg_chat_id,msg_id,"◜𝑠𝑜𝑢𝑟𝑐𝑒 𝑡𝑒𝑙𝑒𝑔𝑜𝑑◞ » @"..chsource.."","html",true, false, false, true, reply_markup)
end
if text == 'حذف كليشه ستارت ✦' then 
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(TeleGod.."Start:Bot") 
return send(msg_chat_id,msg_id,"✦ تم حذف كليشه Start ","md",true)   
end
if text == 'تغيير اسم البوت ✦' then 
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:setex(TeleGod.."Change:Name:Bot"..msg.sender.user_id,300,true) 
return send(msg_chat_id,msg_id,"✦ ارسل لي الاسم الان ","md",true)  
end
if text == 'حذف اسم البوت ✦' then 
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(TeleGod.."Name:Bot") 
return send(msg_chat_id,msg_id,"✦ تم حذف اسم البوت ","md",true)   
end
if text and text:match("^تعين عدد الاعضاء (%d+)$") then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(TeleGod..'Num:Add:Bot',text:match("تعين عدد الاعضاء (%d+)$") ) 
send(msg_chat_id,msg_id,'*✦ تم تعيين عدد اعضاء تفعيل البوت اكثر من : '..text:match("تعين عدد الاعضاء (%d+)$")..' عضو *',"md",true)  
elseif text =='الاحصائيات ✦' then 
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
send(msg_chat_id,msg_id,'*✦عدد احصائيات البوت الكامله \n⩹━━━━✜ 𝗧𝗘𝗟𝗘𝗚𝗢𝗗 ✜━━━━⩺\n✦عدد المجموعات : '..(Redis:scard(TeleGod..'ChekBotAdd') or 0)..'\n✦عدد المشتركين : '..(Redis:scard(TeleGod..'Num:User:Pv') or 0)..'*',"md",true)  
end
if text == 'تغير كليشه المطور ✦' then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(TeleGod..'GetTexting:DevTeleGod'..msg_chat_id..':'..msg.sender.user_id,true)
return send(msg_chat_id,msg_id,'✦ ارسل لي الكليشه الان')
end
if text == 'حذف كليشه المطور ✦' then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(TeleGod..'Texting:DevTeleGod')
return send(msg_chat_id,msg_id,'✦ تم حذف كليشه المطور')
end
if text == 'اضف رد عام ✦' then 
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(TeleGod.."Set:Rd"..msg.sender.user_id..":"..msg_chat_id,true)
return send(msg_chat_id,msg_id,"✦ ارسل الان الكلمه لاضافتها في الردود العامه ","md",true)  
end
if text == 'حذف رد عام ✦' then 
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(TeleGod.."Set:On"..msg.sender.user_id..":"..msg_chat_id,true)
return send(msg_chat_id,msg_id,"✦ ارسل الان الكلمه لحذفها من الردود العامه","md",true)  
end
if text=='اذاعه خاص ✦' then 
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:setex(TeleGod.."Broadcasting:Users" .. msg_chat_id .. ":" .. msg.sender.user_id, 600, true) 
send(msg_chat_id,msg_id,[[
↯︙ارسل لي سواء كان 
❨ ملف ، ملصق ، متحركه ، صوره
 ، فيديو ، بصمه الفيديو ، بصمه ، صوت ، رساله ❩
⩹━━━━✜ 𝗧𝗘𝗟𝗘𝗚𝗢𝗗 ✜━━━━⩺
↯︙للخروج ارسل ( الغاء )
 ✓
]],"md",true)  
return false
end

if text=='اذاعه للمجموعات ✦' then 
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:setex(TeleGod.."Broadcasting:Groups" .. msg_chat_id .. ":" .. msg.sender.user_id, 600, true) 
send(msg_chat_id,msg_id,[[
↯︙ارسل لي سواء كان 
❨ ملف ، ملصق ، متحركه ، صوره
 ، فيديو ، بصمه الفيديو ، بصمه ، صوت ، رساله ❩
⩹━━━━✜ 𝗧𝗘𝗟𝗘𝗚𝗢𝗗 ✜━━━━⩺
↯︙للخروج ارسل ( الغاء )
 ✓
]],"md",true)  
return false
end

if text=="اذاعه بالتثبيت ✦" then 
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:setex(TeleGod.."Broadcasting:Groups:Pin" .. msg_chat_id .. ":" .. msg.sender.user_id, 600, true) 
send(msg_chat_id,msg_id,[[
↯︙ارسل لي سواء كان 
❨ ملف ، ملصق ، متحركه ، صوره
 ، فيديو ، بصمه الفيديو ، بصمه ، صوت ، رساله ❩
⩹━━━━✜ 𝗧𝗘𝗟𝗘𝗚𝗢𝗗 ✜━━━━⩺
↯︙للخروج ارسل ( الغاء )
 ✓
]],"md",true)  
return false
end

if text=="اذاعه بالتوجيه ✦" then 
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:setex(TeleGod.."Broadcasting:Groups:Fwd" .. msg_chat_id .. ":" .. msg.sender.user_id, 600, true) 
send(msg_chat_id,msg_id,"✦ ارسل لي التوجيه الان\n✦ليتم نشره في المجموعات","md",true)  
return false
end

if text=='اذاعه بالتوجيه خاص ✦' then 
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:setex(TeleGod.."Broadcasting:Users:Fwd" .. msg_chat_id .. ":" .. msg.sender.user_id, 600, true) 
send(msg_chat_id,msg_id,"✦ ارسل لي التوجيه الان\n✦ليتم نشره الى المشتركين","md",true)  
return false
end

if text == ("الردود العامه ✦") then 
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local list = Redis:smembers(TeleGod.."List:Rd:Sudo")
text = "\n✦ قائمة الردود العامه \n⩹━━━━✜ 𝗧𝗘𝗟𝗘𝗚𝗢𝗗 ✜━━━━⩺\n"
for k,v in pairs(list) do
if Redis:get(TeleGod.."Add:Rd:Sudo:Gif"..v) then
db = "متحركه ✦"
elseif Redis:get(TeleGod.."Add:Rd:Sudo:vico"..v) then
db = "بصمه ✦"
elseif Redis:get(TeleGod.."Add:Rd:Sudo:stekr"..v) then
db = "ملصق ✦"
elseif Redis:get(TeleGod.."Add:Rd:Sudo:Text"..v) then
db = "رساله ✦"
elseif Redis:get(TeleGod.."Add:Rd:Sudo:Photo"..v) then
db = "صوره ✦"
elseif Redis:get(TeleGod.."Add:Rd:Sudo:Video"..v) then
db = "فيديو ✦"
elseif Redis:get(TeleGod.."Add:Rd:Sudo:File"..v) then
db = "ملف ✦"
elseif Redis:get(TeleGod.."Add:Rd:Sudo:Audio"..v) then
db = "اغنيه ✦"
elseif Redis:get(TeleGod.."Add:Rd:Sudo:video_note"..v) then
db = "بصمه فيديو ✦"
end
text = text..""..k.." » {"..v.."} » {"..db.."}\n"
end
if #list == 0 then
text = "✦ لا توجد ردود للمطور"
end
return send(msg_chat_id,msg_id,"["..text.."]","md",true)  
end
if text == ("مسح الردود العامه ✦") then 
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local list = Redis:smembers(TeleGod.."List:Rd:Sudo")
for k,v in pairs(list) do
Redis:del(TeleGod.."Add:Rd:Sudo:Gif"..v)   
Redis:del(TeleGod.."Add:Rd:Sudo:vico"..v)   
Redis:del(TeleGod.."Add:Rd:Sudo:stekr"..v)     
Redis:del(TeleGod.."Add:Rd:Sudo:Text"..v)   
Redis:del(TeleGod.."Add:Rd:Sudo:Photo"..v)
Redis:del(TeleGod.."Add:Rd:Sudo:Photoc"..v)
Redis:del(TeleGod.."Add:Rd:Sudo:Video"..v)
Redis:del(TeleGod.."Add:Rd:Sudo:Videoc"..v)
Redis:del(TeleGod.."Add:Rd:Sudo:File"..v)
Redis:del(TeleGod.."Add:Rd:Sudo:Audio"..v)
Redis:del(TeleGod.."Add:Rd:Sudo:Audioc"..v)
Redis:del(TeleGod.."Add:Rd:Sudo:video_note"..v)
Redis:del(TeleGod.."List:Rd:Sudo")
end
return send(msg_chat_id,msg_id,"✦ تم حذف الردود العامه","md",true)  
end
if text == 'مسح المطورين ✦' then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(1)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(TeleGod.."Dev:Groups") 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"✦ لا يوجد مطورين حاليا , ","md",true)  
end
Redis:del(TeleGod.."Dev:Groups") 
return send(msg_chat_id,msg_id,"*✦ تم مسح {"..#Info_Members.."} من المطورين *","md",true)
end
if text == 'مسح المطورين الثانويين ✦' then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(TeleGod.."Devss:Groups") 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"✦ لا يوجد مطورين حاليا , ","md",true)  
end
Redis:del(TeleGod.."Devss:Groups") 
return send(msg_chat_id,msg_id,"*✦ تم مسح {"..#Info_Members.."} من المطورين *","md",true)
end
if text == 'مسح قائمه العام ✦' then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(TeleGod.."BanAll:Groups") 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"✦ لا يوجد محظورين عام حاليا , ","md",true)  
end
Redis:del(TeleGod.."BanAll:Groups") 
return send(msg_chat_id,msg_id,"*✦ تم مسح {"..#Info_Members.."} من المحظورين عام *","md",true)
end
if text == 'تعطيل البوت الخدمي ✦' then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(TeleGod.."BotFree") 
return send(msg_chat_id,msg_id,"✦ تم تعطيل البوت الخدمي ","md",true)
end
if text == 'تعطيل التواصل ✦' then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:del(TeleGod.."TwaslBot") 
return send(msg_chat_id,msg_id,"✦ تم تعطيل التواصل داخل البوت ","md",true)
end
if text == 'تفعيل البوت الخدمي ✦' then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(TeleGod.."BotFree",true) 
return send(msg_chat_id,msg_id,"✦ تم تفعيل البوت الخدمي ","md",true)
end
if text == "تعطيل الاشتراك الاجباري لكل الاعضاء ✦" then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end
if not Redis:get(TeleGod.."chmembers") then
return send(msg_chat_id,msg_id,'\n*✦ الامر معطل بالفعل* ',"md",true)  
end
Redis:del(TeleGod.."chmembers")
send(msg_chat_id,msg_id,'\n*✦ تم تعطيل وضع الاشتراك الاجباري لكل الاعضاء اصبح عند استخدام اوامر البوت فقط* ',"md",true)  
end
if text == "تفعيل الاشتراك الاجباري لكل الاعضاء ✦" then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end
if not Redis:get(TeleGod.."chfalse") then
return send(msg_chat_id,msg_id,'\n*✦ عذرا عليك تعيين قناه للاشتراك الاجباري اولا* ',"md",true)  
end
Redis:set(TeleGod.."chmembers","on")
send(msg_chat_id,msg_id,'\n*✦ تم تفعيل وضع الاشتراك لكل الاعضاء* ',"md",true)  
end
if text == "تفعيل الاشتراك الاجباري ✦" then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end
Redis:set(TeleGod.."ch:addd"..msg.sender.user_id,"on")
send(msg_chat_id,msg_id,'✦ ارسل الان معرف القناه ',"md",true)  
end
if text == "تعطيل الاشتراك الاجباري ✦" then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end
Redis:del(TeleGod.."ch:admin")
Redis:del(TeleGod.."chfalse")
send(msg_chat_id,msg_id,'✦ تم حذف القناه ',"md",true)  
end
if Redis:get(TeleGod.."set:chs"..msg.sender.user_id) then
if text then
if text == "الغاء" then
Redis:del(TeleGod.."set:chs"..msg.sender.user_id)
return send(msg_chat_id,msg_id,'تم الغاء الامر بنجاح ',"md",true)  
end
if text:match("^@(.*)$") then
local ch = text:match("^@(.*)$")
Redis:set(TeleGod.."chsource",ch)
Redis:del(TeleGod.."set:chs"..msg.sender.user_id)
send(msg_chat_id,msg_id,'تم حفظ معرف قناه السورس ',"md",true)  
dofile('TeleGod.lua')  
else
send(msg_chat_id,msg_id,'المعرف خطأ ',"md",true)  
end
end
end
if text == "تعيين قناه السورس ✦" then 
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end
Redis:set(TeleGod.."set:chs"..msg.sender.user_id,true)
return send(msg_chat_id,msg_id,'ارسل معرف القناه الان',"md",true)  
end
if Redis:get(TeleGod.."set:rmz"..msg.sender.user_id) then
if text then
if text == "الغاء" then
Redis:del(TeleGod.."set:rmz"..msg.sender.user_id)
return send(msg_chat_id,msg_id,'تم الغاء الامر بنجاح ',"md",true)  
end
Redis:set(TeleGod..'rmzsource',text)
Redis:del(TeleGod.."set:rmz"..msg.sender.user_id)
send(msg_chat_id,msg_id,'تم حفظ رمز السورس ',"md",true)  
dofile('TeleGod.lua')  
end
end
if text == "تعيين رمز السورس ✦" then 
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end
Redis:set(TeleGod.."set:rmz"..msg.sender.user_id,true)
return send(msg_chat_id,msg_id,'ارسل رمز بدل من { ✦ }',"md",true)  
end
if text == "حذف رمز السورس ✦" then 
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end
Redis:set(TeleGod.."rmzsource","✦")
return send(msg_chat_id,msg_id,'تم ارجاع رمز السورس الي  { ✦ }',"md",true)  
end
if Redis:get(TeleGod.."set:devs"..msg.sender.user_id) then
if text then
if text == "الغاء" then
Redis:del(TeleGod.."set:devs"..msg.sender.user_id)
return send(msg_chat_id,msg_id,'تم الغاء الامر بنجاح ',"md",true)  
end
if text:match("^@(.*)$") then
local ch = text:match("^@(.*)$")
Redis:set(TeleGod.."chdevolper",ch)
Redis:del(TeleGod.."set:devs"..msg.sender.user_id)
send(msg_chat_id,msg_id,'تم حفظ معرف مطور السورس ',"md",true)  
dofile('TeleGod.lua')  
else
send(msg_chat_id,msg_id,'المعرف خطأ ',"md",true)  
end
end
end
if text == "تعيين مبرمج السورس ✦" then 
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end
Redis:set(TeleGod.."set:devs"..msg.sender.user_id,true)
return send(msg_chat_id,msg_id,'ارسل معرف المطور الان',"md",true)  
end
if text == 'تفعيل التواصل ✦' then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
Redis:set(TeleGod.."TwaslBot",true) 
return send(msg_chat_id,msg_id,"✦ تم تفعيل التواصل داخل البوت ","md",true)
end
if text == 'قائمه العام ✦' then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(TeleGod.."BanAll:Groups") 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"✦ لا يوجد محظورين عام حاليا , ","md",true)  
end
ListMembers = '\n*✦ قائمه المحظورين عام  \n ⩹━━━━✜ 𝗧𝗘𝗟𝗘𝗚𝗢𝗗 ✜━━━━⩺*\n'
for k, v in pairs(Info_Members) do
local UserInfo = LuaTele.getUser(v)

if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers.."*"..k.." - *[@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {{{text = '- مسح المحظورين عام', data = msg.sender.user_id..'/BanAll'},},}}
return send(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text == 'المطورين ✦' then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(TeleGod.."Dev:Groups") 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"✦ لا يوجد مطورين حاليا , ","md",true)  
end
ListMembers = '\n*✦ قائمه مطورين البوت \n ⩹━━━━✜ 𝗧𝗘𝗟𝗘𝗚𝗢𝗗 ✜━━━━⩺*\n'
for k, v in pairs(Info_Members) do
local UserInfo = LuaTele.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers.."*"..k.." - *[@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {{{text = '- مسح المطورين', data = msg.sender.user_id..'/Dev'},},}}
return send(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if text == 'المطورين الثانويين ✦' then
if not msg.ControllerBot then 
return send(msg_chat_id,msg_id,'\n*✦ هذا الامر يخص  '..Controller_Num(2)..' * ',"md",true)  
end
if ChannelJoin(msg) == false then
local chinfo = Redis:get(TeleGod.."ch:admin")
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = 'اضغط للاشتراك', url = chinfo}, },}}
return send(msg.chat_id,msg.id,'*\n✦ عليك الاشتراك في قناة البوت لاستخذام الاوامر*',"md",false, false, false, false, reply_markup)
end
local Info_Members = Redis:smembers(TeleGod.."Devss:Groups") 
if #Info_Members == 0 then
return send(msg_chat_id,msg_id,"✦ لا يوجد مطورين حاليا , ","md",true)  
end
ListMembers = '\n*✦ قائمه مطورين البوت \n ⩹━━━━✜ 𝗧𝗘𝗟𝗘𝗚𝗢𝗗 ✜━━━━⩺*\n'
for k, v in pairs(Info_Members) do
local UserInfo = LuaTele.getUser(v)
if UserInfo and UserInfo.username and UserInfo.username ~= "" then
ListMembers = ListMembers.."*"..k.." - *[@"..UserInfo.username.."](tg://user?id="..v..")\n"
else
ListMembers = ListMembers.."*"..k.." -* ["..v.."](tg://user?id="..v..")\n"
end
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {{{text = '- مسح المطورين', data = msg.sender.user_id..'/Dev'},},}}
return send(msg_chat_id, msg_id, ListMembers, 'md', false, false, false, false, reply_markup)
end
if not msg.ControllerBot then
if Redis:get(TeleGod.."TwaslBot") and not Redis:sismember(TeleGod.."BaN:In:Tuasl",msg.sender.user_id) then
local ListGet = {Sudo_Id,msg.sender.user_id}
local IdSudo = LuaTele.getChat(ListGet[1]).id
local IdUser = LuaTele.getChat(ListGet[2]).id
local FedMsg = LuaTele.sendForwarded(IdSudo, 0, IdUser, msg_id)
Redis:setex(TeleGod.."Twasl:UserId"..msg.date,172800,IdUser)
if FedMsg.content.luatele == "messageSticker" then
send(IdSudo,0,Reply_Status(IdUser,'✦قام بارسال الملصق').Reply,"md",true)  
end
return send(IdUser,msg_id,Reply_Status(IdUser,'✦ تم ارسال رسالتك الى المطور').Reply,"md",true)  
end
else 
if msg.reply_to_message_id ~= 0 then
local Message_Get = LuaTele.getMessage(msg_chat_id, msg.reply_to_message_id)
if Message_Get.forward_info then
local Info_User = Redis:get(TeleGod.."Twasl:UserId"..Message_Get.forward_info.date) or 46899864
if text == 'حظر' then
Redis:sadd(TeleGod..'BaN:In:Tuasl',Info_User)  
return send(msg_chat_id,msg_id,Reply_Status(Info_User,'✦ تم حظره من تواصل البوت ').Reply,"md",true)  
end 
if text =='الغاء الحظر' or text =='الغاء حظر' then
Redis:srem(TeleGod..'BaN:In:Tuasl',Info_User)  
return send(msg_chat_id,msg_id,Reply_Status(Info_User,'✦ تم الغاء حظره من تواصل البوت ').Reply,"md",true)  
end 
local ChatAction = LuaTele.sendChatAction(Info_User,'Typing')
if not Info_User or ChatAction.message == "USER_IS_BLOCKED" then
send(msg_chat_id,msg_id,Reply_Status(Info_User,'✦قام بحظر البوت لا استطيع ارسال رسالتك ').Reply,"md",true)  
end
if msg.content.video_note then
LuaTele.sendVideoNote(Info_User, 0, msg.content.video_note.video.remote.id)
elseif msg.content.photo then
if msg.content.photo.sizes[1].photo.remote.id then
idPhoto = msg.content.photo.sizes[1].photo.remote.id
elseif msg.content.photo.sizes[2].photo.remote.id then
idPhoto = msg.content.photo.sizes[2].photo.remote.id
elseif msg.content.photo.sizes[3].photo.remote.id then
idPhoto = msg.content.photo.sizes[3].photo.remote.id
end
LuaTele.sendPhoto(Info_User, 0, idPhoto,'')
elseif msg.content.sticker then 
LuaTele.sendSticker(Info_User, 0, msg.content.sticker.sticker.remote.id)
elseif msg.content.voice_note then 
LuaTele.sendVoiceNote(Info_User, 0, msg.content.voice_note.voice.remote.id, '', 'md')
elseif msg.content.video then 
LuaTele.sendVideo(Info_User, 0, msg.content.video.video.remote.id, '', "md")
elseif msg.content.animation then 
LuaTele.sendAnimation(Info_User,0, msg.content.animation.animation.remote.id, '', 'md')
elseif msg.content.document then
LuaTele.sendDocument(Info_User, 0, msg.content.document.document.remote.id, '', 'md')
elseif msg.content.audio then
LuaTele.sendAudio(Info_User, 0, msg.content.audio.audio.remote.id, '', "md") 
elseif text then
send(Info_User,0,text,"md",true)
end 
send(msg_chat_id,msg_id,Reply_Status(Info_User,'✦ تم ارسال رسالتك اليه ').Reply,"md",true)  
end
end
end 
end --UserBot
end -- File_Bot_Run

function CallBackLua(data)

if data and data.luatele and data.luatele == "updateNewInlineQuery" then

local Text = data.query 
if Text == '' then
local input_message_content = {message_text = " ٭ اهلا بك\n ٭ لارسال الهمسه اكتب يوزر البوت + الهمسه + يوزر العضو اللي هتعمله همسه \n ٭ مثال  @Sheyoubot هلا @BK_ZT"}	
local resuult = {{
type = 'article',
id = math.random(1,64),
title = 'اضغط هنا لمعرفه كيفيه ارسال الهمسه',
input_message_content = input_message_content,
reply_markup = {
inline_keyboard ={
{{text ="ch", url= "https://t.me/SR_TeleGod"}},
}
},
},
}
https.request("https://api.telegram.org/bot"..Token..'/answerInlineQuery?inline_query_id='..data.id..'&switch_pm_text=@BK_ZT&switch_pm_parameter=start&results='..JSON.encode(resuult))
end
if Text == "ترجمه" or Text == "ترجمة" then
local input_message_content = {message_text = "٭ لاستخدام الترجمه انلاين اكتب يوزر البوت + en او ar علي حسب لغتك وبعد كدا الكلمه \n٭ مثال : \n٭ [@Sheyoubot] en احبك ", parse_mode = 'Markdown'}	
local resuult = {{
type = 'article',
id = math.random(1,64),
title = "اضغط هنا لمعرفه كيفيه استخدام الترجمه",
input_message_content = input_message_content,
reply_markup = {
inline_keyboard ={
{{text ="◜𝑠𝑜𝑢𝑟𝑐𝑒 𝑡𝑒𝑙𝑒𝑔𝑜𝑑◞", url= "t.me/"..chsource..""}},
}
},
},
}
https.request("https://api.telegram.org/bot"..Token..'/answerInlineQuery?inline_query_id='..data.id..'&switch_pm_text=@BK_ZT&switch_pm_parameter=start&results='..JSON.encode(resuult))
end
if Text and Text:match("en (.*)") or Text:match("En (.*)") then
local tr = Text:match("en (.*)") or Text:match("En (.*)")
local gk = http.request('http://167.71.14.2/google.php?from=auto&to=en&text='..URL.escape(tr)..'')
local br = JSON.decode(gk)
local input_message_content = {message_text = "٭ `"..br.."`", parse_mode = 'Markdown'}	
local resuult = {{
type = 'article',
id = math.random(1,64),
title = br,
input_message_content = input_message_content,
reply_markup = {
inline_keyboard ={
{{text ="◜𝑠𝑜𝑢𝑟𝑐𝑒 𝑡𝑒𝑙𝑒𝑔𝑜𝑑◞", url= "t.me/"..chsource..""}},
}
},
},
}
https.request("https://api.telegram.org/bot"..Token..'/answerInlineQuery?inline_query_id='..data.id..'&switch_pm_text=ترجمه-انجلش&switch_pm_parameter=start&results='..JSON.encode(resuult))
end
if Text and Text:match("ar (.*)") or Text:match("En (.*)") then
local tr = Text:match("ar (.*)") or Text:match("En (.*)")
local gk = http.request('http://167.71.14.2/google.php?from=auto&to=ar&text='..URL.escape(tr)..'')
local br = JSON.decode(gk)
local input_message_content = {message_text = "٭ `"..br.."` ", parse_mode = 'Markdown'}	
local resuult = {{
type = 'article',
id = math.random(1,64),
title = br,
input_message_content = input_message_content,
reply_markup = {
inline_keyboard ={
{{text ="◜𝑠𝑜𝑢𝑟𝑐𝑒 𝑡𝑒𝑙𝑒𝑔𝑜𝑑◞", url= "t.me/"..chsource..""}},
}
},
},
}
https.request("https://api.telegram.org/bot"..Token..'/answerInlineQuery?inline_query_id='..data.id..'&switch_pm_text=ترجمه-عربي&switch_pm_parameter=start&results='..JSON.encode(resuult))
end
if Text and Text:match("(.*)@(.*)") then
local hm = {string.match(Text,"(.*)@(.*)")}
local user = hm[2]
local hms = hm[1]
UserId_Info = LuaTele.searchPublicChat(user)
local idd = UserId_Info.id
local key = math.random(1,999999)
Redis:set(idd..key.."hms",hms)
local us = LuaTele.getUser(idd)
local name = us.first_name
local input_message_content = {message_text = "٭ هذه همسه سريه الي ["..name.."](tg://user?id="..idd..")\n ٭ هو فقط يستطيع رؤيتها ", parse_mode = 'Markdown'}	
local resuult = {{
type = 'article',
id = math.random(1,64),
title = 'هذه همسه سريه الي '..name..'',
input_message_content = input_message_content,
reply_markup = {
inline_keyboard ={
{{text ="اضغط هنا لرؤيتها", callback_data = idd.."hmsaa"..data.sender_user_id.."/"..key}},
}
},
},
}
https.request("https://api.telegram.org/bot"..Token..'/answerInlineQuery?inline_query_id='..data.id..'&switch_pm_text=اضغط لارسال الهمسه&switch_pm_parameter=start&results='..JSON.encode(resuult))
end
end
if data and data.luatele and data.luatele == "updateNewInlineCallbackQuery" then

local Text = LuaTele.base64_decode(data.payload.data)
if Text and Text:match('(.*)hmsaa(.*)/(.*)')  then
local mk = {string.match(Text,"(.*)hmsaa(.*)/(.*)")}
local hms = Redis:get(mk[1]..mk[3].."hms")
if tonumber(mk[1]) == tonumber(data.sender_user_id) or tonumber(mk[2]) == tonumber(data.sender_user_id) then
https.request("https://api.telegram.org/bot"..Token.."/answerCallbackQuery?callback_query_id="..data.id.."&text="..URL.escape(hms).."&show_alert=true")
end
if tonumber(mk[1]) ~= tonumber(data.sender_user_id) or tonumber(mk[2]) ~= tonumber(data.sender_user_id) then
https.request("https://api.telegram.org/bot"..Token.."/answerCallbackQuery?callback_query_id="..data.id.."&text="..URL.escape("الهمسه ليست لك").."&show_alert=true")
end
end
end
if data and data.luatele and data.luatele == "updateSupergroup" then
local Get_Chat = LuaTele.getChat('-100'..data.supergroup.id)
if data.supergroup.status.luatele == "chatMemberStatusBanned" then
Redis:srem(TeleGod.."ChekBotAdd",'-100'..data.supergroup.id)
local keys = Redis:keys(TeleGod..'*'..'-100'..data.supergroup.id..'*')
Redis:del(TeleGod.."List:Manager"..'-100'..data.supergroup.id)
Redis:del(TeleGod.."Command:List:Group"..'-100'..data.supergroup.id)
for i = 1, #keys do 
Redis:del(keys[i])
end
return send(Sudo_Id,0,'*\n✦ تم طرد البوت من جروب جديده \n✦ اسم الجروب : '..Get_Chat.title..'\n✦ ايدي الجروب :*`-100'..data.supergroup.id..'`\n✦ تم مسح جميع البيانات المتعلقه بالجروب',"md")
end
elseif data and data.luatele and data.luatele == "updateMessageSendSucceeded" then
local msg = data.message
local Chat = msg.chat_id
if msg.content.text then
text = msg.content.text.text
end

if msg.content.video_note then
if msg.content.video_note.video.remote.id == Redis:get(TeleGod.."PinMsegees:"..msg.chat_id) then
LuaTele.pinChatMessage(msg.chat_id,msg.id,true)
Redis:del(TeleGod.."PinMsegees:"..msg.chat_id)
end
elseif msg.content.photo then
if msg.content.photo.sizes[1].photo.remote.id then
idPhoto = msg.content.photo.sizes[1].photo.remote.id
elseif msg.content.photo.sizes[2].photo.remote.id then
idPhoto = msg.content.photo.sizes[2].photo.remote.id
elseif msg.content.photo.sizes[3].photo.remote.id then
idPhoto = msg.content.photo.sizes[3].photo.remote.id
end
if idPhoto == Redis:get(TeleGod.."PinMsegees:"..msg.chat_id) then
LuaTele.pinChatMessage(msg.chat_id,msg.id,true)
Redis:del(TeleGod.."PinMsegees:"..msg.chat_id)
end
elseif msg.content.sticker then 
if msg.content.sticker.sticker.remote.id == Redis:get(TeleGod.."PinMsegees:"..msg.chat_id) then
LuaTele.pinChatMessage(msg.chat_id,msg.id,true)
Redis:del(TeleGod.."PinMsegees:"..msg.chat_id)
end
elseif msg.content.voice_note then 
if msg.content.voice_note.voice.remote.id == Redis:get(TeleGod.."PinMsegees:"..msg.chat_id) then
LuaTele.pinChatMessage(msg.chat_id,msg.id,true)
Redis:del(TeleGod.."PinMsegees:"..msg.chat_id)
end
elseif msg.content.video then 
if msg.content.video.video.remote.id == Redis:get(TeleGod.."PinMsegees:"..msg.chat_id) then
LuaTele.pinChatMessage(msg.chat_id,msg.id,true)
Redis:del(TeleGod.."PinMsegees:"..msg.chat_id)
end
elseif msg.content.animation then 
if msg.content.animation.animation.remote.id ==  Redis:get(TeleGod.."PinMsegees:"..msg.chat_id) then
LuaTele.pinChatMessage(msg.chat_id,msg.id,true)
Redis:del(TeleGod.."PinMsegees:"..msg.chat_id)
end
elseif msg.content.document then
if msg.content.document.document.remote.id == Redis:get(TeleGod.."PinMsegees:"..msg.chat_id) then
LuaTele.pinChatMessage(msg.chat_id,msg.id,true)
Redis:del(TeleGod.."PinMsegees:"..msg.chat_id)
end
elseif msg.content.audio then
if msg.content.audio.audio.remote.id == Redis:get(TeleGod.."PinMsegees:"..msg.chat_id) then
LuaTele.pinChatMessage(msg.chat_id,msg.id,true)
Redis:del(TeleGod.."PinMsegees:"..msg.chat_id)
end
elseif text then
if text == Redis:get(TeleGod.."PinMsegees:"..msg.chat_id) then
LuaTele.pinChatMessage(msg.chat_id,msg.id,true)
Redis:del(TeleGod.."PinMsegees:"..msg.chat_id)
end
end
elseif data and data.luatele and data.luatele == "updateNewMessage" then
if data.message.content.luatele == "messageChatDeleteMember" or data.message.content.luatele == "messageChatAddMembers" or data.message.content.luatele == "messagePinMessage" or data.message.content.luatele == "messageChatChangeTitle" or data.message.content.luatele == "messageChatJoinByLink" then
if Redis:get(TeleGod.."Lock:tagservr"..data.message.chat_id) then
LuaTele.deleteMessages(data.message.chat_id,{[1]= data.message.id})
end
end 
if tonumber(data.message.sender.user_id) == tonumber(TeleGod) then
return false
end
if data.message.content.luatele == "messageChatJoinByLink" and Redis:get(TeleGod..'Status:joinet'..data.message.chat_id) == 'true' then
    local reply_markup = LuaTele.replyMarkup{
    type = 'inline',
    data = {
    {
    {text = ' انا لست بوت ', data = data.message.sender.user_id..'/UnKed'},
    },
    }
    } 
    LuaTele.setChatMemberStatus(data.message.chat_id,data.message.sender.user_id,'restricted',{1,0,0,0,0,0,0,0,0})
    return send(data.message.chat_id, data.message.id, '✦ عليك اختيار انا لست بوت لتخطي نظام التحقق', 'md',false, false, false, false, reply_markup)
    end
File_Bot_Run(data.message,data.message)
elseif data and data.luatele and data.luatele == "updateMessageEdited" then
-- data.chat_id -- data.message_id
local Message_Edit = LuaTele.getMessage(data.chat_id, data.message_id)
if Message_Edit.sender.user_id == TeleGod then
print('This is Edit for Bot')
return false
end
File_Bot_Run(Message_Edit,Message_Edit)
Redis:incr(TeleGod..'Num:Message:Edit'..data.chat_id..Message_Edit.sender.user_id)
if Message_Edit.content.luatele == "messageContact" or Message_Edit.content.luatele == "messageVideoNote" or Message_Edit.content.luatele == "messageDocument" or Message_Edit.content.luatele == "messageAudio" or Message_Edit.content.luatele == "messageVideo" or Message_Edit.content.luatele == "messageVoiceNote" or Message_Edit.content.luatele == "messageAnimation" or Message_Edit.content.luatele == "messagePhoto" then
if Redis:get(TeleGod.."Lock:edit"..data.chat_id) then
LuaTele.deleteMessages(data.chat_id,{[1]= data.message_id})
end
end
elseif data and data.luatele and data.luatele == "updateNewCallbackQuery" then
-- data.chat_id
Dataa = data.payload.data
-- data.sender_user_id
Text = LuaTele.base64_decode(data.payload.data)
IdUser = data.sender_user_id
ChatId = data.chat_id
Msg_id = data.message_id
if Text and Text:match('(%d+)/UnKed') then
    local UserId = Text:match('(%d+)/UnKed')
    if tonumber(UserId) ~= tonumber(IdUser) then
    return LuaTele.answerCallbackQuery(data.id, "✦ الامر لا يخصك", true)
    end
    LuaTele.setChatMemberStatus(ChatId,UserId,'restricted',{1,1,1,1,1,1,1,1})
    return edit(ChatId,Msg_id,"✦ تم التحقق منك اجابتك صحيحه يمكنك الدردشه الان", 'md', false)
    end

if Text and Text:match('/Mahibes(%d+)') then
local GetMahibes = Text:match('/Mahibes(%d+)') 
local NumMahibes = math.random(1,6)
if tonumber(GetMahibes) == tonumber(NumMahibes) then
Redis:incrby(TeleGod.."Num:Add:Games"..ChatId..IdUser, 1)  
MahibesText = '*✦ الف مبروك حظك حلو اليوم\n✦ فزت ويانه وطلعت المحيبس بل عظمه رقم {'..NumMahibes..'}*'
else
MahibesText = '*✦ للاسف لقد خسرت المحيبس بالعظمه رقم {'..NumMahibes..'}\n✦ جرب حضك ويانه مره اخره*'
end
if NumMahibes == 1 then
Mahibes1 = '🤚' else Mahibes1 = '👊'
end
if NumMahibes == 2 then
Mahibes2 = '🤚' else Mahibes2 = '👊'
end
if NumMahibes == 3 then
Mahibes3 = '🤚' else Mahibes3 = '👊' 
end
if NumMahibes == 4 then
Mahibes4 = '🤚' else Mahibes4 = '👊'
end
if NumMahibes == 5 then
Mahibes5 = '🤚' else Mahibes5 = '👊'
end
if NumMahibes == 6 then
Mahibes6 = '🤚' else Mahibes6 = '👊'
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '𝟏 » { '..Mahibes1..' }', data = '/*'}, {text = '𝟐 » { '..Mahibes2..' }', data = '/*'}, 
},
{
{text = '𝟑 » { '..Mahibes3..' }', data = '/*'}, {text = '𝟒 » { '..Mahibes4..' }', data = '/*'}, 
},
{
{text = '𝟓 » { '..Mahibes5..' }', data = '/*'}, {text = '𝟔 » { '..Mahibes6..' }', data = '/*'}, 
},
{
{text = '{ اللعب مره اخرى }', data = '/MahibesAgane'},
},
}
}
return edit(ChatId,Msg_id,MahibesText, 'md', true, false, reply_markup)
end
if Text == "/MahibesAgane" then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '𝟏 » { 👊 }', data = '/Mahibes1'}, {text = '𝟐 » { 👊 }', data = '/Mahibes2'}, 
},
{
{text = '𝟑 » { 👊 }', data = '/Mahibes3'}, {text = '𝟒 » { 👊 }', data = '/Mahibes4'}, 
},
{
{text = '𝟓 » { 👊 }', data = '/Mahibes5'}, {text = '𝟔 » { 👊 }', data = '/Mahibes6'}, 
},
}
}
local TextMahibesAgane = [[*
✦ لعبة المحيبس هي لعبة الحظ 
✦ جرب حظك ويه البوت واتونس 
✦ كل ما عليك هوا الضغط على احدى العضمات في الازرار
*]]
return edit(ChatId,Msg_id,TextMahibesAgane, 'md', true, false, reply_markup)
end
if Text and Text:match('(.*)/yes_z/(.*)') then
  local anubis = {Text:match('(.*)/yes_z/(.*)')}
  local zwga_id = anubis[1]
  local zwg_id = anubis[2]
  if tonumber(zwga_id) == tonumber(IdUser) then
    local zwga_name = LuaTele.getUser(zwga_id).first_name
    local zwg_name = LuaTele.getUser(zwg_id).first_name
    Redis:set(TeleGod..ChatId..zwga_id.."mtzwga:", zwg_id)
    Redis:set(TeleGod..ChatId..zwg_id.."mtzwga:", zwga_id)
    return LuaTele.editMessageText(ChatId, Msg_id, "باركو لاختكم ["..zwga_name.."](tg://user?id="..zwga_id..")\nوافقت تتجوز المحروص ["..zwg_name.."](tg://user?id="..zwg_id..")","md",false)
  end
end
if Text and Text:match('(.*)/no_z/(.*)') then
  local anubis = {Text:match('(.*)/no_z/(.*)')}
  local zwga_id = anubis[1]
  local zwg_id = anubis[2]
  if tonumber(zwga_id) == tonumber(IdUser) then
    return LuaTele.editMessageText(ChatId, Msg_id, "امال هتتجوزي امتي يا موكوسه ؟؟","md",false)
  end
end
if Text and Text:match('(%d+)/zeng') then
  local UserId = Text:match('(%d+)/zeng')
  if tonumber(UserId) == tonumber(IdUser) then
    Redis:set(TeleGod..ChatId..IdUser.."zkrf:", "zeng")
    LuaTele.editMessageText(ChatId, Msg_id, "▾ 𝙎𝙀𝙉𝘿 𝙐𝙍 𝙉𝘼𝙈𝙀 🎀..! \n \n✴ اࢪسل الاسم لتتم زخࢪفتھـۃ الان 🎀..!", "md",false)
  end
  end
if Text and Text:match('(.*)/a(.*)') then
    local anubis = {Text:match('(.*)/a(.*)')}
    local UserId = anubis[1]
    local z_num = anubis[2]
    local z_text = Redis:get(TeleGod..ChatId..IdUser.."zkrf:text")
    Redis:set(TeleGod..ChatId..IdUser.."zkrf:num", z_num)
    if tonumber(UserId) == tonumber(IdUser) then
      local api = https.request("https://ayad-12.xyz/anubis/zkhrfa.php?text="..URL.escape(z_text))
      local zkrf = JSON.decode(api)
      local zk = zkrf['anubis'][z_num]
      local reply_markup = LuaTele.replyMarkup{
        type = 'inline',
        data = {
        {{text = zk , data = IdUser.."/b1"}},
        {{text = "𓂄𓆩 "..zk.." 𓆪𓂁", data = IdUser.."/b2"}},
        {{text = "𓆩⸤"..zk.."⸥𓆪", data = IdUser.."/b3"}},
        {{text = "𓆩"..zk.."𓆪", data = IdUser.."/b4"}},
        {{text = "⌁ "..zk.." ’♥ " , data = IdUser.."/b5"}},
        {{text = "ꔷ"..zk.." 🧸💕 ˝♥›." , data = IdUser.."/b6"}},
        {{text = "➹"..zk.." 𓂄𓆩♥𓆪‌‌𓂁", data = IdUser.."/b7"}},
        {{text = "★⃝➼"..zk.." ꗛ", data = IdUser.."/b8"}},
        {{text =  "⋆⃟➼"..zk.." ꕸ", data = IdUser.."/b9"}},
        {{text = "⸢"..zk.."⸥", data = IdUser.."/b10"}},
        {{text = "ꞏ"..zk.." ｢♥｣", data = IdUser.."/b11"}},
        {{text = "⋆"..zk.." ’🧸💕›", data = IdUser.."/b12"}},
        {{text = " ᯓ 𓆩 ˹ "..zk.." ˼ 𓆪 𓆃", data = IdUser.."/b13"}},
        {{text = "𓆩 "..zk.."ｌ➝ ˛⁽♥₎ 𓆪", data = IdUser.."/b14"}},
        {{text = "𒅒• !! "..zk.."  ᵛ͢ᵎᵖ 𒅒", data = IdUser.."/b15"}},
        {{text = "˚₊· ͟͟͞͞➳❥❬ "..zk.." ❭•°", data = IdUser.."/b16"}},
        {{text = "زخࢪفـــھـۃ بالايمۅجي 🎀..!", data = IdUser.."/emo"}},
        }
        }
      LuaTele.editMessageText(ChatId, Msg_id, "▾\n★ لقد اختࢪت \n▷ "..zk, "md",true,false,reply_markup)
    end
    end
if Text and Text:match('(.*)/b(.*)') then
      local anubis = {Text:match('(.*)/b(.*)')}
      local UserId = anubis[1]
      local z_num = tonumber(anubis[2])
      local z_text = Redis:get(TeleGod..ChatId..IdUser.."zkrf:text")
      local z_save = Redis:get(TeleGod..ChatId..IdUser.."zkrf:num")
      if tonumber(UserId) == tonumber(IdUser) then
        local api = https.request("https://ayad-12.xyz/anubis/zkhrfa.php?text="..URL.escape(z_text))
        local zkrf = JSON.decode(api)
        local zk = zkrf['anubis'][z_save]
        local zk_list = {
          zk,
          "𓂄𓆩"..zk.."𓆪𓂁",
          "𓆩⸤"..zk.."⸥𓆪",
          "𓆩"..zk.."𓆪",
          "⌁ "..zk.." ’♥ ", 
          "ꔷ"..zk.." 🧸💕 ˝♥›.", 
          "➹"..zk.." 𓂄𓆩♥𓆪‌‌𓂁", 
          "★⃝➼"..zk.." ꗛ", 
          "⋆⃟➼"..zk.." ꕸ",
          "⸢"..zk.."⸥",
          "ꞏ"..zk.." ｢♥｣",
          "⋆"..zk.." ’🧸💕›",
          " ᯓ 𓆩 ˹ "..zk.." ˼ 𓆪 𓆃",
          "𓆩 "..zk.."ｌ➝ ˛⁽♥₎ 𓆪",
          "𒅒• !! "..zk.."  ᵛ͢ᵎᵖ 𒅒",
          "˚₊· ͟͟͞͞➳❥❬ "..zk.." ❭•°",
        }
        LuaTele.editMessageText(ChatId, Msg_id, "▾\n★ لقد اختࢪت \n▷ `"..zk_list[z_num].."`", "md",false)
        Redis:del(TeleGod..ChatId..IdUser.."zkrf:text")
        Redis:del(TeleGod..ChatId..IdUser.."zkrf:num")
      end
      end
-- z  emo
if Text and Text:match('(%d+)/emo') then
  local UserId = Text:match('(%d+)/emo')
  local z_text = Redis:get(TeleGod..ChatId..IdUser.."zkrf:text")
  local z_save = Redis:get(TeleGod..ChatId..IdUser.."zkrf:num")
  if tonumber(UserId) == tonumber(IdUser) then
    local api = https.request("https://ayad-12.xyz/anubis/zkhrfa.php?text="..URL.escape(z_text))
    local zkrf = JSON.decode(api)
    local zk = zkrf['anubis'][z_save]
    LuaTele.editMessageText(ChatId, Msg_id, "★ تمت الزخࢪفھـۃ بنجاح\n\n▷ `"..zk.." ¦✨❤️` \n\n▷ `"..zk.." “̯ 🐼💗`\n\n▷ `"..zk.." 🦋“`\n\n▷ `"..zk.."ّ ❥̚͢₎ 🐣`\n\n▷ `"..zk.." ℡ ̇ ✨🐯⇣✦`\n\n▷ `"..zk.." 😴🌸✿⇣`\n\n▷ `"..zk.." •🙊💙`\n\n▷ `"..zk.." ❥┊⁽ ℡🦁🌸`\n\n▷ `"..zk.." •💚“`\n\n▷ `"..zk.." ⚡️♛ֆ₎`\n\n▷ `"..zk.." ⁞♩⁽💎🌩₎⇣✿`\n\n▷ `"..zk.." 〄💖‘`\n\nاضغط علي الزخࢪفھـۃ للنسخ 🎀..!", "md",false)
    Redis:del(TeleGod..ChatId..IdUser.."zkrf:text")
    Redis:del(TeleGod..ChatId..IdUser.."zkrf:num")
  end
  end
-- zar call back
if Text and Text:match('(%d+)/zar') then
    local UserId = Text:match('(%d+)/zar')
    if tonumber(UserId) == tonumber(IdUser) then
      Redis:set(TeleGod..ChatId..IdUser.."zkrf:", "zar")
      LuaTele.editMessageText(ChatId, Msg_id, "▾ 𝙎𝙀𝙉𝘿 𝙐𝙍 𝙉𝘼𝙈𝙀 🎀..! \n \n✴ اࢪسل الاسم لتتم زخࢪفتھـۃ الان 🎀..!", "md",false)
    end
    end
if Text and Text:match('(.*)/yes_zw/(.*)') then
  local anubis = {Text:match('(.*)/yes_zw/(.*)')}
  local zwga_id = anubis[1]
  local zwg_id = anubis[2]
  if tonumber(zwga_id) == tonumber(IdUser) then
    local zwga_name = LuaTele.getUser(zwga_id).first_name
    local zwg_name = LuaTele.getUser(zwg_id).first_name
    Redis:set(TeleGod..ChatId..zwga_id.."mtzwga:", zwg_id)
    Redis:set(TeleGod..ChatId..zwg_id.."mtzwga:", zwga_id)
    return LuaTele.editMessageText(ChatId, Msg_id, "باركو ل ["..zwga_name.."](tg://user?id="..zwga_id..")\nوافق يتجوز ["..zwg_name.."](tg://user?id="..zwg_id..")","md",false)
  end
end
if Text and Text:match('(.*)/no_zw/(.*)') then
  local anubis = {Text:match('(.*)/no_zw/(.*)')}
  local zwga_id = anubis[1]
  local zwg_id = anubis[2]
  if tonumber(zwga_id) == tonumber(IdUser) then
    return LuaTele.editMessageText(ChatId, Msg_id, "امال عاوزني اجبلك مين تتجوزو ؟؟","md",false)
  end
end
if Text and Text:match('(%d+)/cancelrdd') then
local UserId = Text:match('(%d+)/cancelrdd')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '◜𝑠𝑜𝑢𝑟𝑐𝑒 𝑡𝑒𝑙𝑒𝑔𝑜𝑑◞', url = 't.me/'..chsource..''}, 
},
}
}
Redis:del(TeleGod.."Set:array:Ssd"..IdUser..":"..ChatId)
Redis:del(TeleGod.."Set:array:rd"..IdUser..":"..ChatId)
Redis:del(TeleGod.."Set:array"..IdUser..":"..ChatId)
Redis:del(TeleGod.."Set:Manager:rd"..IdUser..":"..ChatId)
Redis:del(TeleGod.."Set:Manager:rd"..IdUser..":"..ChatId)
Redis:del(TeleGod.."Set:Rd"..IdUser..":"..ChatId)
Redis:del(TeleGod.."Set:On"..IdUser..":"..ChatId)
Redis:del(TeleGod.."Set:Manager:rd:inline"..IdUser..":"..ChatId)
Redis:del(TeleGod.."Set:On:mz"..IdUser..":"..ChatId)
Redis:del(TeleGod.."Set:Rd:mz"..IdUser..":"..ChatId)
edit(ChatId,Msg_id,"تم الغاء الامر بنجاح", 'md', true, false, reply_markup)
end
end
if Text and Text:match('(%d+)/cancelkit') then
    local UserId = Text:match('(%d+)/cancelkit')
    if tonumber(IdUser) == tonumber(UserId) then
    local reply_markup = LuaTele.replyMarkup{
    type = 'inline',
    data = {
    {
    {text = '◜𝑠𝑜𝑢𝑟𝑐𝑒 𝑡𝑒𝑙𝑒𝑔𝑜𝑑◞', url = 't.me/'..chsource..''}, 
    },
    }
    }
    Redis:del(TeleGod.."Set:kit"..IdUser..":"..ChatId)
    edit(ChatId,Msg_id,"تم الغاء الامر بنجاح", 'md', true, false, reply_markup)
    end
    end
    if Text and Text:match('(%d+)/rmkit_all') then
        local UserId = Text:match('(%d+)/rmkit_all')
        if tonumber(IdUser) == tonumber(UserId) then
        local reply_markup = LuaTele.replyMarkup{
        type = 'inline',
        data = {
        {
        {text = '◜𝑠𝑜𝑢𝑟𝑐𝑒 𝑡𝑒𝑙𝑒𝑔𝑜𝑑◞', url = 't.me/'..chsource..''}, 
        },
        }
        }
        Redis:set(TeleGod.."kit_defullt:","true")
        Redis:del(TeleGod.."kit:")
        edit(ChatId,Msg_id,"تم مسح جميع الاسأله بنجاح", 'md', true, false, reply_markup)
        end
        end
if Text and Text:match('(%d+)/songg') then
local UserId = Text:match('(%d+)/songg')
if tonumber(IdUser) == tonumber(UserId) then
Num = math.random(8,83)
Mhm = math.random(108,143)
Mhhm = math.random(166,179)
Mmhm = math.random(198,216)
Mhmm = math.random(257,626)
local Texting = {Num,Mhm,Mhhm,Mmhm,Mhmm}
local Rrr = Texting[math.random(#Texting)]
au ={
type = "audio",
media = "https://t.me/mmsst13/"..Rrr.."",
caption = '٭ اليك اغنيه عشوائيه من البوت\n',
parse_mode = "Markdown"                                                                                                                                                               
}     
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'اغنيه اخري', callback_data=IdUser.."/songg"},
},
}
local mm = Msg_id/2097152/0.5
https.request("http://api.telegram.org/bot"..Token.."/editmessagemedia?chat_id="..ChatId.."&message_id="..mm.."&media="..JSON.encode(au).."&reply_markup="..JSON.encode(keyboard))
end 
end
if Text and Text:match('(%d+)/sorty(%d+)') then
local UserId = {Text:match('(%d+)/sorty(%d+)')}
local current = math.floor(tonumber(UserId[2]))
local next = math.floor(tonumber(UserId[2]) + 1)
local prev = math.floor(tonumber(UserId[2]) - 1)
print(current)
if tonumber(IdUser) == tonumber(UserId[1]) then
local photo = LuaTele.getUserProfilePhotos(IdUser)
local ph = photo.photos[tonumber(current)]
if ph then
local pho = ph.sizes[#photo.photos[1].sizes].photo.remote.id
pph ={
type = "photo",
media = pho,
caption = '٭ عدد صورك هو '..photo.total_count..'\n٭ وهذه صورتك رقم '..current..'\n',
parse_mode = "Markdown"                                                                                                                                                               
}     
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'صورتك التاليه', callback_data=IdUser.."/sorty"..next..""},{text = 'صورتك السابقه', callback_data=IdUser.."/sorty"..prev..""},
},
}
local mm = Msg_id/2097152/0.5
https.request("http://api.telegram.org/bot"..Token.."/editmessagemedia?chat_id="..ChatId.."&message_id="..mm.."&media="..JSON.encode(pph).."&reply_markup="..JSON.encode(keyboard))
else
LuaTele.answerCallbackQuery(data.id, "✦ لم يتم العثور علي رقم الصوره المطلوبه ", true)
end
end 
end

if Text == '/lhaui' then
local photo = LuaTele.getUserProfilePhotos(TeleGod)
local ph = photo.photos[1].sizes[#photo.photos[1].sizes].photo.remote.id
pph ={
type = "photo",
media = ph,
caption = '* *⩹━━━━✦ 𝗧𝗘𝗟𝗘𝗚𝗢𝗗 ✦ ━━━━⩺\n*🤖┇[⁨𝗦َ𝗢ٰ𝗨ِِ𝖱ٰ𝗖ٌ𝗘˼⁩](t.me/SR_TeleGod)⦒ ',
parse_mode = "Markdown"                                                                                                                                                               
}     
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '- ٓ𝘽ٰ𝘼ٰ𝘾ٰٰ𝙆 -', callback_data="/bnbak"},
},
}
local ban = Msg_id/2097152/0.5
https.request("http://api.telegram.org/bot"..Token.."/editmessagemedia?chat_id="..ChatId.."&message_id="..ban.."&media="..JSON.encode(pph).."&reply_markup="..JSON.encode(keyboard))
end 
if Text == '/bnbak' then
local photo = LuaTele.getUserProfilePhotos(TeleGod)
local  bb = LuaTele.getUser(Sudo_Id) 
local ph = photo.photos[1].sizes[#photo.photos[1].sizes].photo.remote.id
pph ={
type = "photo",
media = ph,
caption = '*\n🎤| أهلآ بك عزيزي أنا بوت '..(Redis:get(TeleGod.."Name:Bot") or "تلي جود")..'\n⚙️| وظيفتي حماية المجموعات\n✅| لتفعيل البوت عليك اتباع مايلي\n🔘| أضِف البوت إلى مجموعتك\n⚡️| ارفعهُ » مشرف\n⬆️| سيتم ترقيتك مالك في البوت \n*',
parse_mode = "Markdown"                                                                                                                                                               
}     
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '🎯 نبذه', callback_data ='/zxhaut'},{text = 'ٓ♻️ حول ',  callback_data ='/lhaui'},
},
{
{text = 'مطور البوت ⚠️', url = "https://t.me/"..bb.username..""},
},
{
{text = '✅ اضفني لمجموعتك', url = 't.me/'..UserBot..'?startgroup=new'}, 
},
}
local ban = Msg_id/2097152/0.5
https.request("http://api.telegram.org/bot"..Token.."/editmessagemedia?chat_id="..ChatId.."&message_id="..ban.."&media="..JSON.encode(pph).."&reply_markup="..JSON.encode(keyboard))
end 
if Text == '/zxhaut' then
local photo = LuaTele.getUserProfilePhotos(TeleGod)
local ph = photo.photos[1].sizes[#photo.photos[1].sizes].photo.remote.id
pph ={
type = "photo",
media = ph,
caption = '*  *[ ☃️︙ٱهـــݪٱ بــک في سـۄرس تلي جود](t.me/SR_TeleGod)*\n\n*[ 🎲| من اقـوي سورسات الحمايه بالتليجرام](t.me/SR_TeleGod)*',
parse_mode = "Markdown"                                                                                                                                                               
}     
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '- ٓ𝘽ٰ𝘼ٰ𝘾ٰٰ𝙆 -', callback_data="/bnbak"},
},
}
local ban = Msg_id/2097152/0.5
https.request("http://api.telegram.org/bot"..Token.."/editmessagemedia?chat_id="..ChatId.."&message_id="..ban.."&media="..JSON.encode(pph).."&reply_markup="..JSON.encode(keyboard))
end
 
if Text == 'EndAddarray'..IdUser then  
if Redis:get(TeleGod..'Set:array'..IdUser..':'..ChatId) == 'true1' then
Redis:del(TeleGod..'Set:array'..IdUser..':'..ChatId)
keyboard = {} 
keyboard.inline_keyboard = {
{{text = '◜𝑠𝑜𝑢𝑟𝑐𝑒 𝑡𝑒𝑙𝑒𝑔𝑜𝑑◞',url='http://t.me/SR_TeleGod'}},
}
local msg_idd = Msg_id/2097152/0.5
return https.request("https://api.telegram.org/bot"..Token..'/editMessageText?chat_id='..ChatId..'&text='..URL.escape(" *✦ تم حفظ الردود بنجاح*")..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
else
keyboard = {} 
keyboard.inline_keyboard = {
{{text = '◜𝑠𝑜𝑢𝑟𝑐𝑒 𝑡𝑒𝑙𝑒𝑔𝑜𝑑◞',url='http://t.me/SR_TeleGod'}},
}
return https.request("https://api.telegram.org/bot"..Token..'/editMessageText?chat_id='..ChatId..'&text='..URL.escape(" *✦ تم تنفيذ الامر سابقا*")..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
end
end
if Text and Text:match('(%d+)/mp3(.*)') then
local UserId = {Text:match('(%d+)/mp3(.*)')}
if tonumber(IdUser) == tonumber(UserId[1]) then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '◜𝑠𝑜𝑢𝑟𝑐𝑒 𝑡𝑒𝑙𝑒𝑔𝑜𝑑◞', url = 't.me/'..chsource..''}, 
},
}
}
local TextHelp = [[*
✦ ارسل ما تريد تحميله
*]]
Redis:set(TeleGod.."youtube"..IdUser..ChatId,'mp3')
edit(ChatId,Msg_id,TextHelp, 'md', true, false, reply_markup)
end
end
if Text and Text:match('(%d+)/mp4(.*)') then
local UserId = {Text:match('(%d+)/mp4(.*)')}
if tonumber(IdUser) == tonumber(UserId[1]) then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '◜𝑠𝑜𝑢𝑟𝑐𝑒 𝑡𝑒𝑙𝑒𝑔𝑜𝑑◞', url = 't.me/'..chsource..''}, 
},
}
}
local TextHelp = [[*
✦ ارسل ما تريد تحميله
*]]
Redis:set(TeleGod.."youtube"..IdUser..ChatId,'mp4')
edit(ChatId,Msg_id,TextHelp, 'md', true, false, reply_markup)
end
end
if Text and Text:match('(%d+)/onlinebott(.*)') then
local UserId = {Text:match('(%d+)/onlinebott(.*)')}
local Get_Chat = LuaTele.getChat(ChatId)
local Info_Chats = LuaTele.getSupergroupFullInfo(ChatId)
if tonumber(IdUser) == tonumber(UserId[1]) then
Redis:sadd(TeleGod.."ChekBotAdd",UserId[2])
local U = LuaTele.getUser(IdUser)
Redis:set(TeleGod.."Status:Id"..UserId[2],true) ;Redis:del(TeleGod.."Status:Reply"..UserId[2]) ;Redis:del(TeleGod.."Status:ReplySudo"..UserId[2]) ;Redis:set(TeleGod.."Status:BanId"..UserId[2],true) ;Redis:set(TeleGod.."Status:SetId"..UserId[2],true) 
local Info_Members = LuaTele.getSupergroupMembers(UserId[2], "Administrators", "*", 0, 200)
local List_Members = Info_Members.members
x = 0
y = 0
for k, v in pairs(List_Members) do
if Info_Members.members[k].bot_info == nil then
if Info_Members.members[k].status.luatele == "chatMemberStatusCreator" then
Redis:sadd(TeleGod.."Owners:Group"..UserId[2],v.member_id.user_id) 
x = x + 1
else
Redis:sadd(TeleGod.."Admin:Group"..UserId[2],v.member_id.user_id) 
y = y + 1
end
end
end
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '- مغادرة المجموعه ', data = '/leftgroup@'..ChatId}, 
},
{
{text = Get_Chat.title, url = Info_Chats.invite_link.invite_link}, 
},
}
}
send(Sudo_Id,0,'*\n✦ تم تفعيل مجموعه جديده \n✦ من قام بتفعيلها : {*['..U.first_name..'](tg://user?id='..IdUser..')*} \n✦ معلومات المجموعه :\n✦ عدد الاعضاء : '..Info_Chats.member_count..'\n✦ عدد الادمنيه : '..Info_Chats.administrator_count..'\n✦ عدد المطرودين : '..Info_Chats.banned_count..'\n✦ عدد المقيدين : '..Info_Chats.restricted_count..'*',"md",true, false, false, false, reply_markup)
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '◜𝑠𝑜𝑢𝑟𝑐𝑒 𝑡𝑒𝑙𝑒𝑔𝑜𝑑◞', url="t.me/SR_TeleGod"},
},
}
local txxt = "✦ تم تفعيل المجموعه و ترقيه {"..y.."} ادمنيه \n⌯︙تم ترقية المالك "
local mm = Msg_id/2097152/0.5
https.request("https://api.telegram.org/bot"..Token..'/EditMessagecaption?chat_id='..ChatId..'&message_id='..mm..'&caption=' .. URL.escape(txxt).."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
end
end
if Text and Text:match('(%d+)mute(%d+)') then
local UserId = {Text:match('(%d+)mute(%d+)')}
local replyy = tonumber(UserId[2])
print(replyy)
if tonumber(IdUser) == tonumber(UserId[1]) then
Redis:sadd(TeleGod.."SilentGroup:Group"..ChatId,replyy) 
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = 'الغاء كتم', data = IdUser..'unmute'..replyy}, 
},
{
{text = '◜𝑠𝑜𝑢𝑟𝑐𝑒 𝑡𝑒𝑙𝑒𝑔𝑜𝑑◞', url = 't.me/'..chsource..''}, 
},
}
}
local TextHelp = Reply_Status(replyy,"✦ تم كتمه في الجروب  ").Reply
edit(ChatId,Msg_id,TextHelp, 'md', true, false, reply_markup)
end
end
if Text and Text:match('(%d+)unmute(%d+)') then
local UserId = {Text:match('(%d+)unmute(%d+)')}
local replyy = tonumber(UserId[2])
print(replyy)
if tonumber(IdUser) == tonumber(UserId[1]) then
Redis:srem(TeleGod.."SilentGroup:Group"..ChatId,replyy) 
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '◜𝑠𝑜𝑢𝑟𝑐𝑒 𝑡𝑒𝑙𝑒𝑔𝑜𝑑◞', url = 't.me/'..chsource..''}, 
},
}
}
local TextHelp = Reply_Status(replyy,"✦ تم الغاء كتمه في الجروب ").Reply
edit(ChatId,Msg_id,TextHelp, 'md', true, false, reply_markup)
end
end

if Text and Text:match('(%d+)ban(%d+)') then
local UserId = {Text:match('(%d+)ban(%d+)')}
local replyy = tonumber(UserId[2])
print(replyy)
if tonumber(IdUser) == tonumber(UserId[1]) then
Redis:sadd(TeleGod.."BanGroup:Group"..ChatId,replyy) 
LuaTele.setChatMemberStatus(ChatId,replyy,'banned',0)
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = 'الغاء حظر', data = IdUser..'unban'..replyy}, 
},
{
{text = '◜𝑠𝑜𝑢𝑟𝑐𝑒 𝑡𝑒𝑙𝑒𝑔𝑜𝑑◞', url = 't.me/'..chsource..''}, 
},
}
}
local TextHelp = Reply_Status(replyy,"✦ تم حظر من الجروب  ").Reply
edit(ChatId,Msg_id,TextHelp, 'md', true, false, reply_markup)
end
end
if Text and Text:match('(%d+)unban(%d+)') then
local UserId = {Text:match('(%d+)unban(%d+)')}
local replyy = tonumber(UserId[2])
print(replyy)
if tonumber(IdUser) == tonumber(UserId[1]) then
Redis:srem(TeleGod.."BanGroup:Group"..ChatId,replyy) 
LuaTele.setChatMemberStatus(ChatId,replyy,'restricted',{1,1,1,1,1,1,1,1,1})
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '◜𝑠𝑜𝑢𝑟𝑐𝑒 𝑡𝑒𝑙𝑒𝑔𝑜𝑑◞', url = 't.me/'..chsource..''}, 
},
}
}
local TextHelp = Reply_Status(replyy,"✦ تم الغاء حظره من الجروب ").Reply
edit(ChatId,Msg_id,TextHelp, 'md', true, false, reply_markup)
end
end
if Text and Text:match('(%d+)kid(%d+)') then
local UserId = {Text:match('(%d+)kid(%d+)')}
local replyy = tonumber(UserId[2])
print(replyy)
if tonumber(IdUser) == tonumber(UserId[1]) then
LuaTele.setChatMemberStatus(ChatId,replyy,'restricted',{1,0,0,0,0,0,0,0,0})
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = 'الغاء تقييد', data = IdUser..'unkid'..replyy}, 
},
{
{text = '◜𝑠𝑜𝑢𝑟𝑐𝑒 𝑡𝑒𝑙𝑒𝑔𝑜𝑑◞', url = 't.me/'..chsource..''}, 
},
}
}
local TextHelp = Reply_Status(replyy,"✦ تم تقييده في الجروب  ").Reply
edit(ChatId,Msg_id,TextHelp, 'md', true, false, reply_markup)
end
end
if Text and Text:match('(%d+)unkid(%d+)') then
local UserId = {Text:match('(%d+)unkid(%d+)')}
local replyy = tonumber(UserId[2])
print(replyy)
if tonumber(IdUser) == tonumber(UserId[1]) then
LuaTele.setChatMemberStatus(ChatId,replyy,'restricted',{1,1,1,1,1,1,1,1})
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '◜𝑠𝑜𝑢𝑟𝑐𝑒 𝑡𝑒𝑙𝑒𝑔𝑜𝑑◞', url = 't.me/'..chsource..''}, 
},
}
}
local TextHelp = Reply_Status(replyy,"✦ تم الغاء تقييده في الجروب ").Reply
edit(ChatId,Msg_id,TextHelp, 'md', true, false, reply_markup)
end
end
if Text and Text:match('(%d+)dl/(.*)') then
local xd = {Text:match('(%d+)dl/(.*)')}
local UserId = xd[1]
local id = xd[2]
if tonumber(IdUser) == tonumber(UserId) then
local json = json:decode(https.request("https://xnxx.TeleGodbots.ml/video_info.php?id=http://www.youtube.com/watch?v="..id))
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = 'تحميل صوت', data = IdUser..'sound/'..id}, {text = 'تحميل فيديو', data = IdUser..'video/'..id}, 
},
}
}
local txx = "["..json.title.."](http://youtu.be/"..id..""
LuaTele.editMessageText(ChatId,Msg_id,txx, 'md', true, false, reply_markup)
else
LuaTele.answerCallbackQuery(data.id, "✦ هذا الامر لا يخصك ", true)
end
end
if Text and Text:match('(%d+)sound/(.*)') then
local xd = {Text:match('(%d+)sound/(.*)')}
local UserId = xd[1]
local id = xd[2]
if tonumber(IdUser) == tonumber(UserId) then
local u = LuaTele.getUser(IdUser)
LuaTele.answerCallbackQuery(data.id, "✦ انتظر يتم التحميل ", true)
local json = json:decode(https.request("https://xnxx.TeleGodbots.ml/video_info.php?id=http://www.youtube.com/watch?v="..id))
local link = "http://www.youtube.com/watch?v="..id
local title = json.title
local title = title:gsub("/","-") 
local title = title:gsub("\n","-") 
local title = title:gsub("|","-") 
local title = title:gsub("'","-") 
local title = title:gsub('"',"-") 
local time = json.t
local p = json.a
local p = p:gsub("/","-") 
local p = p:gsub("\n","-") 
local p = p:gsub("|","-") 
local p = p:gsub("'","-") 
local p = p:gsub('"',"-") 
LuaTele.deleteMessages(ChatId,{[1]= Msg_id})
os.execute("yt-dlp "..link.." -f 251 -o '"..title..".mp3'")
LuaTele.sendAudio(ChatId,0,'./'..title..'.mp3',"✦ ["..title.."]("..link..")\n✦ حسب طلب ["..u.first_name.."](tg://user?id="..IdUser..")","md",tostring(time),title,p) 
sleep(2)
os.remove(""..title..".mp3")
else
LuaTele.answerCallbackQuery(data.id, "✦ هذا الامر لا يخصك ", true)
end
end
if Text and Text:match('(%d+)video/(.*)') then
local xd = {Text:match('(%d+)video/(.*)')}
local UserId = xd[1]
local id = xd[2]
if tonumber(IdUser) == tonumber(UserId) then
local u = LuaTele.getUser(IdUser)
LuaTele.answerCallbackQuery(data.id, "✦ انتظر يتم التحميل ", true)
local json = json:decode(https.request("https://xnxx.TeleGodbots.ml/video_info.php?id=http://www.youtube.com/watch?v="..id))
local link = "http://www.youtube.com/watch?v="..id
local title = json.title
local title = title:gsub("/","-") 
local title = title:gsub("\n","-") 
local title = title:gsub("|","-") 
local title = title:gsub("'","-") 
local title = title:gsub('"',"-") 
LuaTele.deleteMessages(ChatId,{[1]= Msg_id})
os.execute("yt-dlp "..link.." -f 18 -o '"..title..".mp4'")
LuaTele.sendVideo(ChatId,0,'./'..title..'.mp4',"✦ ["..title.."]("..link..")\n✦ حسب طلب ["..u.first_name.."](tg://user?id="..IdUser..")","md") 
sleep(4)
os.remove(""..title..".mp4")
else
LuaTele.answerCallbackQuery(data.id, "✦ هذا الامر لا يخصك ", true)
end
end
if Text and Text:match('(%d+)/help1') then
local UserId = Text:match('(%d+)/help1')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '‹اوامر الادمنيه›', data = IdUser..'/help2'}, 
},
{
{text = '‹اوامر المدراء›', data = IdUser..'/help3'}, {text = '‹اوامر المنشئين›', data = IdUser..'/help4'}, 
},
{
{text = '‹اوامر المطور›', data = IdUser..'/help5'}, {text = '‹اوامر التسليه›', data = IdUser..'/help7'}, 
},
{
{text = 'القائمه الرئيسيه', data = IdUser..'/helpall'},
},
{
{text = '◜𝑠𝑜𝑢𝑟𝑐𝑒 𝑡𝑒𝑙𝑒𝑔𝑜𝑑◞', url = 't.me/'..chsource..''}, 
},
}
}
local TextHelp = [[*
✦ اوامر الحمايه اتبع مايلي ...
⩹━━━━✦ 𝗧𝗘𝗟𝗘𝗚𝗢𝗗 ✦ ━━━━⩺
✦ قفل ، فتح ← الامر 
✦ تستطيع قفل حمايه كما يلي ...
✦ ← بالتقييد ، بالطرد ، بالكتم 
⩹━━━━✦ 𝗧𝗘𝗟𝗘𝗚𝗢𝗗 ✦ ━━━━⩺
✦ الروابط
✦ المعرف
✦ التاك
✦ الشارحه
✦ التعديل
✦ التثبيت
✦ المتحركه
✦ الملفات
✦ الصور
⩹━━━━✦ 𝗧𝗘𝗟𝗘𝗚𝗢𝗗 ✦ ━━━━⩺
✦ الماركداون
✦ البوتات
✦ التكرار
✦ الكلايش
✦ السيلفي
✦ الملصقات
✦ الفيديو
✦ الانلاين
✦ الدردشه
⩹━━━━✦ 𝗧𝗘𝗟𝗘𝗚𝗢𝗗 ✦ ━━━━⩺
✦ القناه
✦ التوجيه
✦ الاغاني
✦ الصوت
✦ الجهات
✦ الاشعارات
*]]
edit(ChatId,Msg_id,TextHelp, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/help2') then
local UserId = Text:match('(%d+)/help2')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '‹اوامر الحمايه›', data = IdUser..'/help1'}, 
},
{
{text = '‹اوامر المدراء›', data = IdUser..'/help3'}, {text = '‹اوامر المنشئين›', data = IdUser..'/help4'}, 
},
{
{text = '‹اوامر المطور›', data = IdUser..'/help5'}, {text = '‹اوامر التسليه›', data = IdUser..'/help7'}, 
},
{
{text = 'القائمه الرئيسيه', data = IdUser..'/helpall'},
},
{
{text = '◜𝑠𝑜𝑢𝑟𝑐𝑒 𝑡𝑒𝑙𝑒𝑔𝑜𝑑◞', url = 't.me/'..chsource..''}, 
},
}
}
local TextHelp = [[*
✦ اوامر ادمنية الجروب ...
⩹━━━━✦ 𝗧𝗘𝗟𝗘𝗚𝗢𝗗 ✦ ━━━━⩺
✦ رفع، تنزيل ← مميز
✦ تاك للكل ، عدد الجروب
✦ كتم ، حظر ، طرد ، تقييد
✦ الغاء كتم ، الغاء حظر ، الغاء تقييد
✦ منع ، الغاء منع 
⩹━━━━✦ 𝗧𝗘𝗟𝗘𝗚𝗢𝗗 ✦ ━━━━⩺
✦ عرض القوائم كما يلي ...
⩹━━━━✦ 𝗧𝗘𝗟𝗘𝗚𝗢𝗗 ✦ ━━━━⩺
✦ المكتومين
✦ المميزين 
✦ قائمه المنع
⩹━━━━✦ 𝗧𝗘𝗟𝗘𝗚𝗢𝗗 ✦ ━━━━⩺
✦ تثبيت ، الغاء تثبيت
✦ الرابط ، الاعدادات
✦ الترحيب ، القوانين
✦ تفعيل ، تعطيل ← الترحيب
✦ تفعيل ، تعطيل ← الرابط
✦ جهاتي ،ايدي ، رسائلي
✦ تعديلاتي ، نقاطي
✦ كشف البوتات
⩹━━━━✦ 𝗧𝗘𝗟𝗘𝗚𝗢𝗗 ✦ ━━━━⩺
✦ وضع ، ضع ← الاوامر التاليه 
✦ اسم ، رابط ، صوره
✦ قوانين ، وصف ، ترحيب
⩹━━━━✦ 𝗧𝗘𝗟𝗘𝗚𝗢𝗗 ✦ ━━━━⩺
✦ حذف ، مسح ← الاوامر التاليه
✦ قائمه المنع ، المحظورين 
✦ المميزين ، المكتومين ، القوانين
✦ المطرودين ، البوتات ، الصوره
✦ الرابط
*]]
edit(ChatId,Msg_id,TextHelp, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)toar') then
local UserId = Text:match('(%d+)toar')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '◜𝑠𝑜𝑢𝑟𝑐𝑒 𝑡𝑒𝑙𝑒𝑔𝑜𝑑◞', url = 't.me/'..chsource..''}, 
},
}
}
local TextHelp = [[*
✦ ارسل النص لترجمته الي العربيه
*]]
Redis:set(TeleGod.."toar"..IdUser,"on")
edit(ChatId,Msg_id,TextHelp, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)toen') then
local UserId = Text:match('(%d+)toen')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '◜𝑠𝑜𝑢𝑟𝑐𝑒 𝑡𝑒𝑙𝑒𝑔𝑜𝑑◞', url = 't.me/'..chsource..''}, 
},
}
}
local TextHelp = [[*
✦ ارسل النص لترجمته الي الانجليزيه
*]]
Redis:set(TeleGod.."toen"..IdUser,"on")
edit(ChatId,Msg_id,TextHelp, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/setallmember') then
local UserId = Text:match('(%d+)/setallmember')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = ': رجوع ᥫ᭡', data = IdUser..'/chback'},
},
{
{text = '◜𝑠𝑜𝑢𝑟𝑐𝑒 𝑡𝑒𝑙𝑒𝑔𝑜𝑑◞', url = 't.me/'..chsource..''}, 
},
}
}
local TextHelp = [[*
✦ تم تفعيل وضع الاشتراك الاجباري لكل الاعضاء
*]]
Redis:set(TeleGod.."chmembers","on")
edit(ChatId,Msg_id,TextHelp, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/setforcmd') then
local UserId = Text:match('(%d+)/setforcmd')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = ': رجوع ᥫ᭡', data = IdUser..'/chback'},
},
{
{text = '◜𝑠𝑜𝑢𝑟𝑐𝑒 𝑡𝑒𝑙𝑒𝑔𝑜𝑑◞', url = 't.me/'..chsource..''}, 
},
}
}
local TextHelp = [[*
✦ تم تفعيل وضع الاشتراك الاجباري علي اوامر البوت فقط مثل (الحظر/الكتم الخ..)
*]]
Redis:del(TeleGod.."chmembers")
edit(ChatId,Msg_id,TextHelp, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/chback') then
local UserId = Text:match('(%d+)/chback')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '1', data = IdUser..'/setallmember'},{text = '2', data = IdUser..'/setforcmd'},
},
}
}
local TextHelp = '✦ اختار كيف تريد تفعيله \n✦ 1 : وضع الاشتراك الاجباري لكل الاعضاء \n✦ 2 : وضع الاشتراك الاجباري عند استخدام الاوامر فقط \n'
edit(ChatId,Msg_id,TextHelp, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/help3') then
local UserId = Text:match('(%d+)/help3')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '‹اوامر الحمايه›', data = IdUser..'/help1'}, {text = '‹اوامر الادمنيه›', data = IdUser..'/help2'}, 
},
{
{text = '‹اوامر المنشئين›', data = IdUser..'/help4'}, 
},
{
{text = '‹اوامر المطور›', data = IdUser..'/help5'}, {text = '‹اوامر التسليه›', data = IdUser..'/help7'}, 
},
{
{text = 'القائمه الرئيسيه', data = IdUser..'/helpall'},
},
{
{text = '◜𝑠𝑜𝑢𝑟𝑐𝑒 𝑡𝑒𝑙𝑒𝑔𝑜𝑑◞', url = 't.me/'..chsource..''}, 
},
}
}
local TextHelp = [[*
✦ اوامر المدراء في الجروب
⩹━━━━✦ 𝗧𝗘𝗟𝗘𝗚𝗢𝗗 ✦ ━━━━⩺
✦ رفع ، تنزيل ← ادمن
✦ الادمنيه 
✦ رفع، كشف ← القيود
✦ تنزيل الكل ← بالرد ، بالمعرف
⩹━━━━✦ 𝗧𝗘𝗟𝗘𝗚𝗢𝗗 ✦ ━━━━⩺
✦ لتغيير رد الرتب في البوت
⩹━━━━✦ 𝗧𝗘𝗟𝗘𝗚𝗢𝗗 ✦ ━━━━⩺
✦ تغيير رد ← اسم الرتبه والنص
✦ المطور ، المنشئ الاساسي
✦ المنشئ ، المدير ، الادمن
✦ المميز ، العضو
⩹━━━━✦ 𝗧𝗘𝗟𝗘𝗚𝗢𝗗 ✦ ━━━━⩺
✦ تفعيل ، تعطيل ← الاوامر التاليه ↓
⩹━━━━✦ 𝗧𝗘𝗟𝗘𝗚𝗢𝗗 ✦ ━━━━⩺
✦ الايدي ، الايدي بالصوره
✦ الردود العامه ، الردود
✦ اطردني ، الالعاب ، الرفع
✦ الحظر ، الرابط 
⩹━━━━✦ 𝗧𝗘𝗟𝗘𝗚𝗢𝗗 ✦ ━━━━⩺
✦ تعين ، مسح ←الايدي 
✦ رفع الادمنيه ، مسح الادمنيه
✦ الردود ، مسح الردود
✦ اضف ، حذف ←  رد 
✦ مسح ← عدد 
*]]
edit(ChatId,Msg_id,TextHelp, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/help4') then
local UserId = Text:match('(%d+)/help4')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '‹اوامر الحمايه›', data = IdUser..'/help1'}, {text = '‹اوامر الادمنيه›', data = IdUser..'/help2'}, 
},
{
{text = '‹اوامر المدراء›', data = IdUser..'/help3'}, 
},
{
{text = '‹اوامر المطور›', data = IdUser..'/help5'}, {text = '‹اوامر التسليه›', data = IdUser..'/help7'}, 
},
{
{text = 'القائمه الرئيسيه', data = IdUser..'/helpall'},
},
{
{text = '◜𝑠𝑜𝑢𝑟𝑐𝑒 𝑡𝑒𝑙𝑒𝑔𝑜𝑑◞', url = 't.me/'..chsource..''}, 
},
}
}
local TextHelp = [[*
✦ اوامر المنشئ الاساسي
⩹━━━━✦ 𝗧𝗘𝗟𝗘𝗚𝗢𝗗 ✦ ━━━━⩺
✦ رفع ، تنزيل ← منشئ 
✦ المنشئين ، مسح المنشئين
⩹━━━━✦ 𝗧𝗘𝗟𝗘𝗚𝗢𝗗 ✦ ━━━━⩺
✦ اوامر المنشئ الجروب
⩹━━━━✦ 𝗧𝗘𝗟𝗘𝗚𝗢𝗗 ✦ ━━━━⩺
✦ رفع ، تنزيل ←  مدير
✦ المدراء ، مسح المدراء
✦ اضف رسائل ←  بالرد او الايدي
✦ اضف نقاط ←  بالرد او الايدي
✦ اضف ، حذف ← امر
✦ الاوامر المضافه ، مسح الاوامر المضافه
*]]
edit(ChatId,Msg_id,TextHelp, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/help5') then
local UserId = Text:match('(%d+)/help5')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '‹اوامر الحمايه›', data = IdUser..'/help1'}, {text = '‹اوامر الادمنيه›', data = IdUser..'/help2'}, 
},
{
{text = '‹اوامر المدراء›', data = IdUser..'/help3'}, {text = '‹اوامر المنشئين›', data = IdUser..'/help4'}, 
},
{
{text = '‹اوامر التسليه›', data = IdUser..'/help7'}, 
},
{
{text = 'القائمه الرئيسيه', data = IdUser..'/helpall'},
},
{
{text = '◜𝑠𝑜𝑢𝑟𝑐𝑒 𝑡𝑒𝑙𝑒𝑔𝑜𝑑◞', url = 't.me/'..chsource..''}, 
},
}
}
local TextHelp = [[*
✦ اوامر المطور الاساسي
⩹━━━━✦ 𝗧𝗘𝗟𝗘𝗚𝗢𝗗 ✦ ━━━━⩺
✦ حظر عام ، الغاء العام
✦ اضف ، حذف ← مطور
✦ قائمه العام ، مسح قائمه العام
✦ المطورين ، مسح المطورين
⩹━━━━✦ 𝗧𝗘𝗟𝗘𝗚𝗢𝗗 ✦ ━━━━⩺
✦ اضف ، حذف ←  رد عام 
✦ وضع ، حذف ← كليشه المطور
✦ مسح الردود العامه ، الردود العامه
✦ تعين عدد الاعضاء ← العدد
✦ تحديث
⩹━━━━✦ 𝗧𝗘𝗟𝗘𝗚𝗢𝗗 ✦ ━━━━⩺
✦ تفعيل ، تعطيل ←  الاوامر التاليه ↓
✦ البوت الخدمي ، المغادرة ، الاذاعه
⩹━━━━✦ 𝗧𝗘𝗟𝗘𝗚𝗢𝗗 ✦ ━━━━⩺
✦ اوامر المطور في البوت
⩹━━━━✦ 𝗧𝗘𝗟𝗘𝗚𝗢𝗗 ✦ ━━━━⩺
✦ تفعيل ، تعطيل ، الاحصائيات
✦ رفع، تنزيل ← منشئ اساسي
✦ رفع، تنزيل ← مالك
✦ مسح الاساسين ، المنشئين الاساسين
✦ غادر ← الايدي
✦ اذاعه ، اذاعه بالتوجيه ، اذاعه بالتثبيت
✦ اذاعه خاص ، اذاعه خاص بالتوجيه
*]]
edit(ChatId,Msg_id,TextHelp, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/help7') then
local UserId = Text:match('(%d+)/help7')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '‹اوامر الحمايه›', data = IdUser..'/help1'}, {text = '‹اوامر الادمنيه›', data = IdUser..'/help2'}, 
},
{
{text = '‹اوامر المدراء›', data = IdUser..'/help3'}, {text = '‹اوامر المنشئين›', data = IdUser..'/help4'}, 
},
{
{text = '‹اوامر المطور›', data = IdUser..'/help5'}, 
},
{
{text = 'القائمه الرئيسيه', data = IdUser..'/helpall'},
},
{
{text = '◜𝑠𝑜𝑢𝑟𝑐𝑒 𝑡𝑒𝑙𝑒𝑔𝑜𝑑◞', url = 't.me/'..chsource..''}, 
},
}
}
local TextHelp = [[*
✦ اوامر التسلية
⩹━━━━✦ 𝗧𝗘𝗟𝗘𝗚𝗢𝗗 ✦ ━━━━⩺
✦ رفع ، تنزيل ← الاوامر التاليه ↓
⩹━━━━✦ 𝗧𝗘𝗟𝗘𝗚𝗢𝗗 ✦ ━━━━⩺
✦ غبي 
✦ سمب
✦ حمار
✦ خول
✦ قرد 
✦ عره
✦ متوحد
✦ متوحده
✦ كلب 
⩹━━━━✦ 𝗧𝗘𝗟𝗘𝗚𝗢𝗗 ✦ ━━━━⩺
✦ اوامر التاك 
⩹━━━━✦ 𝗧𝗘𝗟𝗘𝗚𝗢𝗗 ✦ ━━━━⩺
✦ الاغبياء
✦ الحمير
✦ الخولات
✦ السمب
✦ المتوحدين
✦ الكلاب
✦ العرر
✦ القرود
⩹━━━━✦ 𝗧𝗘𝗟𝗘𝗚𝗢𝗗 ✦ ━━━━⩺
✦ اوامر الترفيه 
⩹━━━━✦ 𝗧𝗘𝗟𝗘𝗚𝗢𝗗 ✦ ━━━━⩺
✦ زخرفه + النص
✦ مثال زخرفه صلاح
✦ احسب + عمرك
✦ مثال احسب 2003/8/1
✦ معني + الاسم 
✦ مثال معني صلاح
*]]
edit(ChatId,Msg_id,TextHelp, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/help6') then
local UserId = Text:match('(%d+)/help6')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = 'العاب السورس ™️', data = IdUser..'/normgm'}, {text = 'العاب متطورة 🎳', data = IdUser..'/degm'}, 
},
{
{text = 'القائمه الرئيسيه', data = IdUser..'/helpall'},
},
{
{text = '◜𝑠𝑜𝑢𝑟𝑐𝑒 𝑡𝑒𝑙𝑒𝑔𝑜𝑑◞', url = 't.me/'..chsource..''}, 
},
}
}
local TextHelp = [[*
✦ أهلا بك في قائمة العاب سورس تلي جود اختر نوع الالعاب 
*]]
edit(ChatId,Msg_id,TextHelp, 'md', true, false, reply_markup)
end

elseif Text and Text:match('(%d+)/degm') then
local UserId = Text:match('(%d+)/degm')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '- فلابي بيرد', url = 'http://t.me/awesomebot?game=FlappyBird'}, 
},
{
{text = '- تبديل النجوم ', url = 'http://t.me/gamee?game=Switchy'}, {text = '- موتسيكلات', url = 'http://t.me/gamee?game=motofx'}, 
},
{
{text = '- اطلاق النار ', url = 'http://t.me/gamee?game=NeonBlaster'}, {text = '- كره القدم', url = 'http://t.me/gamee?game=Footballstar'}, 
},
{
{text = '- تجميع الوان ', url = 'http://t.me/awesomebot?game=Hextris'}, {text = '- المجوهرات', url = 'http://t.me/gamee?game=DiamondRows'}, 
},
{
{text = '- ركل الكرة ', url = 'http://t.me/gamee?game=KeepitUP'}, {text = '- بطولة السحق', url = 'http://t.me/gamee?game=SmashRoyale'}, 
},
{
{text = '- 2048', url = 'http://t.me/awesomebot?game=g2048'}, 
},
{
{text = '- كرة السلة ', url = 'http://t.me/gamee?game=BasketBoy'}, {text = '- القط المجنون', url = 'http://t.me/gamee?game=CrazyCat'}, 
},
{
{text = 'القائمه الرئيسيه', data = IdUser..'/helpall'},
},
{
{text = '◜𝑠𝑜𝑢𝑟𝑐𝑒 𝑡𝑒𝑙𝑒𝑔𝑜𝑑◞', url = 't.me/'..chsource..''}, 
},
}
}
local TextHelp = [[*
✦ مرحبا بك في الالعاب المتطورة الخاص بسورس تلي جود 
✦ اختر اللعبه ثم اختار المحادثة التي تريد اللعب بها
*]]
edit(ChatId,Msg_id,TextHelp, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/normgm') then
local UserId = Text:match('(%d+)/normgm')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = 'القائمه الرئيسيه', data = IdUser..'/helpall'},
},
{
{text = '◜𝑠𝑜𝑢𝑟𝑐𝑒 𝑡𝑒𝑙𝑒𝑔𝑜𝑑◞', url = 't.me/'..chsource..''}, 
},
}
}
local TextHelp = [[*
✦ قائمه الالعاب البوت
⩹━━━━✦ 𝗧𝗘𝗟𝗘𝗚𝗢𝗗 ✦ ━━━━⩺
✦ لعبة المختلف » المختلف
لعبـه بنك الحظ 

✦ لعبة الامثله » امثله
✦ لعبة العكس » العكس
✦ لعبة الحزوره » حزوره
✦ لعبة المعاني » معاني
✦ لعبة الترجمه » انجليزي
✦ لعبة البات » بات
✦ لعبة التخمين » خمن
✦ لعبة الاسرع » الاسرع
✦ لعبة السمايلات » سمايلات
✦ لعبة الاسئلة » كت تويت
✦ لعبة الاعلام والدول » اعلام
✦ لعبة لو خيروك » خيروك
✦ لعبة الصراحه والجرأة » صراحه
⩹━━━━✦ 𝗧𝗘𝗟𝗘𝗚𝗢𝗗 ✦ ━━━━⩺
✦ نقاطي ← لعرض عدد الارباح
✦ بيع نقاطي ← { العدد } ← لبيع كل نقطه مقابل {50} رساله
*]]
edit(ChatId,Msg_id,TextHelp, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/bank') then
local UserId = Text:match('(%d+)/bank')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '◜𝑠𝑜𝑢𝑟𝑐𝑒 𝑡𝑒𝑙𝑒𝑔𝑜𝑑◞', url = 't.me/'..chsource..''}, 
},
}
}
local TextHelp = [[*
✦ اوامر البنك

⌯ انشاء حساب بنكي  ↢ تعمل حساب وتقدر تحول فلوس 

⌯ مسح حساب بنكي  ↢ تلغي حسابك البنكي

⌯ تحويل ↢ تطلب رقم حساب الشخص وتحول له فلوس

⌯ حسابي  ↢ يطلع لك رقم حسابك 

⌯ فلوسي ↢ يعلمك كم فلوسك
⌯ كنز ↢ البحث عن كنزك

⌯ راتبي ↢ يعطيك راتبك كل ٢٠ دقيقة

⌯ بخشيش ↢ يعطيك بخشيش كل ١٠ دقايق

⌯ زرف ↢ تزرف فلوس اشخاص كل ١٠ دقايق

⌯ استثمار ↢ تستثمر بالمبلغ اللي تبيه مع نسبة ربح مضمونه من ١٪؜ الى ١٥٪؜

⌯ حظ ↢ تلعبها بأي مبلغ ياتكسب يا تخسر

⌯ مضاربه ↢ تضارب بأي مبلغ انت عاوزو والنسبة من ٩٠٪؜ الى -٩٠٪؜ انت وحظك

⌯ توب الفلوس ↢ يطلع توب اكتر ناس معهم فلوس في كل الجروبات

⌯ توب الحراميه ↢ يطلع لك اكتر ناس سرقو 😂
كنز & الكنز 
*]]
edit(ChatId,Msg_id,TextHelp, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/helpall') then
local UserId = Text:match('(%d+)/helpall')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = '‹اوامر الحمايه›', data = IdUser..'/help1'}, {text = '‹اوامر الادمنيه›', data = IdUser..'/help2'}, 
},
{
{text = '‹اوامر المدراء›', data = IdUser..'/help3'}, {text = '‹اوامر المنشئين›', data = IdUser..'/help4'}, 
},
{
{text = '‹اوامر المطور›', data = IdUser..'/help5'}, {text = '‹اوامر التسليه›', data = IdUser..'/help7'}, 
},
{
{text = 'الالعاب', data = IdUser..'/help6'},
},
{
{text = 'اوامر القفل', data = IdUser..'/NoNextSeting'}, {text = 'اوامر التعطيل', data = IdUser..'/listallAddorrem'}, 
},
{
{text = '◜𝑠𝑜𝑢𝑟𝑐𝑒◞', url = 't.me/'..chsource..''}, 
},
}
}
local TextHelp = [[*
✦ توجد ← 6 اوامر في البوت
⩹━━━━✦ 𝗧𝗘𝗟𝗘𝗚𝗢𝗗 ✦ ━━━━⩺
✦ 1 ← اوامر الحمايه
✦ 2 ← اوامر الادمنيه
✦ 3 ← اوامر المدراء
✦ 4 ← اوامر المنشئين
✦ 5 ← اوامر مطورين البوت
✦ 6 ← اوامر التسلية البوت
*]]
edit(ChatId,Msg_id,TextHelp, 'md', true, false, reply_markup)
end
end
if Text and Text:match('(%d+)/lock_link') then
local UserId = Text:match('(%d+)/lock_link')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(TeleGod.."Lock:Link"..ChatId,"del")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"✦ تم قفـل الروابط").Lock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_spam') then
local UserId = Text:match('(%d+)/lock_spam')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(TeleGod.."Lock:Spam"..ChatId,"del")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"✦ تم قفـل الكلايش").Lock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_keypord') then
local UserId = Text:match('(%d+)/lock_keypord')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(TeleGod.."Lock:Keyboard"..ChatId,"del")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"✦ تم قفـل الكيبورد").Lock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_voice') then
local UserId = Text:match('(%d+)/lock_voice')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(TeleGod.."Lock:vico"..ChatId,"del")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"✦ تم قفـل الاغاني").Lock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_gif') then
local UserId = Text:match('(%d+)/lock_gif')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(TeleGod.."Lock:Animation"..ChatId,"del")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"✦ تم قفـل المتحركات").Lock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_files') then
local UserId = Text:match('(%d+)/lock_files')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(TeleGod.."Lock:Document"..ChatId,"del")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"✦ تم قفـل الملفات").Lock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_text') then
local UserId = Text:match('(%d+)/lock_text')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(TeleGod.."Lock:text"..ChatId,true) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"✦ تم قفـل الدردشه").Lock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_video') then
local UserId = Text:match('(%d+)/lock_video')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(TeleGod.."Lock:Video"..ChatId,"del")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"✦ تم قفـل الفيديو").Lock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_photo') then
local UserId = Text:match('(%d+)/lock_photo')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(TeleGod.."Lock:Photo"..ChatId,"del")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"✦ تم قفـل الصور").Lock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_username') then
local UserId = Text:match('(%d+)/lock_username')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(TeleGod.."Lock:User:Name"..ChatId,"del")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"✦ تم قفـل المعرفات").Lock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_tags') then
local UserId = Text:match('(%d+)/lock_tags')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(TeleGod.."Lock:hashtak"..ChatId,"del")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"✦ تم قفـل التاك").Lock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_bots') then
local UserId = Text:match('(%d+)/lock_bots')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(TeleGod.."Lock:Bot:kick"..ChatId,"del")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"✦ تم قفـل البوتات").Lock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_fwd') then
local UserId = Text:match('(%d+)/lock_fwd')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(TeleGod.."Lock:forward"..ChatId,"del")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"✦ تم قفـل التوجيه").Lock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_audio') then
local UserId = Text:match('(%d+)/lock_audio')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(TeleGod.."Lock:Audio"..ChatId,"del")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"✦ تم قفـل الصوت").Lock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_stikear') then
local UserId = Text:match('(%d+)/lock_stikear')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(TeleGod.."Lock:Sticker"..ChatId,"del")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"✦ تم قفـل الملصقات").Lock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_phone') then
local UserId = Text:match('(%d+)/lock_phone')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(TeleGod.."Lock:Contact"..ChatId,"del")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"✦ تم قفـل الجهات").Lock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_joine') then
local UserId = Text:match('(%d+)/lock_joine')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(TeleGod.."Lock:Join"..ChatId,"kick")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"✦ تم قفـل الدخول").Lock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_addmem') then
local UserId = Text:match('(%d+)/lock_addmem')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(TeleGod.."Lock:AddMempar"..ChatId,"kick")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"✦ تم قفـل الاضافه").Lock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_videonote') then
local UserId = Text:match('(%d+)/lock_videonote')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(TeleGod.."Lock:Unsupported"..ChatId,"del")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"✦ تم قفـل بصمه الفيديو").Lock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_pin') then
local UserId = Text:match('(%d+)/lock_pin')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(TeleGod.."lockpin"..ChatId,(LuaTele.getChatPinnedMessage(ChatId).id or true)) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"✦ تم قفـل التثبيت").Lock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_tgservir') then
local UserId = Text:match('(%d+)/lock_tgservir')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(TeleGod.."Lock:tagservr"..ChatId,true)  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"✦ تم قفـل الاشعارات").Lock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_markdaun') then
local UserId = Text:match('(%d+)/lock_markdaun')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(TeleGod.."Lock:Markdaun"..ChatId,"del")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"✦ تم قفـل الماركدون").Lock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_edits') then
local UserId = Text:match('(%d+)/lock_edits')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(TeleGod.."Lock:edit"..ChatId,true) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"✦ تم قفـل التعديل").Lock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_games') then
local UserId = Text:match('(%d+)/lock_games')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(TeleGod.."Lock:geam"..ChatId,"del")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"✦ تم قفـل الالعاب").Lock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_flood') then
local UserId = Text:match('(%d+)/lock_flood')
if tonumber(IdUser) == tonumber(UserId) then
Redis:hset(TeleGod.."Spam:Group:User"..ChatId ,"Spam:User","del")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"✦ تم قفـل التكرار").Lock, 'md', true, false, reply_markup)
end
end

if Text and Text:match('(%d+)/lock_linkkid') then
local UserId = Text:match('(%d+)/lock_linkkid')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(TeleGod.."Lock:Link"..ChatId,"ked")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"✦ تم قفـل الروابط").lockKid, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_spamkid') then
local UserId = Text:match('(%d+)/lock_spamkid')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(TeleGod.."Lock:Spam"..ChatId,"ked")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"✦ تم قفـل الكلايش").lockKid, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_keypordkid') then
local UserId = Text:match('(%d+)/lock_keypordkid')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(TeleGod.."Lock:Keyboard"..ChatId,"ked")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"✦ تم قفـل الكيبورد").lockKid, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_voicekid') then
local UserId = Text:match('(%d+)/lock_voicekid')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(TeleGod.."Lock:vico"..ChatId,"ked")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"✦ تم قفـل الاغاني").lockKid, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_gifkid') then
local UserId = Text:match('(%d+)/lock_gifkid')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(TeleGod.."Lock:Animation"..ChatId,"ked")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"✦ تم قفـل المتحركات").lockKid, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_fileskid') then
local UserId = Text:match('(%d+)/lock_fileskid')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(TeleGod.."Lock:Document"..ChatId,"ked")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"✦ تم قفـل الملفات").lockKid, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_videokid') then
local UserId = Text:match('(%d+)/lock_videokid')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(TeleGod.."Lock:Video"..ChatId,"ked")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"✦ تم قفـل الفيديو").lockKid, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_photokid') then
local UserId = Text:match('(%d+)/lock_photokid')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(TeleGod.."Lock:Photo"..ChatId,"ked")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"✦ تم قفـل الصور").lockKid, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_usernamekid') then
local UserId = Text:match('(%d+)/lock_usernamekid')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(TeleGod.."Lock:User:Name"..ChatId,"ked")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"✦ تم قفـل المعرفات").lockKid, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_tagskid') then
local UserId = Text:match('(%d+)/lock_tagskid')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(TeleGod.."Lock:hashtak"..ChatId,"ked")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"✦ تم قفـل التاك").lockKid, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_fwdkid') then
local UserId = Text:match('(%d+)/lock_fwdkid')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(TeleGod.."Lock:forward"..ChatId,"ked")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"✦ تم قفـل التوجيه").lockKid, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_audiokid') then
local UserId = Text:match('(%d+)/lock_audiokid')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(TeleGod.."Lock:Audio"..ChatId,"ked")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"✦ تم قفـل الصوت").lockKid, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_stikearkid') then
local UserId = Text:match('(%d+)/lock_stikearkid')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(TeleGod.."Lock:Sticker"..ChatId,"ked")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"✦ تم قفـل الملصقات").lockKid, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_phonekid') then
local UserId = Text:match('(%d+)/lock_phonekid')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(TeleGod.."Lock:Contact"..ChatId,"ked")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"✦ تم قفـل الجهات").lockKid, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_videonotekid') then
local UserId = Text:match('(%d+)/lock_videonotekid')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(TeleGod.."Lock:Unsupported"..ChatId,"ked")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"✦ تم قفـل بصمه الفيديو").lockKid, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_markdaunkid') then
local UserId = Text:match('(%d+)/lock_markdaunkid')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(TeleGod.."Lock:Markdaun"..ChatId,"ked")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"✦ تم قفـل الماركدون").lockKid, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_gameskid') then
local UserId = Text:match('(%d+)/lock_gameskid')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(TeleGod.."Lock:geam"..ChatId,"ked")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"✦ تم قفـل الالعاب").lockKid, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_floodkid') then
local UserId = Text:match('(%d+)/lock_floodkid')
if tonumber(IdUser) == tonumber(UserId) then
Redis:hset(TeleGod.."Spam:Group:User"..ChatId ,"Spam:User","keed")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"✦ تم قفـل التكرار").lockKid, 'md', true, false, reply_markup)
end
end
if Text and Text:match('(%d+)/lock_linkktm') then
local UserId = Text:match('(%d+)/lock_linkktm')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(TeleGod.."Lock:Link"..ChatId,"ktm")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"✦ تم قفـل الروابط").lockKtm, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_spamktm') then
local UserId = Text:match('(%d+)/lock_spamktm')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(TeleGod.."Lock:Spam"..ChatId,"ktm")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"✦ تم قفـل الكلايش").lockKtm, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_keypordktm') then
local UserId = Text:match('(%d+)/lock_keypordktm')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(TeleGod.."Lock:Keyboard"..ChatId,"ktm")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"✦ تم قفـل الكيبورد").lockKtm, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_voicektm') then
local UserId = Text:match('(%d+)/lock_voicektm')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(TeleGod.."Lock:vico"..ChatId,"ktm")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"✦ تم قفـل الاغاني").lockKtm, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_gifktm') then
local UserId = Text:match('(%d+)/lock_gifktm')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(TeleGod.."Lock:Animation"..ChatId,"ktm")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"✦ تم قفـل المتحركات").lockKtm, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_filesktm') then
local UserId = Text:match('(%d+)/lock_filesktm')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(TeleGod.."Lock:Document"..ChatId,"ktm")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"✦ تم قفـل الملفات").lockKtm, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_videoktm') then
local UserId = Text:match('(%d+)/lock_videoktm')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(TeleGod.."Lock:Video"..ChatId,"ktm")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"✦ تم قفـل الفيديو").lockKtm, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_photoktm') then
local UserId = Text:match('(%d+)/lock_photoktm')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(TeleGod.."Lock:Photo"..ChatId,"ktm")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"✦ تم قفـل الصور").lockKtm, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_usernamektm') then
local UserId = Text:match('(%d+)/lock_usernamektm')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(TeleGod.."Lock:User:Name"..ChatId,"ktm")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"✦ تم قفـل المعرفات").lockKtm, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_tagsktm') then
local UserId = Text:match('(%d+)/lock_tagsktm')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(TeleGod.."Lock:hashtak"..ChatId,"ktm")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"✦ تم قفـل التاك").lockKtm, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_fwdktm') then
local UserId = Text:match('(%d+)/lock_fwdktm')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(TeleGod.."Lock:forward"..ChatId,"ktm")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"✦ تم قفـل التوجيه").lockKtm, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_audioktm') then
local UserId = Text:match('(%d+)/lock_audioktm')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(TeleGod.."Lock:Audio"..ChatId,"ktm")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"✦ تم قفـل الصوت").lockKtm, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_stikearktm') then
local UserId = Text:match('(%d+)/lock_stikearktm')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(TeleGod.."Lock:Sticker"..ChatId,"ktm")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"✦ تم قفـل الملصقات").lockKtm, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_phonektm') then
local UserId = Text:match('(%d+)/lock_phonektm')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(TeleGod.."Lock:Contact"..ChatId,"ktm")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"✦ تم قفـل الجهات").lockKtm, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_videonotektm') then
local UserId = Text:match('(%d+)/lock_videonotektm')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(TeleGod.."Lock:Unsupported"..ChatId,"ktm")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"✦ تم قفـل بصمه الفيديو").lockKtm, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_markdaunktm') then
local UserId = Text:match('(%d+)/lock_markdaunktm')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(TeleGod.."Lock:Markdaun"..ChatId,"ktm")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"✦ تم قفـل الماركدون").lockKtm, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_gamesktm') then
local UserId = Text:match('(%d+)/lock_gamesktm')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(TeleGod.."Lock:geam"..ChatId,"ktm")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"✦ تم قفـل الالعاب").lockKtm, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_floodktm') then
local UserId = Text:match('(%d+)/lock_floodktm')
if tonumber(IdUser) == tonumber(UserId) then
Redis:hset(TeleGod.."Spam:Group:User"..ChatId ,"Spam:User","mute")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"✦ تم قفـل التكرار").lockKtm, 'md', true, false, reply_markup)
end
end
if Text and Text:match('(%d+)/lock_linkkick') then
local UserId = Text:match('(%d+)/lock_linkkick')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(TeleGod.."Lock:Link"..ChatId,"kick")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"✦ تم قفـل الروابط").lockKick, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_spamkick') then
local UserId = Text:match('(%d+)/lock_spamkick')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(TeleGod.."Lock:Spam"..ChatId,"kick")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"✦ تم قفـل الكلايش").lockKick, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_keypordkick') then
local UserId = Text:match('(%d+)/lock_keypordkick')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(TeleGod.."Lock:Keyboard"..ChatId,"kick")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"✦ تم قفـل الكيبورد").lockKick, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_voicekick') then
local UserId = Text:match('(%d+)/lock_voicekick')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(TeleGod.."Lock:vico"..ChatId,"kick")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"✦ تم قفـل الاغاني").lockKick, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_gifkick') then
local UserId = Text:match('(%d+)/lock_gifkick')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(TeleGod.."Lock:Animation"..ChatId,"kick")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"✦ تم قفـل المتحركات").lockKick, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_fileskick') then
local UserId = Text:match('(%d+)/lock_fileskick')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(TeleGod.."Lock:Document"..ChatId,"kick")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"✦ تم قفـل الملفات").lockKick, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_videokick') then
local UserId = Text:match('(%d+)/lock_videokick')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(TeleGod.."Lock:Video"..ChatId,"kick")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"✦ تم قفـل الفيديو").lockKick, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_photokick') then
local UserId = Text:match('(%d+)/lock_photokick')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(TeleGod.."Lock:Photo"..ChatId,"kick")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"✦ تم قفـل الصور").lockKick, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_usernamekick') then
local UserId = Text:match('(%d+)/lock_usernamekick')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(TeleGod.."Lock:User:Name"..ChatId,"kick")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"✦ تم قفـل المعرفات").lockKick, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_tagskick') then
local UserId = Text:match('(%d+)/lock_tagskick')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(TeleGod.."Lock:hashtak"..ChatId,"kick")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"✦ تم قفـل التاك").lockKick, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_fwdkick') then
local UserId = Text:match('(%d+)/lock_fwdkick')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(TeleGod.."Lock:forward"..ChatId,"kick")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"✦ تم قفـل التوجيه").lockKick, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_audiokick') then
local UserId = Text:match('(%d+)/lock_audiokick')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(TeleGod.."Lock:Audio"..ChatId,"kick")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"✦ تم قفـل الصوت").lockKick, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_stikearkick') then
local UserId = Text:match('(%d+)/lock_stikearkick')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(TeleGod.."Lock:Sticker"..ChatId,"kick")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"✦ تم قفـل الملصقات").lockKick, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_phonekick') then
local UserId = Text:match('(%d+)/lock_phonekick')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(TeleGod.."Lock:Contact"..ChatId,"kick")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"✦ تم قفـل الجهات").lockKick, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_videonotekick') then
local UserId = Text:match('(%d+)/lock_videonotekick')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(TeleGod.."Lock:Unsupported"..ChatId,"kick")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"✦ تم قفـل بصمه الفيديو").lockKick, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_markdaunkick') then
local UserId = Text:match('(%d+)/lock_markdaunkick')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(TeleGod.."Lock:Markdaun"..ChatId,"kick")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"✦ تم قفـل الماركدون").lockKick, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_gameskick') then
local UserId = Text:match('(%d+)/lock_gameskick')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(TeleGod.."Lock:geam"..ChatId,"kick")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"✦ تم قفـل الالعاب").lockKick, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/lock_floodkick') then
local UserId = Text:match('(%d+)/lock_floodkick')
if tonumber(IdUser) == tonumber(UserId) then
Redis:hset(TeleGod.."Spam:Group:User"..ChatId ,"Spam:User","kick")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"✦ تم قفـل التكرار").lockKick, 'md', true, false, reply_markup)
end
end
if Text and Text:match('(%d+)/unmute_link') then
local UserId = Text:match('(%d+)/unmute_link')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(TeleGod.."Status:Link"..ChatId) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'listallAddorrem'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"✦ تم تعطيل امر الرابط").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unmute_welcome') then
local UserId = Text:match('(%d+)/unmute_welcome')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(TeleGod.."Status:Welcome"..ChatId) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'listallAddorrem'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"✦ تم تعطيل امر الترحيب").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unmute_Id') then
local UserId = Text:match('(%d+)/unmute_Id')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(TeleGod.."Status:Id"..ChatId) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'listallAddorrem'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"✦ تم تعطيل امر الايدي").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unmute_IdPhoto') then
local UserId = Text:match('(%d+)/unmute_IdPhoto')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(TeleGod.."Status:IdPhoto"..ChatId) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'listallAddorrem'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"✦ تم تعطيل امر الايدي بالصوره").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unmute_kicknum') and data.Creator then
local UserId = Text:match('(%d+)/unmute_kicknum')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(TeleGod.."spammkick"..ChatId,true) 
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'listallAddorrem'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"⌯ تم تعطيل امر منع التصفيه").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unmute_ryple') then
local UserId = Text:match('(%d+)/unmute_ryple')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(TeleGod.."Status:Reply"..ChatId,true) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'listallAddorrem'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"✦ تم تعطيل امر الردود").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unmute_ryplesudo') then
local UserId = Text:match('(%d+)/unmute_ryplesudo')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(TeleGod.."Status:ReplySudo"..ChatId,true) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'listallAddorrem'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"✦ تم تعطيل امر الردود العامه").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unmute_setadmib') then
local UserId = Text:match('(%d+)/unmute_setadmib')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(TeleGod.."Status:SetId"..ChatId) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'listallAddorrem'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"✦ تم تعطيل امر الرفع").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unmute_kickmembars') then
local UserId = Text:match('(%d+)/unmute_kickmembars')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(TeleGod.."Status:BanId"..ChatId) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'listallAddorrem'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"✦ تم تعطيل امر الطرد - الحظر").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unmute_games') then
local UserId = Text:match('(%d+)/unmute_games')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(TeleGod.."Status:Games"..ChatId) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'listallAddorrem'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"✦ تم تعطيل امر الالعاب").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unmute_kickme') then
local UserId = Text:match('(%d+)/unmute_kickme')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(TeleGod.."Status:KickMe"..ChatId) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'listallAddorrem'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"✦ تم تعطيل امر اطردني").unLock, 'md', true, false, reply_markup)
end
end
if Text and Text:match('(%d+)/mute_link') then
local UserId = Text:match('(%d+)/mute_link')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(TeleGod.."Status:Link"..ChatId,true) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'listallAddorrem'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"✦ تم تفعيل امر الرابط").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/mute_kicknum') and data.SuperCreator then
local UserId = Text:match('(%d+)/mute_kicknum')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(TeleGod.."spammkick"..ChatId)
local reply_markup = bot.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'listallAddorrem'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"⌯ تم تفعيل امر منع التصفيه").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/mute_welcome') then
local UserId = Text:match('(%d+)/mute_welcome')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(TeleGod.."Status:Welcome"..ChatId,true) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'listallAddorrem'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"✦ تم تفعيل امر الترحيب").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/mute_Id') then
local UserId = Text:match('(%d+)/mute_Id')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(TeleGod.."Status:Id"..ChatId,true) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'listallAddorrem'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"✦ تم تفعيل امر الايدي").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/mute_IdPhoto') then
local UserId = Text:match('(%d+)/mute_IdPhoto')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(TeleGod.."Status:IdPhoto"..ChatId,true) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'listallAddorrem'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"✦ تم تفعيل امر الايدي بالصوره").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/mute_ryple') then
local UserId = Text:match('(%d+)/mute_ryple')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(TeleGod.."Status:Reply"..ChatId) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'listallAddorrem'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"✦ تم تفعيل امر الردود").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/mute_ryplesudo') then
local UserId = Text:match('(%d+)/mute_ryplesudo')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(TeleGod.."Status:ReplySudo"..ChatId) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'listallAddorrem'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"✦ تم تفعيل امر الردود العامه").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/mute_setadmib') then
local UserId = Text:match('(%d+)/mute_setadmib')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(TeleGod.."Status:SetId"..ChatId,true) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'listallAddorrem'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"✦ تم تفعيل امر الرفع").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/mute_kickmembars') then
local UserId = Text:match('(%d+)/mute_kickmembars')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(TeleGod.."Status:BanId"..ChatId,true) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'listallAddorrem'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"✦ تم تفعيل امر الطرد - الحظر").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/mute_games') then
local UserId = Text:match('(%d+)/mute_games')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(TeleGod.."Status:Games"..ChatId,true) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'listallAddorrem'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"✦ تم تفعيل امر الالعاب").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/mute_kickme') then
local UserId = Text:match('(%d+)/mute_kickme')
if tonumber(IdUser) == tonumber(UserId) then
Redis:set(TeleGod.."Status:KickMe"..ChatId,true) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'listallAddorrem'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"✦ تم تفعيل امر اطردني").unLock, 'md', true, false, reply_markup)
end
end
if Text and Text:match('(%d+)/Fdmin@(.*)') then
local UserId = {Text:match('(%d+)/Fdmin@(.*)')}
if tonumber(IdUser) == tonumber(UserId[1]) then
local Info_Members = LuaTele.getSupergroupMembers(UserId[2], "Administrators", "*", 0, 200)
local List_Members = Info_Members.members
x = 0
y = 0
for k, v in pairs(List_Members) do
if Info_Members.members[k].bot_info == nil then
if Info_Members.members[k].status.luatele == "chatMemberStatusCreator" then
Redis:sadd(TeleGod.."Owners:Group"..UserId[2],v.member_id.user_id) 
x = x + 1
else
Redis:sadd(TeleGod.."Admin:Group"..UserId[2],v.member_id.user_id) 
y = y + 1
end
end
end
LuaTele.answerCallbackQuery(data.id, "✦ تم ترقيه {"..y.."} ادمنيه \n✦ تم ترقية المالك ", true)
end
end
if Text and Text:match('(%d+)/LockAllGroup@(.*)') then
local UserId = {Text:match('(%d+)/LockAllGroup@(.*)')}
if tonumber(IdUser) == tonumber(UserId[1]) then
Redis:set(TeleGod.."Lock:tagservrbot"..UserId[2],true)   
list ={"Lock:Bot:kick","Lock:User:Name","Lock:hashtak","Lock:Cmd","Lock:Link","Lock:forward","Lock:Keyboard","Lock:geam","Lock:Photo","Lock:Animation","Lock:Video","Lock:Audio","Lock:vico","Lock:Sticker","Lock:Document","Lock:Unsupported","Lock:Markdaun","Lock:Contact","Lock:Spam"}
for i,lock in pairs(list) do 
Redis:set(TeleGod..''..lock..UserId[2],"del")    
end
LuaTele.answerCallbackQuery(data.id, "✦ تم قفل جميع الاوامر بنجاح  ", true)
end
end
if Text and Text:match('/leftgroup@(.*)') then
local UserId = Text:match('/leftgroup@(.*)')
LuaTele.answerCallbackQuery(data.id, "✦ تم مغادره البوت من الجروب", true)
LuaTele.leaveChat(UserId)
end


if Text and Text:match('(%d+)/groupNumseteng//(%d+)') then
local UserId = {Text:match('(%d+)/groupNumseteng//(%d+)')}
if tonumber(IdUser) == tonumber(UserId[1]) then
return GetAdminsSlahe(ChatId,UserId[1],UserId[2],Msg_id)
end
end
if Text and Text:match('(%d+)/groupNum1//(%d+)') then
local UserId = {Text:match('(%d+)/groupNum1//(%d+)')}
if tonumber(IdUser) == tonumber(UserId[1]) then
if tonumber(GetAdminsNum(ChatId,UserId[2]).change_info) == 1 then
LuaTele.answerCallbackQuery(data.id, "✦ تم تعطيل صلاحيه تغيير المعلومات", true)
GetAdminsSlahe(ChatId,UserId[1],UserId[2],Msg_id,'❬ ❌ ❭',nil,nil,nil,nil,nil)
LuaTele.setChatMemberStatus(ChatId,UserId[2],'administrator',{0 ,0, 0, 0, 0,0,0,1,0})
else
LuaTele.answerCallbackQuery(data.id, "✦ تم تفعيل صلاحيه تغيير المعلومات", true)
GetAdminsSlahe(ChatId,UserId[1],UserId[2],Msg_id,'❬ ✔️ ❭',nil,nil,nil,nil,nil)
LuaTele.setChatMemberStatus(ChatId,UserId[2],'administrator',{0 ,1, 0, 0, GetAdminsNum(ChatId,UserId[2]).delete_messages, GetAdminsNum(ChatId,UserId[2]).invite_users, GetAdminsNum(ChatId,UserId[2]).restrict_members ,GetAdminsNum(ChatId,UserId[2]).pin_messages, GetAdminsNum(ChatId,UserId[2]).promote})
end
end
end
if Text and Text:match('(%d+)/groupNum2//(%d+)') then
local UserId = {Text:match('(%d+)/groupNum2//(%d+)')}
if tonumber(IdUser) == tonumber(UserId[1]) then
if tonumber(GetAdminsNum(ChatId,UserId[2]).pin_messages) == 1 then
LuaTele.answerCallbackQuery(data.id, "✦ تم تعطيل صلاحيه التثبيت", true)
GetAdminsSlahe(ChatId,UserId[1],UserId[2],Msg_id,nil,'❬ ❌ ❭',nil,nil,nil,nil)
LuaTele.setChatMemberStatus(ChatId,UserId[2],'administrator',{0 ,GetAdminsNum(ChatId,UserId[2]).change_info, 0, 0, GetAdminsNum(ChatId,UserId[2]).delete_messages, GetAdminsNum(ChatId,UserId[2]).invite_users, GetAdminsNum(ChatId,UserId[2]).restrict_members ,0, GetAdminsNum(ChatId,UserId[2]).promote})
else
LuaTele.answerCallbackQuery(data.id, "✦ تم تفعيل صلاحيه التثبيت", true)
GetAdminsSlahe(ChatId,UserId[1],UserId[2],Msg_id,nil,'❬ ✔️ ❭',nil,nil,nil,nil)
LuaTele.setChatMemberStatus(ChatId,UserId[2],'administrator',{0 ,GetAdminsNum(ChatId,UserId[2]).change_info, 0, 0, GetAdminsNum(ChatId,UserId[2]).delete_messages, GetAdminsNum(ChatId,UserId[2]).invite_users, GetAdminsNum(ChatId,UserId[2]).restrict_members ,1, GetAdminsNum(ChatId,UserId[2]).promote})
end
end
end
if Text and Text:match('(%d+)/groupNum3//(%d+)') then
local UserId = {Text:match('(%d+)/groupNum3//(%d+)')}
if tonumber(IdUser) == tonumber(UserId[1]) then
if tonumber(GetAdminsNum(ChatId,UserId[2]).restrict_members) == 1 then
LuaTele.answerCallbackQuery(data.id, "✦ تم تعطيل صلاحيه الحظر", true)
GetAdminsSlahe(ChatId,UserId[1],UserId[2],Msg_id,nil,nil,'❬ ❌ ❭',nil,nil,nil)
LuaTele.setChatMemberStatus(ChatId,UserId[2],'administrator',{0 ,GetAdminsNum(ChatId,UserId[2]).change_info, 0, 0, GetAdminsNum(ChatId,UserId[2]).delete_messages, GetAdminsNum(ChatId,UserId[2]).invite_users, 0 ,GetAdminsNum(ChatId,UserId[2]).pin_messages, GetAdminsNum(ChatId,UserId[2]).promote})
else
LuaTele.answerCallbackQuery(data.id, "✦ تم تفعيل صلاحيه الحظر", true)
GetAdminsSlahe(ChatId,UserId[1],UserId[2],Msg_id,nil,nil,'❬ ✔️ ❭',nil,nil,nil)
LuaTele.setChatMemberStatus(ChatId,UserId[2],'administrator',{0 ,GetAdminsNum(ChatId,UserId[2]).change_info, 0, 0, GetAdminsNum(ChatId,UserId[2]).delete_messages, GetAdminsNum(ChatId,UserId[2]).invite_users, 1 ,GetAdminsNum(ChatId,UserId[2]).pin_messages, GetAdminsNum(ChatId,UserId[2]).promote})
end
end
end
if Text and Text:match('(%d+)/groupNum4//(%d+)') then
local UserId = {Text:match('(%d+)/groupNum4//(%d+)')}
if tonumber(IdUser) == tonumber(UserId[1]) then
if tonumber(GetAdminsNum(ChatId,UserId[2]).invite_users) == 1 then
LuaTele.answerCallbackQuery(data.id, "✦ تم تعطيل صلاحيه دعوه المستخدمين", true)
GetAdminsSlahe(ChatId,UserId[1],UserId[2],Msg_id,nil,nil,nil,'❬ ❌ ❭',nil,nil)
LuaTele.setChatMemberStatus(ChatId,UserId[2],'administrator',{0 ,GetAdminsNum(ChatId,UserId[2]).change_info, 0, 0, GetAdminsNum(ChatId,UserId[2]).delete_messages, 0, GetAdminsNum(ChatId,UserId[2]).restrict_members ,GetAdminsNum(ChatId,UserId[2]).pin_messages, GetAdminsNum(ChatId,UserId[2]).promote})
else
LuaTele.answerCallbackQuery(data.id, "✦ تم تفعيل صلاحيه دعوه المستخدمين", true)
GetAdminsSlahe(ChatId,UserId[1],UserId[2],Msg_id,nil,nil,nil,'❬ ✔️ ❭',nil,nil)
LuaTele.setChatMemberStatus(ChatId,UserId[2],'administrator',{0 ,GetAdminsNum(ChatId,UserId[2]).change_info, 0, 0, GetAdminsNum(ChatId,UserId[2]).delete_messages, 1, GetAdminsNum(ChatId,UserId[2]).restrict_members ,GetAdminsNum(ChatId,UserId[2]).pin_messages, GetAdminsNum(ChatId,UserId[2]).promote})
end
end
end
if Text and Text:match('(%d+)/groupNum5//(%d+)') then
local UserId = {Text:match('(%d+)/groupNum5//(%d+)')}
if tonumber(IdUser) == tonumber(UserId[1]) then
if tonumber(GetAdminsNum(ChatId,UserId[2]).delete_messages) == 1 then
LuaTele.answerCallbackQuery(data.id, "✦ تم تعطيل صلاحيه مسح الرسائل", true)
GetAdminsSlahe(ChatId,UserId[1],UserId[2],Msg_id,nil,nil,nil,nil,'❬ ❌ ❭',nil)
LuaTele.setChatMemberStatus(ChatId,UserId[2],'administrator',{0 ,GetAdminsNum(ChatId,UserId[2]).change_info, 0, 0, 0, GetAdminsNum(ChatId,UserId[2]).invite_users, GetAdminsNum(ChatId,UserId[2]).restrict_members ,GetAdminsNum(ChatId,UserId[2]).pin_messages, GetAdminsNum(ChatId,UserId[2]).promote})
else
LuaTele.answerCallbackQuery(data.id, "✦ تم تفعيل صلاحيه مسح الرسائل", true)
GetAdminsSlahe(ChatId,UserId[1],UserId[2],Msg_id,nil,nil,nil,nil,'❬ ✔️ ❭',nil)
LuaTele.setChatMemberStatus(ChatId,UserId[2],'administrator',{0 ,GetAdminsNum(ChatId,UserId[2]).change_info, 0, 0, 1, GetAdminsNum(ChatId,UserId[2]).invite_users, GetAdminsNum(ChatId,UserId[2]).restrict_members ,GetAdminsNum(ChatId,UserId[2]).pin_messages, GetAdminsNum(ChatId,UserId[2]).promote})
end
end
end
if Text and Text:match('(%d+)/groupNum6//(%d+)') then
local UserId = {Text:match('(%d+)/groupNum6//(%d+)')}
if tonumber(IdUser) == tonumber(UserId[1]) then
if tonumber(GetAdminsNum(ChatId,UserId[2]).promote) == 1 then
LuaTele.answerCallbackQuery(data.id, "✦ تم تعطيل صلاحيه اضافه مشرفين", true)
GetAdminsSlahe(ChatId,UserId[1],UserId[2],Msg_id,nil,nil,nil,nil,nil,'❬ ❌ ❭')
LuaTele.setChatMemberStatus(ChatId,UserId[2],'administrator',{0 ,GetAdminsNum(ChatId,UserId[2]).change_info, 0, 0, GetAdminsNum(ChatId,UserId[2]).delete_messages, GetAdminsNum(ChatId,UserId[2]).invite_users, GetAdminsNum(ChatId,UserId[2]).restrict_members ,GetAdminsNum(ChatId,UserId[2]).pin_messages, 0})
else
LuaTele.answerCallbackQuery(data.id, "✦ تم تفعيل صلاحيه اضافه مشرفين", true)
GetAdminsSlahe(ChatId,UserId[1],UserId[2],Msg_id,nil,nil,nil,nil,nil,'❬ ✔️ ❭')
LuaTele.setChatMemberStatus(ChatId,UserId[2],'administrator',{0 ,GetAdminsNum(ChatId,UserId[2]).change_info, 0, 0, GetAdminsNum(ChatId,UserId[2]).delete_messages, GetAdminsNum(ChatId,UserId[2]).invite_users, GetAdminsNum(ChatId,UserId[2]).restrict_members ,GetAdminsNum(ChatId,UserId[2]).pin_messages, 1})
end
end
end

if Text and Text:match('(%d+)/web') then
local UserId = Text:match('(%d+)/web')
if tonumber(IdUser) == tonumber(UserId) then
if Getpermissions(ChatId).web == true then
LuaTele.setChatPermissions(ChatId, Getpermissions(ChatId).messges, Getpermissions(ChatId).media, Getpermissions(ChatId).polls, Getpermissions(ChatId).other, false, Getpermissions(ChatId).info, Getpermissions(ChatId).invite, Getpermissions(ChatId).pin)
else
LuaTele.setChatPermissions(ChatId, Getpermissions(ChatId).messges, Getpermissions(ChatId).media, Getpermissions(ChatId).polls, Getpermissions(ChatId).other, true, Getpermissions(ChatId).info, Getpermissions(ChatId).invite, Getpermissions(ChatId).pin)
end
Get_permissions(ChatId,IdUser,Msg_id)
end
elseif Text and Text:match('(%d+)/info') then
local UserId = Text:match('(%d+)/info')
if tonumber(IdUser) == tonumber(UserId) then
if Getpermissions(ChatId).info == true then
LuaTele.setChatPermissions(ChatId, Getpermissions(ChatId).messges, Getpermissions(ChatId).media, Getpermissions(ChatId).polls, Getpermissions(ChatId).other, Getpermissions(ChatId).web, false, Getpermissions(ChatId).invite, Getpermissions(ChatId).pin)
else
LuaTele.setChatPermissions(ChatId, Getpermissions(ChatId).messges, Getpermissions(ChatId).media, Getpermissions(ChatId).polls, Getpermissions(ChatId).other, Getpermissions(ChatId).web, true, Getpermissions(ChatId).invite, Getpermissions(ChatId).pin)
end
Get_permissions(ChatId,IdUser,Msg_id)
end
elseif Text and Text:match('(%d+)/invite') then
local UserId = Text:match('(%d+)/invite')
if tonumber(IdUser) == tonumber(UserId) then
if Getpermissions(ChatId).invite == true then
LuaTele.setChatPermissions(ChatId, Getpermissions(ChatId).messges, Getpermissions(ChatId).media, Getpermissions(ChatId).polls, Getpermissions(ChatId).other, Getpermissions(ChatId).web, Getpermissions(ChatId).info, false, Getpermissions(ChatId).pin)
else
LuaTele.setChatPermissions(ChatId, Getpermissions(ChatId).messges, Getpermissions(ChatId).media, Getpermissions(ChatId).polls, Getpermissions(ChatId).other, Getpermissions(ChatId).web, Getpermissions(ChatId).info, true, Getpermissions(ChatId).pin)
end
Get_permissions(ChatId,IdUser,Msg_id)
end
elseif Text and Text:match('(%d+)/pin') then
local UserId = Text:match('(%d+)/pin')
if tonumber(IdUser) == tonumber(UserId) then
if Getpermissions(ChatId).pin == true then
LuaTele.setChatPermissions(ChatId, Getpermissions(ChatId).messges, Getpermissions(ChatId).media, Getpermissions(ChatId).polls, Getpermissions(ChatId).other, Getpermissions(ChatId).web, Getpermissions(ChatId).info, Getpermissions(ChatId).invite, false)
else
LuaTele.setChatPermissions(ChatId, Getpermissions(ChatId).messges, Getpermissions(ChatId).media, Getpermissions(ChatId).polls, Getpermissions(ChatId).other, Getpermissions(ChatId).web, Getpermissions(ChatId).info, Getpermissions(ChatId).invite, true)
end
Get_permissions(ChatId,IdUser,Msg_id)
end
elseif Text and Text:match('(%d+)/media') then
local UserId = Text:match('(%d+)/media')
if tonumber(IdUser) == tonumber(UserId) then
if Getpermissions(ChatId).media == true then
LuaTele.setChatPermissions(ChatId, Getpermissions(ChatId).messges, false, Getpermissions(ChatId).polls, Getpermissions(ChatId).other, Getpermissions(ChatId).web, Getpermissions(ChatId).info, Getpermissions(ChatId).invite, Getpermissions(ChatId).pin)
else
LuaTele.setChatPermissions(ChatId, Getpermissions(ChatId).messges, true, Getpermissions(ChatId).polls, Getpermissions(ChatId).other, Getpermissions(ChatId).web, Getpermissions(ChatId).info, Getpermissions(ChatId).invite, Getpermissions(ChatId).pin)
end
Get_permissions(ChatId,IdUser,Msg_id)
end
elseif Text and Text:match('(%d+)/messges') then
local UserId = Text:match('(%d+)/messges')
if tonumber(IdUser) == tonumber(UserId) then
if Getpermissions(ChatId).messges == true then
LuaTele.setChatPermissions(ChatId, false, Getpermissions(ChatId).media, Getpermissions(ChatId).polls, Getpermissions(ChatId).other, Getpermissions(ChatId).web, Getpermissions(ChatId).info, Getpermissions(ChatId).invite, Getpermissions(ChatId).pin)
else
LuaTele.setChatPermissions(ChatId, true, Getpermissions(ChatId).media, Getpermissions(ChatId).polls, Getpermissions(ChatId).other, Getpermissions(ChatId).web, Getpermissions(ChatId).info, Getpermissions(ChatId).invite, Getpermissions(ChatId).pin)
end
Get_permissions(ChatId,IdUser,Msg_id)
end
elseif Text and Text:match('(%d+)/other') then
local UserId = Text:match('(%d+)/other')
if tonumber(IdUser) == tonumber(UserId) then
if Getpermissions(ChatId).other == true then
LuaTele.setChatPermissions(ChatId, Getpermissions(ChatId).messges, Getpermissions(ChatId).media, Getpermissions(ChatId).polls, false, Getpermissions(ChatId).web, Getpermissions(ChatId).info, Getpermissions(ChatId).invite, Getpermissions(ChatId).pin)
else
LuaTele.setChatPermissions(ChatId, Getpermissions(ChatId).messges, Getpermissions(ChatId).media, Getpermissions(ChatId).polls, true, Getpermissions(ChatId).web, Getpermissions(ChatId).info, Getpermissions(ChatId).invite, Getpermissions(ChatId).pin)
end
Get_permissions(ChatId,IdUser,Msg_id)
end
elseif Text and Text:match('(%d+)/polls') then
local UserId = Text:match('(%d+)/polls')
if tonumber(IdUser) == tonumber(UserId) then
if Getpermissions(ChatId).polls == true then
LuaTele.setChatPermissions(ChatId, Getpermissions(ChatId).messges, Getpermissions(ChatId).media, false, Getpermissions(ChatId).other, Getpermissions(ChatId).web, Getpermissions(ChatId).info, Getpermissions(ChatId).invite, Getpermissions(ChatId).pin)
else
LuaTele.setChatPermissions(ChatId, Getpermissions(ChatId).messges, Getpermissions(ChatId).media, true, Getpermissions(ChatId).other, Getpermissions(ChatId).web, Getpermissions(ChatId).info, Getpermissions(ChatId).invite, Getpermissions(ChatId).pin)
end
Get_permissions(ChatId,IdUser,Msg_id)
end
end

if Text == '/leftz@' then
LuaTele.editMessageText(ChatId,Msg_id,"*✦ ارسل الكلمه لزخرفتها عربي او انجلش*","md",true) 
Redis:set(TeleGod.."zhrfa"..IdUser,"sendzh") 
end 

if Text and Text:match('(%d+)/listallAddorrem') then
local UserId = Text:match('(%d+)/listallAddorrem')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = 'تعطيل الرابط', data = IdUser..'/'.. 'unmute_link'},{text = 'تفعيل الرابط', data = IdUser..'/'.. 'mute_link'},
},
{
{text = 'تعطيل الترحيب', data = IdUser..'/'.. 'unmute_welcome'},{text = 'تفعيل الترحيب', data = IdUser..'/'.. 'mute_welcome'},
},
{
{text = 'اتعطيل الايدي', data = IdUser..'/'.. 'unmute_Id'},{text = 'اتفعيل الايدي', data = IdUser..'/'.. 'mute_Id'},
},
{
{text = 'تعطيل الايدي بالصوره', data = IdUser..'/'.. 'unmute_IdPhoto'},{text = 'تفعيل الايدي بالصوره', data = IdUser..'/'.. 'mute_IdPhoto'},
},
{
{text = 'تعطيل الردود', data = IdUser..'/'.. 'unmute_ryple'},{text = 'تفعيل الردود', data = IdUser..'/'.. 'mute_ryple'},
},
{
{text = 'تعطيل الردود العامه', data = IdUser..'/'.. 'unmute_ryplesudo'},{text = 'تفعيل الردود العامه', data = IdUser..'/'.. 'mute_ryplesudo'},
},
{
{text = 'تعطيل الرفع', data = IdUser..'/'.. 'unmute_setadmib'},{text = 'تفعيل الرفع', data = IdUser..'/'.. 'mute_setadmib'},
},
{
{text = 'تعطيل الطرد', data = IdUser..'/'.. 'unmute_kickmembars'},{text = 'تفعيل الطرد', data = IdUser..'/'.. 'mute_kickmembars'},
},
{
{text = 'تعطيل الالعاب', data = IdUser..'/'.. 'unmute_games'},{text = 'تفعيل الالعاب', data = IdUser..'/'.. 'mute_games'},
},
{
{text = 'تعطيل اطردني', data = IdUser..'/'.. 'unmute_kickme'},{text = 'تفعيل اطردني', data = IdUser..'/'.. 'mute_kickme'},
},
{
{text = 'القائمه الرئيسيه', data = IdUser..'/helpall'},
},
{
{text = '- اخفاء الامر ', data =IdUser..'/'.. 'delAmr'}
},
}
}
return edit(ChatId,Msg_id,'✦ اوامر التفعيل والتعطيل ', 'md', false, false, reply_markup)
end
end
if Text and Text:match('(%d+)/NextSeting') then
local UserId = Text:match('(%d+)/NextSeting')
if tonumber(IdUser) == tonumber(UserId) then
local Text = "*\n✦ اعدادات الجروب ".."\n✦ علامة ال (✔️) تعني مقفول".."\n✦ علامة ال (❌) تعني مفتوح*"
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = GetSetieng(ChatId).lock_fwd, data = '&'},{text = 'التوجبه : ', data =IdUser..'/'.. 'Status_fwd'},
},
{
{text = GetSetieng(ChatId).lock_muse, data = '&'},{text = 'الصوت : ', data =IdUser..'/'.. 'Status_audio'},
},
{
{text = GetSetieng(ChatId).lock_ste, data = '&'},{text = 'الملصقات : ', data =IdUser..'/'.. 'Status_stikear'},
},
{
{text = GetSetieng(ChatId).lock_phon, data = '&'},{text = 'الجهات : ', data =IdUser..'/'.. 'Status_phone'},
},
{
{text = GetSetieng(ChatId).lock_join, data = '&'},{text = 'الدخول : ', data =IdUser..'/'.. 'Status_joine'},
},
{
{text = GetSetieng(ChatId).lock_add, data = '&'},{text = 'الاضافه : ', data =IdUser..'/'.. 'Status_addmem'},
},
{
{text = GetSetieng(ChatId).lock_self, data = '&'},{text = 'بصمه فيديو : ', data =IdUser..'/'.. 'Status_videonote'},
},
{
{text = GetSetieng(ChatId).lock_pin, data = '&'},{text = 'التثبيت : ', data =IdUser..'/'.. 'Status_pin'},
},
{
{text = GetSetieng(ChatId).lock_tagservr, data = '&'},{text = 'الاشعارات : ', data =IdUser..'/'.. 'Status_tgservir'},
},
{
{text = GetSetieng(ChatId).lock_mark, data = '&'},{text = 'الماركدون : ', data =IdUser..'/'.. 'Status_markdaun'},
},
{
{text = GetSetieng(ChatId).lock_edit, data = '&'},{text = 'التعديل : ', data =IdUser..'/'.. 'Status_edits'},
},
{
{text = GetSetieng(ChatId).lock_geam, data = '&'},{text = 'الالعاب : ', data =IdUser..'/'.. 'Status_games'},
},
{
{text = GetSetieng(ChatId).flood, data = '&'},{text = 'التكرار : ', data =IdUser..'/'.. 'Status_flood'},
},
{
{text = '- الرجوع ... ', data =IdUser..'/'.. 'NoNextSeting'}
},
{
{text = 'القائمه الرئيسيه', data = IdUser..'/helpall'},
},
{
{text = '- اخفاء الامر ', data =IdUser..'/'.. '/delAmr'}
},
}
}
edit(ChatId,Msg_id,Text, 'md', false, false, reply_markup)
end
end
if Text and Text:match('(%d+)/NoNextSeting') then
local UserId = Text:match('(%d+)/NoNextSeting')
if tonumber(IdUser) == tonumber(UserId) then
local Text = "*\n✦ اعدادات الجروب ".."\n✦ علامة ال (✔️) تعني مقفول".."\n✦ علامة ال (❌) تعني مفتوح*"
local reply_markup = LuaTele.replyMarkup{
type = 'inline',
data = {
{
{text = GetSetieng(ChatId).lock_links, data = '&'},{text = 'الروابط : ', data =IdUser..'/'.. 'Status_link'},
},
{
{text = GetSetieng(ChatId).lock_spam, data = '&'},{text = 'الكلايش : ', data =IdUser..'/'.. 'Status_spam'},
},
{
{text = GetSetieng(ChatId).lock_inlin, data = '&'},{text = 'الكيبورد : ', data =IdUser..'/'.. 'Status_keypord'},
},
{
{text = GetSetieng(ChatId).lock_vico, data = '&'},{text = 'الاغاني : ', data =IdUser..'/'.. 'Status_voice'},
},
{
{text = GetSetieng(ChatId).lock_gif, data = '&'},{text = 'المتحركه : ', data =IdUser..'/'.. 'Status_gif'},
},
{
{text = GetSetieng(ChatId).lock_file, data = '&'},{text = 'الملفات : ', data =IdUser..'/'.. 'Status_files'},
},
{
{text = GetSetieng(ChatId).lock_text, data = '&'},{text = 'الدردشه : ', data =IdUser..'/'.. 'Status_text'},
},
{
{text = GetSetieng(ChatId).lock_ved, data = '&'},{text = 'الفيديو : ', data =IdUser..'/'.. 'Status_video'},
},
{
{text = GetSetieng(ChatId).lock_photo, data = '&'},{text = 'الصور : ', data =IdUser..'/'.. 'Status_photo'},
},
{
{text = GetSetieng(ChatId).lock_user, data = '&'},{text = 'المعرفات : ', data =IdUser..'/'.. 'Status_username'},
},
{
{text = GetSetieng(ChatId).lock_hash, data = '&'},{text = 'التاك : ', data =IdUser..'/'.. 'Status_tags'},
},
{
{text = GetSetieng(ChatId).lock_bots, data = '&'},{text = 'البوتات : ', data =IdUser..'/'.. 'Status_bots'},
},
{
{text = '- التالي ... ', data =IdUser..'/'.. 'NextSeting'}
},
{
{text = 'القائمه الرئيسيه', data = IdUser..'/helpall'},
},
{
{text = '- اخفاء الامر ', data =IdUser..'/'.. 'delAmr'}
},
}
}
edit(ChatId,Msg_id,Text, 'md', false, false, reply_markup)
end
end 
if Text and Text:match('(%d+)/delAmr') then
local UserId = Text:match('(%d+)/delAmr')
if tonumber(IdUser) == tonumber(UserId) then
return LuaTele.deleteMessages(ChatId,{[1]= Msg_id})
end
end
if Text and Text:match('(%d+)/Status_link') then
local UserId = Text:match('(%d+)/Status_link')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل الروابط', data =UserId..'/'.. 'lock_link'},{text = 'قفل الروابط بالكتم', data =UserId..'/'.. 'lock_linkktm'},
},
{
{text = 'قفل الروابط بالطرد', data =UserId..'/'.. 'lock_linkkick'},{text = 'قفل الروابط بالتقييد', data =UserId..'/'.. 'lock_linkkid'},
},
{
{text = 'فتح الروابط', data =UserId..'/'.. 'unlock_link'},
},
{
{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
edit(ChatId,Msg_id,"✦ عليك اختيار نوع القفل او الفتح على امر الروابط", 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_spam') then
local UserId = Text:match('(%d+)/Status_spam')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل الكلايش', data =UserId..'/'.. 'lock_spam'},{text = 'قفل الكلايش بالكتم', data =UserId..'/'.. 'lock_spamktm'},
},
{
{text = 'قفل الكلايش بالطرد', data =UserId..'/'.. 'lock_spamkick'},{text = 'قفل الكلايش بالتقييد', data =UserId..'/'.. 'lock_spamid'},
},
{
{text = 'فتح الكلايش', data =UserId..'/'.. 'unlock_spam'},
},
{
{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
edit(ChatId,Msg_id,"✦ عليك اختيار نوع القفل او الفتح على امر الكلايش", 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_keypord') then
local UserId = Text:match('(%d+)/Status_keypord')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل الكيبورد', data =UserId..'/'.. 'lock_keypord'},{text = 'قفل الكيبورد بالكتم', data =UserId..'/'.. 'lock_keypordktm'},
},
{
{text = 'قفل الكيبورد بالطرد', data =UserId..'/'.. 'lock_keypordkick'},{text = 'قفل الكيبورد بالتقييد', data =UserId..'/'.. 'lock_keypordkid'},
},
{
{text = 'فتح الكيبورد', data =UserId..'/'.. 'unlock_keypord'},
},
{
{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
edit(ChatId,Msg_id,"✦ عليك اختيار نوع القفل او الفتح على امر الكيبورد", 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_voice') then
local UserId = Text:match('(%d+)/Status_voice')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل الاغاني', data =UserId..'/'.. 'lock_voice'},{text = 'قفل الاغاني بالكتم', data =UserId..'/'.. 'lock_voicektm'},
},
{
{text = 'قفل الاغاني بالطرد', data =UserId..'/'.. 'lock_voicekick'},{text = 'قفل الاغاني بالتقييد', data =UserId..'/'.. 'lock_voicekid'},
},
{
{text = 'فتح الاغاني', data =UserId..'/'.. 'unlock_voice'},
},
{
{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
edit(ChatId,Msg_id,"✦ عليك اختيار نوع القفل او الفتح على امر الاغاني", 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_gif') then
local UserId = Text:match('(%d+)/Status_gif')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل المتحركه', data =UserId..'/'.. 'lock_gif'},{text = 'قفل المتحركه بالكتم', data =UserId..'/'.. 'lock_gifktm'},
},
{
{text = 'قفل المتحركه بالطرد', data =UserId..'/'.. 'lock_gifkick'},{text = 'قفل المتحركه بالتقييد', data =UserId..'/'.. 'lock_gifkid'},
},
{
{text = 'فتح المتحركه', data =UserId..'/'.. 'unlock_gif'},
},
{
{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
edit(ChatId,Msg_id,"✦ عليك اختيار نوع القفل او الفتح على امر المتحركات", 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_files') then
local UserId = Text:match('(%d+)/Status_files')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل الملفات', data =UserId..'/'.. 'lock_files'},{text = 'قفل الملفات بالكتم', data =UserId..'/'.. 'lock_filesktm'},
},
{
{text = 'قفل الملفات بالطرد', data =UserId..'/'.. 'lock_fileskick'},{text = 'قفل الملفات بالتقييد', data =UserId..'/'.. 'lock_fileskid'},
},
{
{text = 'فتح الملفات', data =UserId..'/'.. 'unlock_files'},
},
{
{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
edit(ChatId,Msg_id,"✦ عليك اختيار نوع القفل او الفتح على امر الملفات", 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_text') then
local UserId = Text:match('(%d+)/Status_text')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل الدردشه', data =UserId..'/'.. 'lock_text'},
},
{
{text = 'فتح الدردشه', data =UserId..'/'.. 'unlock_text'},
},
{
{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
edit(ChatId,Msg_id,"✦ عليك اختيار نوع القفل او الفتح على امر الدردشه", 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_video') then
local UserId = Text:match('(%d+)/Status_video')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل الفيديو', data =UserId..'/'.. 'lock_video'},{text = 'قفل الفيديو بالكتم', data =UserId..'/'.. 'lock_videoktm'},
},
{
{text = 'قفل الفيديو بالطرد', data =UserId..'/'.. 'lock_videokick'},{text = 'قفل الفيديو بالتقييد', data =UserId..'/'.. 'lock_videokid'},
},
{
{text = 'فتح الفيديو', data =UserId..'/'.. 'unlock_video'},
},
{
{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
edit(ChatId,Msg_id,"✦ عليك اختيار نوع القفل او الفتح على امر الفيديو", 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_photo') then
local UserId = Text:match('(%d+)/Status_photo')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل الصور', data =UserId..'/'.. 'lock_photo'},{text = 'قفل الصور بالكتم', data =UserId..'/'.. 'lock_photoktm'},
},
{
{text = 'قفل الصور بالطرد', data =UserId..'/'.. 'lock_photokick'},{text = 'قفل الصور بالتقييد', data =UserId..'/'.. 'lock_photokid'},
},
{
{text = 'فتح الصور', data =UserId..'/'.. 'unlock_photo'},
},
{
{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
edit(ChatId,Msg_id,"✦ عليك اختيار نوع القفل او الفتح على امر الصور", 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_username') then
local UserId = Text:match('(%d+)/Status_username')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل المعرفات', data =UserId..'/'.. 'lock_username'},{text = 'قفل المعرفات بالكتم', data =UserId..'/'.. 'lock_usernamektm'},
},
{
{text = 'قفل المعرفات بالطرد', data =UserId..'/'.. 'lock_usernamekick'},{text = 'قفل المعرفات بالتقييد', data =UserId..'/'.. 'lock_usernamekid'},
},
{
{text = 'فتح المعرفات', data =UserId..'/'.. 'unlock_username'},
},
{
{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
edit(ChatId,Msg_id,"✦ عليك اختيار نوع القفل او الفتح على امر المعرفات", 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_tags') then
local UserId = Text:match('(%d+)/Status_tags')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل التاك', data =UserId..'/'.. 'lock_tags'},{text = 'قفل التاك بالكتم', data =UserId..'/'.. 'lock_tagsktm'},
},
{
{text = 'قفل التاك بالطرد', data =UserId..'/'.. 'lock_tagskick'},{text = 'قفل التاك بالتقييد', data =UserId..'/'.. 'lock_tagskid'},
},
{
{text = 'فتح التاك', data =UserId..'/'.. 'unlock_tags'},
},
{
{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
edit(ChatId,Msg_id,"✦ عليك اختيار نوع القفل او الفتح على امر التاك", 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_bots') then
local UserId = Text:match('(%d+)/Status_bots')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل البوتات', data =UserId..'/'.. 'lock_bots'},{text = 'قفل البوتات بالطرد', data =UserId..'/'.. 'lock_botskick'},
},
{
{text = 'فتح البوتات', data =UserId..'/'.. 'unlock_bots'},
},
{
{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
edit(ChatId,Msg_id,"✦ عليك اختيار نوع القفل او الفتح على امر البوتات", 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_fwd') then
local UserId = Text:match('(%d+)/Status_fwd')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل التوجيه', data =UserId..'/'.. 'lock_fwd'},{text = 'قفل التوجيه بالكتم', data =UserId..'/'.. 'lock_fwdktm'},
},
{
{text = 'قفل التوجيه بالطرد', data =UserId..'/'.. 'lock_fwdkick'},{text = 'قفل التوجيه بالتقييد', data =UserId..'/'.. 'lock_fwdkid'},
},
{
{text = 'فتح التوجيه', data =UserId..'/'.. 'unlock_link'},
},
{
{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
edit(ChatId,Msg_id,"✦ عليك اختيار نوع القفل او الفتح على امر التوجيه", 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_audio') then
local UserId = Text:match('(%d+)/Status_audio')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل الصوت', data =UserId..'/'.. 'lock_audio'},{text = 'قفل الصوت بالكتم', data =UserId..'/'.. 'lock_audioktm'},
},
{
{text = 'قفل الصوت بالطرد', data =UserId..'/'.. 'lock_audiokick'},{text = 'قفل الصوت بالتقييد', data =UserId..'/'.. 'lock_audiokid'},
},
{
{text = 'فتح الصوت', data =UserId..'/'.. 'unlock_audio'},
},
{
{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
edit(ChatId,Msg_id,"✦ عليك اختيار نوع القفل او الفتح على امر الصوت", 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_stikear') then
local UserId = Text:match('(%d+)/Status_stikear')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل الملصقات', data =UserId..'/'.. 'lock_stikear'},{text = 'قفل الملصقات بالكتم', data =UserId..'/'.. 'lock_stikearktm'},
},
{
{text = 'قفل الملصقات بالطرد', data =UserId..'/'.. 'lock_stikearkick'},{text = 'قفل الملصقات بالتقييد', data =UserId..'/'.. 'lock_stikearkid'},
},
{
{text = 'فتح الملصقات', data =UserId..'/'.. 'unlock_stikear'},
},
{
{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
edit(ChatId,Msg_id,"✦ عليك اختيار نوع القفل او الفتح على امر الملصقات", 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_phone') then
local UserId = Text:match('(%d+)/Status_phone')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل الجهات', data =UserId..'/'.. 'lock_phone'},{text = 'قفل الجهات بالكتم', data =UserId..'/'.. 'lock_phonektm'},
},
{
{text = 'قفل الجهات بالطرد', data =UserId..'/'.. 'lock_phonekick'},{text = 'قفل الجهات بالتقييد', data =UserId..'/'.. 'lock_phonekid'},
},
{
{text = 'فتح الجهات', data =UserId..'/'.. 'unlock_phone'},
},
{
{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
edit(ChatId,Msg_id,"✦ عليك اختيار نوع القفل او الفتح على امر الجهات", 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_joine') then
local UserId = Text:match('(%d+)/Status_joine')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل الدخول', data =UserId..'/'.. 'lock_joine'},
},
{
{text = 'فتح الدخول', data =UserId..'/'.. 'unlock_joine'},
},
{
{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
edit(ChatId,Msg_id,"✦ عليك اختيار نوع القفل او الفتح على امر الدخول", 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_addmem') then
local UserId = Text:match('(%d+)/Status_addmem')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل الاضافه', data =UserId..'/'.. 'lock_addmem'},
},
{
{text = 'فتح الاضافه', data =UserId..'/'.. 'unlock_addmem'},
},
{
{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
edit(ChatId,Msg_id,"✦ عليك اختيار نوع القفل او الفتح على امر الاضافه", 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_videonote') then
local UserId = Text:match('(%d+)/Status_videonote')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل السيلفي', data =UserId..'/'.. 'lock_videonote'},{text = 'قفل السيلفي بالكتم', data =UserId..'/'.. 'lock_videonotektm'},
},
{
{text = 'قفل السيلفي بالطرد', data =UserId..'/'.. 'lock_videonotekick'},{text = 'قفل السيلفي بالتقييد', data =UserId..'/'.. 'lock_videonotekid'},
},
{
{text = 'فتح السيلفي', data =UserId..'/'.. 'unlock_videonote'},
},
{
{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
edit(ChatId,Msg_id,"✦ عليك اختيار نوع القفل او الفتح على امر بصمه الفيديو", 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_pin') then
local UserId = Text:match('(%d+)/Status_pin')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل التثبيت', data =UserId..'/'.. 'lock_pin'},
},
{
{text = 'فتح التثبيت', data =UserId..'/'.. 'unlock_pin'},
},
{
{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
edit(ChatId,Msg_id,"✦ عليك اختيار نوع القفل او الفتح على امر التثبيت", 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_tgservir') then
local UserId = Text:match('(%d+)/Status_tgservir')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل الاشعارات', data =UserId..'/'.. 'lock_tgservir'},
},
{
{text = 'فتح الاشعارات', data =UserId..'/'.. 'unlock_tgservir'},
},
{
{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
edit(ChatId,Msg_id,"✦ عليك اختيار نوع القفل او الفتح على امر الاشعارات", 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_markdaun') then
local UserId = Text:match('(%d+)/Status_markdaun')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل الماركداون', data =UserId..'/'.. 'lock_markdaun'},{text = 'قفل الماركداون بالكتم', data =UserId..'/'.. 'lock_markdaunktm'},
},
{
{text = 'قفل الماركداون بالطرد', data =UserId..'/'.. 'lock_markdaunkick'},{text = 'قفل الماركداون بالتقييد', data =UserId..'/'.. 'lock_markdaunkid'},
},
{
{text = 'فتح الماركداون', data =UserId..'/'.. 'unlock_markdaun'},
},
{
{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
edit(ChatId,Msg_id,"✦ عليك اختيار نوع القفل او الفتح على امر الماركدون", 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_edits') then
local UserId = Text:match('(%d+)/Status_edits')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل التعديل', data =UserId..'/'.. 'lock_edits'},
},
{
{text = 'فتح التعديل', data =UserId..'/'.. 'unlock_edits'},
},
{
{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
edit(ChatId,Msg_id,"✦ عليك اختيار نوع القفل او الفتح على امر التعديل", 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_games') then
local UserId = Text:match('(%d+)/Status_games')
if tonumber(IdUser) == tonumber(UserId) then
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل الالعاب', data =UserId..'/'.. 'lock_games'},{text = 'قفل الالعاب بالكتم', data =UserId..'/'.. 'lock_gamesktm'},
},
{
{text = 'قفل الالعاب بالطرد', data =UserId..'/'.. 'lock_gameskick'},{text = 'قفل الالعاب بالتقييد', data =UserId..'/'.. 'lock_gameskid'},
},
{
{text = 'فتح الالعاب', data =UserId..'/'.. 'unlock_games'},
},
{
{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
edit(ChatId,Msg_id,"✦ عليك اختيار نوع القفل او الفتح على امر الالعاب", 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/Status_flood') then
local UserId = Text:match('(%d+)/Status_flood')
if tonumber(IdUser) == tonumber(UserId) then

local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {
{
{text = 'قفل التكرار', data =UserId..'/'.. 'lock_flood'},{text = 'قفل التكرار بالكتم', data =UserId..'/'.. 'lock_floodktm'},
},
{
{text = 'قفل التكرار بالطرد', data =UserId..'/'.. 'lock_floodkick'},{text = 'قفل التكرار بالتقييد', data =UserId..'/'.. 'lock_floodkid'},
},
{
{text = 'فتح التكرار', data =UserId..'/'.. 'unlock_flood'},
},
{
{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},
},
}
}
edit(ChatId,Msg_id,"✦ عليك اختيار نوع القفل او الفتح على امر التكرار", 'md', true, false, reply_markup)
end

elseif Text and Text:match('(%d+)/unlock_link') then
local UserId = Text:match('(%d+)/unlock_link')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(TeleGod.."Lock:Link"..ChatId)  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"✦ تم فتح الروابط").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_spam') then
local UserId = Text:match('(%d+)/unlock_spam')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(TeleGod.."Lock:Spam"..ChatId)  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"✦ تم فتح الكلايش").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_keypord') then
local UserId = Text:match('(%d+)/unlock_keypord')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(TeleGod.."Lock:Keyboard"..ChatId)  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"✦ تم فتح الكيبورد").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_voice') then
local UserId = Text:match('(%d+)/unlock_voice')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(TeleGod.."Lock:vico"..ChatId)  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"✦ تم فتح الاغاني").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_gif') then
local UserId = Text:match('(%d+)/unlock_gif')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(TeleGod.."Lock:Animation"..ChatId)  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"✦ تم فتح المتحركات").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_files') then
local UserId = Text:match('(%d+)/unlock_files')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(TeleGod.."Lock:Document"..ChatId)  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"✦ تم فتح الملفات").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_text') then
local UserId = Text:match('(%d+)/unlock_text')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(TeleGod.."Lock:text"..ChatId,true) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"✦ تم فتح الدردشه").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_video') then
local UserId = Text:match('(%d+)/unlock_video')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(TeleGod.."Lock:Video"..ChatId)  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"✦ تم فتح الفيديو").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_photo') then
local UserId = Text:match('(%d+)/unlock_photo')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(TeleGod.."Lock:Photo"..ChatId)  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"✦ تم فتح الصور").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_username') then
local UserId = Text:match('(%d+)/unlock_username')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(TeleGod.."Lock:User:Name"..ChatId)  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"✦ تم فتح المعرفات").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_tags') then
local UserId = Text:match('(%d+)/unlock_tags')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(TeleGod.."Lock:hashtak"..ChatId)  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"✦ تم فتح التاك").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_bots') then
local UserId = Text:match('(%d+)/unlock_bots')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(TeleGod.."Lock:Bot:kick"..ChatId)  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"✦ تم فتح البوتات").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_fwd') then
local UserId = Text:match('(%d+)/unlock_fwd')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(TeleGod.."Lock:forward"..ChatId)  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"✦ تم فتح التوجيه").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_audio') then
local UserId = Text:match('(%d+)/unlock_audio')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(TeleGod.."Lock:Audio"..ChatId)  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"✦ تم فتح الصوت").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_stikear') then
local UserId = Text:match('(%d+)/unlock_stikear')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(TeleGod.."Lock:Sticker"..ChatId)  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"✦ تم فتح الملصقات").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_phone') then
local UserId = Text:match('(%d+)/unlock_phone')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(TeleGod.."Lock:Contact"..ChatId)  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"✦ تم فتح الجهات").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_joine') then
local UserId = Text:match('(%d+)/unlock_joine')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(TeleGod.."Lock:Join"..ChatId)  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"✦ تم فتح الدخول").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_addmem') then
local UserId = Text:match('(%d+)/unlock_addmem')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(TeleGod.."Lock:AddMempar"..ChatId)  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"✦ تم فتح الاضافه").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_videonote') then
local UserId = Text:match('(%d+)/unlock_videonote')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(TeleGod.."Lock:Unsupported"..ChatId)  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"✦ تم فتح بصمه الفيديو").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_pin') then
local UserId = Text:match('(%d+)/unlock_pin')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(TeleGod.."lockpin"..ChatId) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"✦ تم فتح التثبيت").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_tgservir') then
local UserId = Text:match('(%d+)/unlock_tgservir')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(TeleGod.."Lock:tagservr"..ChatId)  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"✦ تم فتح الاشعارات").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_markdaun') then
local UserId = Text:match('(%d+)/unlock_markdaun')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(TeleGod.."Lock:Markdaun"..ChatId)  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"✦ تم فتح الماركدون").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_edits') then
local UserId = Text:match('(%d+)/unlock_edits')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(TeleGod.."Lock:edit"..ChatId) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"✦ تم فتح التعديل").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_games') then
local UserId = Text:match('(%d+)/unlock_games')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(TeleGod.."Lock:geam"..ChatId)  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"✦ تم فتح الالعاب").unLock, 'md', true, false, reply_markup)
end
elseif Text and Text:match('(%d+)/unlock_flood') then
local UserId = Text:match('(%d+)/unlock_flood')
if tonumber(IdUser) == tonumber(UserId) then
Redis:hdel(TeleGod.."Spam:Group:User"..ChatId ,"Spam:User")  
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,Reply_Status(IdUser,"✦ تم فتح التكرار").unLock, 'md', true, false, reply_markup)
end
end
if Text and Text:match('(%d+)/Dev') then
local UserId = Text:match('(%d+)/Dev')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(TeleGod.."Dev:Groups") 
edit(ChatId,Msg_id,"✦ تم مسح مطورين البوت", 'md', false)
end
elseif Text and Text:match('(%d+)/Devss') then
local UserId = Text:match('(%d+)/Devss')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(TeleGod.."Devss:Groups") 
edit(ChatId,Msg_id,"✦ تم مسح مطورين الثانوين من البوت", 'md', false)
end
elseif Text and Text:match('(%d+)/Supcreator') then
local UserId = Text:match('(%d+)/Supcreator')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(TeleGod.."Supcreator:Group"..ChatId) 
edit(ChatId,Msg_id,"✦ تم مسح المنشئين الاساسيين", 'md', false)
end
elseif Text and Text:match('(%d+)/Owners') then
local UserId = Text:match('(%d+)/Owners')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(TeleGod.."Owners:Group"..ChatId) 
edit(ChatId,Msg_id,"✦ تم مسح المالكين", 'md', false)
end
elseif Text and Text:match('(%d+)/Creator') then
local UserId = Text:match('(%d+)/Creator')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(TeleGod.."Creator:Group"..ChatId) 
edit(ChatId,Msg_id,"✦ تم مسح منشئين الجروب", 'md', false)
end
elseif Text and Text:match('(%d+)/Manger') then
local UserId = Text:match('(%d+)/Manger')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(TeleGod.."Manger:Group"..ChatId) 
edit(ChatId,Msg_id,"✦ تم مسح المدراء", 'md', false)
end
elseif Text and Text:match('(%d+)/Admin') then
local UserId = Text:match('(%d+)/Admin')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(TeleGod.."Admin:Group"..ChatId) 
edit(ChatId,Msg_id,"✦ تم مسح ادمنيه الجروب", 'md', false)
end
elseif Text and Text:match('(%d+)/DelSpecial') then
local UserId = Text:match('(%d+)/DelSpecial')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(TeleGod.."Special:Group"..ChatId) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,"✦ تم مسح المميزين", 'md', false)
end

elseif Text and Text:match('(%d+)/Delkholat') then
local UserId = Text:match('(%d+)/Delkholat')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(TeleGod.."kholat:Group"..ChatId) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,"✦ تم مسح جميع خولات المجموعة", 'md', false)
end
elseif Text and Text:match('(%d+)/Delwtk') then
local UserId = Text:match('(%d+)/Delwtk')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(TeleGod.."wtka:Group"..ChatId) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,"✦ تم مسح جميع وتكات المجموعة", 'md', false)
end
elseif Text and Text:match('(%d+)/Deltwhd') then
local UserId = Text:match('(%d+)/Deltwhd')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(TeleGod.."twhd:Group"..ChatId) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,"✦ تم مسح جميع متوحدين المجموعة", 'md', false)
end
elseif Text and Text:match('(%d+)/Delklb') then
local UserId = Text:match('(%d+)/Delklb')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(TeleGod.."klb:Group"..ChatId) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,"✦ تم مسح جميع الكلاب المجموعة", 'md', false)
end
elseif Text and Text:match('(%d+)/Delmar') then
local UserId = Text:match('(%d+)/Delmar')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(TeleGod.."mar:Group"..ChatId) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,"✦ تم مسح جميع حمير المجموعة", 'md', false)
end
elseif Text and Text:match('(%d+)/Delsmb') then
local UserId = Text:match('(%d+)/Delsmb')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(TeleGod.."smb:Group"..ChatId) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,"✦ تم مسح جميع السمب الي هنا ف المجموعة", 'md', false)
end
elseif Text and Text:match('(%d+)/Del2rd') then
local UserId = Text:match('(%d+)/Del2rd')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(TeleGod.."2rd:Group"..ChatId) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,"✦ تم مسح جميع القرود", 'md', false)
end
elseif Text and Text:match('(%d+)/Del3ra') then
local UserId = Text:match('(%d+)/Del3ra')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(TeleGod.."3ra:Group"..ChatId) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,"✦ تم مسح جميع العرر", 'md', false)
end
elseif Text and Text:match('(%d+)/Del8by') then
local UserId = Text:match('(%d+)/Del8by')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(TeleGod.."8by:Group"..ChatId) 
local reply_markup = LuaTele.replyMarkup{type = 'inline',data = {{{text = '- رجوع', data =UserId..'/'.. 'NoNextSeting'},},}}
edit(ChatId,Msg_id,"✦ تم مسح جميع الأغبياء", 'md', false)
end
elseif Text and Text:match('(%d+)/BanAll') then
local UserId = Text:match('(%d+)/BanAll')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(TeleGod.."BanAll:Groups") 
edit(ChatId,Msg_id,"✦ تم مسح المحظورين عام", 'md', false)
end
elseif Text and Text:match('(%d+)/ktmAll') then
local UserId = Text:match('(%d+)/ktmAll')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(TeleGod.."ktmAll:Groups") 
edit(ChatId,Msg_id,"✦ تم مسح المكتومين عام", 'md', false)
end
elseif Text and Text:match('(%d+)/BanGroup') then
local UserId = Text:match('(%d+)/BanGroup')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(TeleGod.."BanGroup:Group"..ChatId) 
edit(ChatId,Msg_id,"✦ تم مسح المحظورين", 'md', false)
end
elseif Text and Text:match('(%d+)/SilentGroupGroup') then
local UserId = Text:match('(%d+)/SilentGroupGroup')
if tonumber(IdUser) == tonumber(UserId) then
Redis:del(TeleGod.."SilentGroup:Group"..ChatId) 
edit(ChatId,Msg_id,"✦ تم مسح المكتومين", 'md', false)
end
end
end
end
Redis:sadd(TeleGod.."eza3a",Token.."&"..TeleGod)
Redis:set("@"..UserBot,TeleGod.."&".."@"..UserBot.."$@"..UserSudo.."+"..Token)
luatele.run(CallBackLua)
 