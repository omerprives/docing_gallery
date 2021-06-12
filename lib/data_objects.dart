import 'package:flutter/material.dart';

enum ItemType { document, pdf, slideshow, spreadsheet, photo, video, directory }

class Week {
  final int semester;
  final int week;
  Week({@required this.semester, @required this.week});

  @override
  bool operator ==(other) {
    bool ret =
        (other is Week) && other.semester == semester && other.week == week;
    return ret;
  }

  @override
  String toString() {
    Map<int, String> sem = {1: "א", 2: "ב", 3: "ג", 4: "ד", 5: "ה", 6: "ו"};
    return week.toString() + " סמסטר " + sem[semester].toString() + " שבוע";
  }

  factory Week.fromJson(Map<String, dynamic> json) =>
      Week(week: json["week"], semester: json["semester"]);

  Map<String, dynamic> toJson() => {"semester": semester, "week": week};
}

class Item {
  // machzor
  final String url;
  final ItemType type;
  final DateTime creationTime;
  // final DateTime lastModified;
  final String title;
  final Week week;
  Item({
    @required this.url,
    @required this.type,
    @required this.creationTime,
    // @required this.lastModified,
    @required this.title,
    @required this.week,
  });

  static DateTime parseDate(dynamic dateString) {
    // todo: correct this
    return DateTime.parse("2021-05-24 13:27:00");
  }

  static ItemType parseType(dynamic typeString) {
    // todo: correct this
    return ItemType.document;
  }

  static String typeToString(ItemType type) {
    Map<ItemType, String> typeStr = {
      ItemType.document: "document",
      ItemType.pdf: "pdf",
      ItemType.slideshow: "slideshow",
      ItemType.spreadsheet: "spreadsheet",
      ItemType.photo: "photo",
      ItemType.video: "video",
      ItemType.directory: "directory"
    };
    return typeStr[type];
  }

  factory Item.fromJson(Map<String, dynamic> json) => Item(
      url: json["link"],
      title: json["name"],
      creationTime: parseDate(json["date"]),
      type: parseType(json["type"]),
      week: Week.fromJson(json["week"]));

  Map<String, dynamic> toJson() => {
        "link": url,
        "name": title,
        "date": creationTime.toString(), // todo: correct this
        "type": typeToString(type),
        "week": week.toJson(),
      };
}

Map<ItemType, String> typeIcon = {
  ItemType.document: "images/google-docs.png",
  ItemType.slideshow: 'images/google-slides.png',
  ItemType.pdf: 'images/google-pdf2.png',
  ItemType.directory: 'images/google-folder.png',
  ItemType.photo: 'images/google-docs.png',
  ItemType.video: 'images/google-video.png',
  ItemType.spreadsheet: 'images/google-sheets.png'
};
