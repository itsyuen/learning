function [outputArg1,outputArg2] = tryMe(inputArg1)
%tryMe test for call from simulink  MATLAB function call
%   dillibarately using different argument names

persistent prev;

if isempty(prev)
    prev = false;
end

outputArg1 = inputArg1;

% if inputArg1 > 0
%     outputArg2 = 1;
% else
%     outputArg2 = 0;
% end

outputArg2 = prev;
prev = (inputArg1 > 0);

end