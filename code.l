`(== 64 64)
(seed (in "/dev/urandom" (rd 8)))
(de randN ()
   (apply
      *
      (make
         (do 8
            (link (rand 12347 1234789012)) ) ) ) )
(de little (N)
   (make
      (do 32
         (link (& 255 N))
         (setq N (>> 8 N)) ) ) )
         
(msg 'ok)
(bye)
