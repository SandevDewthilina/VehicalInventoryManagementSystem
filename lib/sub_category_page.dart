import 'dart:io';
import 'dart:math';
import 'package:car_app/model/category.dart';
import 'package:car_app/model/subcategory.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import 'data/global_variables.dart';
import 'model/vehicle.dart';

class SubCategoryPage extends StatefulWidget {
  Category category;
  Vehicle? vehicle;

  SubCategoryPage(this.category, this.vehicle, {Key? key}) : super(key: key);

  @override
  State<SubCategoryPage> createState() => _SubCategoryPageState();
}

class _SubCategoryPageState extends State<SubCategoryPage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    List<SubCategory> subCategoryList = widget.category.SubCategories!;
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
              'Close-Ups',
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
            Expanded(
              child: ListView.builder(
                  itemCount: subCategoryList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                      child: SizedBox(
                        width: double.infinity,
                        height: size.height * 0.15,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 10,
                                  child: Text(
                                    subCategoryList.elementAt(index).name!,
                                    style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                                  ),
                                ),
                                Expanded(
                                  flex: 9,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      InkWell(
                                        onTap: () async {
                                          // camera logic
                                          XFile? pickfile;

                                          pickfile = await ImagePicker().pickImage(source: ImageSource.camera);

                                          // get file path
                                          var filepath = pickfile!.path;
                                          var dio = Dio();
                                          Response response;
                                          var filename =
                                              '${widget.vehicle!.chassisNo}#${widget.category.Name}#${subCategoryList.elementAt(index).name!}.jpg';

                                          FormData formData = FormData.fromMap({
                                            "file": await MultipartFile.fromFile(filepath, filename: filename),
                                          });
                                          response = await dio.post(
                                              "${GlobalVariable.PROTOCOL}${GlobalVariable.URL}:${GlobalVariable.PORT}/FileUpload/Upload",
                                              data: formData);

                                        },
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(20),
                                          child: subCategoryList.elementAt(index).imageUrl != null
                                              ? Image.network(
                                                  subCategoryList.elementAt(index).imageUrl!,
                                                  fit: BoxFit.fill,
                                                  width: size.height * 0.12,
                                                  height: size.height * 0.09,
                                                )
                                              : Image.asset(
                                                  'assets/image3.png',
                                                  fit: BoxFit.fill,
                                                  width: size.height * 0.12,
                                                  height: size.height * 0.09,
                                                ),
                                        ),
                                      ),
                                      const Text(
                                        'Sync',
                                        textAlign: TextAlign.end,
                                        style:
                                            TextStyle(color: Color.fromRGBO(0, 101, 255, 1), fontWeight: FontWeight.w600),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Divider(
                              height: 1,
                              thickness: 1,
                              color: Colors.grey.withOpacity(0.2),

                            )
                          ],
                        ),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
