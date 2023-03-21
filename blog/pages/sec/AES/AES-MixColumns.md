# AES-MixColumns

Mix Columns je jedna z operací prováděných v šifře [AES](AES.md).  
Vstupem je state (pole `4x4` `16B`).

![[Pasted image 20221229172259.png]]

Mix columns se dá implementovat jako prosté násobení matic. Pozor tento provádí v modulu polynomu $x^8+x^4+x^3+x+1$
![[Pasted image 20221229172406.png]]
Tento předpis lze vyjádřit:
$$
\begin{align}
s'_{0,c} = (\{02\}*s_{0,c})\oplus (\{03\}*s_{1,c})\oplus s_{2,c}\oplus s_{3,c} \\

s'_{1,c} = s_{0,c} \oplus (\{02\}*s_{1,c})\oplus (\{03\}*s_{2,c})\oplus s_{3,c} \\

s'_{2,c} = s_{0,c} \oplus s_{1,c} \oplus (\{02\}*s_{2,c})\oplus (\{03\}*s_{3,c}) \\

s'_{3,c} = (\{03\}*s_{0,c})\oplus s_{1,c} \oplus s_{2,c} \oplus (\{02\}*s_{3,c}) 
\end{align}
$$
Zde se často opakuje operace $(\{02\}*s)$ a $(\{03\}*s)$. Ve standardu je pro tyto operace používá značení $xtimes(s)$ a $xtimes(s)\oplus s$
$$
\begin{align}
(\{02\}*s) \rightarrow xtimes(s)\\
(\{03\}*s) \rightarrow (\{02\}*s) \oplus s \rightarrow xtimes(s) \oplus s\\
\end{align}
$$
Operace  $xtimes(s)$ lze implementovat následujícím způsobem:
```cpp
unit_8 xtimes(uint_8 s){
	if( s & 1000_000 )
		return s << 1; //shift by 1 (s*{02})
	else // im case we have to module by poolynom
		return ( s << 1 ) ^ 0x1b; //shift by 1 (s*{02}) mod polynom
// XOR 0x1b nám udělá modulu polynom x^8+x^4+x^3+x+1
}
```
## Inverzní operace
lze opět implementovat pomocí násobení matic
![[Pasted image 20221229173836.png]]