# Windows Update instellen met Greenhouse Proxy

Vanaf **Proxy 2.2.9** staat **Windows Update** in het menu. Dit gaat over updates van Windows zelf. Nieuwe versies van Greenhouse Proxy blijven via **Controleren op updates** beschikbaar.

Vanaf **Proxy 2.2.12** wacht het ophalen van de status op een eventuele firewallcontrole bij het opstarten. Daardoor verschijnt bij het openen geen onterechte melding meer dat er al een GreenhouseProxy-actie loopt. De app toont ook de volledige Windows-editienaam. Deze oplossingen blijven behouden in **2.2.13**, dat een aparte aan/uit-keuze voor Windows Home toevoegt.

## Windows Home vanaf Proxy 2.2.13

1. Open **Windows Update**. De app haalt de huidige status en mogelijkheden op.
2. Kies **Windows-updates uit**.
3. Klik op **Instellingen toepassen** en bevestig de wijziging.
4. Kies later **Windows-updates aan** en pas de instelling toe, of klik op **Vorige service-instellingen herstellen**.

Uitschakelen stopt de Windows Update-service (`wuauserv`) en zet de startmodus op uitgeschakeld. Zolang de service uitstaat, werken **automatische en handmatige Windows-updates niet, inclusief Windows-beveiligingsupdates**. Zet updates dus eerst weer aan voordat je via **Windows Update openen** handmatig wilt bijwerken. Er is op Home geen installatieplanning via dit menu.

Aanzetten herstelt alleen de oorspronkelijke service-instellingen die Proxy vóór de eerste wijziging heeft opgeslagen. Een service die al buiten Proxy was uitgeschakeld, wordt niet zomaar overgenomen of opnieuw geconfigureerd. Het herstelrecord is alleen schrijfbaar voor beheerders en SYSTEM. Bij instellingen die Windows of een beheerder intussen heeft gewijzigd, vermeldt de app het conflict en overschrijft deze niet.

**Zet Windows-updates weer aan voordat je Proxy verwijdert.** De service-instelling blijft ook gelden wanneer Proxy gesloten is of verwijderd wordt; verwijderen herstelt deze niet automatisch.

Deze Home-bediening is geen door Microsoft ondersteund permanent updatebeleid. Windows kan de service later opnieuw inschakelen. Gebruik **Status ophalen** om de actuele toestand te controleren; Proxy dwingt uitschakelen niet telkens op de achtergrond af. Een al voorbereide update of benodigde herstart kan doorgaan. **Windows Update openen** geeft ook toegang tot de pauze- en onderhoudsmogelijkheden van Windows zelf.

## Windows Pro, Education, Enterprise en IoT Enterprise

Op ondersteunde Windows 10/11-edities blijft het bestaande Windows-beleid beschikbaar:

1. Open **Windows Update**.
2. Kies **Windows beheert updates**, **Gepland installeren** of **Automatische updates uit**.
3. Bij een planning kies je elke dag of een weekdag, en een heel uur in de lokale tijd van de pc.
4. Klik op **Instellingen toepassen** en bevestig de gekozen wijziging.

De gekozen tijd is een installatiemoment bij benadering. Windows kan eerder downloaden; beschikbaarheid van de pc en Windows zelf bepalen wanneer het werk werkelijk plaatsvindt. Een update kan een herstart nodig hebben. Dit menu garandeert niet dat een pc uitsluitend op het gekozen tijdstip herstart.

**Automatische updates uit** stopt bij deze beleidsinstellingen ook de automatische installatie van Windows-beveiligingsupdates. Handmatig bijwerken blijft mogelijk via **Windows Update openen**. Plan dan zelf regelmatig onderhoud. Een update die al bezig is, kan nog doorgaan.

De keuze blijft in Windows bewaard als Proxy gesloten is of verwijderd wordt. **Vorige instellingen herstellen** zet de toestand van vóór de eerste wijziging met Proxy terug. De app bewaart welke eigen beleidswaarden aanwezig waren en controleert of een andere beheerder ze intussen heeft gewijzigd. Bij een conflict wordt niet blind over die wijziging heen geschreven.

## Beheer en herstel

Pc's met domein-/MDM-beheer, WSUS of bestaand conflicterend updatebeleid worden alleen gelezen. De app vermeldt waarom aanpassen niet mogelijk is. Het openen van dit menu of installeren van Proxy wijzigt op zichzelf geen Windows Update-instellingen.

Op Home wijzigt de aan/uit-keuze uitsluitend de Windows Update-service. Op de ondersteunde overige edities gebruikt de functie Windows-beleid. Andere services, Defender, updatetaken, Microsoft-adressen en herstartinstellingen worden niet aangepast. Een fout bij toepassen leidt tot een poging om de vorige toestand te herstellen; de app meldt wanneer herstel niet volledig lukt. Updates van Greenhouse Proxy blijven onafhankelijk van deze instellingen beschikbaar.

Bronnen: [Microsoft: Windows Update-instellingen](https://learn.microsoft.com/en-us/windows/deployment/update/waas-wu-settings), [ondersteunde edities voor automatisch updatebeleid](https://learn.microsoft.com/en-us/windows/client-management/mdm/policy-csp-update#allowautoupdate), [effect van uitschakelen van de Windows Update-service](https://learn.microsoft.com/en-us/powershell/dsc/reference/resources/microsoft/windows/service/examples/get-service-status?view=dsc-3.0), [Microsoft over service uitschakelen versus updatebeleid](https://learn.microsoft.com/en-us/windows/iot/iot-enterprise/os-features/updates) en [herstartbeleid](https://learn.microsoft.com/en-us/windows/deployment/update/waas-restart).
