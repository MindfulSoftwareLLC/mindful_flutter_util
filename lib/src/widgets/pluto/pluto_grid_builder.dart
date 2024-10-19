import 'package:flutter/material.dart';
import 'package:pluto_grid_plus/pluto_grid_plus.dart';

import '../../../mindful_flutter_util.dart';

/// Builds a PlutoGrid from Pluto objects
class PlutoGridBuilder<T> extends StatefulWidget {
  /// Builds a PlutoGrid widget from the configs
  const PlutoGridBuilder({
    super.key,
    required this.data,
    required this.columns,
    required this.rowsBuilder,
    this.noRowsWidget = const SizedBox.shrink(),
    this.plutoGridConfiguration = const PlutoGridConfiguration(),
  });

  /// Pluto column config
  final List<PlutoColumn> columns;

  /// functon that builds PlutoRows
  final RowsBuilder<T> rowsBuilder;

  /// The pluto grid config, the default is used if not specified
  final PlutoGridConfiguration plutoGridConfiguration;

  /// The table data
  final List<T> data;

  /// Widget to display when there are no rows, an empty widget without size
  final Widget noRowsWidget;

  @override
  State<StatefulWidget> createState() {
    return _GridBuilderState<T>();
  }
}

class _GridBuilderState<T> extends State<PlutoGridBuilder<T>> {
  @override
  Widget build(BuildContext context) {
    return createPlutoGrid<T>(
      data: widget.data,
      rowsBuilder: widget.rowsBuilder,
      columns: widget.columns,
      noRowsWidget: widget.noRowsWidget,
      plutoGridConfiguration: widget.plutoGridConfiguration,
    );
  }
}
