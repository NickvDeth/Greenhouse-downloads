# Windows Update instellen met Greenhouse Proxy

Vanaf **Proxy 2.2.9** staat **Windows Update** in het menu. Dit gaat over updates van Windows zelf. Nieuwe versies van Greenhouse Proxy blijven via **Controleren op updates** beschikbaar.

1. Open **Windows Update**. De app haalt de huidige status en mogelijkheden op.
2. Kies **Windows beheert updates**, **Gepland installeren** of **Automatische updates uit**.
3. Bij een planning kies je elke dag of een weekdag, en een heel uur in de lokale tijd van de pc.
4. Klik op **Instellingen toepassen** en bevestig de gekozen wijziging.

De gekozen tijd is een installatiemoment bij benadering. Windows kan eerder downloaden; beschikbaarheid van de pc en Windows zelf bepalen wanneer het werk werkelijk plaatsvindt. Een update kan een herstart nodig hebben. Dit menu garandeert niet dat een pc uitsluitend op het gekozen tijdstip herstart.

**Automatische updates uit** stopt ook de automatische installatie van Windows-beveiligingsupdates. Handmatig bijwerken blijft mogelijk via **Windows Update openen**. Plan dan zelf regelmatig onderhoud. Een update die al bezig is, kan nog doorgaan.

De keuze blijft in Windows bewaard als Proxy gesloten is of verwijderd wordt. **Vorige instellingen herstellen** zet de toestand van vóór de eerste wijziging met Proxy terug. De app bewaart welke eigen beleidswaarden aanwezig waren en controleert of een andere beheerder ze intussen heeft gewijzigd. Bij een conflict wordt niet blind over die wijziging heen geschreven.

Deze instellingen zijn bedoeld voor ondersteunde Windows Pro-, Education- en Enterprise-edities. Windows Home krijgt een verwijzing naar de Windows-instellingen. Pc's met domein-/MDM-beheer, WSUS of bestaand conflicterend updatebeleid worden alleen gelezen. De app vermeldt waarom aanpassen niet mogelijk is. Het openen van dit menu of installeren van Proxy wijzigt op zichzelf geen Windows Update-instellingen.

De functie gebruikt Windows-beleidsinstellingen. Er worden geen updateservices of taken uitgeschakeld, geen Microsoft-adressen geblokkeerd en geen herstarts gestart. Een fout bij toepassen leidt tot een poging om de vorige toestand te herstellen; de app meldt wanneer herstel niet volledig lukt.

Bronnen: [Microsoft: Windows Update-instellingen](https://learn.microsoft.com/en-us/windows/deployment/update/waas-wu-settings), [ondersteunde Windows-edities](https://learn.microsoft.com/en-us/windows/deployment/update/waas-manage-updates-wufb) en [herstartbeleid](https://learn.microsoft.com/en-us/windows/deployment/update/waas-restart).
