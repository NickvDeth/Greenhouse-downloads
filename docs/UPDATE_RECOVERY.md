# Herstel van programmatoegang na bijwerken

Op 17 november 2026 is een fout gereproduceerd in de gedeelde Windows-updater: het vervangen van een bestaand bestand vanuit de beveiligde tijdelijke map kan de gewone gebruikersrechten voor lezen/uitvoeren verliezen. Het bestand blijft aanwezig, maar Windows meldt dat het apparaat, pad of bestand niet toegankelijk is.

De oude automatische updater is daarom gestopt via manifestprotocol 2. Oude apps en helpers begrijpen uitsluitend protocol 1 en weigeren deze feeds voordat zij programmabestanden vervangen. Handtekeningen en downloadbestanden blijven controleerbaar; oude installaties ontvangen tijdelijk geen automatische updates.

Een herstelversie wordt voorbereid met herstel van bestandsrechten, toestemming bij afsluiten en een zichtbaar voortgangsvenster. Daarvoor is eenmalig een nieuwe installer nodig. De oude updater kan zijn eigen vervangingsfout niet betrouwbaar oplossen. Verwijder de bestaande installatie of instellingen niet. Nieuwe instructies verschijnen op de downloadpagina zodra de herstelinstallers zijn getest en gepubliceerd.
