import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
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
      final prefs = await SharedPreferences.getInstance();
      emit(SoilLoadingState());
      String role = prefs.getString("role")!;
      List<Soil> soilList = await _soilRepository.getAllSoils();
      if (role == "admin") {
        soilList != []
            ? emit(SoilLoadedAdminState(soilList, await _soilRepository.getCount()))
            : emit(SoilErrorState("Список почв пуст"));
      }
      else {
        soilList != []
            ? emit(SoilLoadedState(soilList, await _soilRepository.getCount()))
            : emit(SoilErrorState("Список почв пуст"));
      }
    });
    on<SoilDeleteEvent>((event, emit) async {
      _soilRepository.deleteSoil(event.soil);
      add(SoilGetEvent());
    });
  }
}
