# Časový postranní kanál

Časový postranní kanál nejčastěji poskytuje informace o době běhu dané operace. Časový postranní kanál vzniká v případě, že utajovaná informace je závislá na době běhu nějaké události. Prevence proti poskytování časového kanálu je odstranění zmíněné závislosti. Následující kód ukazuje triviální případ časového kanálu.
```cpp
for ( int i = 0 ; i < n ; ++i ) 
    if ( pass[i] != text[i] ) 
	    return false; 
return true;
```
Tato část kódů korektně porovnává dva řetězce textu. Implementace obsahuje slabinu, která poskytuje právě časový postranní kanál. V případě, že by se porovnávalo například tajné heslo s uživatelským vstupem, je možné heslo odhalit. Slabina se nachází na řádku 3, kde funkce vrací zamítavou odpověď hned u prvního, nalezeného znaku. To vytváří závislost mezi porovnávanými řetězci a dobou vykonávání funkce. V případě, že se řetězce liší v prvním znaku, provede se smyčka pouze jednou a odpověď se vrátí ihned (za čas 1). Pokud mají řetězce první dva znaky rozdílné a třetí různý, provede se kód cyklu třikrát. V třetím běhu (čase 3) vrátí funkce ukončí. Díky této závislosti je možné postupně zkoušet heslo, měřit dobu trvání funkce a odhalovat heslo znak po znaku. Díky tomu je možné odhalit obsah řetězce pass metodou hrubé síly s asymptotickou složitostí $O(n)$, místo $O(a^n)$.
Zde je příklad, jak předchozí kód implementovat bez poskytnutí postranního kanálu:
```cpp
byte c = 0;
for ( int i = 0 ; i < n ; ++i )
	c |= pass[i] ^ b[i];
return !c;
```
Tento kód akumuluje rozdíly dvou řetězců a porovnává vždy celé řetězce. Tímto odstraňuje závislost doby běhu na hodnotách řetězců.