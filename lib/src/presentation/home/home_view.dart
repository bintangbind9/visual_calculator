import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../common/constant/app_color.dart';
import '../../common/util/extension/build_context_extension.dart';
import '../../router/routes.dart';
import '../bloc/main_color_index/main_color_index_bloc.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.local.appTitle),
        actions: [
          IconButton(
            onPressed: () =>
                context.read<MainColorIndexBloc>().add(UpdateMainColorIndex()),
            icon: BlocBuilder<MainColorIndexBloc, int>(
              builder: (context, index) {
                return Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: AppColor.mainColors[index],
                    shape: BoxShape.circle,
                  ),
                );
              },
            ),
          ),
          IconButton(
            onPressed: () => context.goNamed(Routes.settings),
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: Container(),
    );
  }
}
