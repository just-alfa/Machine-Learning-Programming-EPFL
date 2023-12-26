function [E] = cost_function(Y, Yd, type)
%COST_FUNCTION compute the error between Yd and Y
%   inputs:
%       o Y (PxM) Output of the last layer of the network, should match Yd
%       o Yd (PxM) Ground truth
%       o type (string) type of the cost evaluation function
%   outputs:
%       o E (scalar) The error

E=0;
M = size(Yd,2);
P = size(Yd,1);

     if strcmp(type,"LogLoss")

        for i=1:P

            for j=1:M

                E= +Yd(i,j)*log(Y(i,j))+(1-Yd(i,j))*log(1-Y(i,j)) + E;

            end

        end

        
        E = -(1/M) * E;
     end

    if strcmp(type,"CrossEntropy")

         for i=1:P

            for j=1:M

                E=  +Yd(i,j)*log(Y(i,j)) + E ;

            end

         end
         
       E = -(1/M) * E;

    end

end