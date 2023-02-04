import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user/domain/usecases/add_user.dart';
import 'package:user/domain/usecases/edit_user.dart';
import '../../../domain/usecases/delete_user.dart';
import 'crud_user_event.dart';
import 'crud_user_state.dart';

class CrudUserBloc extends Bloc<CrudUserEvent, CrudUserState> {
  final AddUser _addUser;
  final EditUser _editUser;
  final DeleteUser _deleteUser;

  CrudUserBloc(this._addUser, this._editUser, this._deleteUser) : super(CrudUserEmpty()) {
    on<OnAddUser>((event, emit) async {
      final user = event.user;
      emit(CrudUserLoading());
      final result = await _addUser.execute(user);

      result.fold(
        (failure) {
          emit(CrudUserError(failure.message));
        },
        (data) {
          emit(CrudUserHasData(data));
        },
      );
    });

    on<OnEditUser>((event, emit) async {
      final user = event.user;
      emit(CrudUserLoading());
      final result = await _editUser.execute(user);

      result.fold(
            (failure) {
          emit(CrudUserError(failure.message));
        },
            (data) {
          emit(CrudUserHasData(data));
        },
      );
    });
    on<OnDeleteUser>((event, emit) async {
      final id = event.id;
      emit(CrudUserLoading());
      final result = await _deleteUser.execute(id);

      result.fold(
            (failure) {
          emit(CrudUserError(failure.message));
        },
            (data) {
          emit(CrudUserHasData(data));
        },
      );
    });
  }
}
