import 'package:flutter/material.dart';
import 'package:noise_guard_app/core/theme/app_colors.dart';

// Um widget para a tabela com a lista de sensores
class SensorListTable extends StatelessWidget {
  const SensorListTable({super.key});

  DataRow _buildSensorRow(
      String id, String local, double nivel, String status) {
    Color statusColor;
    if (status == 'Online') {
      statusColor = DashboardColors.green;
    } else if (status == 'Offline') {
      statusColor = DashboardColors.red;
    } else {
      statusColor = DashboardColors.subText;
    }

    return DataRow(
      cells: [
        DataCell(Text(id, style: const TextStyle(fontWeight: FontWeight.bold))),
        DataCell(Text(local)),
        DataCell(Text('${nivel.toStringAsFixed(1)} dB')),
        DataCell(
          Row(
            children: [
              Icon(Icons.circle, size: 10, color: statusColor),
              const SizedBox(width: 5),
              Text(status),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      color: DashboardColors.cardBackground,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Lista de Sensores',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: DataTable(
                headingRowHeight: 40,
                headingTextStyle: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(fontWeight: FontWeight.bold),
                columns: const [
                  DataColumn(label: Text('ID')),
                  DataColumn(label: Text('Localização')),
                  DataColumn(label: Text('Nível')),
                  DataColumn(label: Text('Status')),
                ],
                rows: [
                  // Dados mockados (estáticos)
                  _buildSensorRow('S-01', 'Praça de Alimentação', 72.3, 'Online'),
                  _buildSensorRow('S-02', 'Entrada Principal', 61.5, 'Online'),
                  _buildSensorRow('S-03', 'Corredor Central', 58.0, 'Online'),
                  _buildSensorRow('S-04', 'Loja A', 60.1, 'Online'),
                  _buildSensorRow('S-05', 'Garagem B1', 55.4, 'Online'),
                  _buildSensorRow('S-06', 'Administração', 52.0, 'Offline'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
