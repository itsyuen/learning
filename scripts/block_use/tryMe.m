function [outputArg1,outputArg2] = tryMe(inputArg1)
%tryMe test for call from simulink  MATLAB function call
%   dillibarately using different argument names

persistent prev;

if isempty(prev)
    prev = false;
end

outputArg1 = inputArg1;

if inputArg1 > 0
    disp('input is greater then zero');
else
    disp('input is less then zero');
end

outputArg2 = prev;
prev = (inputArg1 > 0);

end