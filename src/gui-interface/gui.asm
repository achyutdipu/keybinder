format PE64 NX GUI 6.0
entry start
section '.data' data readable writable
    title db "Choose Key", 0
    title_len equ $ - title
section '.text' code readable executable
    start:
        sub rsp, 28h
        call [GetForegroundWindow]
        mov rcx, rax
        mov rdx, title
        mov r8, title
        xor r9, r9
        call [MessageBoxA]
        add rsp, 28h
        xor rcx, rcx
        jmp [ExitProcess]
section '.idata' import readable writable
    idt:
        dd rva kernel32_iat
        dd 0
        dd 0
        dd rva kernel32_name
        dd rva kernel32_iat
        dd rva user32_iat
        dd 0
        dd 0
        dd rva user32_name
        dd rva user32_iat
        dd 5 dup(0)
    kernel32_name db "KERNEL32.DLL", 0
    user32_name db "USER32.DLL", 0
    kernel32_iat:
        ExitProcess dq rva _ExitProcess_Name
        dq 0
    user32_iat:
        MessageBoxA dq rva _MessageBoxA_Name
        GetForegroundWindow dq rva _GetForegroundWindow_Name
        dq 0
    name_table:
        _ExitProcess_Name dw 0
                          db "ExitProcess", 0
        _MessageBoxA_Name dw 0
                          db "MessageBoxA", 0
        _GetForegroundWindow_Name dw 0
                                  db "GetForegroundWindow", 0