# Achterbosch Greenhouse-tools

Officiële downloads en updategegevens. De broncode blijft privé.

| Tool | Versie | Download |
| --- | --- | --- |
| Greenhouse Proxy | 2.2.8 | [Windows-installatieprogramma](https://github.com/NickvDeth/Greenhouse-downloads/releases/download/proxy-v2.2.8/Setup-Greenhouse-Proxy-2.2.8.exe) |
| Greenhouse Backup | 1.1.11 | [Windows x64-installatieprogramma](https://github.com/NickvDeth/Greenhouse-downloads/releases/download/backup-v1.1.11/Setup-Greenhouse-Backup-1.1.11.exe) |
| Greenhouse PLC Updater | 2.2.12 | [Windows-installatieprogramma](https://github.com/NickvDeth/Greenhouse-downloads/releases/download/plc-updater-v2.2.12/Setup-Greenhouse-PLC-Updater-2.2.12.exe) |
| Greenhouse VNC | 0.1.16 | [Windows-installatieprogramma voor x64 en ARM64](https://github.com/NickvDeth/Greenhouse-downloads/releases/download/vnc-windows-v0.1.16/Setup-Greenhouse-VNC-0.1.16.exe) |

De vier installatieprogramma’s plaatsen elk programma standaard in een eigen map onder `C:\Program Files\Achterbosch`. Tijdens de installatie kun je kiezen of je een snelkoppeling op het bureaublad wilt.

Greenhouse VNC heeft één installatieprogramma dat automatisch de juiste uitvoering voor Windows x64 of ARM64 installeert.

Installeer deze herstelversies eenmalig via de links hierboven, ook als je al automatische updates had. De oude updater kon de lees-/uitvoerrechten op programmabestanden verliezen en is daarom geblokkeerd. De herstelinstaller kan over de bestaande installatie worden uitgevoerd en behoudt instellingen en planning. Zie [herstel na een toegangsfout](docs/UPDATE_RECOVERY.md).

Had je al een geplande back-up met opgeslagen Windows-wachtwoord en de losse EXE? Open na installatie Greenhouse Backup en kies eenmalig **Planning instellen / bijwerken**. Bewaar de oude EXE en de bijbehorende map totdat het bijwerken van de planning is geslaagd. De installatie laat die taak ongemoeid; tot de planning is bijgewerkt gebruikt die het oude programma. Taken zonder opgeslagen Windows-wachtwoord worden automatisch overgezet. Een nieuwe planning gebruikt het geïnstalleerde programma.

Na deze overstap controleren de Windows-tools bij het starten op nieuwe versies. Bij afsluiten vragen ze of je wilt bijwerken. Bij **Ja** verschijnt een zichtbaar venster voor downloaden, controleren en installeren; bij **Nee** worden geen programmabestanden gedownload of gewijzigd. De uitslag blijft zichtbaar totdat je op Sluiten klikt. Instellingen, planningen en snelkoppelingen blijven behouden. Windows kan om beheerderstoestemming vragen. Via de updateknop kun je ook handmatig controleren.

Bij een gewijzigde EXE wordt die EXE volledig gedownload; ongewijzigde bestanden worden overgeslagen. Greenhouse VNC downloadt alleen de eigen Windows-architectuur. Zie [uitgaven voorbereiden en controleren](docs/AUTOMATIC_UPDATES.md).

De huidige Windows-versies vereisen digitaal ondertekende updates en bevatten extra beveiligingscontroles. Lees [de beveiligingswijzigingen en eenmalige controles na bijwerken](docs/SECURITY.md).

[Open de downloadpagina](https://nickvdeth.github.io/Greenhouse-downloads/)
