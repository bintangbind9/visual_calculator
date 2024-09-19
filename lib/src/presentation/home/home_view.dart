import 'package:flutter/material.dart';
import '../../common/util/extension/build_context_extension.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.local.appTitle),
      ),
      body: Container(),
    );
  }
}
