import 'package:flutter/material.dart';
import 'package:noise_guard_app/core/theme/app_colors.dart';

// --- WIDGETS DO MENU LATERAL (AGORA INTERATIVO) ---
class SideMenu extends StatelessWidget {
  // 1. Novos parâmetros para estado e callback
  final int selectedIndex;
  final ValueChanged<int> onTapped;

  const SideMenu({
    super.key,
    required this.selectedIndex,
    required this.onTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260,
      color: DashboardColors.primaryBlue,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Logo e Título (sem alteração)
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.shield_outlined,
                      color: DashboardColors.primaryBlue, size: 24),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'OreIA',
                      style: TextStyle(
                        color: DashboardColors.whiteText,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      'Monitoramento de Ruído',
                      style: TextStyle(
                        color: DashboardColors.lightText,
                        fontSize: 12,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          // Seção PRINCIPAL
          _buildSectionTitle('PRINCIPAL'),
          // 2. Itens do menu agora usam 'selectedIndex' e 'onTapped'
          _buildMenuItem(
            icon: Icons.bar_chart_rounded,
            text: 'Painel',
            isSelected: selectedIndex == 0,
            onTap: () => onTapped(0),
          ),
          _buildMenuItem(
            icon: Icons.map_outlined,
            text: 'Mapa de Sensores',
            isSelected: selectedIndex == 1,
            onTap: () => onTapped(1),
          ),
          _buildMenuItem(
            icon: Icons.warning_amber_rounded,
            text: 'Alertas',
            isSelected: selectedIndex == 2,
            onTap: () => onTapped(2),
          ),
          _buildMenuItem(
            icon: Icons.description_outlined,
            text: 'Relatórios',
            isSelected: selectedIndex == 3,
            onTap: () => onTapped(3),
          ),
          const SizedBox(height: 20),
          // Seção CONFIGURAÇÕES
          _buildSectionTitle('CONFIGURAÇÕES'),
          _buildMenuItem(
            icon: Icons.settings_outlined,
            text: 'Configuração',
            isSelected: selectedIndex == 4,
            onTap: () => onTapped(4),
          ),
          _buildMenuItem(
            icon: Icons.people_outline,
            text: 'Usuários',
            isSelected: selectedIndex == 5,
            onTap: () => onTapped(5),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 10),
      child: Text(
        title,
        style: const TextStyle(
          color: DashboardColors.lightText,
          fontSize: 12,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.1,
        ),
      ),
    );
  }

  // 3. _buildMenuItem agora aceita um VoidCallback 'onTap'
  Widget _buildMenuItem({
    required IconData icon,
    required String text,
    bool isSelected = false,
    VoidCallback? onTap, // Adicionado
  }) {
    final color =
        isSelected ? DashboardColors.whiteText : DashboardColors.lightText;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: isSelected ? DashboardColors.selectedMenuBlue : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        leading: Icon(icon, color: color),
        title: Text(
          text,
          style: TextStyle(
            color: color,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        hoverColor: DashboardColors.selectedMenuBlue.withOpacity(0.5),
        onTap: onTap, // Atribuído aqui
      ),
    );
  }
}

