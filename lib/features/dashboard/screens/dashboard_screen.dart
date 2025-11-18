import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noise_guard_app/bloc/navigation_bloc.dart';
import 'package:noise_guard_app/features/dashboard/widgets/main_content.dart';
import 'package:noise_guard_app/features/dashboard/widgets/side_menu.dart';
import 'package:noise_guard_app/features/sensor_map/screens/sensor_map_screen.dart';


class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  Widget _buildSelectedPage(int index) {
    switch (index) {
      case 0: // Painel
        return const MainContent();
      case 1: // Mapa de Sensores
        return const SensorMapScreen();
      case 2: // Alertas (Placeholder)
        return const Center(child: Text("Tela de Alertas"));
      case 3: // Relatórios (Placeholder)
        return const Center(child: Text("Tela de Relatórios"));
      default:
        return const MainContent();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NavigationBloc(),
      child: Scaffold(
        body: Row(
          children: [

            BlocBuilder<NavigationBloc, NavigationState>(

              buildWhen: (previous, current) => 
                  previous.selectedIndex != current.selectedIndex,
              builder: (context, state) {
                return SideMenu(
                  selectedIndex: state.selectedIndex,
                  
                  onTapped: (index) {
                    context.read<NavigationBloc>().add(NavigationTabChanged(index));
                  },
                );
              },
            ),
            Expanded(
              child: BlocBuilder<NavigationBloc, NavigationState>(
                builder: (context, state) {
                  // Exibe a tela com base no índice do estado do BLoC
                  return _buildSelectedPage(state.selectedIndex);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}