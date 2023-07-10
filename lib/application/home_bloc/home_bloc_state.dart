part of 'home_bloc_bloc.dart';

class HomeBlocState {
   List<StudentModel> studentlist;
  HomeBlocState({required this.studentlist});
}

class HomeBlocInitial extends HomeBlocState {
  HomeBlocInitial({required super.studentlist});
}
