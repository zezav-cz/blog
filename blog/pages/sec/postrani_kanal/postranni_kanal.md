# Postranní kanály

Postranní kanál je způsob výměny informací mezi systémem a okolím systému. Tento kanál využívá slabiny v softwarové, nebo hardwarové implementaci systému. Nejčastěji je napadán *algoritmus* ([Square & Multiply]()), *architektura* ([Meltdown]()), *technologie* ([CMOS]()). Nejedná se přímo o chybnou implementaci, ale o poskytování nežádoucí dat, často metadat, ze kterých lze utajovaná informace sestavit.
Postranní kanál nám poskytuje nějaké informace, které nejsou přímo tajnou informací, ale jsou závislé s utajovanou informací. Na základě dat z postranního kanálu lze utajované informace buď určit, nebo alespoň lépe specifikovat 



Mezi základní druhy postranních kanálů patří:
### [Časový postranní kanál](casovy_postranni_kanal.md)
Časový postranní kanál vzniká v případě, že doba běhu algoritmu je časově závislá na hodnotě utajované informace. Vhodným měřením doby provádění lze výskat informace o utajované informaci.    
### Chybový postranní kanál
Chybový postranní kanál vzniká při poskytování příliš mnoho dat o chybě v průběhu algoritmu. Nejtriviálnějším příkladem chybového postranního kanálu může být hláška, která udává v jakých znacích se liší uživatelský vstup od očekávaného hesla. Dalším příkladem může být poskytnutí HASHe hesla, při chybném zadání. V tomto případě se nejedné o problém v kryptografii, ale v použití kryptografické funkce. 
### [Odběrový postranní kanál](odberovy_postranni_kanal.md)
Postranním kanálem je spotřeba energie při provádění dané úlohy. V případě, že je spotřeba závislá na vnitřním stavu systému, lze informace o tomto stavu odvodit právě ze spotřeby (nejčastěji nějakého obvodu).
### Elektromagnetický postranní kanál
Jedná se o mírnou variaci odběrového postranního kanálu, kde se měří elektromagnetické pole.
### Sociální postranní kanál
Za postranní kanál lze považovat i určité získávání informací u lidí. Příkladem může být osoba, která nechce sdělit koho bude volit v příštích prezidentských volbách. Stačí si po všimnout jaké volební lísky dané osobě zbyly a z toho lze odhadnou, jakého kandidáta ve volbách podpořila.