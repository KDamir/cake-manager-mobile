
class ExpenseModel {
  String _name;
  String _type;
  double _value;
  DateTime _date = DateTime.now();
  String _userId;


  ExpenseModel();

  String get userId => _userId;

  set userId(String value) {
    _userId = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  String get type => _type;

  DateTime get date => _date;

  set date(DateTime value) {
    _date = value;
  }

  double get value => _value;

  set value(double value) {
    _value = value;
  }

  set type(String value) {
    _type = value;
  }

  Map<String, dynamic> toJson() => {
    'name': _name,
    'date': _date,
    'value': _value.toString(),
    'type': _type,
    'userId': _userId
  };

  ExpenseModel.fromDoc(var document) {
    var data = document.data;
    _name = data['name'];
    _type = data['type'];
    _date = data['date'];
    _value = double.parse(data['value'].toString());
    _userId = data['userId'];
  }


}