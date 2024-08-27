import 'package:PS5/sql.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class View_Costs extends StatefulWidget {
  const View_Costs({super.key});

  @override
  State<View_Costs> createState() => _View_CostsState();
}
String extractMonth(String dateString) {
  try{
    final dateFormat = DateFormat('EEEE, MMMM d, yyyy');
    final dateTime = dateFormat.parse(dateString);
    return DateFormat.MMMM().add_y().format(dateTime);
  }catch(error){
    return "Nothing";
  }

}
class _View_CostsState extends State<View_Costs> {
  Map<String, dynamic> data = {};

  Widget build(BuildContext context) {

    String Home = "COSTS VIEW";
    data = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic> ??
        // ignore: dead_null_aware_expression
        data;
    int cost = 0;
    if (data["data"].isNotEmpty) {
      for (int i = 0; i < data["data"].length; i++) {
        try {
          int newcost = data["data"][i]["tasks"]+ data["data"][i]["play"];
          cost = cost + newcost;
        } catch (error) {}
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
              onTap: () {},
              title: Text("PREVIEW COSTS", style: TextStyle(fontSize: 15)),
              tileColor: Colors.deepPurple[200],
            ),
            SizedBox(
              height: 10,
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, "load_costs", (route) => false,arguments: {
                  "name":"payments",
                  "navigator":"payments"
                });
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
          data["data"].isNotEmpty
              ? ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
              ),
              onPressed: () async {
               sql mysql=sql();
               int newcost= await gettheorders_costs();
               cost= cost-newcost;
               showDialog(context: context, builder: (context){
                 return AlertDialog(
                   backgroundColor: Colors.white54,
                   title: Text("DID YOU REALLY WANT TO EDN THIS MONTH?",
                     // textAlign: TextAlign.center,
                   ),
                   actions: [
                     ElevatedButton(
                         style: ElevatedButton.styleFrom(
                           backgroundColor: Colors.deepPurple,
                         ),
                         onPressed: () async {
                           await mysql.deletedb("DELETE FROM costs WHERE 'id' > 0");
                           await mysql.insert("monthly", {
                             "prices": cost,
                             "month":extractMonth(data["data"][0]["day"]),
                           });
                           await mysql.deletedb("DELETE FROM payments WHERE 'id' > 0");
                           await mysql.deletedb("DELETE FROM orders WHERE 'key' > 0");
                           Navigator.pushNamedAndRemoveUntil(
                               context, "load_costs", (route) => false, arguments: {
                             "name": "costs",
                             "navigator": "view_costs"
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
              child: const Text("END FOR THAT MONTH",style: TextStyle(color: Colors.white,),))
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
              "NO TABLE FOR THAT DAY YET!!!!",
              style: TextStyle(fontSize: 20),
            ),
          )
              : ListView(
            children: [
              Container(
                height: MediaQuery.of(context).size.height - 200,
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(top: 5,bottom: 5),
                      decoration:BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0), // Set the border radius to 10.0
                        border: Border.all(width: 2.0), // Add a blue border with a width of 2.0
                        color: Colors.deepPurple[300], // Set the container's background color to white
                      ),
                      child: Column(
                        children: [
                          Container(
                            // color: Colors.deepPurple[300],
                            padding: EdgeInsets.only(top: 10,bottom: 10),
                            child: Text(
                              data["data"][index]["day"],textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 22),
                            ),
                          ),
                          ListTile(
                            title: Row(children: <Widget>[
                              Expanded(
                                  flex: 1,
                                  child: Text("ORDERS",
                                      style:
                                      const TextStyle(fontSize: 18))),
                              Expanded(
                                  flex: 2,
                                  child: Text(
                                    "PLAYS",
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(fontSize: 18),
                                  ))
                            ]),
                            leading: Text(
                              data["data"][index]["tasks"].toString(),
                              style: const TextStyle(fontSize: 22),
                            ),
                            trailing: Text(data["data"][index]["play"].toString(),
                              style: const TextStyle(fontSize: 20),
                              textAlign: TextAlign.center,
                            ),
                          ),

                        ],
                      ),
                    );
                  },
                  itemCount: ((data["data"]).length) as int,
                ),
              ),
              SizedBox(height: 10,),
              Text("THE TOTAL IS :${cost.toString()}",style: TextStyle(fontSize: 28),textAlign: TextAlign.center,),

            ],
          ),
        ),
      ),


    );
  }
}

gettheorders_costs()async{
  int? tempcost=0;
  try{
    List<Map> instance;
    sql mysql=sql();
    instance= await mysql.readdb("SELECT tasks FROM payments");
    for(int i=0;i<instance.length;i++){
      tempcost=(tempcost!+instance[i]["tasks"]) as int?;
    }
    return tempcost;
  }catch(error){
    return 0;
  }
}