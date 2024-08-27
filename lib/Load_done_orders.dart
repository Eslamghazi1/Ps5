import 'package:PS5/additions.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'sql.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
int cost=0;
class Load_order_paid extends StatefulWidget {
  const Load_order_paid({super.key});

  @override
  State<Load_order_paid> createState() => _Load_order_paidState();
}

class _Load_order_paidState extends State<Load_order_paid> {
  Future getdata()async{

    List<Map> instance2=[];
    sql SQL=sql();
    instance2=await SQL.readdb('SELECT * FROM orders');
    // ignore: use_build_context_synchronously
    List<order> listed2=[];

    if (instance2.isNotEmpty) {
      // the orders that did not paid yet...........
      for (int i = 0; i < instance2.length; i++) {
        try {
          order orders = order(key: instance2[i]["key"],
              position: instance2[i]["position"],
              name: instance2[i]["name"]
              ,
              payment: instance2[i]["payment"],
              state: instance2[i]["state"],
              time: instance2[i]["time"],
              hint: instance2[i]["hint"]);
          listed2.add(orders);
        } catch (error) {
        }
      }
    }
    Navigator.pushNamedAndRemoveUntil(context, "paid", (route) => false,arguments: {
      "data":listed2,
    }
    );

    // }

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }
  Map<String, dynamic> data = {};

  @override
  Widget build(BuildContext context) {
    try{
      data = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic> ??
          data; // ignore: dead_null_aware_expression
    }catch(_){}

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
