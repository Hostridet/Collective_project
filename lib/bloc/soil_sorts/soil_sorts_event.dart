part of 'soil_sorts_bloc.dart';

@immutable
abstract class SoilSortsEvent {}

class SoilGetEvent extends SoilSortsEvent {}

class SoilDeleteEvent extends SoilSortsEvent {
  final Soil soil;

  SoilDeleteEvent(this.soil);
}
