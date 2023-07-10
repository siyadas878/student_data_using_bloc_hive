import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/student_model.dart';
import '../../infrastructure/functions.dart';
part 'update_event.dart';
part 'update_state.dart';

class UpdateBloc extends Bloc<UpdateEvent, UpdateState> {
  UpdateBloc() : super(UpdateInitial(studentlist: [])) {
       on<StudentEdit>((event, emit)async {
      List<StudentModel> value =await update(key: event.key,
          data: event.data,
          studentlist: state.studentlist,
          editingindex: event.editingindex);
      return emit(UpdateState(studentlist: value));
    });
  }
}
