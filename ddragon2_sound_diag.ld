MEMORY {
  VEC: org=0x0000, len=0x70
  MAIN: org=0x0070, len=0x7f90
  ERR: org=0x6000, len=0x2000
}

SECTIONS {
  .vecs: {
    *(vectors)
  } >VEC
  .main: {
    *(text)
  } >MAIN
  .err: {
    *(errors)
  } >ERR
}
