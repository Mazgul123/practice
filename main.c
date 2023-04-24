#include <stdio.h>
#include "changestr.h"

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
    if(is_three(s)){
        change_to_number(s);
        printf("%s\n", s); 
    }else{
        invert_str(s);
        printf("%s\n", s);
    }
    return 0;
}
