import 'package:flutter/material.dart';
import '../../../core/constants/appColors.dart';
import '../../../shared/widgets/shimmer_loading.dart';

class ProductSkeleton extends StatelessWidget {
  const ProductSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return ShimmerLoading(
      isLoading: true,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadowLight,
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Skeleton
            Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SkeletonElement(
                  width: double.infinity,
                  height: double.infinity,
                  borderRadius: 15,
                ),
              ),
            ),
            // Details Skeleton
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Brand
                    SkeletonElement(width: 60, height: 12),
                    SizedBox(height: 4),
                    // Name
                    SkeletonElement(width: 100, height: 16),
                    SizedBox(height: 8),
                    // Price and Button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SkeletonElement(width: 50, height: 18),
                        SkeletonElement(
                          width: 35,
                          height: 35,
                          borderRadius: 12,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
