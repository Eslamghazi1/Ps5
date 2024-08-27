import 'package:flutter/material.dart';
import 'sql.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'additions.dart';

class Loading_tester extends StatefulWidget {

  const Loading_tester({super.key});

  @override
  State<Loading_tester> createState() => _Loading_testerState();
}

class _Loading_testerState extends State<Loading_tester> {

  @override
  Future getdata()async{
    List<Map> instance=[];
    sql SQL=sql();
    instance=await SQL.readdb('SELECT * FROM tables');
    List<play_lists> listed=[];
    if (instance.isNotEmpty) {
      for (int i = 0; i < instance.length; i++) {
        try {
          play_lists players=play_lists(special:instance[i]["state"],id: instance[i]["id"], kind: instance[i]["kind"],
                                        place:  instance[i]["place"], frm: instance[i]["frm"],
                                        too: instance[i]["too"], cost: instance[i]["cost"]);
          listed.add(players);
        } catch (error) {
        }
      }
    }
    else {}
    // ignore: use_build_context_synchronously
    Navigator.pushNamedAndRemoveUntil(context, "home_tester",(route) => false,arguments: {
      "data":listed,
    });
  }
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }

  Map<String, int> cost = {};
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Center(
          child:SpinKitPulsingGrid(duration: const Duration(milliseconds: 100),
            itemBuilder: (BuildContext context, int index) {
              return DecoratedBox(
                decoration: BoxDecoration(
                  color: index.isEven ? Colors.blue : Colors.black,
                ),
              );
            },
          )
      ),
      ),

    );
  }
}
// plays.add_data(instance[i]["id"],instance[i]["kind"],
// instance[i]["place"],instance[i]["frm"] ,
// instance[i]["too"] ,instance[i]["cost"]);