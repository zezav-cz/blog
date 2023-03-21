# AES-TBox

[AES-SubBytes](AES-SubBytes.md)
$$
\begin{bmatrix}
b_{i,j}
\end{bmatrix} 
=
\begin{bmatrix}
SBox(a_{i.j})
\end{bmatrix}, 0 \le i \le 4, 0 \le j \le 4 
$$
[AES-ShiftRows](AES-ShiftRows.md)
$$
\begin{bmatrix}
c_{0,j} \\ c_{1,j} \\ c_{2,j} \\ c_{3,j}
\end{bmatrix}
=
\begin{bmatrix}
b_{0,j} \\ b_{1,|j+1|_4} \\ b_{2,|j+2|_4} \\ b_{3,|j+3|_4}
\end{bmatrix}, 0 \le j \le 4
$$
[AES-MixColumns](AES-MixColumns.md)
$$
\begin{bmatrix}
d_{0,j} \\ d_{1,j} \\ d_{2,j} \\ d_{3,j}
\end{bmatrix}
=
\begin{bmatrix}
02 & 03 & 01 & 01 \\
01 & 02 & 03 & 01 \\
01 & 01 & 02 & 03  \\
03 & 01 & 01 & 02
\end{bmatrix}
*
\begin{bmatrix}
c_{0,j} \\ c_{1,j} \\ c_{2,j} \\ c_{3,j}
\end{bmatrix}, 0 \le j \le 4
$$
---
$$
\begin{bmatrix}
d_{0,j} \\ d_{1,j} \\ d_{2,j} \\ d_{3,j}
\end{bmatrix}
=
\begin{bmatrix}
02 & 03 & 01 & 01 \\
01 & 02 & 03 & 01 \\
01 & 01 & 02 & 03  \\
03 & 01 & 01 & 02
\end{bmatrix}
*
\begin{bmatrix}
SBox(a_{0,j}) \\ SBox(a_{1,|j+1|_4}) \\ SBox(a_{2,|j+2|_4}) \\ SBox(a_{3,|j+3|_4})
\end{bmatrix}, 0 \le j \le 4
$$
---
$$
\begin{bmatrix}
d_{0,j} \\ d_{1,j} \\ d_{2,j} \\ d_{3,j}
\end{bmatrix}
=
\begin{bmatrix} 02 \\ 01 \\ 01 \\ 03 \end{bmatrix} * SBox(a_{0,j})
\oplus
\begin{bmatrix} 03 \\ 02 \\ 01 \\ 01 \end{bmatrix} * SBox(a_{1,|j+1|_4}) 
\oplus
\begin{bmatrix} 01 \\ 03 \\ 02 \\ 01 \end{bmatrix} * SBox(a_{2,|j+2|_4})
\oplus
\begin{bmatrix} 01 \\ 01 \\ 03 \\ 02 \end{bmatrix} * SBox(a_{3,|j+3|_4})
, 0 \le j \le 4
$$
Z toho jdou předpočítat tzv **T-Boxy**. Budou to 4 T-boxy pro všecnhy možné hodnoty $a \in \{\{00\}...\{FF\}\}$
$$
T_0[a] =
\begin{bmatrix} 02*SBox(a) \\ 01*SBox(a) \\ 01*SBox(a) \\ 03*SBox(a)\end{bmatrix},
T_1[a] =
\begin{bmatrix} 03*SBox(a) \\ 02*SBox(a) \\ 01*SBox(a) \\ 01*SBox(a)\end{bmatrix},
T_2[a] =
\begin{bmatrix} 01*SBox(a) \\ 03*SBox(a) \\ 02*SBox(a) \\ 01*SBox(a)\end{bmatrix},
T_3[a] =
\begin{bmatrix} 01*SBox(a) \\ 01*SBox(a) \\ 03*SBox(a) \\ 02*SBox(a)\end{bmatrix}
$$
$$
\begin{bmatrix}
d_{0,j} \\ d_{1,j} \\ d_{2,j} \\ d_{3,j}
\end{bmatrix}
=
T_0[a_{0,j}] \oplus T_1[a_{1,|j+1|_4}] \oplus T_2[a_{2,|j+2|_4}] \oplus T_3[a_{3,|j+3|_4}], 0 \le j \le 4
$$