import 'package:flutter/material.dart';
import 'package:login/constants.dart';

class CompetitionModel {
  static List<Item> items = [
    Item(0, 1, "Dustin Böttge", Color.fromRGBO(255, 215, 0, 100), 178),
    Item(1, 2, 'Tom Uhlig', Color.fromRGBO(211, 211, 211, 100), 127),
    Item(2, 3, 'Florian Senf', Color.fromRGBO(191, 137, 123, 100), 108),
    Item(3, 4, 'Thomas Müller', kPrimaryLightColor, 94),
    Item(4, 5, 'Axel Springer', kPrimaryLightColor, 92),
    Item(5, 6, 'Mark Märt', kPrimaryLightColor, 65),
    Item(6, 7, 'Bendedikt Paul', kPrimaryLightColor, 63),
    Item(7, 8, 'Valentin Paweliska', kPrimaryLightColor, 57),
    Item(8, 9, 'Felix Wenz', kPrimaryLightColor, 56),
    Item(9, 10, 'Bernd Stier', kPrimaryLightColor, 49),
    Item(10, 11, 'Julian Draxler', kPrimaryLightColor, 47),
    Item(11, 12, 'Sami Khedira', kPrimaryLightColor, 41),
    Item(12, 13, 'Mesut Özil', kPrimaryLightColor, 37),
    Item(13, 14, 'Lukas Podolski', kPrimaryLightColor, 35),
    Item(14, 15, 'Miroslav Klose', kPrimaryLightColor, 32),
  ];

  Item getById(int id) => Item(
        id,
        items[id].position,
        items[id].name,
        items[id].color,
        items[id].revenue,
      );

// itemNames[id % itemNames.length]
  Item getByPosition(int position) {
    return getById(position);
  }
}

@immutable
class Item {
  final int id;
  final int position;
  final String name;
  final Color color;
  final int revenue;

  /*  Item(
    this.id,
    this.position,
    this.name,
    this.revenue,
  ) : color = Colors
            .primaries[id % Colors.primaries.length]; */ // immer änderende Farbe
  Item(
    this.id,
    this.position,
    this.name,
    this.color,
    this.revenue,
  );

  @override
  int get hashCode => id;

  @override
  bool operator ==(Object other) => other is Item && other.id == id;
}
class ChatModel {
  static List<ChatItem> items = [
    ChatItem(0, "Bezirkserweiterung", "Wir erweitern unser Vertriebsgebiet in Hessen. Alle weiteren Informationen lassen wir euch zeitnah zukommen","Frank Thelen","19","25.02.2021"),
    ChatItem(1,  'Kundeninformationen', "Heute wurden 35 Kunden abgeschlossen, neuer Rekord!","Frank Thelen","37","23.02.2021"),
    ChatItem(2,  'Umsatzbericht', "235.276€, Spitzenleistung für den Januar. Das war ein guter Start in das neue Jahr","Frank Thelen","59","12.02.2021"),
    ChatItem(3,  'Entspurt', "Der Monat neigt sich zum Ende, wir sind auf einem guten Weg. Gebt alles!","Frank Thelen","61","25.01.2021"),
    ChatItem(4,  'Das Team erweitert sich', "Wir begrüßen Peter Ruhr im Vertriebsteam","Anja HR","62","20.01.2021"),
    ChatItem(5,  'Umsatzziele', "Die Umsatzziele wurden veröffentlicht. Bitte checkt euer Email Postfach","Frank Thelen","64","10.01.2021"),
    ChatItem(6,  'Neujahr', "Die Unternehmensleitung wünscht allen ein gesundes erfolgreiches Neues Jahr","Peter Schubert","64","01.01.2021"),
    ChatItem(7,  'Kundeninformationen', "Heute wurden 35 Kunden abgeschlossen, neuer Rekord!","Frank Thelen","64","23.02.2021"),
  ];


}
@immutable
class ChatItem {
  final int id;
  final String titel;
  final String message;
  final String sender;
  final String viewed;
  final String date;

  ChatItem(
    this.id,
    this.titel,
    this.message,
    this.sender,
    this.viewed,
    this.date,
  );
}
