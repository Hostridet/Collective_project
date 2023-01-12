part of 'classifier_bloc.dart';

@immutable
abstract class ClassifierState {}

class ClassifierInitial extends ClassifierState {}

class ClassifierLoadedState extends ClassifierState {
  final List<Soil> soilList;

  ClassifierLoadedState(this.soilList);
}

class ClassifierDoneState extends ClassifierState {}
