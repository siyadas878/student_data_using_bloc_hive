part of 'home_bloc_bloc.dart';

class HomeBlocEvent {}

class AddStudent extends HomeBlocEvent {
  StudentModel data;
  AddStudent({required this.data});
}

class StudentRemove extends HomeBlocEvent {
  StudentModel data;
  StudentRemove({required this.data});
}

class StudentGetAll extends HomeBlocEvent {}

class StudentEdit extends HomeBlocEvent {
  StudentModel data;
  int editingindex;
  int key;
  StudentEdit({required this.data, required this.editingindex,required this.key});
}



