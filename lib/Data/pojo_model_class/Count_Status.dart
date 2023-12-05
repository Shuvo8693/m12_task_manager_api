class CountStatus {
  String? status;
  List<CountList>? countVariable;

  CountStatus({this.status, this.countVariable});

  CountStatus.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      countVariable = <CountList>[];
      json['data'].forEach((v) {
        countVariable!.add(CountList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (countVariable != null) {
      data['data'] = countVariable!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CountList {
  String? sId;
  int? sum;

  CountList({this.sId, this.sum});

  CountList.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    sum = json['sum'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['sum'] = sum;
    return data;
  }
}
