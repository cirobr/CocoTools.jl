const vec_classes = 0:80


const vec_classnames = [
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

const coco_classnames   = sort( Dict(zip(vec_classnames, vec_classes)); byvalue=true )
