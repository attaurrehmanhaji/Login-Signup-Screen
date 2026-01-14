import 'package:flutter/material.dart';
import 'package:login_signin_screens/src/core/constants/appAssets.dart';
import 'package:login_signin_screens/src/core/constants/appColors.dart';
import 'package:login_signin_screens/src/features/home/widgets/banner_carousel.dart';
import 'package:login_signin_screens/src/features/home/product_details.dart';
import 'package:login_signin_screens/src/model/product_model.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;
import '../cart/cart_screen.dart';
import '../../providers/cart_provider.dart';
import 'widgets/product_skeleton.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;

  List<ProductModel> products = [
    ProductModel.fromCarsModel(
      name: 'BMW M4',
      brand: "BMW",
      color: 'Alpine White',
      model: 2024,
      photo: car7,
      sold: false,
      price: 75000,
    ),
    ProductModel.fromCarsModel(
      name: 'Supra MK5',
      brand: "Toyota",
      color: 'Prominence Red',
      model: 2023,
      photo: car3,
      sold: false,
      price: 55000,
    ),
    ProductModel.fromCarsModel(
      name: 'Civic Type R',
      brand: "Honda",
      color: 'Championship White',
      model: 2024,
      photo: car2,
      sold: true,
      price: 45000,
    ),
    ProductModel.fromCarsModel(
      name: 'Camry XSE',
      brand: "Toyota",
      color: 'Celestial Silver',
      model: 2023,
      photo: car4,
      sold: false,
      price: 35000,
    ),
    ProductModel.fromCarsModel(
      name: 'M5 CS',
      brand: "BMW",
      color: 'Frozen Brands Hatch Grey',
      model: 2022,
      photo: car8,
      sold: true,
      price: 95000,
    ),
    ProductModel.fromCarsModel(
      name: 'City Aspire',
      brand: "Honda",
      color: 'Urban Titanium',
      model: 2023,
      photo: car1,
      sold: true,
      price: 22000,
    ),
    ProductModel.fromCarsModel(
      name: 'Corolla Altis',
      brand: "Toyota",
      color: 'Super White',
      model: 2024,
      photo: car5,
      sold: false,
      price: 28000,
    ),
    ProductModel.fromCarsModel(
      name: 'Alto VXL',
      brand: "Suzuki",
      color: 'Solid White',
      model: 2024,
      photo: car6,
      sold: true,
      price: 12000,
    ),
  ];

  String selectedCategory = 'All';
  String searchQuery = '';
  late AnimationController _animationController;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _simulateLoading();
  }

  Future<void> _simulateLoading() async {
    // Simulate network delay for premium feeling
    await Future.delayed(Duration(seconds: 3));
    if (mounted) {
      setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  List<ProductModel> get filteredCars {
    List<ProductModel> tempCars = products;

    // Filter by Category
    if (selectedCategory == 'Available') {
      tempCars = tempCars.where((c) => !c.sold).toList();
    } else if (selectedCategory == 'Sold') {
      tempCars = tempCars.where((c) => c.sold).toList();
    } else if (selectedCategory != 'All') {
      tempCars = tempCars.where((c) => c.brand == selectedCategory).toList();
    }

    // Filter by Search Query
    if (searchQuery.isNotEmpty) {
      tempCars = tempCars
          .where(
            (c) =>
                c.name.toLowerCase().contains(searchQuery.toLowerCase()) ||
                c.brand.toLowerCase().contains(searchQuery.toLowerCase()),
          )
          .toList();
    }

    return tempCars;
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      backgroundColor: AppColors.cardBackground,
      body: SafeArea(
        child: Column(
          children: [
            // Modern App Bar
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.primaryGradientStart,
                    AppColors.primaryGradientEnd,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.shadowMedium,
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Discover',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.2,
                            ),
                          ),
                          Text(
                            'Your Dream Car',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.9),
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Icon(
                              Icons.notifications_outlined,
                              color: Colors.white,
                              size: 28,
                            ),
                          ),
                          SizedBox(width: 10),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CartScreen(),
                                ),
                              );
                            },
                            child: badges.Badge(
                              badgeContent: Text(
                                '${cartProvider.itemCount}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              showBadge: cartProvider.itemCount > 0,
                              badgeStyle: badges.BadgeStyle(
                                badgeColor: AppColors.errorRed,
                              ),
                              child: Container(
                                padding: EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Icon(
                                  Icons.shopping_cart_outlined,
                                  color: Colors.white,
                                  size: 28,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  // Search Bar
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.shadowLight,
                          blurRadius: 8,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          searchQuery = value;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'Search for cars...',
                        hintStyle: TextStyle(
                          color: AppColors.grayColor.withOpacity(0.5),
                          fontSize: 16,
                        ),
                        prefixIcon: Icon(
                          Icons.search,
                          color: AppColors.grayColor.withOpacity(0.5),
                        ),
                        suffixIcon: Icon(
                          Icons.tune,
                          color: AppColors.orangeColor,
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 15),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            // Promotional Banner Carousel
            BannerCarousel(),
            SizedBox(height: 20),
            // Category Chips
            Container(
              height: 50,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 20),
                children: [
                  _buildCategoryChip('All'),
                  _buildCategoryChip('Available'),
                  _buildCategoryChip('Sold'),
                  _buildCategoryChip('Honda'),
                  _buildCategoryChip('Toyota'),
                  _buildCategoryChip('BMW'),
                  _buildCategoryChip('Suzuki'),
                ],
              ),
            ),
            SizedBox(height: 15),
            // Car Grid
            Expanded(
              child: _isLoading
                  ? GridView.builder(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 0.65,
                        mainAxisSpacing: 20,
                        crossAxisSpacing: 20,
                        crossAxisCount: 2,
                      ),
                      itemCount: 6,
                      itemBuilder: (context, index) => ProductSkeleton(),
                    )
                  : AnimatedBuilder(
                      animation: _animationController,
                      builder: (context, child) {
                        return GridView.builder(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                childAspectRatio: 0.65,
                                mainAxisSpacing: 20,
                                crossAxisSpacing: 20,
                                crossAxisCount: 2,
                              ),
                          itemCount: filteredCars.length,
                          itemBuilder: (BuildContext context, int index) {
                            ProductModel myProduct = filteredCars[index];
                            return _buildCarCard(myProduct, index);
                          },
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryChip(String category) {
    bool isSelected = selectedCategory == category;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCategory = category;
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        margin: EdgeInsets.only(right: 12),
        padding: EdgeInsets.symmetric(horizontal: 20),

        decoration: BoxDecoration(
          gradient: isSelected
              ? LinearGradient(
                  colors: [
                    AppColors.primaryGradientStart,
                    AppColors.primaryGradientEnd,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : null,
          color: isSelected ? null : Colors.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: isSelected
                  ? AppColors.primaryGradientStart.withOpacity(0.3)
                  : AppColors.shadowLight,
              blurRadius: 8,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Center(
          child: Text(
            category,
            style: TextStyle(
              color: isSelected ? Colors.white : AppColors.grayColor,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCarCard(ProductModel myProduct, int index) {
    return TweenAnimationBuilder(
      duration: Duration(milliseconds: 300 + (index * 100)),
      tween: Tween<double>(begin: 0, end: 1),
      builder: (context, double value, child) {
        return Transform.scale(
          scale: value,
          child: Opacity(
            opacity: value,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductDetails(product: myProduct),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.shadowLight,
                      blurRadius: 15,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Car Image with Status Badge
                    Stack(
                      children: [
                        Container(
                          height: 140,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                AppColors.secondaryGradientStart.withOpacity(
                                  0.3,
                                ),
                                AppColors.secondaryGradientEnd.withOpacity(0.3),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25),
                              topRight: Radius.circular(25),
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25),
                              topRight: Radius.circular(25),
                            ),
                            child: Image.asset(
                              myProduct.photo,
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 10,
                          right: 10,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: myProduct.sold
                                  ? AppColors.errorRed
                                  : AppColors.successGreen,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      (myProduct.sold
                                              ? AppColors.errorRed
                                              : AppColors.successGreen)
                                          .withOpacity(0.4),
                                  blurRadius: 8,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Text(
                              myProduct.sold ? 'SOLD' : 'AVAILABLE',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    // Car Details
                    Padding(
                      padding: EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            myProduct.brand,
                            style: TextStyle(
                              color: AppColors.grayColor.withOpacity(0.6),
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            myProduct.name,
                            style: TextStyle(
                              color: AppColors.grayColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(
                                Icons.palette_outlined,
                                size: 14,
                                color: AppColors.orangeColor,
                              ),
                              SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  myProduct.color,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: AppColors.grayColor.withOpacity(0.7),
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      AppColors.primaryGradientStart
                                          .withOpacity(0.2),
                                      AppColors.primaryGradientEnd.withOpacity(
                                        0.2,
                                      ),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  myProduct.year.toString(),
                                  style: TextStyle(
                                    color: AppColors.orangeColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
