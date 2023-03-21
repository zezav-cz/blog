# AES

AES (Advance Encryption Standart) je [bloková]() [symetrická]() šifra. Šifra je popsána ve standardu [FIPS PUB 197, 2001](https://nvlpubs.nist.gov/nistpubs/fips/nist.fips.197.pdf).
Šifra AES vznikla, jako náhrada za šifru [DES](), která se postupem času stala zranitelnou na útky hrubou silou. AES vznikla na základě vyběrového řízení pro nový šifrovací federální standard. Soutěž zveřejnila společnost NIST (National Institute of Standards and Technology) v roce 1997. Autoři šifry jsou  *Joana Daemena* a *Vincenta Rijmena*.

**I přesto, že AES je bloková šifra, tak není [Feistelovského typu]()**

### Výhody AES
AES se stala populární hlavně díky její nenáročnosti. AES je jednoduše optimalizovaná na většině procesorech a klade nízké paměťové nároky při šifrování i dešifrování.
### Varianty AES
AES má celkem 3 varianty s různými délkami klíče. Konkrétně podporuje klíče o délkách `128b`, `192b` a `256b`. Od délky klíče se odvozuje i počet rund, které šifra obsahuje. Jednotlivé hodnoty jsou zaznamenány níže v tabulce.
| type    | number of runds | size of expanded key |
| ------- | --------------- | -------------------- |
| AES-128(16B) | $10$              | $16*(10+1)=176B$                     |
| AES-192(24B) | $12$              |        $24*(12+1)=208B$              |
| AES-256(32B) | $14$              | $32*(14+1)=240B$          |

### Princip šifrování

Šifra pracuje s bloky o velikosti `16B (128b)`, každý blok se zpracovává v několika rundách. Runda označuje posloupnost 4 operací. Runda vždy zpracovává `16B` blok dat, který se nazývá state. State je stavové pole každé rundy. State je nejčastěji reprezentováno jako čtvercové pole `16B`.
![aes_state_schema](/images/aes_state_schema.png)
Šifrování pak probíhá dle následujícího schématu:

![aes_encryption_and_decryption_diagram](/images/aes_encryption_and_decryption_diagram.png)
Při šifrování probíhají v rundách následující operace:
- [SubBytes](AES-SubBytes.md) - Substituce bytů
- [ShoftRows](AES-ShiftRows.md)- Rotace každého řádku matice
- [MixColumns](AES-MixColumns.md) - Každý sloupec je zamíchán lineární transformací
- [AddRoundKey](AES-AddRoundKey.md) - Do matice state se přixoruje část expedovaného klíče
Při dešifrování probíhají v rundách inverzní operace jako při šifrování v opačném pořadí:
- [InverseSubBytes](AES-SubBytes.md) - Inverze Substituce bytů
- [InverseShoftRows](AES-ShiftRows.md) Rotace každého řádku matice
- [InverseMixColumns](AES-MixColumns.md) - Každý sloupec je zamíchán lineární transformací
- [AddRoundKey](AES-AddRoundKey.md) - Do matice state se přixoruje část expedovaného klíče

### Optimalizace
#### 32 bit procesor
První tři operace jsou proložit jednou rovnicí. Díky tomu lze 3 operace sjednotit do jedné, tímto dosáhneme menšímu počtu přístupu pro jednotlivá 32b slova. Díky tomu může být algoritmus na 32b architekturách výrazně rychlejší. Navíc se hodnoty těchto tří operací dají předpočítat. Tím se složitost omezí na pouhé xorování a konstantní vyhledávání v poli. Této optimalizaci se říká [optimalizace pomocí T-BOXů](AES-TBox.md).
#### Moderní procesory
Moderní procesory již obsahují dedikované instrukce pro počítaní AES, většinou se jedná o instrukce, které dokáží počítat kompletní rundy.
