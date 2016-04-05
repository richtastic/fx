// erashure.c
// gcc erashure.c -o /media/driveToErase/
// ./erashure 
#include <stdio.h>
#include <time.h>

char randChar255(){
	int r = rand();
	return r%256;
//	return r%10 + '0';
}

int setFilename(char **fn, int start, int d){
	int i, r, len=0, v=abs(d);
	char str[255];
	char *filename = fn;
	while(v>0 || len==0){
		r = v % 10;
		str[len] = r + 48;
		v /= 10;
		++len;
	}
	str[len] = '\0';
	for(i=0; i<len; ++i){
		filename[i+start] = str[len-i-1];
	}
	filename[i+start] = '\0';
	return len;
}

void writeRandomFile(char **filename, int len){
	int i;
	int fd;
	char c;
	fd = fopen(filename,"w+");
	for(i=0; i<len; ++i){
		c = randChar255();
		fprintf(fd,"%c",c);
	}
	fclose(fd);
}

int main(int argc, char **argv){ // ~ 1 GB directories
	srand( time(NULL) );
	int i, j, size;
	char filename[255];
	int MAX_DIRS = 255;
	int MAX_FILES = 1000;
	int MIN_CHARS_PER_FILE = 1000000;
	int RAND_CHARS_PER_FILE = 1000;
	for(j=0;j<MAX_DIRS;++j){
		size = setFilename(&filename, 0, j);
		filename[size] = '/';
		filename[size+1] = '\0';
		mkdir(filename,0777);
		printf("DIRECTORY: %s\n",filename);
		for(i=0;i<MAX_FILES;++i){
			setFilename(&filename, size+1, i);
			//printf("FILE: %s\n",filename);
			writeRandomFile(&filename,(rand()%RAND_CHARS_PER_FILE )+MIN_CHARS_PER_FILE);
		}
	}
	return 0;
}
