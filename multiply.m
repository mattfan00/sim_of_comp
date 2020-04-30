 %set up and run machine language program to compute
%   P = A * B

mem=zeros(2^13,16);

%instruction codes:
LOAD  = bin(0,3);
STORE = bin(1,3);
ADD   = bin(2,3);
BNZ   = bin(3,3);

%Line numbers in mem at which constants and variables will be stored:
%Note that these are the *line numbers*, not the values.
%Values will be assigned later.
%Line numbers chosen big enough to be out of the way.

ZERO = 100;
DECR = 101;
ONE  = 102;
A = 103;
B = 104;
P = 105;

%Names for some line numbers in the program:
BACK = 2;
CONT = 6;

%Write the program:
mem(1+0,:)=[LOAD,bin(ZERO,13)];
disp(mem(1+0,:));
mem(1+1,:)=[STORE,bin(P,13)];      %initialize P
mem(1+BACK,:)=[LOAD,bin(A,13)];    %put A in register
mem(1+3,:)=[BNZ,bin(CONT,13)];     %in A is not zero, goto CONT
mem(1+4,:)=[LOAD,bin(ONE,13)];     
mem(1+5,:)=[BNZ,bin(ZERO,13)];     %stop (since A is now zero)
mem(1+CONT,:)=[ADD,bin(DECR,13)];  %decrement A by 1
mem(1+7,:)=[STORE,bin(A,13)];
mem(1+8,:)=[LOAD,bin(P,13)];
mem(1+9,:)=[ADD,bin(B,13)];        %add B to P 
mem(1+10,:)=[STORE,bin(P,13)];
mem(1+11,:)=[LOAD,bin(ONE,13)];    %put something nonzero in register
mem(1+12,:)=[BNZ,bin(BACK,13)];    %goto BACK

%Assign values to the constants:
mem(1+ZERO,:)=zeros(1,16);
mem(1+DECR,:)=ones(1,16);
mem(1+ONE,:)=bin(1,16);

%Assign values to the variables that will be multiplied
Avalue=input('Avalue=');
Bvalue=input('Bvalue=');
mem(1+A,:)=bin(Avalue,16);
mem(1+B,:)=bin(Bvalue,16);

%run the program:
cpu_program

%output the result:
Pvalue = num(mem(1+P,:),16)

