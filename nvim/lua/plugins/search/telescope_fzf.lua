-- SPDX-FileCopyrightText: 2025-2026 Rafael V. Volkmer
-- SPDX-FileCopyrightText: <rafael.v.volkmer@gmail.com>
-- SPDX-License-Identifier: MIT

local TelescopeFzfNative =
{
    build_cmd = "make",
    build_tool = "make",
}

local function IsExecutable(bin)
    return vim.fn.executable(bin) == 1
end

local function CanBuild()
    -- Only enable this plugin when the build tool is available.
    return IsExecutable(TelescopeFzfNative.build_tool)
end

local function BuildSpec()
    return
    {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = TelescopeFzfNative.build_cmd,
        cond = CanBuild,
    }
end

return
{
    BuildSpec(),
}
