import 'package:flutter/material.dart';
import 'package:login_signin_screens/src/core/constants/appAssets.dart';
import 'package:login_signin_screens/src/core/constants/appColors.dart';
import 'package:login_signin_screens/src/model/cars_model.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CarsModel> car = [
    CarsModel(
      name: 'City',
      brand: "Honda",
      color: 'White',
      model: 2018,
      photo: '',
    ),
    CarsModel(
      name: 'City',
      brand: "Honda",
      color: 'White',
      model: 2018,
      photo: car1,
    ),
    CarsModel(
      name: 'City',
      brand: "Honda",
      color: 'White',
      model: 2018,
      photo: car2,
    ),
    CarsModel(
      name: 'City',
      brand: "Honda",
      color: 'White',
      model: 2018,
      photo: car3,
    ),
    CarsModel(
      name: 'City',
      brand: "Honda",
      color: 'White',
      model: 2018,
      photo: car4,
    ),
    CarsModel(
      name: 'City',
      brand: "Honda",
      color: 'White',
      model: 2018,
      photo: car5,
    ),
    CarsModel(
      name: 'City',
      brand: "Honda",
      color: 'White',
      model: 2018,
      photo: car6,
    ),
    CarsModel(
      name: 'City',
      brand: "Honda",
      color: 'White',
      model: 2018,
      photo: car7,
    ),
    CarsModel(
      name: 'City',
      brand: "Honda",
      color: 'White',
      model: 2018,
      photo: car8,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,

      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: 5,
          crossAxisSpacing: 5,
          crossAxisCount: 2,
        ),
        itemBuilder: (BuildContext context, int index) {
          CarsModel myCars = car[index];

          return Container(
            decoration: BoxDecoration(
              color: AppColors.lightOrangeColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                CircleAvatar(backgroundImage: AssetImage(myCars.photo)),
                Text(myCars.name)
              ],
            ),
          );
        },
      ),
    );
  }
}
