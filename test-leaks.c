#include <stdlib.h>
#include <stdio.h>
#include "gmp.h"

int main(void) {
	mpz_t A;

	mpz_init(A);
	for(u_int64_t i=0; i < 888888888; i++) { 
		mpz_set_str(A, "1234789012347890111", 10);
		// leaks, because of NULL, read doc.
		printf("fin: %s\n", mpz_get_str(NULL, 10, A));
	}

	return 0;
}
