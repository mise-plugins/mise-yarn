--- List all available versions
PLUGIN = {}

local function execCommand(cmd)
    local handle = io.popen(cmd .. " 2>/dev/null")
    if handle then
        local result = handle:read("*a")
        handle:close()
        return result
    end
    return ""
end

function PLUGIN:Available(ctx)
    local versions = {}
    
    -- Get Yarn Berry versions (v2.x+) FIRST in DESCENDING order
    -- When mise reverses the list, these will appear LAST in ASCENDING order
    local berry_output = execCommand([[
        git ls-remote --refs --tags "https://github.com/yarnpkg/berry.git" |
        grep '@yarnpkg/cli' |
        sed -E 's|^.+refs/tags/@yarnpkg/cli/||g' |
        sort -rV
    ]])
    
    for version in berry_output:gmatch("[^\n]+") do
        if version and version ~= "" then
            table.insert(versions, {
                version = version
            })
        end
    end
    
    -- Get Yarn Classic versions (v1.x) SECOND in DESCENDING order
    -- When mise reverses the list, these will appear FIRST in ASCENDING order
    local classic_output = execCommand([[
        git ls-remote --refs --tags "https://github.com/yarnpkg/yarn.git" |
        sed -E 's|^.+refs/tags/||g' |
        grep -E '^v' |
        sed -E 's|^v||g' |
        grep -Ev '^0\.' |
        sort -rV
    ]])
    
    for version in classic_output:gmatch("[^\n]+") do
        if version and version ~= "" then
            table.insert(versions, {
                version = version
            })
        end
    end
    
    return versions
end

return PLUGIN