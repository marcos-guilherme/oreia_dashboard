part of 'navigation_bloc.dart';

abstract class NavigationEvent extends Equatable {
  const NavigationEvent();
  @override
  List<Object> get props => [];
}

// Evento disparado quando o usuário clica em um item do menu
class NavigationTabChanged extends NavigationEvent {
  final int index;
  const NavigationTabChanged(this.index);
  @override
  List<Object> get props => [index];
}