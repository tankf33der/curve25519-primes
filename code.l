`(== 64 64)
(seed (in "/dev/urandom" (rd 8)))
(de mpz_create NIL
   (%@ "malloc" 'P 16) )
(de mpz_init (P)
   (native "libgmp.so" "__gmpz_init" NIL P) )
(de mpz_clear (P)
   (native "libgmp.so" "__gmpz_clear" NIL P) )
(de mpz_set_str (A B Base)
   (default Base 10)
   (native "libgmp.so" "__gmpz_set_str" NIL A B Base) )
(de mpz_nextprime (A B)
   (native "libgmp.so" "__gmpz_nextprime" NIL A B) )
(de mpz_get_str (P Base)
   (default Base 10)
   (native "libgmp.so" "__gmpz_get_str" 'S 0 Base P) )
(de mpz_set (A B)
   (native "libgmp.so" "__gmpz_set" NIL A B) )
(de crypto_x25519_public_key (S)
   (use P
      (native
         "libmonocypher.so"
         "crypto_x25519_public_key"
         NIL
         '(P (32 B . 32))
         (cons NIL (32) S) )
      P ) )
(de crypto_scalarmult_base_soda (S)
   (use P
      (native
         "libsodium.so"
         "crypto_scalarmult_base"
         NIL
         '(P (32 B . 32))
         (cons NIL (32) S))
      P ) )
(de randN ()
   (format
      (apply
         *
         (make
            (do 7
               (link (rand 12347 1234789012)) ) ) ) ) )
(de little (N)
   (make
      (do 32
         (link (& 255 N))
         (setq N (>> 8 N)) ) ) )
(let (A (mpz_create)  B (mpz_create))
   (mpz_init A)
   (mpz_init B)
   (mpz_set_str A (randN))
   (do 100000
      (mpz_nextprime B A)
      (let (L1 (little (format (mpz_get_str B)))  L2 (reverse L1))
         (test (crypto_x25519_public_key L1) (crypto_scalarmult_base_soda L1))
         (test (crypto_x25519_public_key L2) (crypto_scalarmult_base_soda L2)) )
      (mpz_clear A)
      (mpz_init A)
      (mpz_set A B)
      (mpz_clear B)
   ) 
)
(msg 'ok)
(bye)
