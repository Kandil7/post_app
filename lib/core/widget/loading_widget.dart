import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      alignment: Alignment.center,
      child: LoadingAnimationWidget.dotsTriangle(
        size: 50,
        color: Theme.of(context).primaryColor,
      ),
    );
  }
}
