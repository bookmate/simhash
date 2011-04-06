#include "ruby.h"
#include <gmp.h>
#include <stdio.h>

VALUE StringHashing = Qnil;

void Init_string_hashing();

VALUE method_hash_vl(VALUE self, VALUE bitlength);

void Init_string_hashing() {
	rb_define_method(rb_cString, "hash_vl", method_hash_vl, 1);
}

VALUE method_hash_vl(VALUE self, VALUE bitlength) {
    int bl = NUM2INT(bitlength);
    
    // for hard typecasting
    unsigned char one_char;
    char* result;
    result = malloc(bl*sizeof(char));
    unsigned long long len = RSTRING_LEN(self);
    char *string = RSTRING_PTR(self);

    if(len == 0){ return 0; }

    mpz_t x, mask, long_len;
    mpz_init_set_ui (long_len, len);
    one_char = RSTRING_PTR(self)[0];
    mpz_init_set_ui (x, one_char << 7);
    int m = 1000003; 
    
    // generating mask of length bitlength filled with 1
    mpz_init (mask);
    mpz_ui_pow_ui(mask, 2, bl);
    mpz_sub_ui (mask, mask, 1);
    
    mpz_t computations, byte;
    mpz_init(computations);
    mpz_init2 (byte, 8);

    int i = 0;
    for(i; i < len; i++) {
        one_char = string[i];
        mpz_set_ui(byte, one_char);
        mpz_mul_ui(computations, x, m);
        mpz_xor(computations, computations, byte);
        mpz_and (x, mask, computations);
    }
    
    mpz_xor(x, x, long_len);
    //gmp_printf ("C xored x is %Zd\n", x);
    mpz_get_str (result, 10, x);
    VALUE res = rb_str_new2(result);

    mpz_clear(x);
    mpz_clear(byte);
    mpz_clear(computations);
    mpz_clear(mask);
    mpz_clear(long_len);
    free(result);
    
    return res;
}
