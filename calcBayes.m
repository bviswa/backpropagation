% Calculation of bayesian Probabilities 
% First Problem ... Is there a Probability of a drop 

function calcBayes(loopcount)

mth1 = 0.9 
mth2 = 0.9 
mth3 = 0.8 
mth4 = 0.8 
mth5 = 0.2 



th1 = 0.8 
th2 = 0.9 
th3 = 0.7 
th4 = 0.8 
th5 = 0.1 
NUM = 600

pt1 = 0; 
pt2 = 0;
pt3 = 0;
pt4 = 0;
pt5 = 0; 
psdrop = 0;


  
%% In a loop Geta bunch of random data,  Caluclate our probailities , Keep updating 
for loop = 1:loopcount 
  [drop input] = switchmodel(mth1,mth2,mth3,mth4,mth5,NUM,1);
  % normalize the drop array 
  sessiondrop = ( drop > 0);
  t1  = (input(:,1) > th1);
  t2  = (input(:,2) > th2);
  t3  = (input(:,3) > th3);
  t4  = (input(:,4) > th4);
  t5  = (input(:,5) < th5);
  dropcount = sum(sessiondrop);
  t1count = sum(t1);
  t2count = sum(t2);
  t3count = sum(t3);
  t4count = sum(t4);
  t5count = sum(t5);
  psdrop = psdrop + dropcount/NUM;
  pt1 = (pt1 + t1count/dropcount);
  pt2 = (pt2 + t2count/dropcount);
  pt3 = (pt3 + t3count/dropcount);
  pt4 = (pt4 + t4count/dropcount);
  pt5 = (pt5 + t5count/dropcount);
endfor

pt1 
pt2
pt3
pt4
pt5
psdrop

  
end


