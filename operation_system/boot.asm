;--------------------------------------------------------------
;                       简单的引导扇区
;       清除bios显示的信息，再显示一个one os loading在屏幕中央
;       使用10h号中断的功能来实现显示字符
;--------------------------------------------------------------
%ifdef DOS
org     0x0100
%else
org     0x7c00                          ;指示汇编器将程序起始地址定位到0x7c00，这样在汇编器引用文件内标号时，会把偏移加上0x7c00
%endif

Start:
        mov     ax, cs                  ;
        mov     ds, ax                  ;
        mov     es, ax                  ;设置段寄存器，以显示字符串
loop:
        call    clear                   ;清屏
        call    display                 ;显示我们的信息
        jmp     $                       ;死循环
        
clear:
        mov     ah, 0x06                 ;设置为屏幕滚动和清屏功能
        mov     al, 0x00                 ;设置功能为清屏
        mov     ch, 0                   ;设置生效区域的左上角位置（ch代表行，cl代表列）
        mov     cl, 0                   ;
        mov     dh, 24                  ;设置生效区域的右上角位置（dh代表行，dl代表列）
        mov     dl, 79                  ;
        int     10H                     ;视频显示中断
        ret
display:  
        mov     ax, BootMessage  
        mov     bp, ax                  ;es:bp表示字符串的储存位置
        mov     cx, 0x11                 ;cx储存要显示的字符个数(当前17个)
        mov     dh, 12                  ;dh储存显示位置的行数（没有后缀表示十进制数）
        mov     dl, 30                  ;dl储存显示位置的列数
        mov     ah, 0x13                 ;ah储存功能选项，13H（19）表示显示字符串
        mov     al, 0x01                 ;al储存光标控制选项(移动光标)
        mov     bh, 0x00                 ;设置显示页数 
        mov     bl, 0x0a                 ;设置显示属性             
        int     10H                     ;视频显示中断         
        ret  
BootMessage     db      "One os loading..."  ;定义要显示的字符串
times   510-($-$$)      db      0       ;引导扇区只有512byte，我们把不足的用0填满
dw      0xaa55                          ;引导扇区必须以aa55h结束

