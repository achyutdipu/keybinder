format PE64 NX GUI 6.0
include "gui.inc"
entry start
section '.data' data readable writable
    key_name db "KEY_BINDING", 0
    process_name db "PROCESS_BINDING", 0
    delete_name db "DELETE_BINDING", 0
    dll_name db  "gui.dll", 0
    mdh dq 0
    j_t:
        db 0
        db key_name_len
        db key_name_len+process_name_len
section '.text' code readable executable
    dlgwrapper:
        movzx rdx, dx
        mov rax, 1
        cmp rdx, WM_INIT
        jne .cmd
        ret
    .ncmd:
        xor rax, rax
        ret
    .cmd:
        cmp rdx, WM_COMMAND
        jne .ncmd
        cmp r8, ID_CANCEL
        je .cancel
        mov rdx, r8
        jmp [EndDialog]
    .cancel:
        mov rdx, ID_CANCEL
        jmp [EndDialog]
    rungui: ; rdx should have KEY_BINDING when calling
        xor r8, r8
        push rcx
        push r9
        sub rsp, 28h
        mov qword [rsp+20h], 0
        call [DialogBoxParamA]
        add rsp, 28h
        pop r9
        pop rcx
        sub rax, 1000
        test rax, rax
        js .endfunc
        mov rdx, key_name
        movzx rax, byte [j_t+rax]
        add rdx, rax
        jmp rungui
    .endfunc:
        ret
    start:
        sub rsp, 28h
        mov rcx, dll_name
        call [LoadLibraryA]
        mov [mdh], rax
        mov rcx, rax
        mov rdx, key_name
        mov r9, dlgwrapper
        call rungui
        call [FreeLibrary]
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
        GetModuleHandleA dq rva _GetModuleHandleA_Name
        LoadLibraryA dq rva _LoadLibraryA_Name
        FreeLibrary dq rva _FreeLibrary_Name
        dq 0
    user32_iat:
        MessageBoxA dq rva _MessageBoxA_Name
        GetForegroundWindow dq rva _GetForegroundWindow_Name
        DialogBoxParamA dq rva _DialogBoxParamA_Name
        EndDialog dq rva _EndDialog_Name
        dq 0
    name_table:
        _ExitProcess_Name dw 0
                          db "ExitProcess", 0
        _MessageBoxA_Name dw 0
                          db "MessageBoxA", 0
        _GetForegroundWindow_Name dw 0
                                  db "GetForegroundWindow", 0
        _DialogBoxParamA_Name dw 0
                              db "DialogBoxParamA", 0
        _GetModuleHandleA_Name dw 0
                               db "GetModuleHandleA", 0
        _EndDialog_Name dw 0
                        db "EndDialog", 0
        _LoadLibraryA_Name dw 0
                           db "LoadLibraryA", 0
        _FreeLibrary_Name dw 0
                          db "FreeLibrary", 0