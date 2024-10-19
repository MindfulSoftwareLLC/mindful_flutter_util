import 'package:flutter/widgets.dart';
import 'package:pluto_grid_plus/pluto_grid_plus.dart';

/// A functon that builds Pluto Rows
typedef RowsBuilder<T> = List<PlutoRow> Function(List<T> data);

/// Creates a PlutoGrid from a list of data rows and the Pluto configs
/// Used by both PlutoGridBuilder and PlutoRiverPodGridBuilder
Widget createPlutoGrid<T>({
  required List<T> data,
  required RowsBuilder<T> rowsBuilder,
  required List<PlutoColumn> columns,
  Widget? noRowsWidget,
  PlutoGridConfiguration? plutoGridConfiguration,
}) {
  final rows = rowsBuilder(data);
  return PlutoGrid(
    key: ObjectKey(rows),
    noRowsWidget: noRowsWidget ?? const SizedBox.shrink(),
    columns: columns,
    rows: rows,
    configuration: plutoGridConfiguration ?? const PlutoGridConfiguration(),
  );
}
