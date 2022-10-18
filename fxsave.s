section .data
  align 64
  regsave times 0x200 db 0x90

section .text
  global _start

exit_0:
  xor rdi, rdi
  mov rax, 60
  syscall

exit_1:
  mov edi, 1    ; bf 01 00 00 00
  mov eax, 0x3c ; b8 3c 00 00 00
  syscall       ; 0f 05

_start:
  ; save some code in regsave sections using 128-bits chunks
  movdqu xmm0, [exit_1]

  ; copy data to the ordered regsave area
  fxsave [regsave]

  ; modify registers
  xorps xmm0, xmm0

  ; restore registers
  fxrstor  [regsave]

  ; copy regsave ordered area somewhere
  ; here we only copy xmm0 on top of the stack
  sub     rsp, 0x10
  movdqu  [rsp], xmm0

  ; we execute the copied regsave area
  jmp rsp
