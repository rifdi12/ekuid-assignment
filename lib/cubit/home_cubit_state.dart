part of 'home_cubit_cubit.dart';

@immutable
abstract class HomeCubitState extends Equatable {
  const HomeCubitState();
}

class HomeCubitInitial extends HomeCubitState {
  HomeCubitInitial();

  @override
  List<Object> get props => [];
}

class HomeCubitSuccessAdd extends HomeCubitState {
  HomeCubitSuccessAdd();

  @override
  List<Object> get props => [];
}

class HomeCubitSuccessDelete extends HomeCubitState {
  HomeCubitSuccessDelete();

  @override
  List<Object> get props => [];
}

class HomeCubitSuccessUpdate extends HomeCubitState {
  HomeCubitSuccessUpdate();

  @override
  List<Object> get props => [];
}

class HomeCubitError extends HomeCubitState {
  final String error;
  HomeCubitError(this.error);

  @override
  List<Object> get props => [error];
}

class HomeCubitLoading extends HomeCubitState {
  HomeCubitLoading();

  @override
  List<Object> get props => [];
}

class HomeCubitButtonLoading extends HomeCubitState {
  HomeCubitButtonLoading();

  @override
  List<Object> get props => [];
}

class HomeCubitLoaded extends HomeCubitState {
  final List<StudentsModel> data;

  HomeCubitLoaded(this.data);

  @override
  List<Object> get props => [data];
}
