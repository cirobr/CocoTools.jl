const vec_classes = 0:80

const vec_classnames = [
"background",
"person", "bicycle", "car", "motorbike", "aeroplane", "bus", "train", "truck", 
"boat", "traffic_light", "fire_hydrant", "stop_sign", "parking_meter", "bench", "bird", "cat", 
"dog", "horse", "sheep", "cow", "elephant", "bear", "zebra", "giraffe",
"backpack", "umbrella", "handbag", "tie", "suitcase", "frisbee", "skis", "snowboard",
"sports_ball", "kite", "baseball_bat", "baseball_glove", "skateboard", "surfboard", "tennis_racket", "bottle",
"wine_glass", "cup", "fork", "knife", "spoon", "bowl", "banana", "apple",
"sandwich", "orange", "broccoli", "carrot", "hot_dog", "pizza", "donut", "cake",
"chair", "sofa", "pottedplant", "bed", "diningtable", "toilet", "tvmonitor", "laptop",
"mouse", "remote", "keyboard", "cell_phone", "microwave", "oven", "toaster", "sink",
"refrigerator", "book", "clock", "vase", "scissors", "teddy_bear", "hair_drier", "toothbrush"
]

const classnumbers = sort( Dict(zip(vec_classes, vec_classnames)) )
const classnames   = sort( Dict(zip(vec_classnames, vec_classes)); byvalue=true)


function coco_classnumbers(class::Int)
    return get(classnumbers, class, classnumbers[0])   # 0 is background
end
const coco_classnumber2classname = coco_classnumbers


function coco_classnames(name::String)
    return get(classnames, name, classnames["background"])   # "background" is default
end
const coco_classname2classnumber = coco_classnames


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
