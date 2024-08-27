import 'package:PS5/sql.dart';
import 'package:flutter/material.dart';
class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}
Future <void> starter()async{
  List<Map> Rooms=[];
  List<Map> Prices=[];
  List<Map> Types=[];
  List<Map> Hoursprices=[];
  sql SQL=sql();
  Rooms=await SQL.readdb('SELECT * FROM rooms');
  Prices =await SQL.readdb("SELECT * FROM prices");
  Types=await SQL.readdb('SELECT * FROM types');
  Hoursprices =await SQL.readdb("SELECT * FROM hourprices");
}
class _SettingState extends State<Setting> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    starter();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}