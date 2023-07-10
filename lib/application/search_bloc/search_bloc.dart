import 'package:bloc/bloc.dart';

import '../../domain/student_model.dart';
import '../../infrastructure/functions.dart';
part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitial(studentlist: [])) {
   
    on<InitialState>((event, emit) async{
      List<StudentModel> value=await getalldata();
      return emit(SearchState(studentlist: value));
    });
  
      on<StudentSearch>((event, emit) {
      state.searchlist = searchdata(event.query, state.studentlist);
      return emit(SearchState(
          studentlist: state.studentlist, searchlist: state.searchlist));
    });
  }
}
