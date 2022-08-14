-- Auto buffer wrapper.
-- https://gist.github.com/numToStr/1ab83dd2e919de9235f9f774ef8076da

local cmd = vim.api.nvim_command

local function autocmd(this, event, spec)
    local is_table = type(spec) == 'table'
    local action = is_table and spec[1] or '*'
    local pattern = is_table and spec[2] or spec
    if type(action) == 'function' then
	action = this.set(action)
    end
    local e = type(event) == 'table' and table.concat(event, ',') or event
    cmd('autocmd ' .. e .. ' ' .. pattern .. ' ' .. action)
end

local S = {
    __au = {},
}

local X = setmetatable({}, {
    __index = S,
    __newindex = autocmd,
    __call = autocmd,
})

function S.exec(id)
    S.__au[id]()
end

function S.set(fn)
    local id = string.format('%p', fn)
    S.__au[id] = fn
    return string.format('lua require("au").exec("%s")', id)
end
