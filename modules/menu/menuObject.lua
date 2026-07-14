local Menu = lib.class("Menu")
menus = {}

function Menu:constructor(id,title,options)
    --check id for menu duplicates, stop class object creation if duplicate
    id = string.lower(id)
    if menus[id] then print("Error creating menu '"..id.."', id already exists. Cancelling creation") return false end

    --set required data
    self.id = id
    self.title = title

    --set any optional data
    for k,v in pairs(options) do
        self[k] = v
    end

    --save menu for later use
    menus[self.id] = self

    --run menu setup
    return self:setup()
end
function Menu:setup()
    lib.registerMenu({
        id = self.id,
        title = self.title,
        position = self.position,
        onSideScroll = function(selected, scrollIndex, args)
            self:onSideScroll(selected, scrollIndex, args)
        end,
        onSelected = function(selected, secondary, args)
            self:onSelected(selected, secondary, args)
        end,
        onCheck = function(selected, checked, args)
            self:onCheck(selected, checked, args)
        end,
        onClose = function(keyPressed)
            self:onClose(keyPressed)
        end,
        options = self.options or {{label="Default placeholder option, if you are seeing this report it to a dev.",description = "menu creation"}}
    },function(selected, scrollIndex, args)
        self:optionPressed(selected, scrollIndex, args)
    end)
    if not self.onPressed then 
        self.onPressed = function(selected, scrollIndex, args)
            selected = args[1]
            if menus[selected] then menus[selected]:showMenu()end
        end
    end
    return true
end
function Menu:onSideScroll(selected, scrollIndex, args)
    if self.onScroll then
        self.onScroll(selected, scrollIndex, args)
        --self.index = selected
        self.indexOptions = {
            selected = selected,
            scrollIndex = scrollIndex,
            args = args
        }
    end
end
function Menu:onChecked(selected, checked, args)
    if self.onCheck then
        self.onCheck(selected, checked, args)
        --self.index = selected
        self.indexOptions = {
            selected = selected,
            checked = checked,
            args = args
        }
    end
end
function Menu:optionPressed(selected, scrollIndex, args)
    if self.onPressed then self.onPressed(selected, scrollIndex, args) end
    return true
end
function Menu:onClose(keyPressed)
    if keyPressed == 'Backspace' and self.parent then
        menus[self.parent]:showMenu()
    end
end
function Menu:onSelected(selected, secondary, args)
    if self.onSelect then
        self.onSelect(selected, secondary, args)
    end
    self.index = selected
    self.indexOptions = {
        selected = selected,
        secondary = secondary,
        args = args
    }
end
function Menu:setOptions(options,index)
    --if current menu index is greater than new options it will reset the index to 1
    if self.index then
        if self.index > #options then
            self.index = 1
        end
    end

    --if index exists then set self.options[index] to options, otherwise just store the table
    if not index then self.options = options else self.options[index] = options end

    return lib.setMenuOptions(self.id, options, index)
end
function Menu:update(data,key)
    local runSetup = false
    if not key then
        --checks data table for any functions, if they exist then run setup again to recreate the menu
        for k,v in pairs(data) do
            self[k] = v
            if type(v) =="function" then
                runSetup = true
            end
        end
    else
        if type(data) == 'function' then runSetup = true end
    end
    if runSetup then self:setup() end
    return true
end
function Menu:showMenu(args)
    if lib.onShow then self.onShow(args) end
    lib.showMenu(self.id,self.index)
    --[[if not lib.getOpenMenu() then lib.showMenu(self.id,self.index) return true end
    return false]]
end

return Menu