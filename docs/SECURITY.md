# Beveiliging van de Windows-apps

De huidige Windows-uitgave bevat Proxy 2.2.11, Backup 1.1.13, PLC Updater 2.2.14 en VNC Windows 0.1.18. Versies van vóór Proxy 2.2.8, Backup 1.1.11, PLC Updater 2.2.12 of VNC Windows 0.1.16 hebben eenmalig de installer nodig om een fout in bestandsrechten van de eerdere updater te herstellen. Zie [de herstelstappen](UPDATE_RECOVERY.md). De beveiligingsmaatregelen hieronder blijven behouden; Android is niet opnieuw uitgebracht.

Proxy 2.2.9 kan automatische Windows-updates na bevestiging uitschakelen. Dat stopt ook automatische Windows-beveiligingsupdates; handmatig bijwerken blijft mogelijk. Het menu toont deze consequentie en biedt herstel van de eerdere instellingen. De app schakelt geen Windows-services, Defender of updatetaken uit en overschrijft geen centraal of conflicterend updatebeleid. Zie [Windows Update instellen](WINDOWS_UPDATE.md).

## Wat is verbeterd?

- Alle vier apps weigeren automatische updates zonder geldige RSA-4096/SHA-256-handtekening van de afzonderlijke releasesleutel. De sleutel voor controle is opgenomen in de geinstalleerde helper. Elke download wordt bovendien op grootte en SHA-256 gecontroleerd. Ongelijke, oudere en onverwachte bestanden worden geweigerd; een vervangfout activeert herstel.
- Proxy beperkt aangemaakte firewallregels standaard tot het lokale subnet en de netwerkprofielen Private/Domain. FTP-regels worden tot de benodigde TCP-poort beperkt en het Public-profiel staat standaard uit.
- PLC Updater vraagt expliciete goedkeuring van Machine Manager. Het gekozen bestand wordt met SHA-256 vastgelegd, voor uitvoering opnieuw gecontroleerd en gedurende de uitvoering tegen schrijven/vervangen vergrendeld. Een gewijzigde externe tool vereist nieuwe goedkeuring.
- VNC accepteert geen verbinding zonder authenticatie als een wachtwoord is ingesteld. Verbindingen zonder wachtwoord vereisen afzonderlijke toestemming per profiel. Alleen private of lokale adressen zijn toegestaan, met bewuste bevestiging van het onversleutelde protocol. Extra controles begrenzen serverberichten, schermformaten en wachttijden.
- Backup bewaart OneDrive-versiegeschiedenis en plaatst vervangen bestanden in afzonderlijke History-mappen per uitvoering. Alle verbindingsmethoden vereisen lokale goedkeuring van bronmappen. Opgeslagen geheimen krijgen striktere Windows-toegangsrechten; de back-upengine wordt tegen een in de app vastgelegde hash gecontroleerd.
- Releaseprocessen gebruiken vastgelegde GitHub Action-commits. De exacte Windows-apps en installers worden met Microsoft Defender gescand voordat ze worden gepubliceerd. Functionele, installatie- en gerichte beveiligingstests moeten slagen.
- Nieuwe GitHub-downloadreleases zijn onveranderlijk na publicatie. Bestaande oudere releases worden daardoor niet met terugwerkende kracht beschermd. De publieke downloadrepository heeft ook secret scanning en push protection ingeschakeld.

## Eenmalig controleren na de update

Gebruik in Proxy de aangeboden beveiligingsactie voor bestaande app-firewallregels. Een software-update kan eerder ingestelde brede netwerktoegang niet veilig namens alle bestaande configuraties interpreteren. Controleer daarna de benodigde PLC-, FTP- en tijdverbindingen; toegang vanaf andere subnetten kan bewuste netwerkconfiguratie door de beheerder vragen.

De beperkte FTP-regels zijn bedoeld voor actieve FTP. Passieve FTP gebruikt extra serverpoorten; bestaande passieve overdrachten kunnen na het beperken van de oude brede programmaregel stoppen. Stel daarvoor in FileZilla een bewust gekozen beperkt passief poortbereik in en laat alleen dat bereik voor het serverprogramma en vertrouwde bronnen toe. Test een echte bestandsoverdracht: alleen aanmelden test het datakanaal niet. Zie de [FileZilla-documentatie over passieve modus](https://filezillapro.com/docs/server/advanced-options/filezilla-server-passive-mode/).

Bevestig in PLC Updater alleen een Machine Manager-bestand waarvan je de herkomst kent. Controleer in VNC ieder bestaand profiel en gebruik een afgeschermd netwerk of VPN. Klassieke VNC-authenticatie ondersteunt maximaal acht wachtwoordtekens; langere waarden worden geweigerd in plaats van stil afgekapt. Controleer in Backup de bronmappen opnieuw wanneer de app daarom vraagt, ook bij oudere verbindingsmethoden. Geplande taken kunnen stoppen totdat deze lokale goedkeuring is gegeven.

## Grenzen

Er is nog geen officieel Windows-uitgeverscertificaat beschikbaar. De aparte updatehandtekening verandert dat niet; Windows kan de installer nog als onbekende uitgever tonen. De overgang vanaf de eerdere updater vereist een eenmalige herstelinstaller; oude helpers worden via manifestprotocol 2 geblokkeerd.

VNC versleutelt de verbinding niet en verifieert geen servercertificaat. Een privéadres op zichzelf bewijst niet dat het netwerk betrouwbaar is. Gebruik een vertrouwd netwerk/VPN; stel PLC-, FTP- of VNC-poorten niet rechtstreeks bloot aan internet. De beveiliging van externe PLC-tools en servers is hiermee niet bewezen.

Versiegeschiedenis en History zijn geen onveranderlijke of offline back-up: een account met voldoende OneDrive-rechten kan die gegevens nog verwijderen. Maak daarnaast een onafhankelijk bewaarde herstelkopie en test herstel. Bestaande, eerder verwijderde versies worden niet teruggehaald. History kan meer opslag gebruiken en wordt niet automatisch opgeschoond.

De uitgevoerde tests en virusscans geven geen garantie van volledige veiligheid en vervangen geen onafhankelijke penetratietest. Beheerderstoegang of malware onder het releaseaccount kan buiten de bescherming van deze appmaatregelen vallen. Zie [updateondertekening en sleutelbeheer](AUTOMATIC_UPDATES.md).
