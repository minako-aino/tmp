
#include <stdio.h> 

int main()
{
	char name[50];
	
	printf("\n Please Enter your Full Name: \n");
	gets(name);
	
	printf("=============\n");
	printf("%s", name);
	
	return 0;
}