
% SImulate the Model 

function s = systemmodel(t1, t2) 


    s = (t1 + t2 ) ./2  - 0.1*ones(size(t1)) ; %+ 0.1*rand(size(t1));
   %s = ( 1+ t1/2 + t2/2 + t1.^2 + t2.^2)./5 ;
  % s =  (exp(100.*t1)./exp(100) + (1 - t2.^2))./2    ; % + 0.5 * t2;
  %s= sigmoid(s);
  %s = floor(s.*10);
  %s = s/10;



end