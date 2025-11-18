import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'navigation_event.dart';
part 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(const NavigationState(0)) { // Estado inicial: índice 0
    
    // Quando o evento TabChanged ocorrer...
    on<NavigationTabChanged>((event, emit) {
      // ...emita um novo estado com o novo índice
      emit(NavigationState(event.index));
    });
  }
}