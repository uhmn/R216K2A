LC0:
    dw 0x200F, "Hello world!", 0 ; save a string for later



start:
    mov sp, 0  ; zero put sp (whatever that means, I just include it because LBPHacker does it in all of his scripts)
    mov r10, 0 ; save the terminal port as 0
    bump r10   ; reset the terminal
    jmp main   ; jump to the main script



main:
    send r10, 0x1052  ; set cursor position to row 6, column 3 (coords (5,2), x * 12 + y = pos, 5 * 12 + 2 = 0x52 in hex, so the value is 0x1052)
    mov r0, LC0       ; set the string
    call write_string ; write the string to the terminal
    jmp .done         ; end of code

.done:
    hlt       ; hault code execution
    jmp .done ; repeat if user resumes execution



write_string:    ; I just snagged this bit from LBPHacker...
    mov r2, r0
.loop:
    mov r1, [r0]
    jz .exit
    add r0, 1
    send r10, r1
    jmp .loop
.exit:
    add r11, r0
    sub r11, r2
    ret
