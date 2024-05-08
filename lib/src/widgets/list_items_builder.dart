import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../mindful_flutter_util.dart';

typedef ItemWidgetBuilder<T> = Widget Function(BuildContext context, T item);

class ListItemsBuilder<T> extends StatelessWidget {
  const ListItemsBuilder({
    Key? key,
    required this.data,
    required this.itemBuilder,
    required this.itemName,
  }) : super(key: key);
  final AsyncValue<List<T>> data;
  final ItemWidgetBuilder<T> itemBuilder;
  final String itemName;

  @override
  Widget build(BuildContext context) {
    return data.when(
      data: (items) {
        print('Rebuilding list items builder');
        return items.isNotEmpty
            ? ListView.separated(
                itemCount: items.length + 2,
                separatorBuilder: (context, index) =>
                    const Divider(height: 0.5),
                itemBuilder: (context, index) {
                  if (index == 0 || index == items.length + 1) {
                    return const SizedBox.shrink();
                  }
                  return itemBuilder(context, items[index - 1]);
                },
              )
            : EmptyContent(
                message: 'Add a new $itemName to get started',
              );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (_, __) => const EmptyContent(
        title: 'Something went wrong',
        message: 'Can\'t load items right now',
      ),
    );
  }
}
