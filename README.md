# Frequenzzähler

![freqZ](https://user-images.githubusercontent.com/94011180/148918586-18557163-da52-483b-81dc-bf96efdbdaee.png)

### Ziel:

Das Ziel dieser Belegarbeit ist die Implementierung eines Frequenzzählers von der Art
”Universalzähler” in der Beschreibungssprache VHDL, um die wichtigen Grundlagen des
digitalen Schaltungentwurfs mittels VHDL zu meistern.

### Struktur:

1. Eingangsstufe und Trigger: Das zu zählende Signal wird ggf. verstärkt und in eine Abfolge von Rechteckimpulsen umgewandelt. Zähler für sehr hohe Frequenzen (über    ca. 100 MHz) besitzen zusätzlich vorgeschaltete schnelle Frequenzteiler (Vorteiler).
2. Torschaltung: Das Rechtecksignal wird in einer UND-Schaltung mit dem Torsignal verknüpft.
3. Zählerkette: Ein digitaler dekadischer Ereigniszähler zählt die Anzahl der Impulse, die von der Torschaltung kommen. Je nach Anforderung an die Auflösung umfasst    der Zähler meistens 4 bis 8 Dekaden.
4. Anzeige (Display): Der Zählerstand wird in Ziffernform angezeigt. Meistens besitzt die Anzeige einen Speicher, so dass der vorige Zählerstand so lange angezeigt    wird, bis der nächste Messwert ermittelt ist.
5. Zeitbasis: Die Torzeit (umschaltbar in Schritten einer Zehnerpotenz, z. B. 0,01 s, 0,1 s, 1,0 s, 10 s) wird durch einen präzisen Quarzoszillator mit                nachfolgendem, umschaltbarem Frequenzteiler erzeugt.
6. Ablaufsteuerung: durch eine Steuerelektronik.

### Prescaler Schema:
![2022-01-11-104314_1366x768_scrot](https://user-images.githubusercontent.com/94011180/148919325-32c6b869-d131-4874-adaa-8796ba8f7075.png)


[schematic.pdf](https://github.com/ShyngysM/VHDL_Frequenzzaehler/files/7845380/schematic.pdf)
