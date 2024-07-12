# projcoonv

### A Fortran interoperational interface to [PROJ](https://proj.org) coordinate conversion

This software performs a coordinate conversion from a Coordinate Reference System (CRS) to another.

The C function **`projcoonv.c`** calls PROJ to perform the coordinate conversion.

The Fortran module **`pjcoonv_module.f90`** provides the Fortran interface functions to the C function `projcoonv`.

Call from Fortran this way:
<b>

```
  jret= projcoonv(epsgfrom, epsgto, x, y)
```
</b>

Where:

**`epsgfrom`**: character string specifying a CRS

**`epsgto`**  : character string specifying a CRS

**`x`**: `real(8)` or `real(4)` (8-byte  or 4-byte float),  
&nbsp; &nbsp; on &nbsp;input, Easting  coordinate in **`epsgfrom`** CRS  
&nbsp; &nbsp; on output, Easting  coordinate in **`epsgto`** CRS

**`y`**: `real(8)` or `real(4)` (8-byte  or 4-byte float),  
&nbsp; &nbsp; on &nbsp;input, Northing coordinate in **`epsgfrom`** CRS  
&nbsp; &nbsp; on output, Northing coordinate in **`epsgto`** CRS

**`jret`**: integer return code (0 = OK)

**`epsgfrom`** and **`epsgto`** can be specified as **EPSG** codes `"EPSG:<code>"`, **PROJ** strings or **WKT** (Well Known Text), see examples in [doc/examples.md](doc/examples.md).

When `epsgfrom` is `"EPSG:4326"` `x` is longitude and `y` is latitude.  

The `projcoonv` function is overloaded so that `x` and `y` can be indifferently `real(8)` or `real(4)` variables (but both the same type).  
To ensure precision < 1 m, 6 digits and `real(8)` variables are required for longitude and latitude.
For precision of *about* 1 m, 5 digits may be considered sufficient (this is up to your judgement), in that case `real(4)` variables would be precise enough.

## Compilation and test

The Fortran main **`pr_modpj.f90`** 
is provided as an example. It takes command line arguments and performs a coordinate conversion as shown in [doc/examples.md](doc/examples.md).  
**`pr_modpj_f.f90`** is the same as  **`pr_modpj.f90`**, but uses `real(4)` variables.  

Compile this way:

```
gfortran src/projcoonv.c src/pjcoonv_module.f90 main/pr_modpj.f90 -lproj -lstdc++ -o pjcoonv
```

Substitute `main/pr_modpj.f90` with your own Fortran code.

If the provided example main has been compiled, it can be used from command line as:

```
./pjcoonv <epsgfrom> <epsgto> <x/Easting coordinate> <y/Northing coordinate>
```

See [doc/examples.md](doc/examples.md).


The current [version](VERSION) has been written for PROJ-8 and successfully tested with versions of PROJ up to 9.2.1

