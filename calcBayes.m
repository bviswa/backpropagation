% Calculation of bayesian Probabilities 
% First Problem ... Is there a Probability of a drop 

function calcBayes(loopcount)

mth1 = 0.9 
mth2 = 0.9 
mth3 = 0.8 
mth4 = 0.8 
mth5 = 0.2 
msd = 0.04



th1 = 0.9 
th2 = 0.8 
th3 = 0.8 
th4 = 0.8 
th5 = 0.2 
NUM = 0600

pt1 = 0; 
pt2 = 0;
pt3 = 0;
pt4 = 0;
pt5 = 0; 
psdrop = 0;
ptd1 = 0; 
ptd2 = 0;
ptd3 = 0;
ptd4 = 0;
ptd5 = 0; 


  
%% In a loop Geta bunch of random data,  Caluclate our probailities , Keep updating 
for loop = 1:loopcount 
  [drop input] = switchmodel(mth1,mth2,mth3,mth4,mth5,NUM,1);
%  [drop input] = uniformswitch(mth1,mth2,mth3,mth4,mth5,NUM,1);
%  [drop input] = gaussianswitch(mth1,mth2,mth3,mth4,mth5,msd,NUM,1);
  % normalize the drop array 
  sessiondrop = ( drop > 0);
  t1  = (input(:,1) > th1);
  t2  = (input(:,2) > th2);
  t3  = (input(:,3) > th3);
  t4  = (input(:,4) > th4);
  t5  = (input(:,5) < th5);
  td1  = ((input(:,1) > th1) .* (sessiondrop));
  td2  = (input(:,2) > th2) .* (sessiondrop);
  td3  = (input(:,3) > th3) .* (sessiondrop);
  td4  = (input(:,4) > th4) .* (sessiondrop);
  td5  = (input(:,5) < th5) .* (sessiondrop);
  dropcount = sum(sessiondrop);
  t1count = sum(t1);
  t2count = sum(t2);
  t3count = sum(t3);
  t4count = sum(t4);
  t5count = sum(t5);
  td1count = sum(td1);
  td2count = sum(td2);
  td3count = sum(td3);
  td4count = sum(td4);
  td5count = sum(td5);

  if (loop == 1)
  psdrop =  dropcount/NUM;
  pt1 = t1count/dropcount;
  pt2 = t2count/dropcount;
  pt3 = t3count/dropcount;
  pt4 = t4count/dropcount;
  pt5 = t5count/dropcount;
  ptd1 = td1count/t1count;
  ptd2 = td2count/t2count;
  ptd3 = td3count/t3count;
  ptd4 = td4count/t4count;
  ptd5 = td5count/t5count;
  else
  psdrop = [psdrop  dropcount/NUM];
  pt1 = [pt1  t1count/dropcount];
  pt2 = [pt2  t2count/dropcount];
  pt3 = [pt3  t3count/dropcount];
  pt4 = [pt4  t4count/dropcount];
  pt5 = [pt5  t5count/dropcount];
  ptd1 = [ptd1  td1count/t1count];
  ptd2 = [ptd2  td2count/t2count];
  ptd3 = [ptd3  td3count/t3count];
  ptd4 = [ptd4  td4count/t4count];
  ptd5 = [ptd5  td5count/t5count];
  endif
endfor



if (loopcount < 3 )
	pt1 
	pt2
	pt3
	pt4
	pt5
	psdrop
	ptd1 
	ptd2
	ptd3
	ptd4
	ptd5

else

 % Calculate histogram of all 
  [h1 h1c]  = calcThreshold(ptd1,10)
  [h2 h2c]  = calcThreshold(ptd2,10)
  [h3 h3c]  = calcThreshold(ptd3,10)
  [h4 h4c]  = calcThreshold(ptd4,10)
  [h5 h5c]  = calcThreshold(ptd5,10)

endif 
end





function [thresh threshval]= calcThreshold(plist,num)
% Calculate histogram of plist 
[h hc] = hist(plist,10)
sum = 0;
for loop = 1:10
	sum = sum + h(10- loop+1);
	if sum > 50
		break;
	endif
endfor

thresh = 10 - loop + 1;
threshval = hc(10-loop+1); 

end

