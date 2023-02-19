import 'package:equatable/equatable.dart';

class SearchProductEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class SearchEvent extends SearchProductEvent {
  final String searchPattern;
  final int limit;

  SearchEvent({required this.limit, required this.searchPattern});
}

class DataLoadedEvent extends SearchProductEvent {}
