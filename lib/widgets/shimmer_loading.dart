import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoading extends StatelessWidget {
  const ShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 6,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: const ListTile(
              leading: CircleAvatar(radius: 30, backgroundColor: Colors.white),
              title: SizedBox(
                height: 14,
                child: ColoredBox(color: Colors.white),
              ),
              subtitle: Padding(
                padding: EdgeInsets.only(top: 8),
                child: SizedBox(
                  height: 12,
                  child: ColoredBox(color: Colors.white),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}