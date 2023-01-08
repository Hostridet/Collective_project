import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'soil_sorts_event.dart';
part 'soil_sorts_state.dart';

class SoilSortsBloc extends Bloc<SoilSortsEvent, SoilSortsState> {
  SoilSortsBloc() : super(SoilSortsInitial()) {
    on<SoilSortsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
