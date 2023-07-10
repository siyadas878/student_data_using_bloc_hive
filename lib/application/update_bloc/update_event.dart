part of 'update_bloc.dart';

class UpdateEvent {}

class StudentEdit extends UpdateEvent {
  StudentModel data;
  int editingindex;
  int key;
  StudentEdit({required this.data, required this.editingindex,required this.key});
}