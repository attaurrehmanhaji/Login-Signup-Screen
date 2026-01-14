import 'package:flutter/material.dart';
import 'package:login_signin_screens/src/core/constants/appColors.dart';
import 'package:badges/badges.dart' as badges;

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemSelected;
  final int cartItemCount;

  const CustomBottomNavBar({
    Key? key,
    required this.selectedIndex,
    required this.onItemSelected,
    required this.cartItemCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: AppColors.shadowLight,
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildNavItem(
                  0,
                  Icons.home_rounded,
                  Icons.home_outlined,
                  'Home',
                ),
                _buildNavItem(
                  1,
                  Icons.favorite_rounded,
                  Icons.favorite_outline_rounded,
                  'Favorites',
                ),
                _buildNavItem(
                  2,
                  Icons.shopping_cart_rounded,
                  Icons.shopping_cart_outlined,
                  'Cart',
                  badgeCount: cartItemCount,
                ),
                _buildNavItem(
                  3,
                  Icons.person_rounded,
                  Icons.person_outline_rounded,
                  'Profile',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(
    int index,
    IconData activeIcon,
    IconData inactiveIcon,
    String label, {
    int? badgeCount,
  }) {
    final isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: () => onItemSelected(index),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: EdgeInsets.symmetric(
          horizontal: isSelected ? 20 : 12,
          vertical: 12,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.orangeColor.withOpacity(0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildIcon(
              index,
              isSelected ? activeIcon : inactiveIcon,
              isSelected,
              badgeCount,
            ),
            if (isSelected) ...[
              SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  color: AppColors.orangeColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildIcon(
    int index,
    IconData icon,
    bool isSelected,
    int? badgeCount,
  ) {
    Widget iconWidget = Icon(
      icon,
      color: isSelected
          ? AppColors.orangeColor
          : AppColors.grayColor.withOpacity(0.6),
      size: 24,
    );

    if (badgeCount != null && badgeCount > 0) {
      return badges.Badge(
        badgeContent: Text(
          '$badgeCount',
          style: TextStyle(
            color: Colors.white,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
        badgeStyle: badges.BadgeStyle(
          badgeColor: AppColors.errorRed,
          padding: EdgeInsets.all(5),
          elevation: 0,
        ),
        child: iconWidget,
      );
    }

    return iconWidget;
  }
}
