import 'package:flutter/material.dart';
import 'package:neon_overflow/core/responsive.dart';

class Header extends StatelessWidget implements PreferredSizeWidget {
  const Header({super.key});
  bool iconSidebarResponsive(context) {
    var result = Responsive.isMedium(context) || Responsive.isLarge(context);
    if (!result) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      actions: [
        Responsive.isExtraSmall(context) || Responsive.isSmall(context)
            ? const SizedBox.shrink()
            : SizedBox(
                width: Responsive.isSmall(context) ? size.width * 0.4 : 300,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none,
                        ),
                        fillColor: const Color(0xffFAFAFA).withOpacity(0.08),
                        filled: true,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 16),
                        hintText: "Search",
                        isDense: true,
                        hintStyle: const TextStyle(
                          color: Color(0xff8E8E8E),
                        )),
                  ),
                ),
              ),
        const SizedBox(width: 8),
        Container(
          margin: const EdgeInsets.all(8),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: const Color(0xfffafafa).withOpacity(0.1),
          ),
          child: const Row(
            children: [
              Text(
                "5",
                style: TextStyle(
                  color: Colors.amber,
                ),
              ),
              SizedBox(width: 4),
              Icon(
                Icons.circle,
                color: Colors.amber,
                size: 12,
              )
            ],
          ),
        ),
        const SizedBox(width: 8),
        Padding(
          padding: EdgeInsets.only(right: Responsive.isSmall(context) ? 8 : 25),
          child: const CircleAvatar(),
        ),
      ],
      backgroundColor: const Color(0xff202020),
      title: const Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: 'neon',
              style: TextStyle(
                color: Color(0xFF7D00AA),
                fontSize: 20,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w700,
              ),
            ),
            TextSpan(
              text: ' overflow',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
