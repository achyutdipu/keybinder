format PE64 NX GUI 6.0
include "gui.inc"
entry start
section '.data' data readable writable
    r dd 0, 10, 0, 34
    orr dd 0, 10, 400, 34
    measurer dq 0, 0
    omeasurer dq 0, 0
    size dq 0
    key_name du "KEY_BINDING", 0
    process_name du "PROCESS_BINDING", 0
    delete_name du "DELETE_BINDING", 0
    dll_name db "gui.dll", 0
    mdh dq 0
    buf du 101 dup(0)
    buf_len dq 0
    software db "software", 0
    software_handle dq 0
    app_name db "keybinder", 0
    app_handle dq 0
    keys db "keys", 0
    keys_handle dq 0
    processes db "processes", 0
    processes_handle dq 0
    regwritel dq 0 ; registry write, NOT register write
    regwriter dq 0
    rwritel_size db 0
    rwriter_size db 0
    regwritebuf db 17 dup(0)
    last dq 0
    selected dq 0
    lbutton_proc dq 0
    rbutton_proc dq 0
    selected_id dq 0
    keybind dq 0
    dlghandle dq 0
    pid dq 0
    pid2 dq 0
    rcapabilityl db 0
    rcapabilityr db 0
    hextable db "0123456789ABCDEF", 0
    j_t:
        db 0
        db key_name_len
        db key_name_len+process_name_len
    bksp du "Bksp"
    tab du "Tab"
    clear du "Clear"
    entr du 21b5h
    shift du 21e7h
    ctrl du "Ctrl"
    alt du "Alt"
    pausebtn du "Pause"
    caps du "Caps"
    esc du "Esc"
    space du 23b5h
    pageup du "Page Up"
    pagedown du "Page Down"
    nd du "End"
    home du "Home"
    larr du 2190h
    uarr du 2191h
    rarr du 2192h
    darr du 2193h
    select du "Select"
    print du 0d83h, 0ddb6h
    exec du "Exec"
    prtsc du 0d83dh, 0dcf7h
    insert du "Insert"
    delete du "Delete"
    help du "Help"
    win du "Win"
    application du "Application"
    sleep du "Sleep"
    n0 du "Num0"
    n1 du "Num1"
    n2 du "Num2"
    n3 du "Num3"
    n4 du "Num4"
    n5 du "Num5"
    n6 du "Num6"
    n7 du "Num7"
    n8 du "Num8"
    n9 du "Num9"
    nmul du "Num*"
    nadd du "Num+"
    nsep du "Num|"
    nsub du "Num-"
    ndec du "Num."
    ndiv du "Num/"
    f1 du "F1"
    f2 du "F2"
    f3 du "F3"
    f4 du "F4"
    f5 du "F5"
    f6 du "F6"
    f7 du "F7"
    f8 du "F8"
    f9 du "F9"
    f10 du "F10"
    f11 du "F11"
    f12 du "F12"
    f13 du "F13"
    f14 du "F14"
    f15 du "F15"
    f16 du "F16"
    f18 du "F18"
    f19 du "F19"
    f20 du "F20"
    f21 du "F21"
    f22 du "F22"
    f23 du "F23"
    f24 du "F24"
    num du "num"
    scroll du "scroll"
    volmute du 0d83dh, 0dd07h
    voldown du 0d83dh, 0dd09h
    volup du 0d83dh, 0dd0ah
    semicol du ";"
    eplus du "="
    comma du ","
    dash du "-"
    period du "."
    slash du "/"
    grave du "`"
    lbrace du "["
    backslash du 92
    rbrace du "]"
    apostrophe du "'"
    key_table: ; only used for special keys (not numbers or letters)
        dq 0, 0, 0, 0, 0, 0, 0, 0
        dq bksp
        dq tab
        dq 0, 0
        dq clear
        dq entr
        dq 0, 0
        dq shift
        dq ctrl
        dq alt
        dq pausebtn
        dq caps
        dq 0, 0, 0, 0, 0, 0
        dq esc
        dq 0, 0, 0, 0
        dq space
        dq pageup
        dq pagedown
        dq nd
        dq home
        dq larr
        dq uarr
        dq rarr
        dq darr
        dq select
        dq print
        dq exec
        dq prtsc
        dq insert
        dq delete
        dq help ; all ascii keys correspond to their own char code.
        dq win
        dq win
        dq application
        dq sleep
        dq n0, n1, n2, n3, n4, n5, n6, n7, n8, n9, nmul, nadd, nsep, nsub, ndec, ndiv
        dq f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11, f12, f13, f14, f15, f16, 0, f18, f19, f20, f21, f22, f23, f24
        dq 0, 0, 0, 0, 0, 0, 0, 0
        dq num
        dq scroll
        dq 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        dq shift, shift, ctrl, ctrl, alt, alt
        dq 0, 0, 0, 0, 0, 0, 0
        dq volmute, voldown, volup
        dq 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        dq semicol
        dq eplus
        dq comma
        dq dash
        dq period
        dq slash
        dq grave
        dq 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        dq lbrace
        dq backslash
        dq rbrace
        dq apostrophe
        dq 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    key_lengths:
        dq 0
        db tab-bksp
        db clear-tab
        dw 0
        db entr-clear
        db shift-entr
        dw 0
        db ctrl-shift
        db alt-ctrl
        db pausebtn-alt
        db caps-pausebtn
        db esc-caps
        dw 0, 0, 0
        db space-esc
        dd 0
        db pageup-space
        db pagedown-pageup
        db nd-pagedown
        db home-nd
        db larr-home
        db uarr-larr
        db rarr-uarr
        db darr-rarr
        db select-darr
        db print-select
        db exec-print
        db prtsc-exec
        db insert-prtsc
        db delete-insert
        db help-delete
        db win-help ; all ascii keys correspond to their own char code.
        db 2 dup(application-win)
        db sleep-application
        db n0-sleep
        db 16 dup(n1-n0)
        db 9 dup(f2-f1)
        db 7 dup(f11-f10)
        db 0
        db 7 dup(f19-f18)
        dq 0
        db scroll-num
        db volmute-scroll
        dw 0, 0, 0, 0, 0, 0, 0
        db 2 dup(ctrl-shift)
        db 2 dup(alt-ctrl)
        db 2 dup(pausebtn-alt)
        db 0, 0, 0, 0, 0, 0, 0
        db 3 dup(4)
        dw 0, 0, 0, 0, 0
        db 7 dup(2)
        dw 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        db 4 dup(2)
        dq 0, 0, 0, 0
