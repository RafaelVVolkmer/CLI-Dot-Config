-- SPDX-FileCopyrightText: 2025-2026 Rafael V. Volkmer
-- SPDX-FileCopyrightText: <rafael.v.volkmer@gmail.com>
-- SPDX-License-Identifier: MIT

local Comment =
{
    event = "VeryLazy",
    opts = {},
}

local function BuildSpec()
    return
    {
        "numToStr/Comment.nvim",
        event = Comment.event,

        -- Keep opts as a function so it can grow later without changing the spec shape.
        opts = function()
            return Comment.opts
        end,
    }
end

return
{
    BuildSpec(),
}
