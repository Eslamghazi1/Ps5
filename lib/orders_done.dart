import 'package:PS5/additions.dart';
import 'package:flutter/material.dart';
import 'sql.dart';

class Orders_done extends StatefulWidget {
  const Orders_done({super.key});

  @override
  State<Orders_done> createState() => _Orders_doneState();
}

class _Orders_doneState extends State<Orders_done> {
  String Home = "ORDERS PAID";
  Map<String, dynamic> data = {};

  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic> ??
        data; // ignore: dead_null_aware_expression
    int cost = 0;
    if (data["data"].isNotEmpty) {
      for (int i = 0; i < data["data"].length; i++) {
        try {
          cost = cost + data["data"][i].payment as int;
        } catch (error) {
          print(error);
        }
      }
    }
    return Scaffold(
      drawer: Drawer(
        backgroundColor: Colors.grey[400],
        child: ListView(
          children: <Widget>[
            DrawerHeader(
                child: Column(
              children: <Widget>[
                CircleAvatar(
                  backgroundColor: Colors.deepPurple,
                  radius: 48,
                  child: Image(image: AssetImage("images/PS5.png")),
                ),
                Text(
                  "PS5:$Home",
                  style: TextStyle(fontSize: 25),
                ),
              ],
            )),
            ListTile(
              onTap: () {},
              title: Text("ORDERS", style: TextStyle(fontSize: 15)),
              tileColor: Colors.deepPurple[200],
            ),
            SizedBox(
              height: 10,
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, "loading_offer", (route) => false);
              },
              title: Text("OFFER", style: TextStyle(fontSize: 15)),
              tileColor: Colors.deepPurple[400],
            ),
            SizedBox(
              height: 10,
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(
                  context, "loading", (route) => false,
                  //     arguments: {
                  //   "cost":cost,
                  // }
                );
              },
              title: Text("PLAYS LIST", style: TextStyle(fontSize: 15)),
              tileColor: Colors.deepPurple[400],
            ),

            SizedBox(
              height: 10,
            ),
            Divider(
              thickness: 3,
              color: Colors.deepPurple,
            ),
            ListTile(
              onTap: () {
                try {
                  Navigator.pushNamedAndRemoveUntil(
                      context, "load_costs", (route) => false,
                      arguments: {"name": "costs", "navigator": "view_costs"});
                } catch (error) {}
              },
              title: Text("PREVIEW COSTS", style: TextStyle(fontSize: 15)),
              tileColor: Colors.deepPurple[400],
            ),
            SizedBox(
              height: 10,
            ),
            // PAYMENT BUTTON
            ListTile(
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, "load_costs", (route) => false,
                    arguments: {"name": "payments", "navigator": "payments"});
              },
              title: Text("PAYMENTS", style: TextStyle(fontSize: 15)),
              tileColor: Colors.deepPurple[400],
            ),
            SizedBox(
              height: 10,
            ),
            // MONTHLY COSTS BUTTON
            ListTile(
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, "load_costs", (route) => false,
                    arguments: {"name": "monthly", "navigator": "monthly"});
              },
              title: Text("MONTHLY COSTS", style: TextStyle(fontSize: 15)),
              tileColor: Colors.deepPurple[400],
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text(Home),
        backgroundColor: Colors.deepPurple,
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurple,
              elevation: 0,
            ),

            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, "load_orders", (route) => false);
            },
            child: Text("Get Back",style: TextStyle(color: Colors.black)),
          ),
        ],
      ),
      body: Container(
        color: Colors.grey,
        child: SafeArea(
          child: data["data"].isEmpty
              ? const Center(
                  child: Text(
                    "NO ORDERS FOR THAT DAY YET!!!!",
                    style: TextStyle(fontSize: 20),
                  ),
                )
              : ListView(
                  children: [
                    Text("the total cost is:$cost",
                        style: TextStyle(fontSize: 25),
                        textAlign: TextAlign.center),
                    Container(
                      height: MediaQuery.of(context).size.height - 150,
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.only(top: 5),
                            color: Colors.green[200],
                            child: Column(
                              children: [
                                ListTile(
                                  title: Row(children: <Widget>[
                                    Expanded(
                                      flex: 3,
                                      child: Text(data["data"][index].name,
                                          style: const TextStyle(fontSize: 17)),
                                    ),
                                    Expanded(
                                      flex: 4,
                                      child: Column(
                                        children: [
                                          Text(data["data"][index].hint,
                                              style: const TextStyle(
                                                  fontSize: 17)),
                                        ],
                                      ),
                                    ),
                                  ]),
                                  leading: Text(
                                    data["data"][index].position,
                                    style: const TextStyle(fontSize: 22),
                                  ),
                                  trailing: Text(
                                    data["data"][index].payment.toString(),
                                    style: const TextStyle(fontSize: 18),
                                    textAlign: TextAlign.center,
                                  ),
                                  subtitle: Text(data["data"][index].time,
                                      style: const TextStyle(fontSize: 18)),
                                  onTap: () {},
                                ),
                                Row(
                                  children: <Widget>[
                                    //   the stop buttom
                                    Expanded(
                                        child: Container(
                                            child: Container(
                                                padding: EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                  color: Colors.blue,
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                ),
                                                // color: Colors.blue,
                                                child: Text(
                                                  "STOPPED",
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    // color: Colors.black87
                                                  ),
                                                  textAlign: TextAlign.center,
                                                )))),
                                    // the delete buttom
                                    Expanded(
                                        child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.red,
                                            ),
                                            onPressed: () async {
                                              sql mysql = sql();
                                              showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return AlertDialog(
                                                      backgroundColor:
                                                          Colors.white54,
                                                      title: Text(
                                                        "DID YOU REALLY WANT TO DELETE THIS?",
                                                        // textAlign: TextAlign.center,
                                                      ),
                                                      actions: [
                                                        ElevatedButton(
                                                            style:
                                                                ElevatedButton
                                                                    .styleFrom(
                                                              backgroundColor:
                                                                  Colors
                                                                      .deepPurple,
                                                            ),
                                                            onPressed:
                                                                () async {
                                                              await mysql.deletedb(
                                                                  "DELETE FROM disorders WHERE key = '${data["data"][index].key}'");
                                                              setState(() {
                                                                data["data"]
                                                                    .removeAt(
                                                                        index);
                                                              });
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child: const Text(
                                                              "YES",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            )),
                                                        ElevatedButton(
                                                            style:
                                                                ElevatedButton
                                                                    .styleFrom(
                                                              backgroundColor:
                                                                  Colors
                                                                      .deepPurple,
                                                            ),
                                                            onPressed:
                                                                () async {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child: const Text(
                                                                "No",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white)))
                                                      ],
                                                    );
                                                  });
                                            },
                                            child: Text("DELETE"))),
                                  ],
                                )
                              ],
                            ),
                          );
                        },
                        itemCount: ((data["data"]).length) as int,
                      ),
                    ),
                    Divider(
                      color: Colors.deepPurple[400],
                      thickness: 4,
                    ),

                    // the orders to be paid .........................................................................
                    // data["data"].isEmpty
                    //     ? Text("..")
                    //     : Container(
                    //         height:
                    //             MediaQuery.of(context).size.height / 2 - 150,
                    //         child: ListView.builder(
                    //           itemBuilder: (context, index) {
                    //             return Container(
                    //               color: Colors.green[200],
                    //               child: Column(
                    //                 children: [
                    //                   ListTile(
                    //                     title: Row(children: <Widget>[
                    //                       Expanded(
                    //                         flex: 3,
                    //                         child: Text(
                    //                             data["data"][index].name,
                    //                             style: const TextStyle(
                    //                                 fontSize: 17)),
                    //                       ),
                    //                       Expanded(
                    //                         flex: 4,
                    //                         child: Column(
                    //                           children: [
                    //                             Text(data["data"][index].hint,
                    //                                 style: const TextStyle(
                    //                                     fontSize: 17)),
                    //                           ],
                    //                         ),
                    //                       ),
                    //                     ]),
                    //                     leading: Text(
                    //                       data["data"][index].position,
                    //                       style: const TextStyle(fontSize: 22),
                    //                     ),
                    //                     trailing: Text(
                    //                       data["data"][index]
                    //                           .payment
                    //                           .toString(),
                    //                       style: const TextStyle(fontSize: 18),
                    //                       textAlign: TextAlign.center,
                    //                     ),
                    //                     subtitle: Text(data["data"][index].time,
                    //                         style:
                    //                             const TextStyle(fontSize: 18)),
                    //                     onTap: () {},
                    //                   ),
                    //                   Row(
                    //                     children: <Widget>[
                    //                       //   the stop buttom
                    //                       Expanded(
                    //                           child: Container(
                    //                               child: Container(
                    //                                   padding:
                    //                                       EdgeInsets.all(8),
                    //                                   decoration: BoxDecoration(
                    //                                     color: Colors.blue,
                    //                                     borderRadius:
                    //                                         BorderRadius
                    //                                             .circular(50),
                    //                                   ),
                    //                                   child: Text(
                    //                                     "DONE",
                    //                                     style: TextStyle(
                    //                                         fontSize: 18,
                    //                                         color:
                    //                                             Colors.white),
                    //                                     textAlign:
                    //                                         TextAlign.center,
                    //                                   )))),
                    //                       // the delete buttom
                    //                       Expanded(
                    //                           child: ElevatedButton(
                    //                               style:
                    //                                   ElevatedButton.styleFrom(
                    //                                 backgroundColor: Colors.red,
                    //                               ),
                    //                               onPressed: () async {
                    //                                 sql mysql = sql();
                    //                                 showDialog(
                    //                                     context: context,
                    //                                     builder: (context) {
                    //                                       return AlertDialog(
                    //                                         backgroundColor:
                    //                                             Colors.white54,
                    //                                         title: Text(
                    //                                           "DID YOU REALLY WANT TO DELETE THIS?",
                    //                                           // textAlign: TextAlign.center,
                    //                                         ),
                    //                                         actions: [
                    //                                           ElevatedButton(
                    //                                               style: ElevatedButton
                    //                                                   .styleFrom(
                    //                                                 backgroundColor:
                    //                                                     Colors
                    //                                                         .deepPurple,
                    //                                               ),
                    //                                               onPressed:
                    //                                                   () async {
                    //                                                 await mysql
                    //                                                     .deletedb(
                    //                                                         "DELETE FROM orders WHERE key = '${data["data"][index].key}'");
                    //                                                 setState(
                    //                                                     () {
                    //                                                   data["data"]
                    //                                                       .removeAt(
                    //                                                           index);
                    //                                                 });
                    //                                                 Navigator.pop(
                    //                                                     context);
                    //                                               },
                    //                                               child:
                    //                                                   const Text(
                    //                                                 "YES",
                    //                                                 style: TextStyle(
                    //                                                     color: Colors
                    //                                                         .white),
                    //                                               )),
                    //                                           ElevatedButton(
                    //                                               style: ElevatedButton
                    //                                                   .styleFrom(
                    //                                                 backgroundColor:
                    //                                                     Colors
                    //                                                         .deepPurple,
                    //                                               ),
                    //                                               onPressed:
                    //                                                   () async {
                    //                                                 Navigator.pop(
                    //                                                     context);
                    //                                               },
                    //                                               child: const Text(
                    //                                                   "No",
                    //                                                   style: TextStyle(
                    //                                                       color:
                    //                                                           Colors.white)))
                    //                                         ],
                    //                                       );
                    //                                     });
                    //                               },
                    //                               child: Text("DELETE"))),
                    //                     ],
                    //                   )
                    //                 ],
                    //               ),
                    //             );
                    //           },
                    //           itemCount: ((data["data"]).length) as int,
                    //         ),
                    //       ),
                  ],
                ),
        ),
      ),
    );
  }
}
