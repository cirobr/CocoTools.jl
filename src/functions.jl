function createFolder(folder::String)
    if folder[end] != "/"   folder = folder * "/"   end
    if !isdir(folder)       mkdir(folder)           end
end
