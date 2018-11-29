
% SImulate the Switch Model for the drop of BFD sessions as a parameter of 
%th1 - CPU utilization 
%th2 - mem utilization  
%th3 - HWQueues 
%th4 - KernelQueues 
%th5 - systemflowpackets
% NUM - number of datapoints needed 
% rand -- For now not an input
% switchmodel(0.75,0.75,0.6,0.6,0.2,100,0);

function [s me] = switchmodel(th1, th2, th3, th4, th5, NUM, init) 

plotdata = (1:NUM); 
 if (init)
   t1data = rand(NUM,1) ;
   t2data = rand(NUM,1) ;
   t3data = rand(NUM,1) ;
  t4data = rand(NUM,1) ;
   t5data = rand(NUM,1) ;
else
 t1data = (1:NUM) / NUM ;
 t2data = (1:NUM) / NUM ;
 t3data = (1:NUM) / NUM ;
 t4data = (1:NUM) / NUM ;
 t5data = (1:NUM) / NUM ;
endif

 t1sim = zeros(NUM,1);
 t2sim = zeros(NUM,1);
 t3sim = zeros(NUM,1);
 t4sim = zeros(NUM,1);
 t5sim = zeros(NUM,1);
 s = zeros(NUM,1);
for count = 1: NUM 
  if t1data(count) > th1 
   t1sim(count) = 1 + exp(round(10*(t1data(count)-th1)) );
  else
   t1sim(count) = 0;
  endif
  if t2data(count) > th2
   t2sim(count) = 1 + exp(round(10*(t2data(count)-th2)) );
  else
   t2sim(count) = 0;
  endif
  if t3data(count) > th3
   t3sim(count) = 1 + exp(round(2*(t3data(count)-th3)) );
  else
   t3sim(count) = 0;
  endif
  if t4data(count) > th4
   t4sim(count) = 1 + exp(round(2*(t4data(count)-th4)) );
  else
   t4sim(count) = 0;
  endif
  if  (t5data(count) < th5 ) 
    t5sim(count) = 1 + exp(round(3*(t5data(count)-1+th5)^2) );
  elseif (t5data(count) > (1-th5) )
  %  t5sim(count) = 1 + exp(round(2*(t5data(count)-th5)^2) );
     t5sim(count) = 0;
  else
    t5sim(count) = 0;
  endif
 
  
s = t1sim+t2sim+t3sim+t4sim+t5sim;
% plot3(t1data,t2data,s);
% surface(t1data,t2data,s);
size(t1data);
size(t5data);
count;
endfor
%dont plot 
if 0
close
figure(1);
plot(t1data,s, "r*", t5data,t5sim,"g+");
figure(2);
plot(t2data,t2sim,"g+", t4data,t4sim,"r+" );
[xx yy ] = meshgrid(t1data,t1data);
[zz ] = meshgrid(s);
size(xx);
size(yy);
size(zz);
figure(3)

surf(xx,yy,zz);
figure(4)
plot3(t1data,t5data,s,"r*");
endif

if (init)
me = [t1data t2data t3data t4data t5data t1sim t2sim t3sim t4sim t5sim s];
else
me = [t1data; t2data; t3data ; t4data;  t5data; t1sim'; t2sim'; t3sim'; t4sim'; t5sim'; s']';
endif


end
