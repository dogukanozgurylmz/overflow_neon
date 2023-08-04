import 'package:flutter/material.dart';
import 'package:neon_overflow/core/responsive.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Container(
      height: 70,
      width: Responsive.isMobile(context) ? size.width : size.width - 270,
      decoration: const BoxDecoration(
        color: Color(0xff202020),
      ),
      child: Row(
        children: [
          Responsive.isMobile(context)
              ? IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.menu,
                    color: Color(0xffFAFAFA),
                  ),
                )
              : const SizedBox.shrink(),
          Responsive.isMobile(context)
              ? const Text.rich(
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
                )
              : const SizedBox.shrink(),
          Expanded(
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
          const CircleAvatar(),
        ],
      ),
    );
  }
}
