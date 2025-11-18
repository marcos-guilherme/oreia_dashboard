part of 'navigation_bloc.dart';

// O estado simplesmente guarda o índice atual
class NavigationState extends Equatable {
  final int selectedIndex;
  const NavigationState(this.selectedIndex);
  
  @override
  List<Object> get props => [selectedIndex];
}