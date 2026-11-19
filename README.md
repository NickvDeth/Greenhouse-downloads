# Achterbosch Greenhouse-tools

Officiële downloads en updategegevens. De broncode blijft privé.

| Tool | Versie | Download |
| --- | --- | --- |
| Greenhouse Proxy | 2.2.17 | [Windows-installatieprogramma](https://github.com/NickvDeth/Greenhouse-downloads/releases/download/proxy-v2.2.17/Setup-Greenhouse-Proxy-2.2.17.exe) |
| Greenhouse Backup | 1.1.14 | [Windows x64-installatieprogramma](https://github.com/NickvDeth/Greenhouse-downloads/releases/download/backup-v1.1.14/Setup-Greenhouse-Backup-1.1.14.exe) |
| Greenhouse PLC Updater | 2.2.14 | [Windows-installatieprogramma](https://github.com/NickvDeth/Greenhouse-downloads/releases/download/plc-updater-v2.2.14/Setup-Greenhouse-PLC-Updater-2.2.14.exe) |
| Greenhouse VNC | 0.1.18 | [Windows-installatieprogramma voor x64 en ARM64](https://github.com/NickvDeth/Greenhouse-downloads/releases/download/vnc-windows-v0.1.18/Setup-Greenhouse-VNC-0.1.18.exe) |
| Achterbosch IP Tool | 1.4.2 | [Windows x64-installatieprogramma](https://github.com/NickvDeth/Greenhouse-downloads/releases/download/ip-tool-v1.4.2/AchterboschIPTool-win-Setup.exe) |

De installatieprogramma’s van de vier Greenhouse-apps plaatsen elk programma standaard in een eigen map onder `C:\Program Files\Achterbosch`. Tijdens de installatie kun je kiezen of je een snelkoppeling op het bureaublad wilt.

Greenhouse VNC heeft één installatieprogramma dat automatisch de juiste uitvoering voor Windows x64 of ARM64 installeert.

Kies in Proxy **2.2.17** na het bijwerken eenmaal **Taakplanner → Planning opslaan**. De app controleert de hoofdmap, **Microsoft** en **Microsoft → Windows**. Na controle van de nieuwe taak ruimt de app herkende oude proxytaken in de eerste twee mappen op. [Taaklocaties en gebruik](docs/PROXY_TASK_SCRIPT.md).

Nieuw in Proxy **2.2.16**: kies **Bestaande proxy gebruiken** op **Machines** of **Bestanden & info**. Je ziet een overzicht van een vooraf ingestelde proxy voordat je de hele machinelijst vervangt. **Opslaan** bewaart de keuze; **Configuratie toepassen** stelt de netwerkregels in. Alle vijf configuraties zijn beschikbaar: **Achterbosch**, **Fikona**, **Stadsweiden**, **Trayplant** en **Wouters**. Zie [beschikbare configuraties en gebruik](docs/PROXY_PRESETS.md).

Nieuw in Proxy **2.2.15**: de taak **RimoteGreenhouseProxy** staat weer onder **Taakplannerbibliotheek → Microsoft → Windows**. Kies na een automatische app-update eenmaal **Taakplanner → Planning opslaan**. Een herkende eerdere app-taak in de hoofdmap wordt gecontroleerd overgezet. Het PowerShell-script en extra logbestand blijven op dezelfde plek staan. Zie [taakscript en taaklocatie](docs/PROXY_TASK_SCRIPT.md).

Nieuw in Proxy **2.2.14**: **Taakplanner → Planning opslaan** maakt `C:\Program Files\Rimote\Achterbosch\GreenhouseProxy\GreenhouseProxy.ps1` aan en laat de bestaande taak **RimoteGreenhouseProxy** dat script uitvoeren. Het script gebruikt steeds de laatst opgeslagen machineconfiguratie. In dezelfde map houdt **GreenhouseProxy.log** de aangemaakte/bijgewerkte regels en eventuele fouten bij. De installatiemap van de app blijft gelijk. Zie [taakscript en extra logbestand](docs/PROXY_TASK_SCRIPT.md).

Vanaf Proxy 2.2.8, Backup 1.1.11, PLC Updater 2.2.12 en VNC Windows 0.1.16 werken volgende updates via de app. Nog oudere versies hebben eenmalig de nieuwste installer nodig: de oude updater kon lees-/uitvoerrechten verliezen en is geblokkeerd. De installer kan over de bestaande installatie worden uitgevoerd en behoudt instellingen en planning. Zie [herstel na een toegangsfout](docs/UPDATE_RECOVERY.md).

Nieuw in Backup 1.1.14: kies **Mappen & instellingen → Appgegevens toevoegen** om de instellingen van Proxy, PLC Updater en VNC te selecteren. Controleer de gevonden bestanden en kies daarna **Opslaan in OneDrive**. De eigen Backup-configuratie wordt al in OneDrive bewaard. Zie [appgegevens bewaren en herstellen](docs/APP_DATA_BACKUP.md).

Proxy 2.2.9 voegde het menu **Windows Update** toe. Op ondersteunde Pro-, Education-, Enterprise- en IoT Enterprise-edities kun je automatische installaties plannen op een dag en heel uur, Windows zelf laten kiezen of automatische updates uitzetten terwijl handmatig bijwerken mogelijk blijft. Zie [Windows Update instellen](docs/WINDOWS_UPDATE.md).

Nieuw in Proxy **2.2.13**: op Windows Home kun je in dit menu **Windows-updates uit** of **Windows-updates aan** kiezen. Uitzetten stopt de Windows Update-service (`wuauserv`) en schakelt het starten ervan uit. Automatische én handmatige Windows-updates, inclusief Windows-beveiligingsupdates, werken dan niet. Aanzetten herstelt alleen de oorspronkelijke service-instellingen die Proxy heeft opgeslagen. Home heeft hier geen installatieplanning. Zet Windows-updates weer aan voordat je Proxy verwijdert.

Deze Home-bediening is geen door Microsoft ondersteund permanent updatebeleid: Windows kan de service later opnieuw inschakelen, en een al voorbereide update of herstart kan doorgaan. Updates van Greenhouse Proxy blijven beschikbaar. **Windows Update openen** geeft toegang tot de pauze- en onderhoudsmogelijkheden van Windows zelf.

Proxy **2.2.12** herstelde de melding dat er al een actie loopt wanneer je Windows Update tijdens de opstartcontrole opent. Die versie herkende Windows Home duidelijker en legde uit dat Home het gebruikte automatische updatebeleid niet ondersteunt. Ook de overdracht van opdrachten naar PowerShell werd hersteld voor verschillende Windows-tekencoderingen. Deze oplossingen blijven in 2.2.13 behouden.

Had je al een geplande back-up met opgeslagen Windows-wachtwoord en de losse EXE? Open na installatie Greenhouse Backup en kies eenmalig **Planning instellen / bijwerken**. Bewaar de oude EXE en de bijbehorende map totdat het bijwerken van de planning is geslaagd. De installatie laat die taak ongemoeid; tot de planning is bijgewerkt gebruikt die het oude programma. Taken zonder opgeslagen Windows-wachtwoord worden automatisch overgezet. Een nieuwe planning gebruikt het geïnstalleerde programma.

Vanaf Proxy 2.2.11, Backup 1.1.13, PLC Updater 2.2.14 en VNC Windows 0.1.18 verschijnt bij het opstarten een **Ja/Nee**-vraag als een update beschikbaar is. Bij **Nee** kun je doorwerken en blijft **Nu bijwerken** beschikbaar. Er worden dan geen programmabestanden gedownload of gewijzigd. Bij **Ja** of **Nu bijwerken** sluit de app eerst netjes af. Daarna verschijnt **Download bezig → Update bezig → Update voltooid**, zonder een tweede bevestigingsvraag. Het venster blijft op de uitslag staan tot **OK**. Windows kan om beheerderstoestemming vragen. Een uitgestelde update wordt ook bij normaal afsluiten opnieuw aangeboden. Lopende back-ups, PLC-acties en VNC-sessies worden niet onderbroken; geplande back-ups tonen geen updatevraag. Dit geldt voor geïnstalleerde apps; een losse EXE biedt de vertrouwde installer aan en moet vóór installatie handmatig worden gesloten.

Bestaande bureaubladsnelkoppelingen blijven exact behouden, ook wanneer je de nieuwste installer over een bestaande installatie uitvoert. De bureaubladoptie in de installer maakt alleen een ontbrekende snelkoppeling aan; uitvinken verwijdert een bestaand pictogram niet. Zo blijft je bureaubladindeling behouden.

De nieuwe stappenweergave zit in Proxy 2.2.10, Backup 1.1.12, PLC Updater 2.2.13 en VNC Windows 0.1.17. Deze versies herstellen ook een fout waardoor Windows het voortgangsvenster na **Ja** verborgen kon houden. **Installeer voor direct herstel eenmalig de nieuwste installer over de bestaande installatie**, zonder eerst te verwijderen. Instellingen blijven behouden. De eerste automatische update vanuit een oudere versie gebruikt nog de oude updater en kan dus nog onzichtbare voortgang hebben; volgende updates gebruiken de herstelde stappenweergave.

Heb je al op Ja geklikt en verscheen er geen voortgangsvenster? Rond lopende PLC-acties en back-ups af. Herstart Windows op een geschikt onderhoudsmoment en installeer daarna de nieuwste versie. Zo worden oude, verborgen updaterprocessen ook beëindigd.

Bij een gewijzigde EXE wordt die EXE volledig gedownload; ongewijzigde bestanden worden overgeslagen. Greenhouse VNC downloadt alleen de eigen Windows-architectuur. Zie [uitgaven voorbereiden en controleren](docs/AUTOMATIC_UPDATES.md).

De huidige Windows-versies vereisen digitaal ondertekende updates en bevatten extra beveiligingscontroles. Lees [de beveiligingswijzigingen en eenmalige controles na bijwerken](docs/SECURITY.md).

[Open de downloadpagina](https://nickvdeth.github.io/Greenhouse-downloads/)
