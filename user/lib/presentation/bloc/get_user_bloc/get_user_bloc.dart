import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/Search_users.dart';
import '../../../domain/usecases/get_users.dart';
import 'get_user_event.dart';
import 'get_user_state.dart';

class GetUserBloc extends Bloc<GetUserEvent, GetUserState> {
  final GetUsers _getUsers;
  final SearchUsers _searchUsers;

  GetUserBloc(this._getUsers, this._searchUsers) : super(GetUserEmpty()) {
    on<OnGetUser>((event, emit) async {
      emit(GetUserLoading());
      final result = await _getUsers.execute();

      result.fold(
        (failure) {
          emit(GetUserError(failure.message));
        },
        (data) {
          emit(GetUserHasData(data));
        },
      );
    });

    on<OnSearchUser>((event, emit) async {
      final query = event.query;
      emit(GetUserLoading());
      final result = await _searchUsers.execute(query);

      result.fold(
            (failure) {
          emit(GetUserError(failure.message));
        },
            (data) {
          emit(GetUserHasData(data));
        },
      );
    });
  }
}
