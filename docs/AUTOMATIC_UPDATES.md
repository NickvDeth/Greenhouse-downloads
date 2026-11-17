# Automatische Windows-updates

Vanaf Proxy 2.2.8, Backup 1.1.11, PLC Updater 2.2.12 en VNC Windows 0.1.16 gebruikt de gedeelde updater manifestprotocol 2. Installeer deze herstelversies eenmalig, ook als een oudere updater aanwezig is. Protocol 1 is gestopt vanwege verlies van lees-/uitvoerrechten bij bestandsvervanging. Zie [herstelinstructies](UPDATE_RECOVERY.md).

Tijdens gebruik wordt alleen de ondertekende versie-informatie opgehaald. Bij afsluiten volgt een Ja/Nee-vraag, standaard Nee. Alleen na Ja start het zichtbare updatevenster met **Download bezig → Update bezig → Update voltooid** en worden gewijzigde programmabestanden gedownload, gecontroleerd en geinstalleerd. Windows kan om beheerderstoestemming vragen. Annuleren kan tijdens downloaden/wachten; de vervanging en eventuele rollback worden niet onderbroken. Het venster blijft op de uitslag staan tot **OK**.

De nieuwe weergave zit in de updater van Proxy 2.2.10, Backup 1.1.12, PLC Updater 2.2.13 en VNC Windows 0.1.17. De helper maakt zijn eigen venster nu expliciet zichtbaar, zodat het verborgen starten van PowerShell niet ook het voortgangsvenster verbergt. Tijdens de eerste automatische update naar deze versies draait nog de oude geïnstalleerde helper; die kan de voortgang dus nog verborgen houden. Installeer voor direct herstel eenmalig de nieuwste installer over de bestaande installatie, zonder eerst te verwijderen. Instellingen blijven behouden; volgende updates gebruiken de nieuwe stappenweergave.

Heb je al op Ja geklikt en verscheen er geen voortgangsvenster? Rond lopende PLC-acties en back-ups af. Herstart Windows op een geschikt onderhoudsmoment en installeer daarna de nieuwste versie. Zo worden oude, verborgen updaterprocessen ook beëindigd.

De updater vergelijkt SHA-256 per bestand en slaat ongewijzigde bestanden over. Het zijn bestandsupdates, geen binaire patches: een gewijzigde EXE wordt volledig gedownload. VNC downloadt uitsluitend de eigen Windows-architectuur. Instellingen, PLC-gegevens, back-ups, planningen en snelkoppelingen worden niet opnieuw aangemaakt of vervangen.

Vanaf Proxy 2.2.7, Backup 1.1.10, PLC Updater 2.2.11 en VNC Windows 0.1.15 vereist de geinstalleerde updater bovendien een RSA-4096/SHA-256-ondertekening. De openbare controlesleutel staat vast in de helper onder Program Files. Alle versies, bestandsnamen, downloadlocaties en hashes worden uit de ondertekende payload gelezen; gewijzigde buitenste JSON-velden kunnen geen installatie autoriseren. Beide updatefasen controleren de handtekening opnieuw. De prive-sleutel staat niet in GitHub of GitHub Actions.

De eerste overstap moet via de herstelinstaller gebeuren: oude helpers weigeren protocol 2 en passen de nieuwe bestanden niet toe. Nieuwe helpers accepteren uitsluitend protocol 2, controleren beide keren de handtekening en herstellen de juiste bestandsrechten. Een handtekening voorkomt geen ontbrekende/geblokkeerde updates, fouten in vertrouwde software of misbruik door een beheerder die de geinstalleerde helper kan vervangen.

## Een nieuwe uitgave voorbereiden

1. Laat alle bouw-, beveiligings- en installatietests van de betreffende bronrepository slagen. Gebruik alleen artifacts van dezelfde geteste commit.
2. Download de installer en de update-artifact(s). Elke platformmap bevat `files.windows-*.json` en `update-*.zip`. VNC heeft twee platformmappen naast één universele installer.
3. Voer met Windows PowerShell 5.1 op de beheerderscomputer `tools/Prepare-UpdateFeed.ps1` uit met de bestaande feed, de geteste installer en alle platformmetadata. Dit controleert hashes, ZIP-inhoud, architecturen en versies en ondertekent de lokale feed. Zonder de bijbehorende lokale sleutel stopt de voorbereiding. Voorbeeld:

   ```powershell
   .\tools\Prepare-UpdateFeed.ps1 -FeedPath .\updates\proxy.json -InstallerPath .\release\Setup-Greenhouse-Proxy-2.2.8.exe -MetadataPaths .\release\updates\files.windows-anycpu.json
   ```

