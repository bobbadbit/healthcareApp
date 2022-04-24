class Recommend {
  int aqi = 30;
  String sensitive = 'None';
  String effect = 'None';
  String caution = 'None';

  Recommend();

  factory Recommend.fromJson(Map<String, dynamic> json) {
    if (json == null) return Recommend();
    Recommend recommend = Recommend();
    recommend.aqi = (json['aqi'] as double).toInt();
    recommend.sensitive = json['sensitive'];
    recommend.effect = json['effect'];
    recommend.caution = json['caution'];
    return recommend;
  }
}