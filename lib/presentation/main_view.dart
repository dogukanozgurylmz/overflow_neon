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
    var size = MediaQuery.sizeOf(context);
    var selectedIndex = context.watch<SidebarProvider>().selectedIndex;
    return Scaffold(
      appBar: const Header(),
      bottomNavigationBar:
          Responsive.isExtraSmall(context) || Responsive.isSmall(context)
              ? BottomNavBar(selectedIndex: selectedIndex)
              : size.height < 500
                  ? BottomNavBar(selectedIndex: selectedIndex)
                  : null,
      body: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                size.height < 500
                    ? const SizedBox.shrink()
                    : Responsive.isSmall(context) ||
                            Responsive.isExtraSmall(context)
                        ? const SizedBox.shrink()
                        : const Sidebar(),
                Consumer<SidebarProvider>(
                  builder: (context, value, child) {
                    var getStatus = context.watch<SidebarProvider>().getStatus;
                    if (getStatus == SidebarStatus.home) {
                      return HomeView();
                    } else if (getStatus == SidebarStatus.categories) {
                      return CategoriesView();
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

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    super.key,
    required this.selectedIndex,
  });

  final int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: (value) {
        context.read<SidebarProvider>().setSelectedIndex(value);
        context.read<SidebarProvider>().setStatus(SidebarStatus.values[value]);
      },
      elevation: 0,
      backgroundColor: const Color(0xFF202020),
      unselectedItemColor: Colors.grey,
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: true,
      showUnselectedLabels: false,
      currentIndex: selectedIndex ?? 0,
      selectedFontSize: 12,
      selectedLabelStyle: const TextStyle(
        color: Colors.white,
      ),
      selectedItemColor: Colors.white,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(
            icon: Icon(Icons.category_outlined), label: "Categories"),
        BottomNavigationBarItem(
            icon: Icon(Icons.notifications_none_outlined),
            label: "Notifications"),
        BottomNavigationBarItem(
            icon: Icon(Icons.bookmark_border_outlined), label: "Favorites"),
        BottomNavigationBarItem(
            icon: Icon(Icons.question_mark_sharp), label: "My Questions"),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings"),
      ],
    );
  }
}
