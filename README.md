![alt text](https://github.com/cirobr/TinyMachines.jl/blob/main/images/logo-name-tm.png?raw=true)

# CocoTools.jl

[![Build Status](https://github.com/cirobr/CocoTools.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/cirobr/CocoTools.jl/actions/workflows/CI.yml?query=branch%3Amain)

Toolset for handling COCO-2017 dataset


## Usage
```
using CocoTools

coco_download("path") # Downloads the COCO dataset to the designated "path"

coco_classnumbers(), coco_classnumber2classname()

coco_classnames(), coco_classname2classnumber()
```
