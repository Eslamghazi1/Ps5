import 'package:flutter/material.dart';
import 'additions.dart';
import 'sql.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading_offer extends StatefulWidget {
  const Loading_offer({super.key});

  @override
  State<Loading_offer> createState() => _Loading_offerState();
}

class _Loading_offerState extends State<Loading_offer> {

  Future getdata()async{
    List<Map> instance=[];
    sql SQL=sql();
    instance=await SQL.readdb('SELECT * FROM offers');
    List<offers> listed=[];
    if (instance.isNotEmpty) {
      for (int i = 0; i < instance.length; i++) {
        try {
          offers players=offers(special:bool.parse(instance[i]["state"]),id: instance[i]["id"], kind: instance[i]["kind"],
              place:  instance[i]["place"], frm: instance[i]["frm"],
              too: instance[i]["too"], cost: instance[i]["cost"]);
          listed.add(players);
        } catch (error) {
        }
      }
    }
    else   {}
    Navigator.pushNamedAndRemoveUntil(context, "offer",(route) => false,arguments: {
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
