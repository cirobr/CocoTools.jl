# read COCO categories from official url
const COCO_CLASSES_URL = "https://raw.githubusercontent.com/cocodataset/panopticapi/master/panoptic_coco_categories.json"
const JSON_PATH = "panoptic_coco_categories.json"

if !isfile(JSON_PATH)
    @info "Downloading category table..."
    HTTP.download(COCO_CLASSES_URL, JSON_PATH)
end


# create dataframe
data = JSON.parsefile(JSON_PATH)
dfcoco = DataFrame(
    supercategory=String[],
    color=Tuple{Int,Int,Int}[],
    isthing=Bool[],
    id=Int[],
    name=String[]
    )

for cat in data
    supercategory = cat.supercategory
    color         = cat.color |> Tuple
    isthing       = cat.isthing::Int |> Bool
    id            = cat.id::Int
    name          = cat.name

    push!(dfcoco, [supercategory, color, isthing, id, name])
end

class_numbers   = vcat(0, dfcoco.id)
class_names     = vcat("background", dfcoco.name)

dict_numbers = Dict(zip(class_numbers, class_names))
classnumbers = DataStructures.OrderedDict( sort(collect(dict_numbers)) )
function classnumber2classname(class::Int)
    return get(classnumbers, class, "void")
end

dict_names = Dict(zip(class_names, class_numbers))
classnames = DataStructures.OrderedDict( sort(collect(dict_names)) )
function classname2classnumber(name::String)
    return get(classnames, name, 255)   # 255 is void class
end
