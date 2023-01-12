part of 'classifier_bloc.dart';

@immutable
abstract class ClassifierEvent {}

class ClassifierGetSoils extends ClassifierEvent {}

class ClassifierClassify extends ClassifierEvent {}
