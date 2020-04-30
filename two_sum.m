mem=zeros(2^13,16); % initialize memory spaces 


%instruction codes:
LOAD  = bin(0,3);
STORE = bin(1,3);
ADD   = bin(2,3);
BNZ   = bin(3,3);
OR    = bin(5,3);

%Line numbers in mem at which constants and variables will be stored:
%Note that these are the *line numbers*, not the values.
%Values will be assigned later.
%Line numbers chosen big enough to be out of the way.

ONE = 100;
DECR = 102; 
N = 103; % number of integers in the list
i = 104; % index counter 
j = 105; % another index counter
A = 106; % one of the integers we are working with
B = 107; % another one of the integers
ptSTART = 108; % this contains the line number of START
TARGET = 109; % the target value
LOC = 110;
START = 200; % where the list of integers starts

% These are variables that hold the line numbers of key sections outlined
% in the google doc

ZERO = 0;
INITIAL = 1;
CHECK = 6;

mem(1+INITIAL,:) = [LOAD, bin(N,13)];
mem(1+2,:) = [STORE, bin(i,13)];
mem(1+3,:) = [LOAD, bin(i,13)];
mem(1+4,:) = [ADD, bin(DECR,13)];
mem(1+5,:) = [STORE, bin(j,13)];
mem(1+CHECK,:) = [LOAD, bin(ptSTART,13)];
mem(1+7,:) = [ADD, bin(i,13)]; % reg is currently 204
mem(1+8,:) = [OR, LOAD, zeros(1,10)];
mem(1+9,:) = [STORE, bin(LOC,13)];


% This is to just end the program
mem(1+11,:) = [LOAD, bin(ONE,13)];
mem(1+12,:) = [BNZ, bin(ZERO,13)];




mem(1+ONE,:) = bin(1,16);
mem(1+DECR,:) = ones(1,16);
mem(1+ptSTART,:) = bin(START,16);

% Receive input 
Nvalue = input("Number of integers in the list (> 2): ");
mem(1+N,:) = bin(Nvalue, 16);
for k = 1:Nvalue
     inputvalue= input(sprintf("Integer at index %d: ", k)); 
     mem(1+START+k,:) = bin(inputvalue, 16);
end
targetvalue= input("Target value: ");
mem(1+TARGET,:) = bin(targetvalue, 16);


% Run the program
cpu_program