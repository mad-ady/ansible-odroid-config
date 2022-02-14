#!/usr/bin/lua

local bp = require("lua-shepi")
local rofi_markup = print("\0markup-rows\x1ftrue\n")

local function GetTabs(sin, sout, serr)
    local delim = print("\x00delim\x1f\x0f")
    local markup_s = '%s\n<span foreground="#6B838E">%s\n</span><span foreground="#44555D"><small><i>%s</i></small></span>\x0f'
    local pipe_in = sin:read("a")
    for line in pipe_in:gmatch("([^\n]*)\n") do
        local id, title, url = line:match("([^\t]+)\t([^\t]+)\t([^\t]+)")
        local result = string.format(markup_s, title, url:match("https?://[www%.]*(.*)"), id)
        local prune_s = result:gsub("&", "&amp;")
        sout:write(prune_s)
    end
end

args = {...}
local pipe = bp.bt("list") | bp.tac("-s", "\n") | bp.fun(GetTabs)
if not args[1] then
    io.write(pipe())
else
    os.execute(string.format("bt activate %s", args[1]:match("<i>(.-)</i>")))
end

