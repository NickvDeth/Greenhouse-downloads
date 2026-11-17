# Achterbosch Greenhouse-tools

Officiële downloads en updategegevens. De broncode blijft privé.

| Tool | Versie | Download |
| --- | --- | --- |
| Greenhouse Proxy | 2.2.7 | [Windows-installatieprogramma](https://github.com/NickvDeth/Greenhouse-downloads/releases/download/proxy-v2.2.7/Setup-Greenhouse-Proxy-2.2.7.exe) |
| Greenhouse Backup | 1.1.10 | [Windows x64-installatieprogramma](https://github.com/NickvDeth/Greenhouse-downloads/releases/download/backup-v1.1.10/Setup-Greenhouse-Backup-1.1.10.exe) |
| Greenhouse PLC Updater | 2.2.11 | [Windows-installatieprogramma](https://github.com/NickvDeth/Greenhouse-downloads/releases/download/plc-updater-v2.2.11/Setup-Greenhouse-PLC-Updater-2.2.11.exe) |
| Greenhouse VNC | 0.1.15 | [Windows-installatieprogramma voor x64 en ARM64](https://github.com/NickvDeth/Greenhouse-downloads/releases/download/vnc-windows-v0.1.15/Setup-Greenhouse-VNC-0.1.15.exe) |

De vier installatieprogramma’s plaatsen elk programma standaard in een eigen map onder `C:\Program Files\Achterbosch`. Tijdens de installatie kun je kiezen of je een snelkoppeling op het bureaublad wilt.

Greenhouse VNC heeft één installatieprogramma dat automatisch de juiste uitvoering voor Windows x64 of ARM64 installeert.

Gebruik je nog een losse EXE van een van deze tools? Download eenmalig het nieuwe installatieprogramma via de links hierboven. Oudere versies, waaronder PLC Updater 2.2.7, stappen niet automatisch over op het installatieprogramma.

Had je al een geplande back-up met opgeslagen Windows-wachtwoord en de losse EXE? Open na installatie Greenhouse Backup en kies eenmalig **Planning instellen / bijwerken**. Bewaar de oude EXE en de bijbehorende map totdat het bijwerken van de planning is geslaagd. De installatie laat die taak ongemoeid; tot de planning is bijgewerkt gebruikt die het oude programma. Taken zonder opgeslagen Windows-wachtwoord worden automatisch overgezet. Een nieuwe planning gebruikt het geïnstalleerde programma.

Vanaf Proxy 2.2.6, Backup 1.1.9, PLC Updater 2.2.10 en VNC Windows 0.1.14 controleren de Windows-tools bij het starten op nieuwe versies en downloaden ze automatisch alleen gewijzigde programmabestanden. Oudere installaties en losse EXE's moeten eenmalig een installer gebruiken. De update wordt na normaal afsluiten geïnstalleerd zonder installatiewizard. Instellingen, planningen en snelkoppelingen blijven behouden. Windows kan nog om beheerderstoestemming vragen. Via de updateknop kun je ook handmatig controleren en na een fout opnieuw proberen.

Bij een gewijzigde EXE wordt die EXE volledig gedownload; ongewijzigde bestanden worden overgeslagen. Greenhouse VNC downloadt alleen de eigen Windows-architectuur. Zie [uitgaven voorbereiden en controleren](docs/AUTOMATIC_UPDATES.md).

De huidige Windows-versies vereisen digitaal ondertekende updates en bevatten extra beveiligingscontroles. Lees [de beveiligingswijzigingen en eenmalige controles na bijwerken](docs/SECURITY.md).

[Open de downloadpagina](https://nickvdeth.github.io/Greenhouse-downloads/)
