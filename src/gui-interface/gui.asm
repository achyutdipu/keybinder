format PE64 NX GUI 6.0
include "gui.inc"
entry start
section '.data' data readable writable
    r dd 0, 10, 0, 34
    orr dd 0, 10, 400, 34
    key_name db "KEY_BINDING", 0
    process_name db "PROCESS_BINDING", 0
    delete_name db "DELETE_BINDING", 0
    dll_name db  "gui.dll", 0
    mdh dq 0
    last dq 0
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
    .sz:
        db 66h, 0fh, 6fh, 00000101b
        dd orr - $ - 4 ; RIP-relative offset: destination - current address - offset to start of instruction
        ; movdqa xmm0, [orr]
        db 66h, 0fh, 7fh, 00000101b
        dd r - $ - 4
        ; movdqa [r], xmm0
        test r8, r8
        jz .fb
        mov [last], r8
        cmp r8, 1
        je .f
    .szc:
        and r9, 0xffff
        push r9
        push rcx
        mov rdx, IDC_TEXT
        sub rsp, 20h
        call [GetDlgItem]
        add rsp, 20h
        pop rcx
        push rax
        push rcx
        mov rdx, r
        sub rsp, 20h
        call [MapDialogRect]
        add rsp, 20h
        pop rcx
        mov rdx, r
        mov r9, 1
        sub rsp, 20h
        call [InvalidateRect]
        add rsp, 20h
        pop rcx
        pop r9
        xor rdx, rdx
        movsxd r8, [r+4]
        movsxd r10, [r+12]
        sub r10, r8
        sub rsp, 38h
        mov [rsp+20h], r10
        mov qword [rsp+28h], 1
        call [MoveWindow]
        add rsp, 38h
        ret
    .fb:
        cmp [last], 2
        mov [last], r8
        jne .f
        jmp .szc
    .ncmd:
        cmp rdx, WM_SIZE
        je .sz 
    .f:
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
        movzx rdx, byte [j_t+rax]
        add rdx, key_name
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
        GetDlgItem dq rva _GetDlgItem_Name
        MoveWindow dq rva _MoveWindow_Name
        MapDialogRect dq rva _MapDialogRect_Name
        InvalidateRect dq rva _InvalidateRect_Name
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
        _GetDlgItem_Name dw 0
                         db "GetDlgItem", 0
        _MoveWindow_Name dw 0
                         db "MoveWindow", 0
        _MapDialogRect_Name dw 0
                            db "MapDialogRect", 0
        _InvalidateRect_Name dw 0
                             db "InvalidateRect", 0