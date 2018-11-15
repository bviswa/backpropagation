% 

%Simulate the Data 
trainingset = 20000;

%t1 = 0:trainingset;
%t2 = 0:trainingset;
%t1 = t1'./trainingset;
%t2 = t2'./trainingset;
t1 = rand(trainingset,1);
t2 = rand(trainingset,1);

%t1 = sort(t1);
%t2 = sort(t2);
size(t1)
size(t2)
S = systemmodel(t1,t2); 

plot3(t1,t2,S);


% General Parameters for the Problem. 
X = [t1  t2];
size(X)
size(S)

%% Initial Training  
%% Neural Network Size  
%% Input = 2, Hidden = 2*2, Ouput = 1 
input = 2;
hidden = 60*input; 
output = 1; 

Theta1 = rand(input+1,hidden)./200; 
Theta2 = rand(hidden+1,output)./200; 

DeltaTheta1 = zeros(input+1,hidden); 
DeltaTheta2 = zeros(hidden+1,output); 


%Theta1 = Theta1.* 0.0015
%Theta2 = Theta2 .*0.0015

%% Feedforward.. 
Energy = [];
for iteration = 1 : trainingset
  sample = floor(rand()*trainingset) + 1; 
  input = X(sample,:);
  output = S(sample, :);
  Theta1;
  Theta2;
  a0 = [1 input];
  z1 = a0*Theta1;
  a1 = sigmoid(z1);
  a1 = [1 a1];
  z2 = a1*Theta2;
  a2 = sigmoid(z2);
  error =  a2-output;
   % negative absorbed above 
  % Backpropagae teh error 
  delta2 = -error*a2*(1-a2);
  delta1 = (Theta2 * delta2);
  C= a1.*(ones(size(a1)) - a1 );
  delta1 = delta1.* C';
  delta1 = delta1(2:end);
  if (iteration < 6000) 
    eta = 0.6; 
  else 
    eta = 0.05;
  endif
  
  
  DeltaTheta1 =  eta*a0'*delta1'  - 0.001*DeltaTheta1;
  DeltaTheta2 = eta*a1'*delta2' - 0.001*DeltaTheta2;
  
  
  Theta1 = Theta1 + DeltaTheta1;
  Theta2 = Theta2 + DeltaTheta2;
  Energy = [Energy error.^2 ];
endfor

Theta1;
Theta2;
%pause;

%% Feed Forward and check the first error 

sample = 300; 

T = [];
for test = 1:20
  input = X(sample + test*10,:);
  output = S(sample + test*10, :);
  Theta1;
  Theta2;
  a0 = [1 input];
  z1 = a0*Theta1;
  a1 = sigmoid(z1);
  a1 = [1 a1];
  z2 = a1*Theta2;
  a2 = sigmoid(z2);
  error =  output - a2; 
  errorp = round(error/output*100);
  error10 = abs(round(output*10) - round(a2*10)); 
  error10p = error10/(output*10)*100;
 
 T = [T ; input output a2 error errorp error10 error10p];
 
endfor

T







