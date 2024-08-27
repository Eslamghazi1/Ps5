import 'package:PS5/Home.dart';
import 'package:PS5/Home_tester.dart';
import 'package:PS5/Load_done_orders.dart';
import 'package:PS5/Update_offer.dart';
import 'package:PS5/class.dart';
import 'package:PS5/costview.dart';
import 'package:PS5/insert.dart';
import 'package:PS5/insert_orders.dart';
import 'package:PS5/insert_tester.dart';
import 'package:PS5/load_costs.dart';
import 'package:PS5/loading_offer.dart';
import 'package:PS5/monthly.dart';
import 'package:PS5/orders.dart';
import 'package:PS5/loading.dart';
import 'package:PS5/order_load.dart';
import 'package:PS5/orders_done.dart';
import 'package:PS5/payments.dart';
import 'package:PS5/update.dart';
import 'package:flutter/material.dart';
import 'package:intl/number_symbols_data.dart';

import 'loading_tester.dart';

void main() {
  runApp(new Myapp());
}

class Myapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Loading(),
      routes: {
        "offer": (context) => Home_offer(),
        "insert_offer": (context) => Insert_offer(),
        "orders": (context) => Orders(),
        "load_orders": (context) => Load_order(),
        "view_costs": (context) => View_Costs(),
        "Home": (context) => Home(),
        "loading": (context) => Loading(),
        "insert": (context) => Insert(),
        "update": (context) => Update(),
        "insert_order": (context) => Insert_Orders(),
        "load_costs": (context) => load_cost(),
        "monthly": (context) => Monthly_costs(),
        "payments": (context) => Payments(),
        "loading_tester": (context) => Loading_tester(),
        "tester": (context) => tester(),
        "loading_offer": (context) => Loading_offer(),
        "update_offer": (context) => Update_offer(),
        "paid":(context)=>Orders_done(),
        "load_paid":(context)=>Load_order_paid(),
      },
    );
  }
}
//Orders_done