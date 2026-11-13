import 'package:flutter/material.dart';

class BotonVolver extends StatelessWidget {
  const BotonVolver({super.key, this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed ?? () => Navigator.of(context).maybePop(),
      tooltip: 'Volver',
      icon: const Icon(Icons.arrow_back),
    );
  }
}
