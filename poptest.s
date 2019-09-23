.text
.global poptest
poptest:
    movq %rsp, %rax
    pushq $0x1111
    popq %rsp
    movq %rsp, %rdx
    movq %rax, %rsp
    movq %rdx, %rax
    ret           
