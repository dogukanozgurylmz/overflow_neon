import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neon_overflow/core/responsive.dart';
import 'package:neon_overflow/data/repository/category_repository.dart';
import 'package:neon_overflow/presentation/categories/cubit/categories_cubit.dart';

class CategoriesView extends StatelessWidget {
  final CategoryRepository _categoryRepository = CategoryRepository();
  CategoriesView({super.key});

  int gridResponsive(context) {
    var result1 =
        Responsive.isExtraSmall(context) || Responsive.isSmall(context);
    var result2 = Responsive.isMedium(context) || Responsive.isLarge(context);
    if (result1) {
      return 1;
    }
    if (result2) {
      return 2;
    }
    return 3;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CategoriesCubit(
        categoryRepository: _categoryRepository,
      ),
      child: BlocBuilder<CategoriesCubit, CategoriesState>(
        builder: (context, state) {
          return Expanded(
            child: GridView.builder(
              padding: EdgeInsets.only(
                  left: 8,
                  top: 8,
                  right: Responsive.isXXLarge(context) ? 200 : 8,
                  bottom: 8),
              shrinkWrap: true,
              itemCount: state.categories.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: Responsive.isExtraSmall(context) ||
                        Responsive.isSmall(context)
                    ? 4 / 1
                    : 2 / 1,
                crossAxisCount: gridResponsive(context),
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemBuilder: (context, index) {
                var category = state.categories[index];
                return Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://picsum.photos/2${index}00"),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                      child: Container(
                        color: Colors.black.withOpacity(0.5),
                        child: Center(
                          child: Text(
                            category.name!,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
