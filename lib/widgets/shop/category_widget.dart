import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:grocery_app/model/category.dart';
import 'package:grocery_app/util/shopping_colors.dart';

class CategoryWidget extends StatelessWidget {
  final Category? category;
  final Function? onTap;
  const CategoryWidget({Key? key, required this.category, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap!(category!.id);
      },
      child: Container(
        width: 800,
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Stack(
          children: [
            Positioned(
              right: 10,
              bottom: 12,
              child: GestureDetector(
                onTap: () {
                  onTap!(category!.id);
                },
                child: CircleAvatar(
                  radius: 18,
                  backgroundColor: primaryColor,
                  child: const Icon(Icons.add_rounded, color: Colors.white),
                ).animate().fade(duration: 200.ms),
              ),
            ),
            Positioned(
              top: 22,
              left: 26,
              right: 25,
              child: Image.memory(base64Decode(category!.imageUrl)).animate().slideX(
                    duration: 200.ms,
                    begin: 1,
                    curve: Curves.easeInSine,
                  ),
            ),
            Positioned(
              left: 12,
              bottom: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(category!.title,
                          style: TextStyle(
                              fontFamily: 'Gilroy', fontSize: 20, color: shrineBackgroundWhite))
                      .animate()
                      .fade()
                      .slideY(
                        duration: 200.ms,
                        begin: 1,
                        curve: Curves.easeInSine,
                      ),
                  const SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
