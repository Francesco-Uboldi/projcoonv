/*
  Francesco Uboldi 2023
  PROJ >= 6

  NOTE: the use of PROJ strings to describe CRS is strongly discouraged in PROJ 6,
  as PROJ strings are a poor way of describing a CRS, and more precise its geodetic
  datum. Use of codes provided by authorities (such as "EPSG:4326", etc...) or WKT
  strings will bring the full power of the "transformation engine" used by PROJ to
  determine the best transformation(s) between two CRS. 

*/

#include <stdio.h>
#include <math.h>
#include <proj.h>

int projcoonv(char *epsgfrom,  char *epsgto,  double *x, double *y) {
  PJ *P;
  PJ* P_for_GIS;
  PJ_COORD aa, bb;

  // printf("projcoonv.c: FROM: %s\n", epsgfrom);
  // printf("projcoonv.c:  TO : %s\n", epsgto);
  // printf("projcoonv.c: input x=%lf y=%lf\n", *x, *y);


  P = proj_create_crs_to_crs(PJ_DEFAULT_CTX, epsgfrom, epsgto, NULL);

  if (P == 0) {
    printf("ERROR PROJ_CREATE_CRS_TO_CRS\n");
    return 1;
  }

  /*
    proj_normalize_for_visualization() ensures that the coordinate
    order expected and returned by proj_trans() will be longitude,
    latitude for geographic CRS, and easting, northing for projected
    CRS. If instead of using PROJ strings as above, "EPSG:XXXX" codes
    had been used, this might had been necessary.
  */
  P_for_GIS = proj_normalize_for_visualization(PJ_DEFAULT_CTX, P);
  if (P_for_GIS == 0)  {
    printf("ERROR PROJ_NORMALIZE_FOR_VISUALIZATION\n");
    proj_destroy(P);
    return 1;
  }
  proj_destroy(P);
  P = P_for_GIS;

  /*
    For reliable geographic <--> geocentric conversions, z shall not
    be some random value. Also t shall be initialized to HUGE_VAL to
    allow for proper selection of time-dependent operations if one of
    the CRS is dynamic.
  */
  aa.lpzt.z = 0.0;
  aa.lpzt.t = HUGE_VAL;

  aa.xy.x = *x;
  aa.xy.y = *y;

/*
  if (!(pj_from = pj_init_plus(epsgfrom))) {
    printf("\nstringa FROM non corretta:\n%s\n", epsgfrom);
    //printf("NO! pj_from=%p\n", pj_from);
    return 1;
  }
  if (!(pj_to = pj_init_plus(epsgto))) {
    printf("\nstringa TO non corretta:\n%s\n", epsgto);
    // printf("NO! pj_to=%p\n", pj_to);
    return 1;
  }
*/

  bb = proj_trans(P, PJ_FWD, aa);

  *x= bb.xy.x;
  *y= bb.xy.y;

  // printf("projcoonv.c: output x=%lf y=%lf\n", *x, *y);

  proj_destroy (P);

  // fflush(stdout);

  return 0;
}

