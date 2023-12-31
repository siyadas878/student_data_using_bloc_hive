import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_details_hive_bloc/infrastructure/functions.dart';

import '../../domain/student_model.dart';
part 'home_bloc_event.dart';
part 'home_bloc_state.dart';

class HomeBlocBloc extends Bloc<HomeBlocEvent, HomeBlocState> {
  HomeBlocBloc() : super(HomeBlocInitial(studentlist: [])) {
    
    on<AddStudent>((event, emit) {
      List<StudentModel> value=  studentDbAdd(data: event.data, studentlist: state.studentlist);
      return emit(HomeBlocState(studentlist: value));
    });

    on<StudentRemove>((event, emit) async {
      List<StudentModel> value = studentDbDelete(
          data: event.data, studentlist: state.studentlist);
          // await Future.delayed(const Duration(seconds: 3));
      return emit(HomeBlocState(studentlist: value));
    });

    on<StudentGetAll>((event, emit) async {
      List<StudentModel> value = await getalldata();
      return emit(HomeBlocState(studentlist: value));
    });



  }
}
