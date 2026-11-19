# Proxy-taakscript en extra logbestand

Vanaf Greenhouse Proxy **2.2.14** kan de taak **RimoteGreenhouseProxy** dit bestand uitvoeren:

`C:\Program Files\Rimote\Achterbosch\GreenhouseProxy\GreenhouseProxy.ps1`

De app blijft geïnstalleerd in `C:\Program Files\Achterbosch\Greenhouse Proxy`.

Vanaf **2.2.15** vind je de taak in Windows Taakplanner onder **Taakplannerbibliotheek → Microsoft → Windows → RimoteGreenhouseProxy**. De interne taakmap is `\Microsoft\Windows\`.

## Instellen

1. Werk Greenhouse Proxy bij en controleer de machines in de app.
2. Open **Taakplanner** en kies opstarten van Windows met vertraging, of een dagelijks tijdstip.
3. Klik op **Planning opslaan** en bevestig.

De app bewaart de configuratie, maakt het taakscript aan en slaat de taak op onder **Microsoft → Windows**. Vanaf **2.2.17** controleert de app drie plekken op **RimoteGreenhouseProxy**: de hoofdmap van de Taakplannerbibliotheek, direct onder **Microsoft** en onder **Microsoft → Windows**. Na controle van de nieuwe taak verwijdert de app herkende oude proxyvarianten uit beide eerdere mappen, ook als ze daar tegelijk staan. De taak voert het script via Windows PowerShell uit als SYSTEM, ook wanneer niemand is aangemeld. Bij volgende uitvoeringen gebruikt het script de laatst opgeslagen machineconfiguratie en de actuele geïnstalleerde app. Er verschijnt geen appvenster.

Kies na een automatische app-update eenmaal **Planning opslaan** om over te stappen op het nieuwe script. Gebruik je het installatieprogramma, dan kan dit een bestaande app-taak met behoud van de planning overzetten. Kies zelf de gewenste planning in de app als er alleen een klassieke Rimote-taak is of als de bestaande planningen verschillen. De opruiming betreft uitsluitend herkende proxytaken. Andere taken zoals **RimoteDeploy** blijven beschikbaar.

Een lopende of wachtende taak wordt niet verplaatst. Laat deze eerst afronden. Bij conflicterende taken of een mislukte migratie toont de app of installer een fout; er wordt niet stilzwijgend over een onbekende taak heen geschreven. De app toont de werkelijk gevonden taakmap, zodat je kunt zien of de overstap nog nodig is.

## Extra logbestand

Naast het script staat:

`C:\Program Files\Rimote\Achterbosch\GreenhouseProxy\GreenhouseProxy.log`

Elke uitvoering voegt datum, tijd, aangemaakte of bijgewerkte poortkoppelingen, aangemaakte of vervangen firewallregels, resultaat en eventuele fouten toe. Voor een poortkoppeling zie je het luisteradres en de poort, plus het doeladres en de doelpoort. Een stap wordt pas als geslaagd gemeld nadat de opdracht gelukt is.

Bij een fout kunnen eerdere stappen al uitgevoerd zijn. Controleer het log voordat je opnieuw start. De bestaande logboeken en portproxy-back-ups onder `C:\ProgramData\GreenhouseProxy\Log` blijven ook beschikbaar. Planning opnieuw opslaan, herinstallatie en verwijderen van de app wissen het extra logbestand niet.

## Beheerd script en losse export

Het taakscript gebruikt de geïnstalleerde app; laat die installatie staan zolang de taak nodig is. Het is geen momentopname van de machines. De losse optie **PowerShell-script exporteren** onder **Bestanden & info** maakt juist een zelfstandig script met de configuratie van dat moment. Die export kan het beheerde taakscript niet overschrijven.

Bij verwijderen van de app wordt alleen een herkende eigen taak en een ongewijzigd eigen taakscript opgeruimd. Eigen scripts, gewijzigde bestanden, machineconfiguratie en logboeken blijven behouden.
