import 'package:flutter/material.dart';
import 'package:garbage_collection_reminder/controller/collection_controller.dart';
import 'package:get/get.dart';
import './model/Collection.dart';
import './widget/collection_card.dart';

void main() {
  runApp(MyApp());
}

final baseDate = DateTime(2017, 7, 17);

bool isEvenWeek() {
  final currentTime = DateTime.now();

  final dayDiff = currentTime.difference(baseDate).inDays;
  final weekDiff = (dayDiff / 7).floor();

  return weekDiff % 2 == 0;
}

bool shouldFollowSummerSchedule() {
  final currentMonth = DateTime.now().month;
  return (currentMonth >= 3 && currentMonth < 11);
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Garbage Collection Reminder',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CollectionController collectionController =
        Get.put(CollectionController());

    final evenWeek = isEvenWeek();
    final summerSchedule = shouldFollowSummerSchedule();

    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text("Garbage Collection Reminder"),
        ),
        body: Expanded(
          child: ListView.builder(
            itemBuilder: (context, index) {},
            itemCount: ,
          ),
        )

        /*FutureBuilder<List<Collection>>(
        future: fetchCollection(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print(snapshot.error);
            return Center(child: Text("Fail"));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasData && snapshot.data.isNotEmpty) {
            final collectionList = snapshot.data;
            final children = collectionList
                .map((currCollection) => Expanded(
                      child: CollectionCard(
                          binType: currCollection.binType,
                          collectionDate: currCollection.collectionDate,
                          collectionDateCode: currCollection.collectionDateCode,
                          collectionFrequencySummer:
                              currCollection.collectionFrequencySummer,
                          collectionFrequencyWinter:
                              currCollection.collectionFrequencyWinter,
                          evenWeek: evenWeek,
                          summerSchedule: summerSchedule),
                    ))
                .toList();
            return Column(
              children: children,
            );
          } else {
            return Center(child: Text("No Data Available"));
          }
        },
      ),*/
        );
  }
}
