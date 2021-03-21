#include <stdlib.h>
#include <stdio.h>
#include "gmp.h"

int main(void) {
	mpz_t A;

	mpz_init(A);
	mpz_set_str(A, "1234789012347890", 10);

	return 0;
}
