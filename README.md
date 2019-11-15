# Vivado Version
To build this project use Vivado Version 2019.2

# Setup the Project
## Setup the Vivado Project
To setup the project type the following commands in the Vivado TCL Console:
```
cd <path to project>
source build.tcl
```

## Setup the Software Vitis Project
To setup the software project at first the hardware needs to be exported. The first step is to generate the block design with the `Generate Block Design` command. Then the hardware need to be exported with `File -> Export -> Export hardware...` (use default options).
