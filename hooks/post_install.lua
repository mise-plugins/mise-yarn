--- Post-installation hook
PLUGIN = {}

local function download_file(url, output_path)
    -- Try wget first, then curl
    local wget_cmd = "wget -q -O " .. output_path .. " " .. url .. " 2>/dev/null"
    local curl_cmd = "curl -sSL -o " .. output_path .. " " .. url .. " 2>/dev/null"
    
    if os.execute(wget_cmd) == 0 then
        return true
    elseif os.execute(curl_cmd) == 0 then
        return true
    end
    return false
end

function PLUGIN:PostInstall(ctx)
    -- Get install path - it should be in sdkInfo
    local install_path = nil
    local version = nil
    
    -- Try to get path from sdkInfo
    if ctx.sdkInfo and ctx.sdkInfo.yarn then
        install_path = ctx.sdkInfo.yarn.path
        version = ctx.sdkInfo.yarn.version
    end
    
    -- Fallback to environment variable
    if not install_path then
        install_path = os.getenv("MISE_INSTALL_PATH")
    end
    if not version then
        version = os.getenv("MISE_INSTALL_VERSION") or ctx.version
    end
    
    if not install_path or not version then
        -- For v1, mise handles everything, so this is OK
        return {}
    end
    
    local major_version = string.sub(version, 1, 1)
    
    if major_version ~= "1" then
        -- Yarn Berry (v2.x+) - download single JS file
        local yarn_url = "https://repo.yarnpkg.com/" .. version .. "/packages/yarnpkg-cli/bin/yarn.js"
        
        -- Create bin directory
        os.execute("mkdir -p " .. install_path .. "/bin")
        
        -- Download yarn.js
        local yarn_file = install_path .. "/bin/yarn"
        if not download_file(yarn_url, yarn_file) then
            error("Failed to download Yarn v2+")
        end
        
        -- Make executable
        os.execute("chmod +x " .. yarn_file)
    end
    
    return {}
end

return PLUGIN