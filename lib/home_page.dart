import 'package:flutter/material.dart';
import 'http_client.dart';
import 'data_objects.dart';

class DataViewer {
  Map<Week, List<Item>> itemsByWeeks;

  DataViewer(List<Item> items) {
    itemsByWeeks = new Map<Week, List<Item>>();
    for (int i = 0; i < items.length; i++) {
      bool containsKey = false;
      List<Item> current;
      for (Week k in itemsByWeeks.keys.toList()) {
        print(i);
        if (k == items[i].week) {
          containsKey = true;
          current = itemsByWeeks[k];
          break;
        }
      }
      if (!containsKey) {
        itemsByWeeks[items[i].week] = [];
        current = itemsByWeeks[items[i].week];
      }
      current.add(items[i]);
    }
  }
}

List<Item> items = [
  Item(
      creationTime: DateTime.parse("2021-05-27 13:27:00"),
      url: "jbjkbsak",
      type: ItemType.video,
      title: "מתן גץ",
      week: Week(semester: 6, week: 11)),
  Item(
      creationTime: DateTime.parse("2021-05-26 13:27:00"),
      url: "jbjkbsak",
      type: ItemType.document,
      title: "יובל נבו",
      week: Week(semester: 6, week: 11)),
  Item(
      creationTime: DateTime.parse("2021-05-24 13:27:00"),
      url: "jbjkbsak",
      type: ItemType.directory,
      title: "מסע ציונות",
      week: Week(semester: 6, week: 11)),
  Item(
      creationTime: DateTime.parse("2021-05-24 13:27:00"),
      url: "jbjkbsak",
      type: ItemType.spreadsheet,
      title: "מסע ציונות",
      week: Week(semester: 6, week: 11)),
  Item(
      creationTime: DateTime.parse("2021-05-24 13:27:00"),
      url: "jbjkbsak",
      type: ItemType.slideshow,
      title: "מסע ציונות",
      week: Week(semester: 6, week: 11)),
  Item(
      creationTime: DateTime.parse("2021-05-24 13:27:00"),
      url: "jbjkbsak",
      type: ItemType.slideshow,
      title: "נועה קורן",
      week: Week(semester: 6, week: 10)),
  Item(
      creationTime: DateTime.parse("2021-05-24 13:27:00"),
      url: "jbjkbsak",
      type: ItemType.pdf,
      title: "אלון גרנות",
      week: Week(semester: 6, week: 9)),
  Item(
      creationTime: DateTime.parse("2021-05-24 13:27:00"),
      url: "jbjkbsak",
      type: ItemType.slideshow,
      title: "מסע ציונות",
      week: Week(semester: 6, week: 9))
];

class Search extends SearchDelegate {
  String selectedResult = "";
  final List<String> listExample;
  Search(this.listExample);

  List<String> recentList = ["Text 4", "Text 3"];

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            query = "";
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container(
        color: Colors.black87,
        child: Center(
          child: Text(selectedResult),
        ));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> suggestionsList = [];
    query.isEmpty
        ? suggestionsList = recentList
        : suggestionsList
            .addAll(listExample.where((element) => element.contains(query)));

