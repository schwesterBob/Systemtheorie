function[y] = sigma_(x)
for i=1 : length(x);
    if(x(i)<0)
        y(i) = 0;
    else
        y(i) = 1;
    end
end
