-- SPDX-FileCopyrightText: 2025-2026 Rafael V. Volkmer
-- SPDX-FileCopyrightText: <rafael.v.volkmer@gmail.com>
-- SPDX-License-Identifier: MIT

local Illuminate =
{
    event = "VeryLazy",
}

local function BuildSpec()
    return
    {
        "RRethy/vim-illuminate",
        event = Illuminate.event,
    }
end

return
{
    BuildSpec(),
}
