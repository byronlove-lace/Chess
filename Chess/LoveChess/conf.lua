#!/bin/lua

function love.conf(t)
        t.version = "11.4"
        t.window.title = "Chess"
        t.window.width = 720
        t.window.height = 720
        t.window.vsync = 1
        t.window.display = 1
        t.window.fullscreen = false
        t.window.borderless = true
end

