import 'package:flutter/material.dart';

/// ویجت فیلد جستجو
class SearchBox extends StatefulWidget {
  final ValueChanged<String>? onChanged;

  const SearchBox({super.key, this.onChanged});

  @override
  State<SearchBox> createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(
            Icons.search,
            color: _isFocused
                ? colors.primary
                : colors.onSurface.withOpacity(0.7),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              focusNode: _focusNode,
              textDirection: TextDirection.rtl,
              onChanged: widget.onChanged,
              cursorColor: colors.primary,
              decoration: InputDecoration(
                hintText: 'جستجو ...',
                hintStyle: TextStyle(
                  fontFamily: 'Yekan',
                  color: colors.onBackground.withOpacity(0.5),
                  fontWeight: FontWeight.w300,
                ),
                border: InputBorder.none,
              ),
              style: TextStyle(fontFamily: 'Yekan', color: colors.onBackground),
            ),
          ),
        ],
      ),
    );
  }
}