4. Plaats de installer en alle ZIP-bestanden eerst in een conceptrelease onder het bijbehorende versielabel in deze repository. Bestanden met dezelfde naam/hash hoeven maar eenmaal te worden geüpload. Controleer de volledige assetlijst en hashes voor publicatie: nieuwe releases zijn onveranderlijk, dus de tag en bestanden kunnen na publicatie niet meer worden vervangen of aangevuld. Een correctie vereist een nieuw versienummer.
5. Controleer de openbare downloads voordat de feed en downloadpagina worden samengevoegd. De bestaande `downloadUrl`, `sha256` en `bytes` blijven naar de installer verwijzen voor oudere apps. De nieuwe `files`-lijst bevat uitsluitend programmabestanden. Android-vermeldingen blijven behouden.

Bewaar ook de exacte ondertekende feed als `update-manifest.signed.json` in de conceptrelease, naast de controlewaarden. Zo blijven de metadata van die uitgave na publicatie controleerbaar, ook wanneer de hoofdfeed later naar een volgende versie wijst. De downloadrepository controleert handtekeningen en overeenstemming met de legacyvelden in CI.

De helpers staan in de bronrepository's onder `installer/` (bij VNC onder `desktop/installer/`). Een wijziging aan de gedeelde helper of tests wordt naar alle vier repositories doorgezet. Nieuwe programmabestandsnamen vereisen ook een bewuste uitbreiding van de toegestane namen in de helper; gebruikersgegevens horen nooit in de update-artifact.

## Sleutelbeheer en Windows-uitgever

De release-sleutel staat onder `%LOCALAPPDATA%\Achterbosch\ReleaseSigning\release-key.dpapi`, buiten de bronrepository en OneDrive. Windows DPAPI beveiligt de sleutel voor het huidige Windows-profiel; de map is alleen toegankelijk voor dat account en SYSTEM. Alleen `tools/release-public-key.json` is openbaar. `New-ReleaseSigningKey.ps1` is uitsluitend voor een nieuwe vertrouwensketen en weigert een bestaande sleutel te vervangen. Een nieuw gegenereerde sleutel wordt niet vanzelf door bestaande apps vertrouwd.

Behoud toegang tot dit Windows-profiel. Alleen het DPAPI-bestand kopieren naar een andere computer is geen herstelprocedure. Maak voor vervanging van deze computer een onafhankelijk versleutelde offline sleutelback-up onder beheer van de eigenaar, of rol eerst een met de bestaande sleutel ondertekende helper met de volgende publieke sleutel uit. Verlies van de oude sleutel zonder herstel vereist een eenmalige, gecontroleerde herinstallatie. Bij vermoeden van sleutelmisbruik: publicatie stoppen, de releasecomputer onderzoeken en via een onafhankelijk gecontroleerd kanaal nieuwe installers verspreiden. Malware die als dezelfde Windows-gebruiker of beheerder draait, valt buiten de bescherming van DPAPI.

Deze updateondertekening is geen officieel Authenticode-uitgeverscertificaat. De Windows-installers zijn nog niet door een erkende uitgever ondertekend. Een toekomstig Windows-certificaat of Microsoft Artifact Signing moet de exacte EXE- en installerbytes voor de hash- en publicatiestappen ondertekenen. Defender-scans en handtekeningen zijn nuttige controles, maar geen garantie dat software vrij is van kwetsbaarheden.

## Bij een onderbreking

Een afgebroken of ongeldige download wordt niet toegepast. Tijdens gebruik wacht de helper; lopende processen worden nooit beëindigd. Bij een vervangfout worden eerdere bestanden teruggezet. Als ook herstel mislukt, blijven de eerdere bestanden met `RECOVERY.txt` in de afgeschermde `.update-*`-map onder de installatie staan.

Status en log staan onder `%LOCALAPPDATA%\Achterbosch\Updates\<appId>`. Na een fout kan de gebruiker in de app opnieuw controleren. De updater maakt geen services of geplande updatetaken aan en bewaart geen Windows-wachtwoorden.
