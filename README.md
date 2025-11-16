![alt text](https://github.com/cirobr/TinyMachines.jl/blob/main/images/logo-name-tm.png?raw=true)

# CocoTools.jl

[![Build Status](https://github.com/cirobr/CocoTools.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/cirobr/CocoTools.jl/actions/workflows/CI.yml?query=branch%3Amain)

Toolset for handling COCO-2017 dataset


## Usage
```
using CocoTools; c=CocoTools
dfcoco   # shows the complete class dataframe

# functions
c.classnumber2classname(21) == "cow"
c.classname2classnumber("cow") == 21
c.colormap2classnumber((120,166,157)) == 21

# alternative function names
c.get_classname(0) == "background"
c.get_classname(300) == "background"
c.get_classnumber("background") == 0
```
