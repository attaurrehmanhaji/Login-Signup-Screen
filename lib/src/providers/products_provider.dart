import 'package:flutter/material.dart';
import '../model/product_model.dart';
import '../core/constants/appAssets.dart';

class ProductsProvider with ChangeNotifier {
  final List<ProductModel> _products = [
    ProductModel.fromCarsModel(
      id: '1',
      name: 'BMW M4',
      brand: "BMW",
      color: 'Alpine White',
      model: 2024,
      photo: car7,
      sold: false,
      price: 75000,
    ),
    ProductModel.fromCarsModel(
      id: '2',
      name: 'Supra MK5',
      brand: "Toyota",
      color: 'Prominence Red',
      model: 2023,
      photo: car3,
      sold: false,
      price: 55000,
    ),
    ProductModel.fromCarsModel(
      id: '3',
      name: 'Civic Type R',
      brand: "Honda",
      color: 'Championship White',
      model: 2024,
      photo: car2,
      sold: true,
      price: 45000,
    ),
    ProductModel.fromCarsModel(
      id: '4',
      name: 'Camry XSE',
      brand: "Toyota",
      color: 'Celestial Silver',
      model: 2023,
      photo: car4,
      sold: false,
      price: 35000,
    ),
    ProductModel.fromCarsModel(
      id: '5',
      name: 'M5 CS',
      brand: "BMW",
      color: 'Frozen Brands Hatch Grey',
      model: 2022,
      photo: car8,
      sold: true,
      price: 95000,
    ),
    ProductModel.fromCarsModel(
      id: '6',
      name: 'City Aspire',
      brand: "Honda",
      color: 'Urban Titanium',
      model: 2023,
      photo: car1,
      sold: true,
      price: 22000,
    ),
    ProductModel.fromCarsModel(
      id: '7',
      name: 'Corolla Altis',
      brand: "Toyota",
      color: 'Super White',
      model: 2024,
      photo: car5,
      sold: false,
      price: 28000,
    ),
    ProductModel.fromCarsModel(
      id: '8',
      name: 'Alto VXL',
      brand: "Suzuki",
      color: 'Solid White',
      model: 2024,
      photo: car6,
      sold: true,
      price: 12000,
    ),
  ];

  List<ProductModel> get products => [..._products];

  ProductModel? findById(String id) {
    try {
      return _products.firstWhere((p) => p.id == id);
    } catch (e) {
      return null;
    }
  }

  List<ProductModel> getProductsByIds(Iterable<String> ids) {
    return _products.where((p) => ids.contains(p.id)).toList();
  }
}
