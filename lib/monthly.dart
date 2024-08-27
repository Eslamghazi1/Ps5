import 'package:flutter/material.dart';
import 'sql.dart';
class Monthly_costs extends StatefulWidget {
  const Monthly_costs({super.key});

  @override
  State<Monthly_costs> createState() => _Monthly_costsState();
}

class _Monthly_costsState extends State<Monthly_costs> {
  Map<String, dynamic> data = {};
  String Home = "MONTHLY COSTS";
  Widget build(BuildContext context) {
    data = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic> ??
        // ignore: dead_null_aware_expression
        data;
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

              },
              title: Text("MONTHLY COSTS", style: TextStyle(fontSize: 15)),
              tileColor:Colors.deepPurple[200],
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
                            await mysql.deletedb("DELETE FROM monthly WHERE 'id' > 0");
                            Navigator.pushNamedAndRemoveUntil(
                                context, "load_costs", (route) => false,arguments: {
                              "name":"monthly",
                              "navigator":"monthly"
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
              "NO COSTS YET!!!!",
              style: TextStyle(fontSize: 20),
            ),
          )
              : ListView(
            children: [
              Container(
                height: MediaQuery.of(context).size.height - 150,
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
                          ListTile(
                            leading: Text(
                              data["data"][index]["month"],
                              style: const TextStyle(fontSize: 22),
                            ),
                            trailing: Text(data["data"][index]["prices"].toString(),
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
            ],
          ),
        ),
      ),

    );
  }
}
