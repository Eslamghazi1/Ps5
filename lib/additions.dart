
class play_lists {
  int id = 0;
  String kind = "";
  String place = '';
  String frm = "";
  String too = "";
  String cost = "";
  String special="";
  play_lists(
      {required this.id,
        required this.kind,
        required this.place,
        required this.frm,
        required this.too,
        required this.special,
        required this.cost,});
}


class order {
  int key = 0;
  String position = "";
  String name = '';
  int payment =0;
  String state = "";
  String time = "";
  String hint = "";
  order(
      {required this.key,
      required this.position,
      required this.name,
      required this.payment,
      required this.state,
      required this.time,
      required this.hint});
}
class offers {
  int id = 0;
  String kind = "";
  String place = '';
  String frm = "";
  String too = "";
  String cost = "";
  bool special=false;
  offers(
      {required this.id,
        required this.kind,
        required this.place,
        required this.frm,
        required this.too,
        required this.special,
        required this.cost,});
}
