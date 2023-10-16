const vec_classes = 0:80

const vec_classnames = [
"background",
"person", "bicycle", "car", "motorbike", "aeroplane", "bus", "train", "truck", 
"boat", "traffic light", "fire hydrant", "stop sign", "parking meter", "bench", "bird", "cat", 
"dog", "horse", "sheep", "cow", "elephant", "bear", "zebra", "giraffe",
"backpack", "umbrella", "handbag", "tie", "suitcase", "frisbee", "skis", "snowboard",
"sports ball", "kite", "baseball bat", "baseball glove", "skateboard", "surfboard", "tennis racket", "bottle",
"wine glass", "cup", "fork", "knife", "spoon", "bowl", "banana", "apple",
"sandwich", "orange", "broccoli", "carrot", "hot dog", "pizza", "donut", "cake",
"chair", "sofa", "pottedplant", "bed", "diningtable", "toilet", "tvmonitor", "laptop",
"mouse", "remote", "keyboard", "cell phone", "microwave", "oven", "toaster", "sink",
"refrigerator", "book", "clock", "vase", "scissors", "teddy bear", "hair drier", "toothbrush"
]

const coco_classnumbers = sort( Dict(zip(vec_classes, vec_classnames)) )

const coco_classnames   = sort( Dict(zip(vec_classnames, vec_classes)); byvalue=true)

function createfolder(folder::String)
    if folder[end] != "/"   folder = folder * "/"   end
    if !isdir(folder)       mkdir(folder)           end
end

function coco_download(coco_data_folder::String)
    createfolder(coco_data_folder)

    # download coco data
    Downloads.download("http://images.cocodataset.org/zips/train2017.zip",
                        coco_data_folder * "train2017.zip")
    Downloads.download("http://images.cocodataset.org/zips/val2017.zip",
                        coco_data_folder * "val2017.zip")
    Downloads.download("http://images.cocodataset.org/annotations/annotations_trainval2017.zip",
                        coco_data_folder * "annotations_trainval2017.zip")
    Downloads.download("http://calvin.inf.ed.ac.uk/wp-content/uploads/data/cocostuffdataset/stuffthingmaps_trainval2017.zip",
                        coco_data_folder * "stuffthingmaps_trainval2017.zip")

    # unzip coco data
    Threads.@spawn run(`unzip $(coco_data_folder)/train2017.zip -d $(coco_data_folder)`)
    Threads.@spawn run(`unzip $(coco_data_folder)/val2017.zip -d $(coco_data_folder)`)
    Threads.@spawn run(`unzip $(coco_data_folder)/annotations_trainval2017.zip -d $(coco_data_folder)`)
    Threads.@spawn run(`unzip $(coco_data_folder)/stuffthingmaps_trainval2017.zip -d $(coco_data_folder)`)

    # delete unzipped files
    # rm( joinpath(coco_data_folder, "train2017.zip") )
    # rm( joinpath(coco_data_folder, "val2017.zip") )
    # rm( joinpath(coco_data_folder, "annotations_trainval2017.zip") )
    # rm( joinpath(coco_data_folder, "stuffthingmaps_trainval2017.zip") )
end