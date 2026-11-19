# Bestaande proxy gebruiken

Vanaf Greenhouse Proxy **2.2.16** staat de knop **Bestaande proxy gebruiken** op **Machines** en **Bestanden & info**. Hiermee laad je één volledige vooraf ingestelde proxyconfiguratie.

## Een configuratie kiezen

1. Klik op **Bestaande proxy gebruiken** en kies de gewenste naam.
2. Controleer het overzicht met machines, luisteradressen, doeladressen en poorten.
3. Laad de keuze. Als er al machines of niet-opgeslagen wijzigingen zijn, vraagt de app eerst om bevestiging voor het vervangen van de hele machinelijst.
4. Pas de machines zo nodig aan. Kies **Opslaan** om de instellingen te bewaren en **Configuratie toepassen** om de TCP-koppelingen en firewallregels op de computer in te stellen.

Annuleren behoudt de huidige configuratie. Een keuze openen of laden wijzigt geen netwerkregels of geplande taken. De configuraties zijn alternatieven, omdat zij deels dezelfde luisterpoorten gebruiken; ze worden niet samengevoegd.

## Beschikbare keuzes

| Naam | Verbindingen | Configuratie |
| --- | ---: | --- |
| Achterbosch | 30 | Railwagens op `192.168.51.101–130`, luisterpoorten `9501–9530`, doelpoort `1000`, luisteradres `0.0.0.0`. |
| Fikona | 309 | Railwagens, potrobots, deuren en een unload position. |
| Stadsweiden | 313 | Railwagens, potrobots, deuren en unload positions. |
| Trayplant | 408 | Railwagens, potrobots, deuren en unload positions, met de gegevens uit het bijbehorende `Package.xml`. |
| Wouters | 18 | Railwagens 145–162. |

Alle vijf configuraties zijn beschikbaar. Controleer het overzicht voor de gewenste locatie en de netwerkadressen van deze pc voordat je een keuze toepast. Luisteradres `0.0.0.0` gebruikt alle netwerkkaarten op deze pc.

De configuraties zijn in de app opgenomen; de oorspronkelijke bestanden of de gedeelde bronmap zijn tijdens gebruik niet nodig. De app voert die oorspronkelijke scripts niet uit. De bestaande firewallbeperkingen van Greenhouse Proxy blijven gelden wanneer je de configuratie toepast.

## Bestaande instellingen en planning

Een app-update laadt geen preset en behoudt je opgeslagen instellingen. Een eerste installatie begint met een lege machinelijst. Het installatiepad, het beheerde PowerShell-script en het extra logbestand blijven gelijk.

De geplande taak gebruikt bij de volgende uitvoering de laatst opgeslagen machineconfiguratie. Als je een nieuwe preset wilt gebruiken voor die taak, sla je de gekozen configuratie eerst op. Voor de taaklocatie en het opruimen van een oude taak in de hoofdmap, zie [taakscript en taaklocatie](PROXY_TASK_SCRIPT.md).

Het vervangen van de machinelijst verwijdert geen oude actieve netwerkregels. Gebruik indien nodig **Poortbeheer** om oude koppelingen op te ruimen.
