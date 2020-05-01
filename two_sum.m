mem=zeros(2^13,16); % initialize memory spaces 


%instruction codes:
LOAD  = bin(0,3);
STORE = bin(1,3);
ADD   = bin(2,3);
BNZ   = bin(3,3);
OR    = bin(5,3);
XOR   = bin(6,3);

%Line numbers in mem at which constants and variables will be stored:
%Note that these are the *line numbers*, not the values.
%Values will be assigned later.
%Line numbers chosen big enough to be out of the way.

ONE = 100;
DECR = 101; 
N = 102; % number of integers in the list
i = 103; % index counter 
j = 104; % another index counter
A = 105; % one of the integers we are working with
B = 106; % another one of the integers
ptSTART = 107; % this contains the line number of START
TARGET = 108; % the target value
LOADVAL = 109;
START = 200; % where the list of integers starts

% These are variables that hold the line numbers of key sections outlined
% in the google doc

ZERO = 0;
INITIAL = 1;
CHECK = 6;
LOC1 = 10;
LOC2 = 16;
END = 21;
CHECK1 = 23;

mem(1+INITIAL,:) = [LOAD, bin(N,13)];
mem(1+2,:) = [STORE, bin(i,13)];
mem(1+3,:) = [LOAD, bin(i,13)];
mem(1+4,:) = [ADD, bin(DECR,13)];
mem(1+5,:) = [STORE, bin(j,13)];

mem(1+CHECK,:) = [LOAD, bin(ptSTART,13)];
mem(1+7,:) = [ADD, bin(i,13)]; % reg is currently 204
mem(1+8,:) = [OR, bin(LOADVAL,13)]; % reg now has the instruction and address 
mem(1+9,:) = [STORE, bin(LOC1,13)];
% now mem(1+LOC1,:) has the LOAD command stored in the first 3 bits and the
% addr of the index in the array stored in the remaining bits
mem(1+11,:) = [STORE, bin(A,13)]; 
mem(1+12,:) = [LOAD, bin(ptSTART,13)];
mem(1+13,:) = [ADD, bin(j,13)];
mem(1+14,:) = [OR, bin(LOADVAL,13)];
mem(1+15,:) = [STORE, bin(LOC2,13)];
% now mem(1+LOC2,:) has the LOAD command stored in the first 3 bits and the 
% addr of the index in the array stored in the remaining bits
mem(1+17,:) = [STORE, bin(B,13)]; 
mem(1+18,:) = [ADD, bin(A,13)];
mem(1+19,:) = [XOR, bin(TARGET,13)]; 
mem(1+20,:) = [BNZ, bin(CHECK1,13)];

mem(1+END,:) = [LOAD, bin(ONE,13)];
mem(1+22,:) = [BNZ, bin(ZERO,13)];

mem(1+CHECK1,:) = [LOAD, bin(i,13)];
mem(1+24,:) = [ADD, bin(DECR,13)];
mem(1+25,:) = [STORE, bin(j,13)];
mem(1+26,:) = [BNZ, bin(CHECK,13)]; % j != 0




mem(1+ONE,:) = bin(1,16);
mem(1+DECR,:) = ones(1,16);
mem(1+ptSTART,:) = bin(START,16);
mem(1+LOADVAL,:) = [bin(0,3), zeros(1,13)];

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


Avalue = num(mem(1+A,:),16)
Bvalue = num(mem(1+B,:),16)