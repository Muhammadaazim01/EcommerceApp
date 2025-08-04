import 'package:flutter/material.dart';

class ExpandableText extends StatefulWidget {
  final String text;
  final int trimLines;

  const ExpandableText({Key? key, required this.text, this.trimLines = 5})
    : super(key: key);

  @override
  _ExpandableTextState createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final span = TextSpan(text: widget.text);
    final tp = TextPainter(
      text: span,
      maxLines: widget.trimLines,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: MediaQuery.of(context).size.width);

    final isOverflow = tp.didExceedMaxLines;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.text,
          maxLines: isExpanded ? null : widget.trimLines,
          overflow: isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
          style: const TextStyle(color: Colors.grey),
        ),
        if (isOverflow)
          GestureDetector(
            onTap: () => setState(() => isExpanded = !isExpanded),
            child: Text(
              isExpanded ? 'Show less' : 'Show more',
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
      ],
    );
  }
}
