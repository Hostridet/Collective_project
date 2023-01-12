import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../models/Soil.dart';
import '../../repository/ClassifierRepository.dart';

part 'classifier_event.dart';
part 'classifier_state.dart';

class ClassifierBloc extends Bloc<ClassifierEvent, ClassifierState> {
  final ClassifierRepository _classifierRepository;
  ClassifierBloc(this._classifierRepository) : super(ClassifierInitial()) {
    on<ClassifierGetSoils>((event, emit) async {
      List<Soil> soilList = await _classifierRepository.getAllSoils();
      emit(ClassifierLoadedState(soilList));
    });

    on<ClassifierClassify>((event, emit) async {
      emit(ClassifierDoneState());
    });
  }

}
