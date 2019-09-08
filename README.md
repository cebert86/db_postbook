# db_postbook

Generell habe ich mich auf YAGNI (You ain't gonna need it) gestützt und nur das umgesetzt, was auch wirklich angefordert wurde.

Ich habe versucht die Aufgabe komplett mit Swift-Bordmitteln zu erledigen, damit keine Abhängigkeiten zu Pods von Drittanbietern bestehen.
Einzige Ausnahme ist "Snapkit", welches das Erstellen dynamischer Autolayout-Regeln sehr vereinfacht.

Beim Unit-Testing habe ich nur Swift-Bordmittel benutzt, wobei ich das Mocken der Objekte sehr einfach über Protokolle gelöst habe.

Als Architekturansatz habe ich mich für ein vereinfachtes VIPER entschieden.

V: View
I: Interactor (entfällt)
P: Presenter
E: Entity
R: Routing

Jeder Screen besteht aus den Komponenten ViewController <-> Presenter. Der ViewController benachrichtigt bei Events (zum Beispiel Usereingaben) seinen Presenter, welcher die Businesslogik enthält. Der Presenter hat eine weak reference auf seine View (hier: ViewController). Damit kann auf einfache Art und Weise das Updaten der UI stattfinden.

Bei Bedarf enthält der Presenter einen Wireframe, welcher das Routing übernimmt. Beispielsweise kann so aus der Liste der Posts über den Wireframe ganz einfach zu den Kommentaren des Posts navigiert werden.
