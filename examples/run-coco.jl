using Pkg
envpath = expanduser("../")
Pkg.activate(envpath)

using CocoTools

display(coco_classnumbers)

display(coco_classnames)

folder = expanduser("~/datasets/coco/")
CocoTools.coco_download(folder)
