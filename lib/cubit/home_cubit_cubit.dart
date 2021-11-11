import 'package:bloc/bloc.dart';
import 'package:ekuid_assignment/helper/graphql_helper.dart';
import 'package:ekuid_assignment/model/students_model.dart';
import 'package:graphql/client.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

part 'home_cubit_state.dart';

class HomeCubit extends Cubit<HomeCubitState> {
  HomeCubit() : super(HomeCubitInitial());

  void getData() async {
    emit(HomeCubitLoading());
    QueryResult result = await readStudent();
    List<StudentsModel> listModel = [];
    for (var item in result.data!['persons']) {
      StudentsModel model = StudentsModel.fromJson(item);
      listModel.add(model);
    }
    emit(HomeCubitLoaded(listModel));
  }

  void addData({age, id, lastName, name}) async {
    emit(HomeCubitButtonLoading());
    try {
      QueryResult result =
          await addStudent(age: age, id: id, lastName: lastName, name: name);
      if (result.data!['addPerson']['id'] == null)
        emit(HomeCubitError('ID sudah digunakan'));
      else
        emit(HomeCubitSuccessAdd());
    } catch (e) {
      emit(HomeCubitError('Error menambahkan data'));
    }
  }

  void editData({age, id, lastName, name}) async {
    emit(HomeCubitButtonLoading());
    try {
      QueryResult result =
          await editStudent(age: age, id: id, lastName: lastName, name: name);
      if (result.data!['editPerson']['id'] == null)
        emit(HomeCubitError('ID sudah digunakan'));
      else
        emit(HomeCubitSuccessAdd());
    } catch (e) {
      emit(HomeCubitError('Error menambahkan data'));
    }
  }

  void deleteData(id) async {
    emit(HomeCubitLoading());
    try {
      QueryResult result = await deleteStudent(id: id);
      print(result);
      if (result.data!['deletePerson']['id'] == null)
        emit(HomeCubitSuccessDelete());
    } catch (e) {
      print(e);
      emit(HomeCubitError('Error menghapus data'));
    }
  }
}
