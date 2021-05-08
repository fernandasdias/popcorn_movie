part of 'show_bloc.dart';

abstract class ShowState extends Equatable {
  const ShowState();

  @override
  List<Object> get props => [];
}

class ShowInitial extends ShowState {}

class IndexLoadedState extends ShowState {}

class FailureState extends ShowState {}
