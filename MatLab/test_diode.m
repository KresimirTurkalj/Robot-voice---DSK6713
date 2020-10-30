clear all;
close all;
vb = 0.2;
vl = 0.4;
h = 1.0;
t = -1+(1/32768):1/32768:1;
samples = 65536;
v = zeros(samples,1);
value = zeros(samples,1);
diode = zeros(samples/2+1,2);
for i=1:samples
  
  v(i) = (i - samples/2) / (samples/2);
  v(i) = abs(v(i));
 
  if (v(i) <= vb)
    value(i) = 0;
  elseif ((vb < v(i)) && (v(i) <= vl))
    value(i) = h * ((power(v(i) - vb, 2)) / (2 * vl - 2 * vb));
  else
    value(i) = h * v(i) - h * vl + (h * (power(vl - vb, 2) / (2 * vl - 2 * vb)));
  end;
end;
for i=samples/2:samples
    diode(i-(samples/2-1),1) = v(i);
    diode(i-(samples/2-1),2) = value(i);
end;
diode2 = diode .* 32768;
diode2 = round(diode2);