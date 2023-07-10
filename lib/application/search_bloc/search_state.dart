part of 'search_bloc.dart';

class SearchState {
     List<StudentModel> studentlist;
   List<StudentModel>? searchlist;
  SearchState({required this.studentlist,this.searchlist});
}

class SearchInitial extends SearchState {
  SearchInitial({required super.studentlist});
}
