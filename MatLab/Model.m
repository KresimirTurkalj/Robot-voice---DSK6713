test_diode;

[Sound, Fs]=audioread('good_dalek.wav');
N = size(Sound,1);

t = linspace(0,N/Fs,N);
sine = 0.5 * sin(2 * pi * 30 * t);
Vin = transpose([sine;sine]);

Path1 = Sound + Vin;
Path2 = -(Sound + Vin);
Path3 = Sound - Vin;
Path4 = -(Sound - Vin);

Path = [Path1 Path2 Path3 Path4];

for i=1:N
    pos = 0;
    for j=1:4
        if Path(i,pos+1) < 0
        	[~,indexL] = min(abs(diode(:,1) + (Path(i,pos+1))));
            Path(i,pos+1) = -diode(indexL,2);
        else 
            [~,indexL] = min(abs(diode(:,1) - (Path(i,pos+1))));
            Path(i,pos+1) = diode(indexL,2);
        end;
        if Path(i,2) < 0    
            [~,indexR] = min(abs(diode(:,1) + (Path(i,pos+2))));
            Path(i,pos+2) = -diode(indexR,2);
        else
            [~,indexR] = min(abs(diode(:,1) - (Path(i,pos+2))));
            Path(i,pos+2) = diode(indexR,2);
        end;
         pos = pos+2; 
    end;
end;

Path(:,1) = Path(:,1) + Path(:,3);
Path(:,2) = Path(:,2) + Path(:,4);
Path(:,5) = Path(:,5) + Path(:,7);
Path(:,6) = Path(:,6) + Path(:,8);

RingSoundL = Path1(:,1) - Path(:,5);
RingSoundR = Path1(:,2) - Path(:,6);

RingSound = [RingSoundL RingSoundR];
RingSound  = 2 * RingSound;

sound(RingSound, Fs);