class Challenge {
  int id;
  String title;
  String tier;
  bool isCompleted;

  Challenge({
    this.title,
    this.tier,
    this.isCompleted,
  });

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'title': title,
      'tier': tier,
    };
    return map;
  }

  Challenge.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    title = map['title'];
    tier = map['tier'];
    isCompleted = map['isCompleted'] == 1;
  }
}
