-- Tools for conditionally loading plugins via lazy
M = {}

M.machines = { 'nest', 'Goose.local' }

local getDefaultmetatable = {
    __index = function(tbl, key)
        if rawget(tbl, key) then
            return tbl[key]
        else
            return tbl["default"]
        end
    end
}

-- Create a table for each machine with a default value
-- current machines: nest, Goose.local
M.createProfiles = function(default)
    local profiles = {}
    profiles.default = default
    for _, machine in ipairs(M.machines) do
        profiles[machine] = default
    end
    setmetatable(profiles, getDefaultmetatable)
    return profiles
end

return M
