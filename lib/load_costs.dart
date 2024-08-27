import 'package:flutter/material.dart';
import 'sql.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class load_cost extends StatefulWidget {
  const load_cost({super.key});

  @override
  State<load_cost> createState() => _load_costState();
}

class _load_costState extends State<load_cost> {
  Future getdata(String tabele,String navigator)async{
    try{
      List<Map> instance=[];
      sql SQL=sql();
      instance=await SQL.readdb('SELECT * FROM $tabele');
      // ignore: use_build_context_synchronously
      Navigator.pushNamedAndRemoveUntil(context, navigator, (route) => false,arguments: {
        "data":instance,
      }
      );
    }catch(error){
    }

  }
  Map<String, dynamic> data = {};
  @override
  Widget build(BuildContext context) {

    data = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic> ??
        // ignore: dead_null_aware_expression
        data;
    getdata(data["name"], data["navigator"]);
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
