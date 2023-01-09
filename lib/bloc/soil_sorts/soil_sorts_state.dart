part of 'soil_sorts_bloc.dart';

@immutable
abstract class SoilSortsState {}

class SoilSortsInitial extends SoilSortsState {}

class SoilLoadingState extends SoilSortsState {}

class SoilLoadedState extends SoilSortsState {
  final List<Soil> soilList;

  SoilLoadedState(this.soilList);
}

class SoilErrorState extends SoilSortsState {
  final String error;

  SoilErrorState(this.error);
}