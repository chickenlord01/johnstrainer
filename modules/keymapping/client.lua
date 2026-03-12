local keyMapping = lib.callback.await("johnstrainer:keymap:getDefaultSettings",false)
if keyMapping then RegisterKeyMapping("opentrainer","Open trainer menu",keyMapping.keyMapper,keyMapping.key) end