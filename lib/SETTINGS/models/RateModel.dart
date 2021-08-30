class RateModel {
  int id;
  String rate;

  RateModel({this.id, this.rate});

  RateModel.fromMap(dynamic obj) {
    this.id = obj['Id'];
    this.rate = obj['rate'];

  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{

      'Id': id,
      'rate': rate,
    };

    return map;
  }
}