    return ListView.builder(
        itemCount: suggestionsList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(suggestionsList[index]),
            onTap: () {
              selectedResult = suggestionsList[index];
              showResults(context);
            },
          );
        });
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // List<Item> items =
    // loadData(); // todo: this line is not working due to Future<>
    print("Im hereee");
    print(update());
    DataViewer db = DataViewer(items);
    List<Week> weeks = db.itemsByWeeks.keys.toList();
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        actions: <Widget>[
          IconButton(
              onPressed: () {
                showSearch(
                    context: context, delegate: Search(["Try 1", "Try 2"]));
              },
              icon: Icon(Icons.search)),
        ],
        centerTitle: true,
        title: Text(
          "חיפוש",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // SizedBox(
            //   height: 10,
            // ),
            // Text(
            //   'תלפיות',
            //   style: TextStyle(
            //     fontSize: 25,
            //     fontWeight: FontWeight.w600,
            //     color: Colors.white,
            //   ),
            //   textAlign: TextAlign.center,
            // ),
            // SizedBox(
            //     height: 10,
            //     child: const DecoratedBox(
            //         decoration: const BoxDecoration(color: Color(0xFF212121)))),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 0,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  // color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: new ListView.builder(
                    itemCount: weeks.length,
                    itemBuilder: (context, listIndex) {
                      return Column(children: [
                        Container(
                            child: Text(
                              weeks[listIndex].toString() + "        ",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                            alignment: Alignment.centerRight),
                        Directionality(
                            textDirection: TextDirection.rtl,
                            child: GridView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 5,
                                      crossAxisSpacing: 4.0,
                                      mainAxisSpacing: 2.0),
                              itemCount:
                                  db.itemsByWeeks[weeks[listIndex]].length,
                              itemBuilder: (context, gridIndex) {
                                return RawMaterialButton(
                                  onPressed: () {
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //     builder: (context) => DetailsPage(
                                    //       imagePath: _images[index].imagePath,
                                    //       title: _images[index].title,
                                    //       photographer: _images[index].photographer,
                                    //       price: _images[index].price,
                                    //       details: _images[index].details,
                                    //       index: index,
                                    //     ),
                                    //   ),
                                    // );
                                  },
                                  child: Hero(
                                    tag: 'logo$gridIndex',
                                    child: Container(
                                      decoration: BoxDecoration(
                                        // color: Colors.black87,
                                        borderRadius: BorderRadius.circular(0),
                                        image: DecorationImage(
                                          image: AssetImage(typeIcon[db
                                              .itemsByWeeks[weeks[listIndex]]
                                                  [gridIndex]
                                              .type]),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ))
                      ]);
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }
}

/*
List<ImageDetails> _images = [
  ImageDetails(
    imagePath: 'images/1.jpg',
    price: '\$20.00',
    photographer: 'Martin Andres',
    title: 'New Year',
    details:
        'This image was taken during a party in New York on new years eve. Quite a colorful shot.',
  ),
  ImageDetails(
    imagePath: 'images/2.jpg',
    price: '\$10.00',
    photographer: 'Abraham Costa',
    title: 'Spring',
    details:
        'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Nihil error aspernatur, sequi inventore eligendi vitae dolorem animi suscipit. Nobis, cumque.',
  ),
  ImageDetails(
    imagePath: 'images/3.jpg',
    price: '\$30.00',
    photographer: 'Jamie Bryan',
    title: 'Casual Look',
    details:
        'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Nihil error aspernatur, sequi inventore eligendi vitae dolorem animi suscipit. Nobis, cumque.',
  ),
  ImageDetails(
    imagePath: 'images/4.jpg',
    price: '\$20.00',
    photographer: 'Jamie Bryan',
    title: 'New York',
    details:
        'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Nihil error aspernatur, sequi inventore eligendi vitae dolorem animi suscipit. Nobis, cumque.',
  ),
  ImageDetails(
    imagePath: 'images/5.jpg',
    price: '\$20.00',
    photographer: 'Jamie Bryan',
    title: 'New York',
    details:
        'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Nihil error aspernatur, sequi inventore eligendi vitae dolorem animi suscipit. Nobis, cumque.',
  ),
  ImageDetails(
    imagePath: 'images/6.jpg',
    price: '\$20.00',
    photographer: 'Jamie Bryan',
    title: 'New York',
    details:
        'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Nihil error aspernatur, sequi inventore eligendi vitae dolorem animi suscipit. Nobis, cumque.',
  ),
  ImageDetails(
    imagePath: 'images/7.jpg',
    price: '\$20.00',
    photographer: 'Jamie Bryan',
    title: 'New York',
    details:
        'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Nihil error aspernatur, sequi inventore eligendi vitae dolorem animi suscipit. Nobis, cumque.',
  ),
  ImageDetails(
    imagePath: 'images/8.jpg',
    price: '\$20.00',
    photographer: 'Jamie Bryan',
    title: 'New York',
    details:
        'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Nihil error aspernatur, sequi inventore eligendi vitae dolorem animi suscipit. Nobis, cumque.',
  ),
  ImageDetails(
    imagePath: 'images/9.jpg',
    price: '\$20.00',
    photographer: 'Jamie Bryan',
    title: 'New York',
    details:
        'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Nihil error aspernatur, sequi inventore eligendi vitae dolorem animi suscipit. Nobis, cumque.',
  ),
  ImageDetails(
    imagePath: 'images/10.jpg',
    price: '\$20.00',
    photographer: 'Jamie Bryan',
    title: 'New York',
    details:
        'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Nihil error aspernatur, sequi inventore eligendi vitae dolorem animi suscipit. Nobis, cumque.',
  ),
  ImageDetails(
    imagePath: 'images/11.jpg',
    price: '\$20.00',
    photographer: 'Jamie Bryan',
    title: 'New York',
    details:
        'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Nihil error aspernatur, sequi inventore eligendi vitae dolorem animi suscipit. Nobis, cumque.',
  ),
  ImageDetails(
    imagePath: 'images/12.jpg',
    price: '\$20.00',
    photographer: 'Jamie Bryan',
    title: 'New York',
    details:
        'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Nihil error aspernatur, sequi inventore eligendi vitae dolorem animi suscipit. Nobis, cumque.',
  ),
  ImageDetails(
    imagePath: 'images/13.jpg',
    price: '\$20.00',
    photographer: 'Jamie Bryan',
    title: 'New York',
    details:
        'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Nihil error aspernatur, sequi inventore eligendi vitae dolorem animi suscipit. Nobis, cumque.',
  ),
  ImageDetails(
    imagePath: 'images/14.jpg',
    price: '\$20.00',
    photographer: 'Matthew',
    title: 'Cone Ice Cream',
    details:
        'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Nihil error aspernatur, sequi inventore eligendi vitae dolorem animi suscipit. Nobis, cumque.',
  ),
  ImageDetails(
    imagePath: 'images/15.jpg',
    price: '\$25.00',
    photographer: 'Martin Sawyer',
    title: 'Pink Ice Cream',
    details:
        'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Nihil error aspernatur, sequi inventore eligendi vitae dolorem animi suscipit. Nobis, cumque.',
  ),
  ImageDetails(
    imagePath: 'images/16.jpg',
    price: '\$15.00',
    photographer: 'John Doe',
    title: 'Strawberry Ice Cream',
    details:
        'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Nihil error aspernatur, sequi inventore eligendi vitae dolorem animi suscipit. Nobis, cumque.',
  ),
];

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(
              height: 40,
            ),
            Text(
              'Gallery',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 40,
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 30,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) {
                    return RawMaterialButton(
                      onPressed: () {},
                      child: Hero(
                        tag: 'logo$index',
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                              image: AssetImage(_images[index].imagePath),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: _images.length,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}


class ImageDetails {
  final String imagePath;
  final String price;
  final String photographer;
  final String title;
  final String details;
  ImageDetails({
    @required this.imagePath,
    @required this.price,
    @required this.photographer,
    @required this.title,
    @required this.details,
  });
}
*/
