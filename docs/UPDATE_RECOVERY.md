# Herstel na 'Kan geen toegang krijgen tot het opgegeven apparaat, pad of bestand'

De eerste herstelversies zijn Proxy **2.2.8**, Backup **1.1.11**, PLC Updater **2.2.12** en VNC Windows **0.1.16**. Je kunt ook een nieuwere versie gebruiken. Vanaf deze versies werken volgende updates via de app; de eenmalige installer is alleen nodig voor nog oudere installaties.

## Op de getroffen Windows-pc

1. Laat eventuele PLC-updates en back-ups afronden. Sluit de betreffende app als deze nog draait.
2. Download de nieuwe installer via de [downloadpagina](https://nickvdeth.github.io/Greenhouse-downloads/website/).
3. Voer de installer uit en gebruik de bestaande standaardmap onder `C:\Program Files\Achterbosch`. Bevestig de Windows-beheerderstoestemming indien gevraagd.
4. Verwijder de oude installatie of instellingen niet vooraf. De installer vervangt de programmabestanden en herstelt lees- en uitvoerrechten; instellingen, bronmappen en bestaande planningen blijven behouden.
5. Open de app opnieuw via de bestaande snelkoppeling. Blijft een fout bestaan, noteer de volledige melding en controleer of de snelkoppeling naar de standaardinstallatiemap verwijst.

De installer geeft gewone gebruikers geen schrijfrechten op programmabestanden. Windows kan nog een onbekende uitgever tonen omdat een officieel uitgeverscertificaat ontbreekt.

## Wat is opgelost?

De oude updater verving bestanden vanuit een afgeschermde tijdelijke map. Daarbij konden de lees-/uitvoerrechten voor gewone gebruikers verloren gaan. Het bestand bleef aanwezig, maar Windows weigerde het te starten. De fout is in een tijdelijke testomgeving gereproduceerd en hersteld. Nieuwe regressietests controleren rechten bij vervanging, rollback en herinstallatie, en het daadwerkelijk starten als standaardgebruiker zonder beheerdersrechten.

De oude updateprocedure is gestopt met manifestprotocol 2. Een eenmalige herstelinstallatie is noodzakelijk: de oude updater kan zijn eigen vervangingsfout niet betrouwbaar oplossen. Ook nog werkende oude installaties moeten deze overstap maken. Digitale handtekeningen, hashcontroles en de bescherming van gebruikersgegevens blijven behouden.

## Daarna bijwerken

Bij het starten controleert de app alleen of een nieuwe versie beschikbaar is. Na afsluiten verschijnt **Wil je nu bijwerken?**. **Nee** stelt de update uit zonder programmabestanden te downloaden of te wijzigen. **Ja** start het zichtbare updatevenster, eventueel na Windows-beheerderstoestemming. Dat venster toont **Download bezig → Update bezig → Update voltooid** en houdt de uitslag zichtbaar totdat je op **OK** klikt.

Deze stappenweergave is toegevoegd in Proxy 2.2.10, Backup 1.1.12, PLC Updater 2.2.13 en VNC Windows 0.1.17. Deze versies herstellen ook een fout waardoor Windows het voortgangsvenster na **Ja** verborgen kon houden. Installeer voor direct herstel eenmalig de nieuwste installer over de bestaande installatie, zonder eerst te verwijderen. Instellingen blijven behouden. De eerste automatische update vanuit een oudere versie gebruikt nog de oude updater en kan dus nog onzichtbare voortgang hebben; volgende updates gebruiken de herstelde stappenweergave.

Heb je al op Ja geklikt en verscheen er geen voortgangsvenster? Rond lopende PLC-acties en back-ups af. Herstart Windows op een geschikt onderhoudsmoment en installeer daarna de nieuwste versie. Zo worden oude, verborgen updaterprocessen ook beëindigd.

Tijdens downloaden of wachten kun je annuleren. Tijdens het vervangen van bestanden wordt annuleren tijdelijk geblokkeerd zodat herstel veilig kan verlopen. Bij een herstelfout toont het venster waar de herstelbestanden bewaard zijn; lange meldingen kun je scrollen en kopieren. Er worden geen actieve apps of achtergrondtaken geforceerd afgesloten.
