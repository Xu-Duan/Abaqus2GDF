# Abaqus2GDF
A program written in FORTRAN used to convert Abaqus input file `*.inp` to `*.gdf` used in Wamit.

## Components
1. `Abaqus2GDF.f90` and its executable file `Abaqus2GDF.exe` complied by gfortran.
2. `Abaqus2GDFReverse.f90` and its executable file `Abaqus2GDFReverse.exe` complied by gfortran. This is remedial measure in case one forget to modify normal vectors of mesh.
## How to use
### 1. Default method
Move executable file to your work directory where lies Abaqus `Job-1.inp` file. Double click the executable file `Abaqus2GDF.exe` or `Abaqus2GDFReverse.exe` and a `module.gdf` file will generate base on `Job-1.inp` file.

### 2. A method that receive arbitary file name and generate
First variable is Abaqus input file. Second variable is output gdf file.
```
./Abaqus2GDF C:\"Program files"\Thisisinput.inp D:\Research\Thisisoutput.gdf"
```

### Extra explanation
Exactly one variable input is considered wrong. For example 
```
./Abaqus2GDF C:\\"Program files"\\Job-2.inp"
```
