import 'package:car_app/data/global_variables.dart';
import 'package:car_app/model/vehicle.dart';
import 'package:car_app/sub_category_page.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'model/category.dart';

class CategoryPage extends StatelessWidget {
  Vehicle vehicle;
  CategoryPage(this.vehicle, {Key? key}) : super(key: key);

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
              'Capture',
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 25.0, right: 25, top: 35),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: const [
                Text('VIN / Stock Number'),
                SizedBox(
                  width: 15,
                ),
                Text(
                  'Edit',
                  style: TextStyle(color: Color.fromRGBO(0, 101, 255, 1), fontWeight: FontWeight.w600),
                )
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            const Text(
              '1122',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 22),
            ),
            FutureBuilder<List<Category>>(
                future: getCategories(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Expanded(
                      child: ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              SubCategoryPage(snapshot.data!.elementAt(index),
                                                  vehicle)));
                                },
                                child: Container(
                                  width: double.infinity,
                                  height: size.height * 0.1,
                                  decoration: BoxDecoration(
                                      color: const Color.fromRGBO(218, 223, 223, 1.0),
                                      borderRadius: BorderRadius.circular(14)),
                                  child: Center(
                                    child: Text(
                                      snapshot.data!.elementAt(index).Name!,
                                      style: const TextStyle(fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                    );
                  } else {
                    return const Expanded(
                      child: Center(
                        child: Text('Downloading Data, Please wait!'),
                      ),
                    );
                  }
                })
          ],
        ),
      ),
    );
  }

  Future<List<Category>> getCategories() async {
    try {
      var dio = Dio();
      Response response = await dio.get(
          "${GlobalVariable.PROTOCOL}${GlobalVariable.URL}:${GlobalVariable.PORT}/AppService/GetCategories?userName=Admin");

      // if there is a key before array, use this : return (response.data['data'] as List).map((child)=> Children.fromJson(child)).toList();
      return (response.data as List).map((x) => Category.fromJson(x)).toList();
    } catch (error, stacktrace) {
      throw Exception("Exception occurred: $error stackTrace: $stacktrace");
    }
  }
}
