import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sample_details_hive_bloc/core/constans.dart';
import 'package:sample_details_hive_bloc/domain/student_model.dart';

class DetsilScreen extends StatelessWidget {
  final StudentModel data;
  const DetsilScreen({super.key,required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:const Text('Details'),),
      body: SafeArea(child: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 200,width: 200,
              decoration: BoxDecoration(
                image: DecorationImage(image: FileImage(File(data.imgpath),),fit: BoxFit.cover),
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            kheight,
            Text('Name: ${data.name}',style:const TextStyle(fontSize: 20),),
            kheight,
            Text('Age: ${data.age}',style:const TextStyle(fontSize: 20)),
            kheight,
            Text('Place: ${data.place}',style:const TextStyle(fontSize: 20)),
            IconButton(onPressed: () {
              Navigator.pop(context);
            }, icon:const Icon(Icons.home))
          ],
        ),
      )),
    );
  }
}