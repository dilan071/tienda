import 'package:flutter/material.dart';

class EmptyState extends StatelessWidget {
  final String? message;
  final String? imageAsset;

  const EmptyState({
    Key? key,
    this.message = 'Ups! no hay nada por aquí.',
    this.imageAsset = 'assets/no tengo imagenes de momento',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (imageAsset != null)
              SizedBox(
                height: 120.0,
                child: Image.asset(imageAsset!),
              ),
            const SizedBox(height: 20),
            Text(
              message!,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.w500,
                color: Color(0xFF4C53A5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
