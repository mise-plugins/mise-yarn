--- Parse legacy version files
PLUGIN = {}

function PLUGIN:ParseLegacyFile(ctx)
    local filepath = ctx.filepath
    local file = io.open(filepath, "r")
    if file then
        local version = file:read("*l")
        file:close()
        if version then
            version = version:gsub("^v", ""):gsub("%s+", "")
            return {
                version = version
            }
        end
    end
    return {}
end

return PLUGIN