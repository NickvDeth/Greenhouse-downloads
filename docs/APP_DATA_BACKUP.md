# Greenhouse-appgegevens bewaren

Vanaf Greenhouse Backup 1.1.14 kun je de instellingen van de andere Greenhouse-apps toevoegen:

1. Open **Mappen & instellingen** en kies **Appgegevens toevoegen**.
2. Controleer de gevonden apps, bronpaden en bestanden. Vink uit wat je niet wilt meenemen. Ontbrekende of onleesbare gegevens kun je niet selecteren.
3. Kies **Toevoegen**. Dit wijzigt alleen je concept; er start nog geen back-up.
4. Kies **Opslaan in OneDrive** en voer een back-up uit, of laat de volgende geplande back-up lopen.

Opnieuw toevoegen maakt geen dubbele regels en schakelt bestaande uitgevinkte regels niet opnieuw in. Controleer zulke regels zelf als je ze wilt inschakelen.

| App | Gegevens | Standaardbron |
| --- | --- | --- |
| Greenhouse Proxy | `config.xml` en, indien aanwezig, `config.xml.bak` | `%PROGRAMDATA%\GreenhouseProxy` |
| Greenhouse PLC Updater | `voorkeuren.xml` | `%LOCALAPPDATA%\Achterbosch\PLC-Updater` |
| Greenhouse VNC | `plcs.json` en, indien aanwezig, `plcs.json.bak` | `%LOCALAPPDATA%\Achterbosch\PlcVnc` |
| Greenhouse Backup | De eigen opgeslagen configuratie | Al in OneDrive onder `Configuratie/backupsettings.json` |

Nieuw toegevoegde appprofielen nemen alleen de genoemde bestanden mee. Bestaande gewone bronmappen blijven ongewijzigd; controleer hun inhoud apart. Een nog niet gebruikte app heeft mogelijk nog geen instellingenbestand. Proxy-instellingen kunnen beheerdersrechten vereisen; de knop verandert geen Windows-toegangsrechten.

Voeg externe PLC-projectmappen, updatesjablonen en PLC-lijsten apart toe als je die ook wilt bewaren. Deze knop kopieert geen programmabestanden, logboeken, Windows-firewallregels, Windows Update-beleid of geplande taken. Verbindingsgeheimen en tijdelijke aanmeldbestanden van Backup blijven uitgesloten.

## Herstellen

Sluit de betreffende app. Bewaar eerst een kopie van eventueel bestaande instellingen en kopieer daarna de geback-upte bestanden naar de overeenkomstige gegevensmap op de doel-pc. Start de app en controleer de instellingen. Herstel nooit een volledige private Backup-gegevensmap van een andere pc.

VNC-wachtwoorden blijven versleuteld voor de oorspronkelijke Windows-gebruiker. Op een andere pc of onder een andere gebruiker moet je ze opnieuw invoeren. Controleer ook de VNC-profielen en de vertrouwde Machine Manager in PLC Updater opnieuw; paden kunnen op de doel-pc anders zijn.

Verbind Backup op een nieuwe pc opnieuw met OneDrive, controleer de bronpaden en kies **Opslaan in OneDrive** om ze lokaal goed te keuren. Verwijder appgegevensregels met een oud gebruikerspad en voeg ze op de nieuwe pc opnieuw toe met **Appgegevens toevoegen**. Gebruik bij de nieuwe regels de gewenste bestaande OneDrive-doelmapnamen voordat je opslaat. Het verwijderen van een regel verwijdert geen lokale bestanden of bestaande back-ups. Stel de planning opnieuw in wanneer nodig. Het terugzetten van bestanden herstelt geen Windows-taken of systeembeleid.

Configuraties met appgegevens vereisen Backup 1.1.14 of nieuwer. Oudere versies weigeren deze configuratie om te voorkomen dat zij de volledige appmap kopiëren. Werk daarom ook een losse EXE bij waarnaar een bestaande geplande taak nog verwijst.
