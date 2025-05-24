using Pkg
envpath = expanduser("../")
Pkg.activate(envpath)

using CocoTools

display(coco_classnumbers)
display(coco_classnames)

path = expanduser("~/datasets/coco/")
CocoTools.coco_download(path)
