 
#include <stdio.h> 
#include<string.h>
int main()
{
   char str1[50];
   char str2[50];
   char str3[] =  " C Programming Language";
   char str4[50], str5[50];
 
   printf("\n Please enter the String you want to Copy: \n");
   gets(str1);
 
   strcpy(str2, str1); 
   //puts(str1);
   puts(str2);
  
   strcpy(str4, str3);
   puts(str4);
   //puts(str3); 
 
   strcpy(str5, " we provide free tutorials");
   puts(str5);
}