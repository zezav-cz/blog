# Oděrový postranní kanál

Při odběrovém postranním kanálu jsou informace předávány jako hodnoty spotřeby energie při výkonu (nejčastěji výpočtu).
Útok se dělí na dvě skupiny
## SPA (Simple Power Analysis)
Pro analýzu stačí jeden průběh, analyzuje se spotřeba signálu v času.
### Útok na [Square and Multiply]()
Nejjednodušším příkladem je útok na algoritmus Square and Multiply, kdy můžeme ze spotřeby odhadnou hodnotu exponentu. To je velmi závažné například u šifry [RSA](), kdy exponent tvoří privátní klíč.
V algoritmu se provádí operace *square* vždy a operace *multiply* pouze pokud je v bitu exponentu hodnota $1$. V případě, že máme k dispozici funkci spotřeby výpočetního obvodu v čase, můžeme z této funkce hodnotu exponentu odvodit.
![odberovy_postrani_kanal6](/images/odberovy_postrani_kanal6.png) na příkladu je vidět, kdy byla prováděna operace *square* a kdy operace *multiply*.
Pro odstranění zranitelnosti je potřeba zrušit vazbu mezi výkonem a tajnou informací. Toho můžeme dosáhnout následujícím způsobem
```cpp
int k = length(d);
int x = 1;
int dummy = 1;
for ( int i = k - 1 ; i >= 0 ; --i ){
	x = x*x % n; // x^2 | SQUARE
	if (d[i] == 1)
		x = x*c & n; // x*c | MULTIPLY
	else
		dummy = = x*c & n;
}
return x;
```
Do algoritmu byl přidán řádek `8` a `9`.

## DPA (Differential Power Analysis)
Pro analýzu je potřeba velké množství průběhů, analyzuje se okamžitá hodnota spotřeby.

DPA má daný **postup**:
1. Zvolit vnitřní hodnotu, která závisí na datech a na klíči $v=f(d,k)$
2. Změřit průběhy spotřeby (traces) $t_i$ při šifrování dat $d_i$
3. Vytvořit matici hypotetických vnitřních hodnot pro všechny možné klíče a použitá data $v_{i,j}$
4. Pomocí modelu spotřeby sestavit matici hypotetické spotřeby z hypotetických vnitřních hodnot $h_{i,j}$
5. Statisticky vyhodnotit, která hypotéza o klíči nejlépe odpovídá změřené spotřebě (zvlášt’ pro každý okamžik v čase)
Postup budeme krok po kroku demonstrovat na šifře [AES](/pages/sec/AES/AES.md). Konkrétně se pokusíme o zjištění prvního bytu klíče. K dispozici budeme mít obvod, který můžeme nechat šifrovat námi zadaný otevřený text a měřit spotřebu v čase. Spotřeba bude navzorkovaná ve stálých časových intervalech. A každé měření bude začínat ve "stejný" okamžik při započetí šifrování. Budeme počítat, že máme naměřeno 500 šifrování s námi zadanými známými OT
### Zvolit vnitřní hodnotu, která závisí na datech a na klíči $v=f(d,k)$
Proto abychom mohli útok provést, musíme si určit stav v průběhu šifry, který budeme napadat. Tento stav by měla tvořit funkce, která je závislá na hledané informaci a být jedinou neznámou proměnou pro výpočet stavu. V našem případě můžeme zvolit hodnotu prvního byte po aplikaci  `AddRoundKey` a `SubBytes`. Tato funkce vypadá následovně $v = SubBytes( d \oplus k )$ , kde $v$ je výsledný byte, $d$ je první byte námi šifrovaného OT a $k$ je první byte hesla.
### Změřit průběhy spotřeby (traces) $t_i$ při šifrování dat $d_i$
Provedeme za pomocí následujícího obvodu. 
![odberovy_postrani_kanal1](/images/odberovy_postrani_kanal1.png)
Zaznamenáme spotřebu jako funkci času, vzorkování hodnot proveddeme po fixních intervalech. Z každého měření dostaneme vektor o 375000 hodnotách spotřeby. Vzorků budeme mít 500.
Z těchto dat vytvoříme matici $T \in \mathbb{Z_{256}^{500,50000}}$, kde v řádcích budeme mít jednotlivé běhy a ve sloupcích hodnoty spotřeby. Matici jsme omezili na $50000$ hodnot měření, jelikož zkoukáme pouze operaci na začátku AES. V jednom ze sloupečků (nevíme kde) se nachází okamžitá spotřeba zkoumaného stavu.
![odberovy_postrani_kanal2](/images/odberovy_postrani_kanal2.png)
### Vytvořit matici hypotetických vnitřních hodnot pro všechny možné klíče a použitá data $v_{i,j}$
Nyní vytvoříme matici, která bude reprezentovat všechny možné hodnoty námy definované funkce v prvním bodě pro všechna měření. Pro každé měření spočítáme hodnotu po operaci `SubBytes` pro každou hodnotu klíče. $V \in \mathbb{Z}_{256}^{500,256}$, $v_{i,j} = SubBytes(d \oplus k_j)$, kde $d$ je prvn9 byte OT, $k_j$ možná prvního byte hodnota klíče. 
![odberovy_postrani_kanal3](/images/odberovy_postrani_kanal3.png)
Jeden ze sloupců odpovídá hodnotě po operace `SubBytes`. Jedná se o index sloupce na pozici hodnoty prvního byte klíče.  
### Pomocí modelu spotřeby sestavit matici hypotetické spotřeby z hypotetických vnitřních hodnot $h_{i,j}$
Proto abychom mohli modelovat data dle spotřeby potřebujeme vědět, jakým způsobem jsou naše data závislá na spotřebě obvodu. Pro náš účel z předchozích výzkumů spotřeby obvodů [CMOS]() hradel víme, že očekáváme lineární spotřebu na hodnotu  [hemigovi váhy]() mezi aktuálním stavem registru respektive hodnotou na sběrnic a předchozí stavem respektive předchozí hodnotou na sběrnici.
Pro naše potřeby tedy vytvoříme matici hypotetické spotřeby $H \in \mathbb{Z_{8}^{500,256}}$, kde $h_{i,j} = HW(v_{i,j},v_{i,j-1})$
![odberovy_postrani_kanal4](/images/odberovy_postrani_kanal4.png)
Vzniklá matice je pouze transformace předchozí se zachováním významu pořadí řádků. Proto stále platí že jeden ze sloupců odpovídá **spotyřebě** po operace `SubBytes`. Jedná se o index sloupce na pozici hodnoty prvního byte klíče.  
### Statisticky vyhodnotit, která hypotéza o klíči nejlépe odpovídá změřené spotřebě (zvlášt’ pro každý okamžik v čase)
Nyní pouze stačí statisticky porovnat a vyhodnotit matice $H$ a $T$, pro vyhodnocení lze použít Pearsonův korelační koeficient, který charakterizuje úměrnost náhodných veličin. Čím více se absolutní hodnota blíží $1$, tím více jsou náhodné veličiny úměrné.
Pro vyhodnocení provedeme korelaci všech hodnot $H$ a $T$ tak aby vznikla matice $C$. Schéma matice je vidět na obrázku níže.
![odberovy_postrani_kanal5](/images/odberovy_postrani_kanal5.png)
Nyní stačí najít kde je korelace největší. Index daného řádku bude první byte klíče.