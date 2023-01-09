import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../models/Soil.dart';
import '../../repository/SoilRepository.dart';

part 'soil_sorts_event.dart';
part 'soil_sorts_state.dart';

class SoilSortsBloc extends Bloc<SoilSortsEvent, SoilSortsState> {
  SoilRepository _soilRepository;
  SoilSortsBloc(this._soilRepository) : super(SoilSortsInitial()) {
    on<SoilGetEvent>((event, emit) async {
      emit(SoilLoadingState());
      List<Soil> soilList = await _soilRepository.getAllSoils();
      soilList != []
          ? emit(SoilLoadedState(soilList))
          : emit(SoilErrorState("Список почв пуст"));
    });
    on<SoilDeleteEvent>((event, emit) async {
      _soilRepository.deleteSoil(event.soil);
      add(SoilGetEvent());
    });
  }
}