section '.text' code readable executable
    htoa: ; r9 = number, r10 = buffer
        push rax
        push rcx
        push r8
        push r9
        mov r11, 16
        mov r8, r10
        .loop:
            rol r9, 4
            mov al, r9b
            and al, 0fh
            movzx rcx, byte [hextable+rax]
            mov byte [r10], cl
            inc r10
            dec r11
            jnz .loop
        mov r10, r8
        pop r9
        pop r8
        pop rcx
        pop rax
        ret
    atoh:
        push rcx
        push r9
        push r10
        xor rax, rax
        mov r9, 16
        .loop:
            movzx rcx, byte [r10]
            cmp cl, 'A'
            jl .is_digit
            sub cl, 'A' - 10
            jmp .write
        .is_digit:
            sub cl, '0'
        .write:
            shl rax, 4
            or al, cl
            inc r10
            dec r9
            jnz .loop
        pop r10
        pop r9
        pop rcx
        ret
    hook_proc:
        test rcx, rcx
        jnz .finish
        push rcx
        push rdx
        push r8
        sub rsp, 30h
        call [GetForegroundWindow]
        mov rcx, rax
        mov rdx, pid2
        call [GetWindowThreadProcessId]
        mov rax, [pid2]
        cmp rax, [pid]
        jne .wrongprocess
        add rsp, 30h
        ; int3
        pop r8
        pop rdx
        pop rcx
        mov rcx, [dlghandle]
        movsxd r9, [r8+8]
        movsxd r8, [r8]
        cmp rdx, WM_KEYDOWN
        je dlgwrapper.keydown
        cmp rdx, WM_SYSKEYDOWN
        je dlgwrapper.keydown
        jmp dlgwrapper.keyup
    .wrongprocess:
        add rsp, 30h
        pop r8
        pop rdx
        pop rcx
    .finish:
        mov r9, r8
        mov r8, rdx
        mov rdx, rcx
        mov rcx, [keybind]
        jmp [CallNextHookEx]
    dlgwrapper:
        movzx rdx, dx
        mov rax, 1
        cmp rdx, WM_INIT
        jne .cmd
        ; int3
        mov [dlghandle], rcx
        push r9
        push r8
        push rdx
        push rcx
        mov rdx, IDC_TEXT
        sub rsp, 28h
        call [GetDlgItem]
        mov rcx, rax
        call [SetFocus]
        add rsp, 28h
        pop rcx
        pop rdx
        pop r8
        pop r9
        cmp [last], 2
        jne .ret
        mov rdx, SW_MAXIMIZE
        sub rsp, 28h
        call [ShowWindow]
        add rsp, 28h
        ret
    .sz:
        db 01100110b, 00001111b, 01101111b, 00000101b ; manual opcodes necessary bc assembler seems to not compile the actual instructions
        dd orr - $ - 4 ; RIP-relative offset: destination - current address - offset to start of instruction
        ; movdqa xmm0, [orr]
        db 01100110b, 00001111b, 01111111b, 00000101b
        dd r - $ - 4
        ; movdqa [r], xmm0
        ; int3
        mov r10, r9
        and r9, 0xffff
        shr r10, 16
        shl r10, 32
        or r10, r9
        ; rol r10, 32
        mov [size], r10
        test r8, r8
        jz .fb
        mov [last], r8
        cmp r8, 1
        je .f
    .szc:
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
    .keydown:
        cmp [selected], 0
        je .f
        push rdi
        push rsi
        xorps xmm0, xmm0
        db 01100110b, 00001111b, 01111111b, 00000101b
        dd measurer - $ - 4
        db 01100110b, 00001111b, 01101111b, 00000101b
        dd orr - $ - 4
        db 01100110b, 00001111b, 01111111b, 00000101b
        dd r - $ - 4
        mov dword [r], 5
        add dword [r+4], 2
        cmp [selected_id], IDC_OUTPUTKEY
        je .keydownr
        cmp [rcapabilityl], 0
        jne .noregwritereset
        mov [regwritel], 0
        inc [rcapabilityl]
    .noregwritereset:
        cmp r8, 30h
        jl .ckeydown
        cmp r8, 5bh
        jg .keydownc
        je .winkey
        movzx r10, byte [rwritel_size]
        mov byte [regwritel+r10], r8b
        inc [rwritel_size]
        mov rdi, [buf_len]
        test rdi, rdi
        jz .keydownsubcont
        mov word [buf+rdi], "+"
        add [buf_len], 2
        add rdi, 2
    .keydownsubcont:
        mov [buf+rdi], r8w
        add [buf_len], 2
        add rdi, 2
        jmp .keydownsubc
    .winkey:
        movzx r10, byte [rwritel_size]
        mov byte [regwritel+r10], r8b
        inc [rwritel_size]
        mov rdi, [buf_len]
        test rdi, rdi
        jz .winkeyc
        mov word [buf+rdi], "+"
        add [buf_len], 2
        add rdi, 2
    .winkeyc:
        add rdi, buf
        mov rdx, rcx
        mov rcx, 6
        mov r9, rcx
        mov rsi, win
        rep movsb
        mov rcx, rdx
        jmp .keydownsubc
    .keydownc:
        sub r8, 2ch
    .ckeydown:
        mov rsi, [key_table+r8*8]
        test rsi, rsi
        jz .sf
        movzx r10, byte [rwritel_size]
        mov byte [regwritel+r10], r8b
        inc [rwritel_size]
        mov rdi, [buf_len]
        test rdi, rdi
        jz .keydowncont
        mov word [buf+rdi], "+"
        add [buf_len], 2
        add rdi, 2
    .keydowncont:
        add rdi, buf
        mov rdx, rcx
        movzx rcx, byte [key_lengths+r8]
        mov r9, rcx
        rep movsb
        mov rcx, rdx
    .keydownsubc:
        mov rsi, rcx
        mov rdx, measurer
        add [buf_len], r9
        sub rsp, 28h
        call [MapDialogRect]
        mov rcx, rsi
        mov rdx, r
        call [MapDialogRect]
        mov rcx, [selected]
        call [GetDC]
        mov rsi, rax
        mov rcx, [selected]
        mov rdx, WM_GETFONT
        xor r8, r8
        xor r9, r9
        ; int3
        call [SendMessageW]
        mov rcx, rsi
        mov rdx, rax
        call [SelectObject]
        ; int3
        mov rcx, rsi
        mov rdx, buf
        mov rdi, rax
        mov r8, [buf_len]
        shr r8, 1
        mov r9, measurer
        sub rsp, 10h
        mov qword [rsp+20h], 420h ; DT_CALCRECT | DT_SINGLELINE
        mov qword [rsp+28h], 0
        ; int3
        call [DrawTextExW]
        add rsp, 10h
        mov rcx, rsi
        mov rdx, rdi
        call [SelectObject]
        mov rdi, [selected]
        mov rcx, rdi
        mov rdx, rsi
        call [ReleaseDC]
        mov rcx, [selected]
        movsxd rdx, dword [size]
        movsxd r8, dword [size+4]
        shr rdx, 1
        shr r8, 1
        sub edx, [r]
        movsxd r9, [r+4]
        sub rsp, 10h
        mov [rsp+20h], r9
        shr r9, 1
        sub edx, dword [measurer+8]
        sub edx, 5
        sub r8, r9
        movsxd r9, dword [measurer+8]
        add r9, 5
        mov qword [rsp+28h], 1
        ; int3
        call [MoveWindow]
        add rsp, 10h
        mov rcx, [selected]
        mov rdx, buf
        call [SetWindowTextW]
        add rsp, 28h
        pop rsi
        pop rdi
        ret
    .sf:
        pop rsi
        pop rdi
        jmp .f
    .keydownr:
        cmp [rcapabilityr], 0
        jne .noregwriteresetr
        mov [regwriter], 0
        inc [rcapabilityr]
    .noregwriteresetr:
        cmp r8, 30h
        jl .ckeydownr
        cmp r8, 5bh
        jg .keydowncr
        je .winkeyr
        movzx r10, byte [rwriter_size]
        mov byte [regwriter+r10], r8b
        inc [rwriter_size]
        mov rdi, [buf_len]
        test rdi, rdi
        jz .keydownsubcontr
        mov word [buf+rdi], "+"
        add [buf_len], 2
        add rdi, 2
    .keydownsubcontr:
        mov [buf+rdi], r8w
        add [buf_len], 2
        add rdi, 2
        jmp .keydownsubcr
    .winkeyr:
        movzx r10, byte [rwriter_size]
        mov byte [regwriter+r10], r8b
        inc [rwriter_size]
        mov rdi, [buf_len]
        test rdi, rdi
        jz .winkeyc
        mov word [buf+rdi], "+"
        add [buf_len], 2
        add rdi, 2
    .winkeycr:
        add rdi, buf
        mov rdx, rcx
        mov rcx, 6
        mov r9, rcx
        mov rsi, win
        rep movsb
        mov rcx, rdx
        jmp .keydownsubc
    .keydowncr:
        sub r8, 2bh
    .ckeydownr:
        mov rsi, [key_table+r8*8]
        test rsi, rsi
        jz .sf
        movzx r10, byte [rwritel_size]
        mov byte [regwritel+r10], r8b
        inc [rwriter_size]
        mov rdi, [buf_len]
        test rdi, rdi
        jz .keydowncontr
        mov word [buf+rdi], "+"
        add [buf_len], 2
        add rdi, 2
    .keydowncontr:
        add rdi, buf
        mov rdx, rcx
        movzx rcx, byte [key_lengths+r8]
        mov r9, rcx
        rep movsb
        mov rcx, rdx
    .keydownsubcr:
        mov rsi, rcx
        mov rdx, measurer
        add [buf_len], r9
        sub rsp, 28h
        call [MapDialogRect]
        mov rcx, rsi
        mov rdx, r
        call [MapDialogRect]
        mov rcx, [selected]
        call [GetDC]
        mov rsi, rax
        mov rcx, [selected]
        mov rdx, WM_GETFONT
        xor r8, r8
        xor r9, r9
        call [SendMessageW]
        mov rcx, rsi
        mov rdx, rax
        call [SelectObject]
        ; int3
        mov rcx, rsi
        mov rdx, buf
        mov rdi, rax
        mov r8, [buf_len]
        shr r8, 1
        mov r9, measurer
        sub rsp, 10h
        mov qword [rsp+20h], 420h ; DT_CALCRECT | DT_SINGLELINE
        mov qword [rsp+28h], 0
        call [DrawTextExW]
        add rsp, 10h
        mov rcx, rsi
        mov rdx, rdi
        call [SelectObject]
        mov rdi, [selected]
        mov rcx, rdi
        mov rdx, rsi
        call [ReleaseDC]
        mov rcx, [selected]
        movsxd rdx, dword [size]
        movsxd r8, dword [size+4]
        shr rdx, 1
        shr r8, 1
        add edx, [r]
        movsxd r9, [r+4]
        sub rsp, 10h
        mov [rsp+20h], r9
        shr r9, 1
        sub r8, r9
        movsxd r9, dword [measurer+8]
        add r9, 5
        mov qword [rsp+28h], 1
        ; int3
        call [MoveWindow]
        add rsp, 10h
        mov rcx, [selected]
        mov rdx, buf
        call [SetWindowTextW]
        add rsp, 28h
        pop rsi
        pop rdi
        ret
    .keyup:
        ; int3
        cmp [selected], 0
        jne .ret
        cmp [selected], IDC_INPUT
        jne .keyupcontr
        cmp byte [regwritel], r8b
        jne .ret
        mov [rcapabilityl], 0
        mov [rwritel_size], 0
        push rsi
        push rdi
        mov rcx, [buf_len]
        mov [buf_len], 0
        mov rdi, buf
        xor rax, rax
        rep stosb
        pop rdi
        pop rsi
        jmp .ret
    .keyupcontr:
        cmp byte [regwriter], r8b
        jne .ret
        mov [rcapabilityr], 0
        mov [rwriter_size], 0
        push rsi
        push rdi
        mov rcx, [buf_len]
        mov [buf_len], 0
        mov rdi, buf
        xor rax, rax
        rep stosb
        pop rdi
        pop rsi
    .ret:
        ret
    .lbutton:
        ; int3
        jmp [SetFocus]
    .dlgfix:
        mov rax, DLGC_WANTALLKEYS
        ret
    .ncmd:
        cmp rdx, WM_SIZE
        je .sz
        cmp rdx, WM_KEYDOWN
        je .keydown
        cmp rdx, WM_SYSKEYDOWN
        je .keydown
        cmp rdx, WM_KEYUP
        je .keyup
        cmp rdx, WM_SYSKEYUP
        je .keyup
        cmp rdx, WM_LBUTTONDOWN
        je .lbutton
        cmp rdx, WM_GETDLGCODE
        je .dlgfix
    .f:
        xor rax, rax
        ret
    .cmd:
        cmp rdx, WM_COMMAND
        jne .ncmd
        ; int3
        cmp r8, ID_CANCEL
        je .cancel
        cmp r8, IDC_SUBMITKEY
        je .submitkey
        mov rdx, r8
        cmp r8, 2000
        jge .ntnav
        jmp [EndDialog]
    .cancel:
        mov rdx, ID_CANCEL
        jmp [EndDialog]
    .ntnav:
        cmp r8, IDC_ARROW
        je .f
        int3
        push rsi
        push rdi
        mov rdx, rcx
        mov rcx, [buf_len]
        mov [buf_len], 0
        mov rdi, buf
        xor rax, rax
        rep stosb
        pop rdi
        pop rsi
        mov rcx, rdx
        mov rdx, r8
        mov [selected_id], rdx
        sub rsp, 28h
        call [GetDlgItem]
        add rsp, 28h
        mov [selected], rax
        ret
    .submitkey:
        int3
        cmp [rwritel_size], 0
        je .f
        cmp [rwriter_size], 0
        je .f
        sub rsp, 38h
        mov r10, regwritebuf
        mov r9, [regwritel]
        call htoa
        mov rcx, [keys_handle]
        mov rdx, r10
        xor r8, r8
        mov r9, REG_BINARY
        mov r10, regwriter
        mov qword [rsp+20h], r10
        movzx r10, byte [rwriter_size]
        mov qword [rsp+28h], r10
        call [RegSetValueExA]
        add rsp, 38h
        jmp .f
    rungui: ; rdx should have KEY_BINDING when calling
        xor r8, r8
        push rcx
        push r9
        sub rsp, 28h
        mov qword [rsp+20h], 0
        call [DialogBoxParamW]
        add rsp, 28h
        pop r9
        pop rcx
        sub rax, 1000
        jl .endfunc
        movzx rdx, byte [j_t+rax]
        add rdx, key_name
        jmp rungui
    .endfunc:
        ret
    start:
        int3
        sub rsp, 28h
        mov rcx, HKEY_LOCAL_MACHINE
        mov rdx, software
        xor r8, r8
        mov r9, KEY_ALL_ACCESS
        mov qword [rsp+20h], software_handle
        call [RegOpenKeyExA]
        mov rcx, [software_handle]
        mov rdx, app_name
        xor r8, r8
        mov r9, KEY_ALL_ACCESS
        mov qword [rsp+20h], app_handle
        call [RegOpenKeyExA]
        mov rcx, [app_handle]
        mov rdx, keys
        xor r8, r8
        mov r9, KEY_ALL_ACCESS
        mov qword [rsp+20h], keys_handle
        call [RegOpenKeyExA]
        mov rcx, [app_handle]
        mov rdx, processes
        xor r8, r8
        mov r9, KEY_ALL_ACCESS
        mov qword [rsp+20h], processes_handle
        call [RegOpenKeyExA]
        mov rcx, [gs:30h]
        mov rcx, [rcx+40h]
        mov [pid], rcx
        xor rcx, rcx
        call [GetModuleHandleA]
        mov r8, rcx
        mov rcx, WH_KEYBOARD_LL
        mov rdx, hook_proc
        xor r9, r9
        call [SetWindowsHookExW]
        mov [keybind], rax
        mov rcx, dll_name
        call [LoadLibraryA]
        mov [mdh], rax
        mov rcx, rax
        mov rdx, key_name
        mov r9, dlgwrapper
        call rungui
        mov rcx, [mdh]
        call [FreeLibrary]
        mov rcx, [keybind]
        call [UnhookWindowsHookEx]
        mov rcx, [software_handle]
        call [RegCloseKey]
        mov rcx, [app_handle]
        call [RegCloseKey]
        mov rcx, [keys_handle]
        call [RegCloseKey]
        mov rcx, [processes_handle]
        call [RegCloseKey]
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
        dd rva gdi32_iat
        dd 0
        dd 0
        dd rva gdi32_name
        dd rva gdi32_iat
        dd rva advapi32_iat
        dd 0
        dd 0
        dd rva advapi32_name
        dd rva advapi32_iat
        dd 5 dup(0)
    kernel32_name db "KERNEL32.DLL", 0
    user32_name db "USER32.DLL", 0
    gdi32_name db "GDI32.DLL", 0
    advapi32_name db "ADVAPI32.DLL", 0
    kernel32_iat:
        ExitProcess dq rva _ExitProcess_Name
        GetModuleHandleA dq rva _GetModuleHandleA_Name
        LoadLibraryA dq rva _LoadLibraryA_Name
        FreeLibrary dq rva _FreeLibrary_Name
        dq 0
    user32_iat:
        MessageBoxA dq rva _MessageBoxA_Name
        GetForegroundWindow dq rva _GetForegroundWindow_Name
        DialogBoxParamW dq rva _DialogBoxParamW_Name
        EndDialog dq rva _EndDialog_Name
        GetDlgItem dq rva _GetDlgItem_Name
        MoveWindow dq rva _MoveWindow_Name
        MapDialogRect dq rva _MapDialogRect_Name
        InvalidateRect dq rva _InvalidateRect_Name
        ShowWindow dq rva _ShowWindow_Name
        GetDC dq rva _GetDC_Name
        SendMessageW dq rva _SendMessageW_Name
        DrawTextExW dq rva _DrawTextExW_Name
        ReleaseDC dq rva _ReleaseDC_Name
        SetWindowTextW dq rva _SetWindowTextW_Name
        GetDlgCtrlID dq rva _GetDlgCtrlID_Name
        CallWindowProcW dq rva _CallWindowProcW_Name
        SetWindowLongPtrW dq rva _SetWindowLongPtrW_Name
        GetParent dq rva _GetParent_Name
        SetFocus dq rva _SetFocus_Name
        CallNextHookEx dq rva _CallNextHookEx_Name
        SetWindowsHookExW dq rva _SetWindowsHookExW_Name
        UnhookWindowsHookEx dq rva _UnhookWindowsHookEx_Name
        GetWindowThreadProcessId dq rva _GetWindowThreadProcessId_Name
        dq 0
    gdi32_iat:
        SelectObject dq rva _SelectObject_Name
        dq 0
    advapi32_iat:
        RegOpenKeyExA dq rva _RegOpenKeyExA_Name
        RegCloseKey dq rva _RegCloseKey_Name
        RegSetValueExA dq rva _RegSetValueExA_Name
        dq 0
    name_table:
        _ExitProcess_Name dw 0
                          db "ExitProcess", 0
        _MessageBoxA_Name dw 0
                          db "MessageBoxA", 0
        _GetForegroundWindow_Name dw 0
                                  db "GetForegroundWindow", 0
        _DialogBoxParamW_Name dw 0
                              db "DialogBoxParamW", 0
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
        _ShowWindow_Name dw 0
                         db "ShowWindow", 0
        _GetDC_Name dw 0
                    db "GetDC", 0
        _SendMessageW_Name dw 0
                          db "SendMessageW", 0
        _SelectObject_Name dw 0
                           db "SelectObject", 0
        _DrawTextExW_Name dw 0
                          db "DrawTextExW", 0
        _ReleaseDC_Name dw 0
                        db "ReleaseDC", 0
        _SetWindowTextW_Name dw 0
                             db "SetWindowTextW", 0
        _GetDlgCtrlID_Name dw 0
                           db "GetDlgCtrlID", 0
        _CallWindowProcW_Name dw 0
                              db "CallWindowProcW", 0
        _SetWindowLongPtrW_Name dw 0
                                db "SetWindowLongPtrW", 0
        _GetParent_Name dw 0
                        db "GetParent", 0
        _SetFocus_Name dw 0
                       db "SetFocus", 0
        _CallNextHookEx_Name dw 0
                             db "CallNextHookEx", 0
        _SetWindowsHookExW_Name dw 0
                                db "SetWindowsHookExW", 0
        _UnhookWindowsHookEx_Name dw 0
                                  db "UnhookWindowsHookEx", 0
        _GetWindowThreadProcessId_Name dw 0
                                       db "GetWindowThreadProcessId", 0
        _RegOpenKeyExA_Name dw 0
                            db "RegOpenKeyExA", 0
        _RegCloseKey_Name dw 0
                          db "RegCloseKey", 0
        _RegSetValueExA_Name dw 0
                             db "RegSetValueExA", 0