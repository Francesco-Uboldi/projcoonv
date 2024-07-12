**projcoonv**,  
written for PROJ-8, successfully tested with versions of PROJ up to 9.2.1

## Examples:

GEO = longlat: "EPSG:4326"
UTM33N:  "EPSG:32633"
UTM32N:  "EPSG:32632"

```
$ pjcoonv "EPSG:4326" "EPSG:32633" 15.0014057 37.0473493
EPSG:4326
EPSG:32633
 
 IN:    15.001405699999999        37.047349300000000     
projcoonv.c: FROM: ./proj.db
projcoonv.c: FROM: EPSG:4326
projcoonv.c:  TO : EPSG:32633
projcoonv.c: input x=15.001406 y=37.047349
projcoonv.c: output x=500124.996060 y=4100125.004172
 pjcoonv_module.f90: jret=           0
 jret=           0
 OUT:    500124.99605990312        4100125.0041716523 
```

```
$ pjcoonv "EPSG:32633" "EPSG:4326" 500125 4100125
EPSG:32633
EPSG:4326
 
 IN:    500125.00000000000        4100125.0000000000     
projcoonv.c: FROM: ./proj.db
projcoonv.c: FROM: EPSG:32633
projcoonv.c:  TO : EPSG:4326
projcoonv.c: input x=500125.000000 y=4100125.000000
projcoonv.c: output x=15.001406 y=37.047349
 pjcoonv_module.f90: jret=           0
 jret=           0
 OUT:    15.001405744309453        37.047349262394697     
```


