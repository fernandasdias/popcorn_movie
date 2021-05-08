part of 'show_bloc.dart';

abstract class ShowEvent extends Equatable {
  const ShowEvent();

  @override
  List<Object> get props => [];
}

class ShowIndexEvent extends ShowEvent {}

class SearchShowEvent extends ShowEvent {
  final String search;

  SearchShowEvent(this.search);
}

class ClearSearchShowEvent extends ShowEvent {}

class GetDetailShowEvent extends ShowEvent {}
