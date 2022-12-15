import 'package:car_app/category_page.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'data/global_variables.dart';
import 'model/vehicle.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: AppBar(
            iconTheme: const IconThemeData(color: Colors.black),
            backgroundColor: Colors.white,
            centerTitle: true,
            title: const Padding(
              padding: EdgeInsets.only(top: 18.0),
              child: Text(
                'My Spins',
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17),
              ),
            ),
            actions: const [
              Padding(
                padding: EdgeInsets.only(top: 10.0, right: 10),
                child: Icon(
                  Icons.cloud_upload,
                  color: Colors.blueAccent,
                ),
              )
            ],
          ),
        ),
        drawer: Drawer(
          // Add a ListView to the drawer. This ensures the user can scroll
          // through the options in the drawer if there isn't enough vertical
          // space to fit everything.
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              SizedBox(
                height: size.height * 0.22,
                child: DrawerHeader(
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20)),
                      image: DecorationImage(
                          image: AssetImage("assets/drawer_rec.png"),
                          fit: BoxFit.fill)),
                  child: Row(
                    children: [
                      Image.asset(
                        "assets/face.png",
                        height: size.height * 0.06,
                      ),
                      const SizedBox(width: 15),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            "Sandev Dewthilina",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 19),
                          ),
                          Text(
                            "Email: sandev@gmail.com",
                            style: TextStyle(
                                color: Color.fromRGBO(255, 255, 255, 50),
                                fontSize: 9),
                          ),
                          Text(
                            "Mobile: +94 768 789 255",
                            style: TextStyle(
                                color: Color.fromRGBO(255, 255, 255, 50),
                                fontSize: 9),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              ListTile(
                title: Row(
                  children: const [
                    Icon(
                      Icons.dashboard,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text("Dashboard")
                  ],
                ),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Row(
                  children: const [
                    Icon(
                      Icons.key,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text("Change Password")
                  ],
                ),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
              const SizedBox(height: 10,),
              Container(
                margin: const EdgeInsets.only(left: 20),
                child: const Text(
                  "Settings",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              ListTile(
                title: Row(
                  children: const [
                    Icon(
                      Icons.settings,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text("Settings")
                  ],
                ),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: double.infinity,
              child: Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  Flexible(
                    flex: 10,
                    child: SizedBox(
                      height: 45,
                      child: TextFormField(
                        decoration: InputDecoration(
                          isDense: true,
                          prefixIcon: const Icon(Icons.search),
                          contentPadding: const EdgeInsets.only(top: 0, bottom: 0, right: 2, left: 10),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: Color.fromRGBO(5, 18, 239, 0.31), width: 1)),
                          hintText: 'Search',
                          hintMaxLines: 1,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Flexible(
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: button('Search', const Color.fromRGBO(0, 101, 255, 1), Colors.white, context),
                      )),
                ],
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 1,
                  width: size.width * 0.3,
                  color: Colors.grey,
                ),
                Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: const Text(
                      "Results",
                      style: TextStyle(color: Colors.black),
                    )),
                Container(
                  height: 1,
                  width: size.width * 0.3,
                  color: Colors.grey,
                ),
              ],
            ),
            Expanded(child: getListView(size))
          ],
        ));
  }
}

Widget getListView(Size size) {
  return FutureBuilder<List<Vehicle>>(
    future: getVehicals(),
    builder: (context, snapshot) {
      if (snapshot.hasData) {

        return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (BuildContext context, int index) {
              var item = snapshot.data!.elementAt(index);
              return GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)  => CategoryPage(item)));
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          height: size.height * 0.09,
                          width: size.height * 0.12,
                          decoration: const BoxDecoration(
                            image: DecorationImage(image: AssetImage("assets/image1.png"), fit: BoxFit.fill),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        height: size.height * 0.1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:  [
                            Text(
                              item.chassisNo!,
                              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              'Published ${item.publishedDateTime}',
                              style: TextStyle(fontSize: 10, color: Colors.grey),
                            ),
                            Text(
                              'VIN / Stock Number ${item.stockId}',
                              style: TextStyle(fontSize: 10, color: Colors.grey),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            // Text(
                            //   'Customer Name: H.N.D Perirs',
                            //   style: TextStyle(fontSize: 10, color: Colors.grey),
                            // )
                          ],
                        ),
                      ),
                      const Expanded(
                          child: Center(
                            child: Text(
                              'Sync',
                              textAlign: TextAlign.end,
                              style: TextStyle(color: Color.fromRGBO(0, 101, 255, 1), fontWeight: FontWeight.w600),
                            ),
                          ))
                    ],
                  ),
                ),
              );
            });
      } else {
        return const Center(
          child: Text('Downloading, Please wait!'),
        );
      }

    }
  );
}

Widget button(String text, Color color, Color textColor, BuildContext context) {
  return GestureDetector(
    onTap: () {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
        (Route<dynamic> route) => false,
      );
    },
    child: Container(
      height: 40,
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(10)),
      child: Center(
        child: Text(
          text,
          style: TextStyle(color: textColor, fontSize: 12),
        ),
      ),
    ),
  );
}

Widget getPill(String text, Color color, Color textColor, bool isFill, BuildContext context) {
  return GestureDetector(
    onTap: () {},
    child: Container(
      height: 40,
      decoration: BoxDecoration(
          color: isFill ? color : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: color)),
      child: Center(
        child: Text(
          text,
          style: TextStyle(color: textColor, fontSize: 12),
        ),
      ),
    ),
  );
}

Future<List<Vehicle>> getVehicals() async {
  try {
    var dio = Dio();
    Response response = await dio.get(
        "${GlobalVariable.PROTOCOL}${GlobalVariable.URL}:${GlobalVariable.PORT}/AppService/GetVehicles");

    // if there is a key before array, use this : return (response.data['data'] as List).map((child)=> Children.fromJson(child)).toList();
    return (response.data as List).map((x) => Vehicle.fromJson(x)).toList();
  } catch (error, stacktrace) {
    throw Exception("Exception occurred: $error stackTrace: $stacktrace");
  }
}

