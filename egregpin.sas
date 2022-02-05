options ls=80;
data one;
input x1 x2 x3 x4 y;
cards;
7   26   6   60  78.5
1   29   15  52  74.3
11  56   8   20  104.3
11  31   8   47  87.6
7   52   6   33  95.9
11  55   9   22  109.2
3   71   17  6   102.7
1   31   22  44  72.5
2   54   18  22  93.1
21  47   4   26  115.9
1   40   23  34  83.8
11  66   9   12  113.3
10  68   8   12  109.4
;
proc reg;
 model y=x1 x2 x3 x4/all;
proc princomp  cov out=new prefix=as;
 var x1 x2 x3 x4;
proc reg data=new;
  model y=as1 as3 as2 as4;
  model y=as1 as3;
  model y= as1 as2;
 proc reg data=new;
  model y=as1 as3;
  output out=bb p=p r=r;
  proc plot data=bb;
  plot p*r;
  proc print;

run;
QUIT;



ods graphics on;
proc reg data=one outvif
         outest=c ridge=0 to 0.04 by .002;
   model y=x1 x2 x3 x4;
run;
proc print data=c;
run;
proc reg data=one plots(only)=ridge(unpack VIFaxis=log)
         outest=c ridge=0 to 0.04 by .002;
   model y=x1 x2 x3 x4;
run;

ods graphics off;
run;