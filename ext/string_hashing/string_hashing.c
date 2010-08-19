#include "ruby.h"
#include <stdio.h>

VALUE StringHashing = Qnil;

void Init_string_hashing();

VALUE method_hash_wl(VALUE self, VALUE bitlength);

void Init_string_hashing() {
	rb_define_method(rb_cString, "hash_wl", method_hash_wl, 1);
}

VALUE method_hash_wl(VALUE self, VALUE bitlength) {
	unsigned long long len = RSTRING(self)->len;
    char *p = RSTRING(self)->ptr;
	if(len == 0){ return 0; }
    unsigned long long x = RSTRING(self)->ptr[0] << 7;
    int m = 1000003; 
    unsigned long long mask = (1 << bitlength) - 1;
    while (len--) {
      x = ((x * m) ^ *p) & mask;  
      p++;
    }

	return INT2NUM(x);
}
