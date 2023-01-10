part of 'soil_sorts_bloc.dart';

@immutable
abstract class SoilSortsState {}

class SoilSortsInitial extends SoilSortsState {}

class SoilLoadingState extends SoilSortsState {}

class SoilLoadedState extends SoilSortsState {
  final List<Soil> soilList;
  final int count;
  SoilLoadedState(this.soilList, this.count);
}

class SoilLoadedAdminState extends SoilSortsState {
  final List<Soil> soilList;
  final int count;

  SoilLoadedAdminState(this.soilList, this.count);
}

class SoilErrorState extends SoilSortsState {
  final String error;

  SoilErrorState(this.error);
}