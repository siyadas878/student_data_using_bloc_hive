import 'package:hive/hive.dart';
import '../domain/student_model.dart';

List<StudentModel> studentlistnotifier = [];

List<StudentModel> studentDbAdd(
    {required StudentModel data, required List<StudentModel> studentlist}) {
  final db = Hive.box<StudentModel>('student.db');
  studentlist.add(data);
  db.add(data);
  return studentlist;
}

Future<List<StudentModel>> getalldata() async {
  final db = await Hive.openBox<StudentModel>('student.db');
  studentlistnotifier.clear();
  studentlistnotifier.addAll(db.values);
  print(db.values.length);
  return studentlistnotifier;
}

List<StudentModel> studentDbDelete(
    {required StudentModel data, required List<StudentModel> studentlist}) {
  final db = Hive.box<StudentModel>('student.db');
  var key = data.key;
  db.delete(key);
  studentlist.remove(data);
  return studentlist;
}

List<StudentModel> searchdata(String querry, List<StudentModel> studentlist) {
  List<StudentModel> searchlist = [];
  searchlist = studentlist
      .where((element) =>
          element.name.toLowerCase().contains(querry.trim().toLowerCase()))
      .toList();
  return searchlist;
}

Future<List<StudentModel>> update(
    {required StudentModel data,required int key,
    required List<StudentModel> studentlist,
    required int editingindex}) async{
 final db = await Hive.openBox<StudentModel>('student.db');
 // int key = data.key;
   print(key);
  await db.put(key, data);
  studentlist[editingindex] = data;
  print(studentlist.length);
  return studentlist;
}
