import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sample_details_hive_bloc/application/home_bloc/home_bloc_bloc.dart';
import '../../core/constans.dart';
import '../../domain/student_model.dart';

class EditScreen extends StatelessWidget {
  final StudentModel data;
  final int dataIndex;
  EditScreen({super.key, required this.data, required this.dataIndex});

  final name = TextEditingController();
  final age = TextEditingController();
  final place = TextEditingController();

  final nameFormKey = GlobalKey<FormState>();
  final ageFormKey = GlobalKey<FormState>();
  final placeFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    ValueNotifier<String?> imagepath = ValueNotifier(null);
    name.text = data.name;
    age.text = data.age;
    place.text = data.place;
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: SingleChildScrollView(
              child: BlocBuilder<HomeBlocBloc, HomeBlocState>(
                builder: (context, state) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () => getimage(context, imagepath),
                        child: ValueListenableBuilder(
                          valueListenable: imagepath,
                          builder: (context, value, child) {
                            return CircleAvatar(
                              backgroundImage: imageselector(imagepath.value),
                              radius: 100,
                            );
                          },
                        ),
                      ),
                      kheight,
                      dataField('name', nameFormKey, name),
                      kheight,
                      dataField('age', ageFormKey, age),
                      kheight,
                      dataField('place', placeFormKey, place),
                      kheight,
                      ElevatedButton(
                          onPressed: (() {
                            if (nameFormKey.currentState!.validate() &&
                                ageFormKey.currentState!.validate() &&
                                placeFormKey.currentState!.validate()) {
                              StudentModel edited = StudentModel(
                                  imgpath: imagepath.value ?? data.imgpath,
                                  place: place.text,
                                  name: name.text,
                                  age: age.text);
                              BlocProvider.of<HomeBlocBloc>(context).add(
                                  StudentEdit(key: data.key,
                                      data: edited, editingindex: dataIndex));
                              Navigator.of(context).pop();
                            }
                          }),
                          child: const Text('Update')),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget dataField(String label, GlobalKey<FormState> key,
      TextEditingController controller) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Form(
          key: formkeySelector(controller),
          child: TextFormField(
            validator: (value) {
              return validatorchecking(value, controller);
            },
            controller: controller,
            keyboardType:
                controller == age ? TextInputType.number : TextInputType.text,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                labelText: controller == name
                    ? 'Name'
                    : controller == age
                        ? 'Age'
                        : 'Place',
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                )),
          ),
        ));
  }

  getimage(BuildContext context, ValueNotifier<String?> imagepath) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image?.path != null) {
      imagepath.value = image?.path;
    }
  }

  imageselector(String? path) {
    if (path == null) {
      return FileImage(File(data.imgpath));
    } else {
      return FileImage(File(path));
    }
  }

  GlobalKey formkeySelector(TextEditingController controller) {
    if (controller == name) {
      return nameFormKey;
    } else if (controller == age) {
      return ageFormKey;
    } else {
      return placeFormKey;
    }
  }

  String? validatorchecking(value, TextEditingController controller) {
    if (controller == name) {
      if (name.text.isEmpty) {
        return 'Name is required';
      }
    } else if (controller == age) {
      if (age.text.isEmpty) {
        return 'Age is required';
      } else if (int.tryParse(age.text) == null) {
        return 'Age should be number';
      }
    } else if (controller == place) {
      if (place.text.isEmpty) {
        return 'Place is required';
      }
    }

    return null;
  }
}
