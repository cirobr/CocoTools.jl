using Pkg
envpath = expanduser("./")
Pkg.activate(envpath)
using CocoTools; c=CocoTools

display(dfcoco)

path = expanduser("./datasets/coco/")
c.coco_download(path)
