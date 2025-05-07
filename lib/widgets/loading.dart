import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        height: 60.0,
        width: 60.0,
        child: CircularProgressIndicator(
          strokeWidth: 5.0,
          color: Color(0xFF4C53A5), 
        ),
      ),
    );
  }
}
