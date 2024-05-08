import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../../mindful_flutter_util.dart';

/// A widget that builds a PlutoGrid based on the Pluto configurations
class PlutoRiverpodGridBuilder<T> extends ConsumerStatefulWidget {
  /// Constructor that takes riverpod data
  const PlutoRiverpodGridBuilder({
    super.key,
    required this.asyncData,
    required this.columns,
    required this.rowsBuilder,
    this.noRowsWidget = const SizedBox.shrink(),
    this.plutoGridConfiguration = const PlutoGridConfiguration(),
    this.error,
    this.loading,
  });

  /// Async Riverpod data
  final AsyncValue<List<T>> asyncData;

  /// Pluto column config
  final List<PlutoColumn> columns;

  /// functon that builds PlutoRows
  final RowsBuilder<T> rowsBuilder;

  /// The pluto grid config, the default is used if not specified
  final PlutoGridConfiguration plutoGridConfiguration;

  /// Widget to display when there are no rows, an empty widget without size
  final Widget noRowsWidget;

  /// Typical Riverpod error widget, default shows the error in the grid
  final Widget Function(Object error, StackTrace stackTrace)? error;

  /// Typical Riverpod Loading function
  final Widget Function()? loading;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _GridBuilderState<T>();
  }
}

class _GridBuilderState<T> extends ConsumerState<PlutoRiverpodGridBuilder<T>> {
  @override
  Widget build(BuildContext context) {
    return widget.asyncData.when(
      error: widget.error ?? (error, stack) => ErrorWidget(error),
      loading: widget.loading ?? () => const ListTileShimmer(),
      data: (data) {
        return createPlutoGrid<T>(
          data: data,
          rowsBuilder: widget.rowsBuilder,
          columns: widget.columns,
          noRowsWidget: widget.noRowsWidget,
          plutoGridConfiguration: widget.plutoGridConfiguration,
        );
      },
    );
  }
}
