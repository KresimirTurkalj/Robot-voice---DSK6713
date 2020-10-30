fileID = fopen('C:\Users\Student\Desktop\New folder\ring_mod.txt','w');
fprintf(fileID,'#ifndef HEADER_FILE\n');
fprintf(fileID,'#define HEADER_FILE\n\n');
fprintf(fileID,'extern const float sin[1472];\n');
fprintf(fileID,'extern const float diode[513][2];\n\n');
fprintf(fileID,'#endif');