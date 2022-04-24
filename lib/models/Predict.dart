class Predict {
  int f1 = 30;
  int f8 = 30;
  int f24 = 30;
  Predict();
  factory Predict.fromJson(Map<String, dynamic> json) {
    if (json == null) return Predict();
    Predict predict = Predict();
    predict.f1 = (json['f1'] as double).toInt();
    predict.f8 = (json['f8'] as double).toInt();
    predict.f24 = (json['f24'] as double).toInt();
    return predict;
  }
}