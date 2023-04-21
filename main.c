#include <stdio.h>
#include "changestr.h"
#include <string.h>

int is_three(const char* s){
    int c = 0;
    while(*s){
        c += ((*s>='a')&&(*s<='z'))||((*s>='A')&&(*s<='Z'));
        *s++;
    }
    return (c>=3);
}

int main(){
    char s[100];
    scanf("%s", s);
    int n = strlen(s);
    if(is_three(s)){
        change_to_number(s, n);
        printf("%s\n", s); 
    }else{
        invert_str(s, n);
        printf("%s\n", s);
    }
    return 0;
}
