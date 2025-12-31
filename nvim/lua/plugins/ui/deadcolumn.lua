-- SPDX-FileCopyrightText: 2025-2026 Rafael V. Volkmer
-- SPDX-FileCopyrightText: <rafael.v.volkmer@gmail.com>
-- SPDX-License-Identifier: MIT

local DeadColumn =
{
    events =
    {
        "BufReadPre",
        "BufNewFile",
    },

    opts =
    {
        scope = "line",
        modes = { "n", "i", "R" },

        blending =
        {
            threshold = 0.4,
            colorcode = "#2A1A1E",
            hlgroup = { "NonText", "bg" },
        },

        warning =
        {
            alpha = 0.4,
            offset = 0,
            colorcode = "#C76B73",
            hlgroup = { "Error", "bg" },
        },
    },
}

local function SafeRequire(module_name)
    local ok, mod = pcall(require, module_name)
    if ok
    then
        return mod
    end

    return nil
end

local function BuildOpts()
    -- Centralize options so they remain easy to tune (colors, thresholds, modes).
    return DeadColumn.opts
end

local function Setup(_, opts)
    local deadcolumn = SafeRequire("deadcolumn")
    if deadcolumn == nil
    then
        return
    end

    -- Visual guide for line length, with gradual blending and warning threshold.
    deadcolumn.setup(opts or {})
end

return
{
    {
        "Bekaboo/deadcolumn.nvim",
        event = DeadColumn.events,

        opts = function()
            return BuildOpts()
        end,

        config = function(_, opts)
            Setup(_, opts)
        end,
    },
}
