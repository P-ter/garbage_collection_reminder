import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:garbage_collection_reminder/main.dart';

enum CollectionFrequency { EVERY, EVEN, ODD }

class CollectionCard extends StatelessWidget {
  final String binType;
  final int collectionDateCode;
  final String collectionDate;
  final String collectionFrequencySummer;
  final String collectionFrequencyWinter;
  final bool evenWeek;
  final bool summerSchedule;

  CollectionCard({
    this.binType,
    this.collectionDate,
    this.collectionDateCode,
    this.collectionFrequencySummer,
    this.collectionFrequencyWinter,
    this.evenWeek,
    this.summerSchedule,
  });

  @override
  Widget build(BuildContext context) {
    final binType = this.binType;
    var nextPickupDate;

    final collectionFrequency = EnumToString.fromString(
        CollectionFrequency.values,
        (summerSchedule
            ? collectionFrequencySummer
            : collectionFrequencyWinter));
    final currentDateCode = DateTime.now().weekday;

    if(collectionFrequency == CollectionFrequency.EVERY) {
      if(currentDateCode > this.collectionDateCode) {
        nextPickupDate = "Next week, on ${this.collectionDate}";
      } else if (currentDateCode > this.collectionDateCode) {
        nextPickupDate = "This ${this.collectionDate}";
      } else {
        nextPickupDate = "Today";
      }
    } else if ((collectionFrequency == CollectionFrequency.ODD && this.evenWeek)
    || (collectionFrequency == CollectionFrequency.EVEN && !this.evenWeek)) {
      nextPickupDate = "Next week, on ${this.collectionDate}";
    } else {
      if(currentDateCode > this.collectionDateCode) {
        nextPickupDate = "In 2 weeks, on ${this.collectionDate}";
      } else if (currentDateCode < this.collectionDateCode) {
        nextPickupDate = "This ${this.collectionDate}";
      } else {
        nextPickupDate = "Today";
      }
    }

    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(30),
      child: Column(
        children: [
          Center(
            child: Text(binType),
          ),
          Divider(
            thickness: 2,
          ),
          Center(
            child: Text(nextPickupDate),
          ),
        ],
      ),
    );
  }
}
