
class CakeOrdersModel {

  final List<CakeOrderModel> results;

  CakeOrdersModel({
    this.results,
  });

  factory CakeOrdersModel.fromJson(List<dynamic> parsedJson) {
    return new CakeOrdersModel(
      results: parsedJson.map((i)=>CakeOrderModel.fromJson(i)).toList()
    );
  }

}

class CakeOrderModel {

  int _id;
  DateTime _toDateTime = DateTime.now();
  String _orderName;
  String _decor;
  String _description;
  String _clientName;
  String _clientContact;
  double _price;
  String _userId;

  CakeOrderModel();

  set id(int value) {
    _id = value;
  }

  int get id => _id;

  DateTime get toDateTime => _toDateTime;

  double get price => _price;

  String get clientContact => _clientContact;

  String get clientName => _clientName;

  String get description => _description;

  String get decor => _decor;

  String get orderName => _orderName;


  String get userId => _userId;

  set userId(String value) {
    _userId = value;
  }

  CakeOrderModel.fromJson(Map<String,dynamic> parsedJson) {
    _id = parsedJson['id'];
    _orderName = parsedJson['name'];
    _toDateTime = DateTime.parse(parsedJson['onDate']);
    _decor = parsedJson['decor'];
    _description = parsedJson['description'];
    _clientName = parsedJson['clientName'];
    _clientContact = parsedJson['clientContact'];
    _price = parsedJson['price'];
  }

  Map<String, dynamic> toJson() =>
  {
    'name': _orderName,
    'onDate': _toDateTime.toIso8601String() + 'Z',
    'decor': _decor,
    'description': _description,
    'clientName': _clientName,
    'clientContact': _clientContact,
    'price': _price.toString(),
    'userId': _userId
  };

  set toDateTime(DateTime value) {
    _toDateTime = value;
  }

  set orderName(String value) {
    _orderName = value;
  }

  set decor(String value) {
    _decor = value;
  }

  set description(String value) {
    _description = value;
  }

  set clientName(String value) {
    _clientName = value;
  }

  set clientContact(String value) {
    _clientContact = value;
  }

  set price(double value) {
    _price = value;
  }

}
