![alt text](https://github.com/cirobr/TinyMachines.jl/blob/main/images/logo-name-tm.png?raw=true)

# CocoTools.jl

[![Build Status](https://github.com/cirobr/CocoTools.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/cirobr/CocoTools.jl/actions/workflows/CI.yml?query=branch%3Amain)

Toolset for handling COCO-2017 dataset


## Usage
```
using CocoTools; ct=CocoTools

ct.dfcoco   # shows the complete class dataframe
ct.classnumber2classname(21) == "cow"
ct.classname2classnumber("cow") == 21
