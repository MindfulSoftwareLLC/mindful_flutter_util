import 'package:flutter/material.dart';

class GridActionCellWidgets extends StatelessWidget {
  const GridActionCellWidgets(
      {super.key,
      required this.onEditPressed,
      required this.onDeletePressed,
      required this.overflowTextWhatIsThis});

  final Future<Null> Function() onEditPressed;
  final Future<Null> Function() onDeletePressed;
  final String overflowTextWhatIsThis;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: const Icon(
            Icons.edit,
          ),
          onPressed: onEditPressed,
          iconSize: 18,
          color: Colors.green,
          padding: const EdgeInsets.all(0),
        ),
        IconButton(
          icon: const Icon(
            Icons.delete,
          ),
          onPressed: onDeletePressed,
          iconSize: 18,
          color: Colors.redAccent,
          padding: const EdgeInsets.all(0),
        ),
        Expanded(
          child: Text(
            overflowTextWhatIsThis,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
