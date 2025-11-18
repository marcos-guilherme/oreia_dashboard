import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noise_guard_app/bloc/navigation_bloc.dart';
import 'package:noise_guard_app/features/dashboard/widgets/main_content.dart';
import 'package:noise_guard_app/features/dashboard/widgets/side_menu.dart';
import 'package:noise_guard_app/features/sensor_map/screens/sensor_map_screen.dart';


// 1. Convertido DE VOLTA para StatelessWidget
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  // 2. Método helper (agora pode ser estático ou fora da classe)
  //    para escolher qual tela exibir
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
    // 3. Fornecemos o NavigationBloc para esta tela e seus filhos (SideMenu)
    return BlocProvider(
      create: (context) => NavigationBloc(),
      child: Scaffold(
        body: Row(
          children: [
            // 4. Usamos um BlocBuilder para obter o índice atual
            //    e passá-lo para o SideMenu
            BlocBuilder<NavigationBloc, NavigationState>(
              // O buildWhen otimiza para reconstruir o SideMenu
              // apenas se o índice realmente mudar
              buildWhen: (previous, current) => 
                  previous.selectedIndex != current.selectedIndex,
              builder: (context, state) {
                return SideMenu(
                  selectedIndex: state.selectedIndex,
                  
                  // 5. O onTapped agora é muito mais simples.
                  //    Ele apenas adiciona um evento ao BLoC.
                  //    O SideMenu nem precisa saber o que vai acontecer.
                  onTapped: (index) {
                    context.read<NavigationBloc>().add(NavigationTabChanged(index));
                  },
                );
              },
            ),
            Expanded(
              // 6. Usamos um BlocBuilder para trocar a página principal
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