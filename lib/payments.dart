import 'package:flutter/material.dart';
import 'sql.dart';
import 'package:intl/intl.dart';

class Payments extends StatefulWidget {
  const Payments({super.key});

  @override
  State<Payments> createState() => _PaymentsState();
}

class _PaymentsState extends State<Payments> {
  Map<String, dynamic> data = {};
  String Home = "PAYMENTS";
  Widget build(BuildContext context) {
      data = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic> ??
          // ignore: dead_null_aware_expression
          data;
      int cost = 0;
      if (data["data"].isNotEmpty) {
        for (int i = 0; i < data["data"].length; i++) {
          try {
            int newcost = data["data"][i]["tasks"];
            cost = cost + newcost;
          } catch (error) {}
        }
      }      final validate=GlobalKey<FormState>();
      TextEditingController kind=TextEditingController();
      TextEditingController hint=TextEditingController();

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
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, "load_orders", (route) => false);
              },
              title: Text("ORDERS", style: TextStyle(fontSize: 15)),
              tileColor: Colors.deepPurple[400],
            ),
            SizedBox(
              height: 10,
            ),ListTile(
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
                    context, "loading", (route) => false);
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
                Navigator.pushNamedAndRemoveUntil(
                    context, "load_costs", (route) => false,arguments: {
                  "name":"costs",
                  "navigator":"view_costs"
                });
              },
              title: Text("PREVIEW COSTS", style: TextStyle(fontSize: 15)),
              tileColor: Colors.deepPurple[400],
            ),
            SizedBox(
              height: 10,
            ),
            ListTile(
              title: Text("PAYMENTS", style: TextStyle(fontSize: 15)),
              tileColor: Colors.deepPurple[200],
            ),
            SizedBox(
              height: 10,
            ),
            // MONTHLY COSTS BUTTON
            ListTile(
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, "load_costs", (route) => false,arguments: {
                  "name":"monthly",
                  "navigator":"monthly"
                });
              },
              title: Text("MONTHLY COSTS", style: TextStyle(fontSize: 15)),
              tileColor:Colors.deepPurple[400],
            ),

          ],
        ),
      ),
      appBar: AppBar(
        title: Text(Home),
        backgroundColor: Colors.deepPurple,
        actions: [
          // the second button
          data["data"].isNotEmpty
              ? ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
              ),
              onPressed: () async {
                sql mysql=sql();
                showDialog(context: context, builder: (context){
                  return AlertDialog(
                    backgroundColor: Colors.white54,
                    title: Text("DID YOU REALLY WANT TO DELETE THIS?",
                      // textAlign: TextAlign.center,
                    ),
                    actions: [
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepPurple,
                          ),
                          onPressed: () async {
                            await mysql.deletedb("DELETE FROM payments WHERE 'id' > 0");
                            Navigator.pushNamedAndRemoveUntil(
                                context, "load_costs", (route) => false,arguments: {
                              "name":"payments",
                              "navigator":"payments"
                            });
                          },
                          child: const Text("YES",style: TextStyle(color: Colors.white),)),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepPurple,
                          ),
                          onPressed: () async {
                            Navigator.pop(context);
                          },
                          child: const Text("No",style: TextStyle(color: Colors.white)))],
                  );
                });

              },
              child: const Text("Clear All",style: TextStyle(color: Colors.white,)))
              : const Icon(
            Icons.deblur_rounded,
          ),
        ],
      ),
      body: Container(
        color: Colors.grey,
        child: SafeArea(
          child: (data["data"].isEmpty)
              ? const Center(
            child: Text(
              "NO PAYMENTS YET!!!!",
              style: TextStyle(fontSize: 20),
            ),
          )
              : ListView(
            children: [
              SizedBox(height: 10,),
              Text("THE TOTAL IS :${cost.toString()}",style: TextStyle(fontSize: 28),textAlign: TextAlign.center,),
              SizedBox(height: 10,),
              Container(
                height: MediaQuery.of(context).size.height - 150,
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Container(
                          decoration:BoxDecoration(
                            // borderRadius: BorderRadius.circular(10.0), // Set the border radius to 10.0
                            border: Border.all(width: 0.5), // Add a blue border with a width of 2.0
                            // color: Colors.deepPurple[300], // Set the container's background color to white
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              ListTile(
                                subtitle: Text(data["data"][index]["hint"]),
                                leading: Text(
                                  data["data"][index]["day"],
                                  style: const TextStyle(fontSize: 22),
                                ),
                                trailing: Text(data["data"][index]["tasks"].toString(),
                                  style: const TextStyle(fontSize: 20),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.deepPurple,
                                ),
                                onPressed: () async {
                                  sql mysql = sql();
                                  showDialog(context: context, builder: (context){
                                    return AlertDialog(
                                      backgroundColor: Colors.white54,
                                      title: Text("DID YOU REALLY WANT TO DELETE THIS?",
                                        // textAlign: TextAlign.center,
                                      ),
                                      actions: [
                                        ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.deepPurple,
                                            ),
                                            onPressed: () async {
                                              await mysql.deletedb(
                                                  "DELETE FROM payments WHERE id = ${data["data"][index]["id"]}");
                                              Navigator.pushNamedAndRemoveUntil(
                                                  context, "load_costs", (route) => false,arguments: {
                                                "name":"payments",
                                                "navigator":"payments"
                                              });
                                            },
                                            child: const Text("YES",style: TextStyle(color: Colors.white),)),
                                        ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.deepPurple,
                                            ),
                                            onPressed: () async {
                                              Navigator.pop(context);
                                            },
                                            child: const Text("No",style: TextStyle(color: Colors.white)))],
                                    );
                                  });

                                },
                                label:Text("DELETE",style: TextStyle(color: Colors.white,)),icon: Icon(Icons.delete_forever,color: Colors.white,),)
                            ],
                          ),
                        ),

                      ],
                    );
                  },
                  itemCount: ((data["data"]).length) as int,
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.deepPurple,
          child: const Icon(
            Icons.add,
          ),
          onPressed: () {
            showDialog(context: context, builder: (context){
              return AlertDialog(
                backgroundColor: Colors.white70,
                title: Text("ENTER THE AMOUNT OF MONEY",textAlign: TextAlign.center,),
                content:SizedBox(
                  height: 190,
                  child: Form(
                    key: validate,
                    child: Column(
                      children: [
                        TextFormField(
              keyboardType: TextInputType.number,
              controller: kind,
              validator: (value){
              if(value==null||value.isEmpty) {
              return "Enter The Number";
              }
              return null;
              },
              decoration: const InputDecoration(
              enabledBorder: UnderlineInputBorder(),
              hintText: "Cash",
              border: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
              color: Colors.deepPurple,
              ))
              ),
              ),
                        TextFormField(
                          maxLength: 60,
                          controller: hint,
                          decoration: const InputDecoration(
                              enabledBorder: UnderlineInputBorder(),
                              hintText: "Hint",
                              hintStyle: TextStyle(fontSize: 20),
                              border: OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.deepPurple,
                                  ))
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                actions: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                      ),
                      onPressed: () async {
                              if(validate.currentState!.validate()) {
                              ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Great"))
                              );
                              int temp=int.parse(kind.text).toInt();
                              hint.text.isEmpty?hint.text="...":hint.text=hint.text;
                              sql mysql=sql();
                              await mysql.insert("payments", {
                                "day": DateFormat.EEEE().add_yMd().format(DateTime.now()),
                                "tasks": temp,
                                "hint":hint.text,
                              });
                              Navigator.pushNamedAndRemoveUntil(
                                  context, "load_costs", (route) => false,arguments: {
                                "name":"payments",
                                "navigator":"payments"
                              });

                             }
                      },
                      child: const Text("DONE",style: TextStyle(color: Colors.white,)))],
              );
            });
          }),
    );
  }
}
