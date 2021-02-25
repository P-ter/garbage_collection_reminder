class Collection {
  final String binType;
  final String collectionDate;
  final int collectionDateCode;
  final String collectionFrequencySummer;
  final String collectionFrequencyWinter;

  const Collection(
      {this.binType,
      this.collectionDate,
      this.collectionDateCode,
      this.collectionFrequencySummer,
      this.collectionFrequencyWinter});

  factory Collection.fromJson(Map<String, dynamic> json) {
    return Collection(
      binType: json['commodity'],
      collectionDate: json['collection_day'],
      collectionDateCode: int.parse(json['clect_day_code']),
      collectionFrequencySummer: json['clect_int_summer'],
      collectionFrequencyWinter: json['clect_int_winter'],
    );
  }
}
