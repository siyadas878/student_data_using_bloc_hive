part of 'search_bloc.dart';

class SearchEvent {}

class InitialState extends SearchEvent{}

class StudentSearch extends SearchEvent {
  String query;
  StudentSearch({required this.query});
}