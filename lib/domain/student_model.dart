import 'package:hive/hive.dart';
part 'student_model.g.dart';

@HiveType(typeId: 1)
class StudentModel extends HiveObject{


  @HiveField(0)
  final String name;

  @HiveField(1)
  final String age;

  @HiveField(2)
  final String place;

  @HiveField(3)
  final String imgpath;

  StudentModel({required this.imgpath,required this.place, required this.name,required this.age});

}