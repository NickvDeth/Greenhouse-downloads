# Automatische Windows-updates

Vanaf Proxy 2.2.6, Backup 1.1.9, PLC Updater 2.2.10 en VNC Windows 0.1.14 bevat de installer een gedeelde updater. Bestaande versies moeten deze installer eenmalig gebruiken. Daarna worden nieuwe programmabestanden automatisch gedownload en na normaal afsluiten toegepast, zonder installatiewizard. Windows kan om beheerderstoestemming vragen.

De updater vergelijkt SHA-256 per bestand en slaat ongewijzigde bestanden over. Het zijn bestandsupdates, geen binaire patches: een gewijzigde EXE wordt volledig gedownload. VNC downloadt uitsluitend de eigen Windows-architectuur. Instellingen, PLC-gegevens, back-ups, planningen en snelkoppelingen worden niet opnieuw aangemaakt of vervangen.

## Een nieuwe uitgave voorbereiden

1. Laat alle bouw-, beveiligings- en installatietests van de betreffende bronrepository slagen. Gebruik alleen artifacts van dezelfde geteste commit.
2. Download de installer en de update-artifact(s). Elke platformmap bevat `files.windows-*.json` en `update-*.zip`. VNC heeft twee platformmappen naast één universele installer.
3. Voer `tools/Prepare-UpdateFeed.ps1` uit met de bestaande feed, de geteste installer en alle platformmetadata. Dit controleert hashes, ZIP-inhoud, architecturen en versies en wijzigt alleen de lokale feed. Voorbeeld:

   ```powershell
   .\tools\Prepare-UpdateFeed.ps1 -FeedPath .\updates\proxy.json -InstallerPath .\release\Setup-Greenhouse-Proxy-2.2.6.exe -MetadataPaths .\release\updates\files.windows-anycpu.json
   ```

4. Plaats de installer en alle ZIP-bestanden als release-assets onder het bijbehorende versielabel in deze repository. Bestanden met dezelfde naam/hash hoeven maar eenmaal te worden geüpload.
5. Controleer de openbare downloads voordat de feed en downloadpagina worden samengevoegd. De bestaande `downloadUrl`, `sha256` en `bytes` blijven naar de installer verwijzen voor oudere apps. De nieuwe `files`-lijst bevat uitsluitend programmabestanden. Android-vermeldingen blijven behouden.

De helpers staan in de bronrepository's onder `installer/` (bij VNC onder `desktop/installer/`). Een wijziging aan de gedeelde helper of tests wordt naar alle vier repositories doorgezet. Nieuwe programmabestandsnamen vereisen ook een bewuste uitbreiding van de toegestane namen in de helper; gebruikersgegevens horen nooit in de update-artifact.

## Bij een onderbreking

Een afgebroken of ongeldige download wordt niet toegepast. Tijdens gebruik wacht de helper; lopende processen worden nooit beëindigd. Bij een vervangfout worden eerdere bestanden teruggezet. Als ook herstel mislukt, blijven de eerdere bestanden met `RECOVERY.txt` in de afgeschermde `.update-*`-map onder de installatie staan.

Status en log staan onder `%LOCALAPPDATA%\Achterbosch\Updates\<appId>`. Na een fout kan de gebruiker in de app opnieuw controleren. De updater maakt geen services of geplande updatetaken aan en bewaart geen Windows-wachtwoorden.
