# AES-ShiftRows

Sub Bytes je jedna z operací prováděných v šifře [AES](AES.md).  
Vstupem je state (pole 4x4 `16B`).

Funkce Shift Rows pouze orotuje řádky matice (vstupního pole). Při šifrování se rotuje doleva a při dešifrování do prava.
Šifrování:
$$S'_{i,j} = S_{i,|j+i|_4}$$
![[Pasted image 20221229172046.png]]
Dešifrování
$$S'_{i,j} = S_{i,|j-i|_4}$$