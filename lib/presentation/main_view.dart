import 'package:flutter/material.dart';
import 'package:neon_overflow/presentation/widgets/header/header.dart';
import 'package:neon_overflow/presentation/widgets/sidebar/sidebar.dart';
import 'package:provider/provider.dart';

import '../core/responsive.dart';
import 'categories/categories_view.dart';
import 'home/home_view.dart';
import 'widgets/sidebar/sidebar_provider.dart';

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Header(),
      drawer: Responsive.isExtraSmall(context) || Responsive.isSmall(context)
          ? const Sidebar()
          : null,
      body: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Responsive.isSmall(context) || Responsive.isExtraSmall(context)
                    ? const SizedBox.shrink()
                    : const Sidebar(),
                Consumer<SidebarProvider>(
                  builder: (context, value, child) {
                    var getStatus = context.watch<SidebarProvider>().getStatus;
                    if (getStatus == SidebarStatus.home) {
                      return HomeView();
                    } else if (getStatus == SidebarStatus.categories) {
                      return const CategoriesView();
                    } else if (getStatus == SidebarStatus.notifications) {
                      return const Text("notification");
                    } else if (getStatus == SidebarStatus.favorites) {
                      return const Text("favorites");
                    } else if (getStatus == SidebarStatus.myquestions) {
                      return const Text("myquestions");
                    } else if (getStatus == SidebarStatus.settings) {
                      return const Text("settings");
                    } else {
                      return const Text("Default Data");
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
