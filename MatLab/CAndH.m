fileID = fopen('C:\Users\Student\Desktop\New folder\ringmod.h','w');
fprintf(fileID,'#ifndef ringmod\r\n');
fprintf(fileID,'#define ringmod\r\n');
fprintf(fileID,'\r\n');
fprintf(fileID,'extern const short int diode[2][32769];\r\n');
fprintf(fileID,'extern const double sine_matrix[1470];\r\n');		//Ispis .h datoteke poštujući pravila C jezika
fprintf(fileID,'\r\n');
fprintf(fileID,'#endif');
fclose(fileID);

test_diode;
fileID = fopen('C:\Users\Student\Desktop\New folder\ringmod.c','w');
fprintf(fileID,'#include "ringmod.h"\r\n');
fprintf(fileID,'const short int diode[2][32769] = {');				//početak .c datoteke, uključivanje headera
buffer = 35;
samples = 65536;
for index = 1:2
    for index2 = 1:samples/2+1
        if(diode2(index2,index)~=0)
            numberLength = floor(log10(diode2(index2,index)))+2;	//.txt ima ograničenje na 1024 znaka po redu, 2 su \r i \n
            buffer = buffer + numberLength;							//2 dodatna po broju su " ", "," i ".", ostalo ostaje znamenkama broja
        else														//Broj znakova po broju određuje se s floor(log10())
            buffer = buffer + 1;									//floor uzima cijeli dio decimalnog broja
        end;
        if(buffer > 1022)
            fprintf(fileID,'\r\n');									//Ako bi prešlo 1024, prebaci u novi red
            buffer = numberLength;
        end;
        if(index ~= 2 || index2 ~= samples/2+1)					
            fprintf(fileID,' %d,',diode2(index2, index));
        else
            fprintf(fileID,' %d',diode2(index2, index));			//MatLab ne može brisati znakove, provjera da zadnji broj ne završi s ","
        end;
    end;
end;
fprintf(fileID, '\r\n');
fprintf(fileID,'};');
fprintf(fileID, '\r\n');
fprintf(fileID, '\r\n');
t = linspace(0,1/44100*1470,1470);									//sine_matrix polje sa vrijednostima sinusa u 1470 vrijednosti
sine =  sin(2 * pi * 30 * t) * 16384;								//Analogno gornjem polju, paziti na 1024 znaka po redu
fprintf(fileID,'const double sine_matrix[1470] = { 0,');
buffer = 37;
for index = 2:1469
    if(sine(index) > 0)
        numberLength = 14;
    else
        numberLength = 15;
    end;
    buffer = buffer + numberLength;
    if(buffer > 1022)
        fprintf(fileID,'\r\n');
        buffer = numberLength;
    end;
    if(index ~= 1469)
        fprintf(fileID,' %d,',sine(index));
    else
        fprintf(fileID,' %d',sine(index));
    end;
end;
fprintf(fileID, '\r\n');
fprintf(fileID,'};');
fprintf(fileID, '\r\n');
fclose(fileID);
