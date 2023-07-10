part of 'home_bloc_bloc.dart';

class HomeBlocState {
   List<StudentModel> studentlist;
   List<StudentModel>? searchlist;
  HomeBlocState({required this.studentlist,this.searchlist});
}

class HomeBlocInitial extends HomeBlocState {
  HomeBlocInitial({required super.studentlist});
}
