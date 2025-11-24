# read COCO categories from official url
const COCO_CLASSES_URL = "https://raw.githubusercontent.com/cocodataset/panopticapi/master/panoptic_coco_categories.json"
const JSON_PATH = "panoptic_coco_categories.json"

if !isfile(JSON_PATH)
    @info "Downloading category table..."
    HTTP.download(COCO_CLASSES_URL, JSON_PATH)
end


# create dataframe
data = JSON3.read(read(JSON_PATH, String))
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

vec_classnumbers   = vcat(0, dfcoco.id)
vec_classnames     = vcat("background", dfcoco.name)
vec_colormap       = vcat((0,0,0), dfcoco.color)
const classnumbers = sort( Dict(zip(vec_classnumbers, vec_classnames)) )
const classnames   = sort( Dict(zip(vec_classnames, vec_classnumbers)); byvalue=true)
const colormaps    = sort( Dict(zip(vec_colormap, vec_classnumbers)); byvalue=true )


function get_classname(class::Int)
    return get(classnumbers, class, classnumbers[0])   # 0 is background
end
const classnumber2classname = get_classname


function get_classnumber(name::String)
    return get(classnames, name, classnames["background"])   # "background" is default
end
const classname2classnumber = get_classnumber


function colormap2classnumber(colormap::Tuple{Int,Int,Int})
    return get(colormaps, colormap, colormaps[(0,0,0)])   # (0,0,0) is background
end


function coco_rgb2classes(mask::AbstractArray{RGB{N0f8}, 2})
    h, w = size(mask)
    X = Matrix{Int}(undef, (h,w))
    m = channelview(mask) .* 255 .|> Int   # CHW

    for i in 1:h; for j in 1:w
        X[i,j] = colormap2classnumber((m[1,i,j], m[2,i,j], m[3,i,j]))
    end; end

    return X
end


function coco_download(folder::String)
    coco_data_folder = folder
    if coco_data_folder[end] == "/"   coco_data_folder = coco_data_folder[1:end-1]   end
    mkpath(coco_data_folder)
    
    # download coco data
    if !isfile(coco_data_folder * "/train2017.zip")
        @info "Downloading COCO train data..."
        Downloads.download("http://images.cocodataset.org/zips/train2017.zip",
                            coco_data_folder * "/train2017.zip")
    end

    if !isfile(coco_data_folder * "/val2017.zip")
        @info "Downloading COCO val data..."
        Downloads.download("http://images.cocodataset.org/zips/val2017.zip",
                            coco_data_folder * "/val2017.zip")
    end

    if !isfile(coco_data_folder * "/annotations_trainval2017.zip")
        @info "Downloading COCO annotations..."
        Downloads.download("http://images.cocodataset.org/annotations/annotations_trainval2017.zip",
                            coco_data_folder * "/annotations_trainval2017.zip")
    end

    if !isfile(coco_data_folder * "/stuffthingmaps_trainval2017.zip")
        @info "Downloading COCO stuffthingmaps..."
        Downloads.download("http://calvin.inf.ed.ac.uk/wp-content/uploads/data/cocostuffdataset/stuffthingmaps_trainval2017.zip",
                            coco_data_folder * "/stuffthingmaps_trainval2017.zip")
    end
    
    # unzip coco data
    Threads.@sync begin
        # https://superuser.com/questions/100656/linux-unzip-command-option-to-force-overwrite
        Threads.@spawn run(`unzip -o $(coco_data_folder)/train2017.zip -d $(coco_data_folder)`)
        Threads.@spawn run(`unzip -o $(coco_data_folder)/val2017.zip -d $(coco_data_folder)`)
        Threads.@spawn run(`unzip -o $(coco_data_folder)/annotations_trainval2017.zip -d $(coco_data_folder)`)
        Threads.@spawn run(`unzip -o $(coco_data_folder)/stuffthingmaps_trainval2017.zip -d $(coco_data_folder)`)
    end
    @info "COCO data downloaded and unzipped."
end
